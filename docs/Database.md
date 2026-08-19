# Recollect It Database

## Overview

Recollect It uses PostgreSQL as its authoritative persistent data store.

This document defines the initial database schema, database-enforced invariants, deletion behavior, indexes, and migration conventions. Product behavior belongs in `Product.md`; application structure and database-access rules belong in `Architecture.md`.

The schema is intentionally small and uses ordinary PostgreSQL tables, constraints, and indexes. The application accesses it with direct parameterized SQL through the `pg` client. No ORM, query builder, stored-procedure layer, or dedicated migration framework is required.

## Design Principles

1. Store only durable product state.
2. Use primary keys, foreign keys, unique constraints, and check constraints for invariants PostgreSQL can express simply.
3. Keep multi-table product rules in straightforward TypeScript and transactions rather than forcing them into triggers.
4. Prefer simple, normalized tables that directly represent current product concepts. Avoid abstractions intended only for hypothetical future requirements.

## Naming and Data-Type Conventions

- Use `snake_case` for tables, columns, constraints, and indexes.
- Use plural table names.
- Use `integer GENERATED ALWAYS AS IDENTITY` primary keys.
- Use `text` for user-entered and administrator-entered text unless a real database limit is required.
- Use `timestamptz` for timestamps. Configure application/database sessions to use UTC.
- Use `created_at` for creation time and specific timestamps such as `completed_at` where they represent a product event.
- Let PostgreSQL generate identifiers and timestamps.
- Do not use PostgreSQL enums initially; small `text` or `char` fields with check constraints are easier to change through ordinary SQL migrations.
- UUIDs are not needed for the current architecture because identifiers are created by one PostgreSQL database and do not need to be globally unique.

## Entity Relationships

```text
students 1 ---- * sessions * ---- 1 subjects
                  |
                  *
           session_questions * ---- 1 questions * ---- 1 subjects
                                                     |
                                                     0..1 categories
```

Important details:

- `session_questions` freezes the set of Questions selected when a Session starts.

## Tables

### `students`

Stores one row for each Student.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `id` | `integer` identity | No | Primary key. |
| `username` | `text` | No | NFC-normalized, case-sensitive Username. |
| `created_at` | `timestamptz` | No | Student creation time. Use DEFAULT NOW().|

Constraints:

- Primary key on `id`.
- Unique constraint on `username`.
- Application validation must normalize the Username to Unicode NFC and reject whitespace, control characters, and invisible formatting characters before insertion.
- PostgreSQL's ordinary case-sensitive text equality is required. Do not use `citext` or compare with `lower(username)`.

The database does not attempt to reproduce the full Unicode validation rule with a check constraint. TypeScript is the clearer authoritative implementation for that rule.

### `subjects`

Stores the shared Subjects maintained by the Administrator.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `id` | `integer` identity | No | Primary key. |
| `title` | `text` | No | Subject title shown to Students. |

Constraints:

- Primary key on `id`.
- Check that `title` is not empty after trimming.

### `categories`

Stores optional subtopics within a Subject.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `id` | `integer` identity | No | Primary key. |
| `subject_id` | `integer` | No | Owning Subject. |
| `title` | `text` | No | Category title shown to Students. |

Constraints:

- Primary key on `id`.
- Foreign key from `subject_id` to `subjects(id)`.
- Check that `title` is not empty after trimming.

### `questions`

Stores Questions and their single Answers.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `id` | `integer` identity | No | Primary key. |
| `subject_id` | `integer` | No | Subject containing the Question. |
| `category_id` | `integer` | Yes | Optional Category. |
| `question_text` | `text` | No | Prompt shown to the Student. |
| `answer_text` | `text` | No | Correct Answer used for Guess evaluation. |

Constraints:

- Primary key on `id`.
- Foreign key from `subject_id` to `subjects(id)`.
- Composite foreign key from `(subject_id, category_id)` to `categories(subject_id, id)`. This ensures that a Question's Category belongs to the same Subject as the Question.
- Checks that `question_text` and `answer_text` are not empty after trimming.

The `categories` table therefore needs a supporting unique constraint on `(subject_id, id)` even though `id` is already its primary key.

The Answer remains on the Question row because the initial release permits exactly one Answer per Question. A separate answers table would add indirection without supporting a current requirement.

Normalized Answer values are not stored. Guess normalization and Damerau-Levenshtein comparison occur in TypeScript as defined by `Product.md` and `Architecture.md`.

### `sessions`

Stores active and completed Sessions. Abandoned Sessions are retained and marked complete.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `id` | `integer` identity | No | Primary key. |
| `student_id` | `integer` | No | Student who owns the Session. |
| `subject_id` | `integer` | No | Session Subject. |
| `created_at` | `timestamptz` | No | Session creation time. Use DEFAULT NOW(). |
| `completed_at` | `timestamptz` | Yes | Completion or abandonment time. NULL while the Session is active. ` |

Constraints:

- Primary key on `id`.
- Foreign key from `student_id` to `students(id)`.
- Foreign key from `subject_id` to `subjects(id)`.

When `completed_at` is NULL, the Session is active. When `completed_at` is NOT NULL, the Session is completed (including abandoned).
A Session’s Question membership is established when the Session is created, stored in `session_questions`, and does not change after Session creation.
The current round of a Session can be derived from the session_questions table.

### `session_questions`

Stores the fixed Question membership of a Session and whether each Question has been completed.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `session_id` | `integer` | No | Owning Session. |
| `question_id` | `integer` | No | Question included in the Session. |
| `attempts` | `integer` | No | Number of Attempts submitted for this Question in this Session. Use `DEFAULT 0`. |
| `completed_at` | `timestamptz` | Yes | Time of the first correct Attempt in this Session. |

Constraints:

- Add `CHECK (attempts >= 0)`.
- Composite primary key on `(session_id, question_id)`.
- Foreign key from `session_id` to `sessions(id)`.
- Foreign key from `question_id` to `questions(id)`.

The application must ensure that every Question belongs to the Session's Subject. Session creation inserts the Session and all of its `session_questions` rows in one transaction.

A Question is incomplete when `completed_at IS NULL`. A correct Guess sets `completed_at` once; it is never cleared.

Derive Accuracy from session_questions rather than storing a second authoritative copy.

### `logs`

Stores server-side error and warning messages for operational troubleshooting.

| Column | Type | Null | Purpose |
| --- | --- | --- | --- |
| `severity` | `text` | No | Log severity. Use `DEFAULT 'error'`; warnings use `warning`. |
| `message` | `text` | No | Non-sensitive error or warning details. |
| `created_at` | `timestamptz` | No | Log creation time. Use `DEFAULT NOW()`. |

The application must not store credentials, connection strings, or other secrets in log messages.

## Derived Data and Queries

### Question Accuracy

Accuracy is derived from `session_questions` and `sessions` for one Student and one Question:

Any time `attempts` is zero, a divide by zero would occur, so instead Accuracy should be defined as 0% for these cases.

When filtering many Questions for Session creation, aggregate Attempts once for the Student and left join the result to eligible Questions. Do not execute one Accuracy query per Question.

Do not store an Accuracy percentage column initially. Stored totals would duplicate the authoritative attempt counts in session_questions and require additional update logic.

### Current Round

Assume that all references to `session_questions` below are limited to the Questions belonging to the Session.

For an active Session, a Question is incomplete when completed_at IS NULL. It is eligible to be asked in the current Round only when it is incomplete and has the minimum attempts value among all incomplete Questions in the Session.

The current Round is derived from `session_questions.attempts`, `session_questions.completed_at`, and `sessions.completed_at`. The current Round is not stored separately.

For a completed Session, the Round is the maximum value of `session_questions.attempts`.

For an active Session, consider only pending Questions and determine the minimum and maximum values of `session_questions.attempts`:

If the minimum and maximum are equal, all pending Questions have been attempted the same number of times. The Round number is that value plus 1.
If the minimum and maximum are different, the Session is partway through a Round. The Round number is the maximum value.

This design does not require a separate Round table.

### Current and Previous Question State

The database does not store a `current_question_id` on the Session. The server selects a random pending Question when it needs to present one.

The previous Q&A panel is browser-visit state and is intentionally hidden after the page is opened or resumed, so it does not require a durable database field.

A skipped Question remains pending because skipping writes no Attempt. The server can choose another pending Question for the response.

### Session Completion Summary

For a completed Session:

- Unique Questions = number of `session_questions` rows.
- Guesses = sum of session_questions.attempts for the Session.
- Session Accuracy = Unique Questions / Guesses × 100

For abandoned Sessions, Session Accuracy is not shown. Thus, cases where no Guesses were made or there are more Unique Questions than Guesses are safely ignored.

## Transactions

### Create Student

A single insert is sufficient. The unique Username constraint handles concurrent attempts to create the same exact normalized Username.

### Start Session

Use one transaction to:

1. Select the eligible Questions using the submitted filters and historical Accuracy.
2. Insert the `sessions` row.
3. Insert every `session_questions` row.
4. Commit.

The Question set is fixed by the inserted rows and must not be regenerated later.

The rejection of a Session due to no Questions being eligible is handled solely in code.

The five-active-Session limit is handled solely in code. If a race condition exists that allows six active Sessions, that is ok.

### Submit Guess

Use one transaction to:

1. Increment `session_questions.attempts` if `session_questions.completed_at` is NULL (this conditional is solely to catch rare concurrency issues).
2. If correct, set `session_questions.completed_at` if it is still `NULL`.
3. If all Session Questions are complete, set `sessions.completed_at` if it is still `NULL`.
4. Commit.

Guess evaluation occurs before the transaction begins. The Answer may be read as part of the validation query. The transaction coordinates only the database changes resulting from the Guess.

### Skip Question

Skipping does not change durable product history and does not require an insert. The server validates that another Question is pending in the current Round, selects a replacement, and returns it.

### Abandon Session

After the Student confirms abandonment, mark the active Session as complete by setting `sessions.completed_at`.

Whether a completed Session was completed normally or abandoned can be derived from its session_questions: if any Question remains incomplete, the Session was abandoned.

## Indexes

Primary keys, unique constraints, and the supporting unique constraint on `categories(subject_id, id)` create their own indexes.

Create these additional indexes initially:

```sql
CREATE INDEX questions_subject_category_idx
  ON questions (subject_id, category_id);
  
CREATE INDEX sessions_student_completed_idx
  ON sessions (student_id, completed_at);
  
CREATE INDEX session_questions_question_idx
  ON session_questions (question_id);
```

Do not add indexes speculatively beyond the known access patterns. Review actual queries with `EXPLAIN` if performance becomes a problem.

## Deletion and Update Rules

The initial release relies on the Administrator's operational promise not to edit or delete Subjects, Categories, or Questions while affected Sessions are active.

Recommended foreign-key deletion behavior:

- `students`: restrict deletion while Sessions exist.
- `subjects`: restrict deletion while Categories, Questions, or Sessions exist.
- `categories`: restrict deletion while Questions exist.
- `questions`: restrict deletion while `session_questions` rows exist.

The application should not silently cascade deletion of historical learning data.

## Initial Migration

Create the schema in:

```text
database/001_migration_initial.sql
```

The migration should create tables in dependency order:

1. `students`
2. `subjects`
3. `categories`
4. `questions`
5. `sessions`
6. `session_questions`
7. `logs`
8. Additional indexes

Migration files are ordinary SQL, are committed to source control, and are applied in numeric order. After a migration has been applied to production, do not edit it; create a new numbered migration for corrections.

Every `.sql` filename must begin with its numeric sequence followed by either `migration` or `seed`, using the format `<number>_migration_<description>.sql` or `<number>_seed_<description>.sql`.

Apply and verify every migration against the development Neon database before applying it to production.

## Seed Data

Initial Subjects, Categories, and Questions may be inserted directly through Neon.

Seed SQL files must use the `<number>_seed_<description>.sql` filename format, for example `002_seed_world_capitals.sql`.

## Manual Database Smoke Tests

Before the initial release, verify at least the following against the development database:

1. Create two distinct case-sensitive Usernames and reject an exact duplicate.
2. Start a Session and confirm its Question membership remains fixed.
3. Submit an incorrect Guess and confirm that session_questions.attempts increases by 1 and the Question remains incomplete.
4. Submit a correct Guess and confirm that session_questions.attempts increases by 1 and completed_at is set.
5. Complete a Round and confirm the next Round begins with only incomplete Questions.
6. Complete the final Question and confirm the Session and completion timestamp update atomically.
7. Confirm a skipped Question does not change session_questions.attempts and the Question remains pending.
8. Confirm database constraints reject invalid foreign keys.
