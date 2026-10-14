# Recollect It API

## Overview

This document defines the HTTP API contracts used by the Recollect It browser application.

Recollect It is a single Next.js application. The endpoints in this document are Next.js Route Handlers under `src/app/api/`; they are not a separately deployed backend service.

`Product.md` defines product behavior. `Architecture.md` defines application structure. `Database.md` defines persistent data and transactions. This document defines only the browser-to-server HTTP contracts needed by interactive application operations.

## API Principles

1. Keep the API small and specific to current product operations.
2. Use ordinary JSON requests and responses.
3. Use Route Handlers for all mutations.
4. Keep Route Handlers focused on HTTP validation and response handling. Server-side business functions enforce product rules and coordinate database work.
5. Validate all request data on the server even when it was already validated in the browser.
6. Derive the current Student from the server-set cookie. This is useful for remembering which Student is currently using the application as they move between pages. Enhanced security to be added in the future.
7. Return small responses containing only the data the browser needs for its next action.
8. Do not expose SQL, database errors, stack traces, or internal implementation details.

## Scope

The initial API contains endpoints for:

- Logging in.
- Logging out.
- Creating a Student.
- Previewing the number of Questions eligible for a new Session.
- Starting a Session.
- Submitting a Guess.
- Obtaining a Question.
- Abandoning a Session.

Most page reads do not require HTTP API endpoints. Next.js Server Components may retrieve Landing Page, Session Creation, and Session Completion data directly through server-side database and business modules, as described in `Architecture.md`.

Administrative CRUD endpoints are not included. Initial administrative data management occurs directly through Neon.

## Conventions

### Base Path

All endpoints use paths under:

```text
/api
```

### Content Type

Requests with bodies use:

```http
Content-Type: application/json
```

Successful responses containing bodies return JSON.

### Student Cookie

Successful login and Student creation set a cookie identifying the current Student.

The cookie must be:

- `HttpOnly`.
- `SameSite=Lax`.
- `Secure` in production.
- `Path=/`.
- Set by the server.

The cookie is a convenience mechanism, not secure authentication. Anyone who knows a Username can access that Student's data under the initial product design.

Set the cookie name to `recollect_student`.

The cookie will store the Student ID directly.

The cookie lifetime is 30 days.

### Identifiers

Database identifiers are PostgreSQL integers. JSON represents them as numbers.

Every endpoint that receives a resource identifier must verify that the resource exists and, for Student-owned resources, belongs to the current Student.

### Timestamps

When a timestamp is needed in a response, return it as an ISO 8601 UTC string, for example:

```json
"2026-08-16T14:30:00.000Z"
```

### Success Status Codes

- `200 OK` for successful actions and previews.
- `201 Created` when a Student or Session is created.
- `204 No Content` for a successful login.
- `303 See Other` after a successful logout, redirecting the browser to the Student Access page.

### Error Shape

All expected API errors use this minimal shape:

```json
{
  "error": {
    "code": "USERNAME_NOT_FOUND",
    "message": "That Username does not exist."
  }
}
```

- `code` is a stable machine-readable value used by application code.
- `message` is a short Student-facing message.
- Additional fields should be added only when the browser needs structured information to recover from the error.

Unexpected errors return:

```json
{
  "error": {
    "code": "INTERNAL_ERROR",
    "message": "Something went wrong. Please try again."
  }
}
```

The server should write the underlying unexpected error to the `logs` table without returning its details to the browser.

### Common Error Status Codes

| Status | Meaning |
| --- | --- |
| `400 Bad Request` | Malformed JSON, missing field, wrong type, or invalid value. |
| `401 Unauthorized` | No valid current-Student cookie is present. This status describes missing application identity even though the initial release does not provide secure authentication. |
| `403 Forbidden` | The identified resource belongs to another Student. |
| `404 Not Found` | The requested resource does not exist. |
| `409 Conflict` | The request is valid but conflicts with current state or a uniqueness rule. |
| `500 Internal Server Error` | Unexpected server failure. |

Student-owned Sessions should return `403` when accessed by another Student.

## Shared Types

The examples below describe JSON shapes, not required TypeScript implementation names.

### Session Filters

```ts
type SessionFilters =
  | {
      askAllQuestions: true;
    }
  | {
      askAllQuestions: false;
      categoryIds: number[];
      accuracyOperator: "lte" | "gte";
      accuracyPercent: 0 | 10 | 20 | 30 | 40 | 50 | 60 | 70 | 80 | 90 | 100;
    };
```

The selected `subjectId` is sent separately. When `askAllQuestions` is `true`, the server ignores additional filter fields.

An empty `categoryIds` array means all Categories and uncategorized Questions in the Subject are eligible before applying the Accuracy filter.

### Question Prompt

```ts
type QuestionPrompt = {
  questionId: number;
  questionText: string;
  questionAccuracy: number | null;
};
```

The Answer is not returned with the current Question.

`questionAccuracy` is the Student's Question Accuracy across all Sessions, rounded to the nearest whole percentage. It is `null` when the Student has never answered the Question correctly; the Session page does not display Question Accuracy in that case.

### Session State

```ts
type SessionState = {
  roundNumber: number;
  questionsAnsweredCorrectly: number;
  questionsTotal: number;
};
```

`roundNumber` is the current Round derived as defined in `Database.md`.

`questionsAnsweredCorrectly` is the number of Questions in the Session that have been answered correctly. `questionsTotal` is the total number of Questions in the Session. Both values describe the entire Session and do not reset when a new Round begins.

## Endpoints

### Log In

```http
POST /api/login
```

Finds an existing Student by the submitted Username and sets the current-Student cookie.

Request:

```json
{
  "username": "Wade"
}
```

Server behavior:

1. Require `username` to be a string.
2. Normalize it to Unicode NFC.
3. Validate the Username rules from `Product.md`.
4. Perform an exact, case-sensitive lookup.
5. If found, set the current-Student cookie.

Success response — `204 No Content` (no response body).

Expected errors:

| Status | Code | Condition |
| --- | --- | --- |
| `400` | `INVALID_USERNAME` | Username fails format or length validation. |
| `404` | `USERNAME_NOT_FOUND` | No exact normalized Username exists. |

### Log Out

```http
POST /api/logout
```

Deletes the server-set current-Student cookie. Logging out does not change any Student or Session data.

The request has no body. The operation is idempotent and succeeds even when the current-Student cookie is already missing or invalid.

Success response — `303 See Other` with `Location: /`. The redirect causes the browser to retrieve the Student Access page with a `GET` request after the cookie has been deleted.

### Create Student

```http
POST /api/students
```

Creates a Student and sets the current-Student cookie.

Request:

```json
{
  "username": "Wade"
}
```

Server behavior:

1. Require `username` to be a string.
2. Trim leading and trailing whitespace.
3. Normalize it to Unicode NFC.
4. Validate the Username rules and 25-character product limit.
5. Insert the Student.
6. Set the current-Student cookie after a successful insert.

Success response — `201 Created` (no response body).

Expected errors:

| Status | Code | Condition |
| --- | --- | --- |
| `400` | `INVALID_USERNAME` | Username fails format or length validation. |
| `409` | `USERNAME_ALREADY_EXISTS` | The exact normalized Username already exists. |

Concurrent duplicate inserts are resolved by the database unique constraint and mapped to `USERNAME_ALREADY_EXISTS`.
Every `USERNAME_ALREADY_EXISTS` response writes an `info` entry to the `logs` table containing the normalized Username.

### Preview Session Question Count

```http
POST /api/sessions/preview
```

Returns how many Questions would be included if the Student started a Session with the submitted Subject and filters. This endpoint does not create durable state.

Request:

```json
{
  "subjectId": 3,
  "filters": {
    "askAllQuestions": false,
    "categoryIds": [7, 8],
    "accuracyOperator": "lte",
    "accuracyPercent": 60
  }
}
```

Success response — `200 OK`:

```json
{
  "questionCount": 24
}
```

Expected errors:

| Status | Code | Condition |
| --- | --- | --- |
| `400` | `INVALID_SESSION_FILTERS` | A filter value is missing, malformed, or contradictory. |
| `404` | `SUBJECT_NOT_FOUND` | The Subject does not exist. |
| `409` | `CATEGORY_SUBJECT_MISMATCH` | A submitted Category does not belong to the submitted Subject. |

A zero count is a successful preview, not an error.

Because Accuracy and Question eligibility can change between preview and Session creation, the preview is informational. `POST /api/sessions` must recalculate eligibility.

### Start Session

```http
POST /api/sessions
```

Creates a Session with a fixed set of eligible Questions and returns its identifier. The browser then navigates to `/sessions/{sessionId}`, where `GET /api/sessions/{sessionId}` retrieves the initial Question and Session state.

Request:

```json
{
  "subjectId": 3,
  "filters": {
    "askAllQuestions": false,
    "categoryIds": [7, 8],
    "accuracyOperator": "lte",
    "accuracyPercent": 60
  }
}
```

Server behavior:

1. Validate the current Student, Subject, Categories, and filters.
2. Apply the active-Session limit.
3. Recalculate eligible Questions using current historical Accuracy.
4. In one transaction, create the Session and all `session_questions` rows.
5. Return only the created Session identifier.

Success response — `201 Created`:

```json
{
  "sessionId": 45
}
```

Expected errors:

| Status | Code                           | Condition                                               |
| ------ | ------------------------------ | ------------------------------------------------------- |
| `400`  | `INVALID_SESSION_FILTERS`      | A filter value is missing, malformed, or contradictory. |
| `404`  | `SUBJECT_NOT_FOUND`            | The Subject does not exist.                             |
| `409`  | `CATEGORY_SUBJECT_MISMATCH`    | A submitted Category does not belong to the Subject.    |
| `409`  | `NO_ELIGIBLE_QUESTIONS`        | The filters currently produce zero Questions.           |
| `409`  | `ACTIVE_SESSION_LIMIT_REACHED` | The Student already has five active Sessions.           |

### Get Session

```http
GET /api/sessions/{sessionId}
```

Selects and returns the Session details, a valid pending Question, and the current Session state for an active Session. This endpoint is used when opening, resuming, or refreshing a Session. Each request selects the Question randomly from those eligible in the current Round, so refreshing may show a different Question.

The Session must be active and belong to the current Student.

Success response — `200 OK`:

```json
{
  "sessionDetails": {
    "subject": "World Capitals",
    "categories": ["Asia", "Europe"]
  },
  "currentQuestion": {
    "questionId": 101,
    "questionText": "France",
    "questionAccuracy": 67
  },
  "session": {
    "roundNumber": 1,
    "questionsAnsweredCorrectly": 5,
    "questionsTotal": 20
  }
}
```

`sessionDetails.categories` contains the distinct, alphabetically ordered, non-null Categories represented by the Session's fixed Questions. It is an empty array when none of those Questions has a Category.

The response does not include `previous` state because previous Q&A is retained only in browser state and is not restored when a Session is resumed or refreshed.

Expected errors:

| Status | Code                        | Condition                               |
| ------ | --------------------------- | ----------------------------------------|
| `400`  | `INVALID_SESSION_ID`        | `sessionId` is not a valid integer.     |
| `403`  | `SESSION_FORBIDDEN`         | The Session belongs to another Student. |
| `404`  | `SESSION_NOT_FOUND`         | The Session does not exist.             |
| `409`  | `SESSION_ALREADY_COMPLETED` | The Session is no longer active.        |

### Skip Question

```http
POST /api/sessions/{sessionId}/skip
```

Validates a skip and returns a different pending Question if one exists. Skipping does not update the database nor change durable product history.

Request:

```json
{
  "questionId": 101
}
```

Success response — `200 OK`:

```json
{
  "currentQuestion": {
    "questionId": 102,
    "questionText": "Germany",
    "questionAccuracy": null
  },
  "session": {
    "roundNumber": 1,
    "questionsAnsweredCorrectly": 5,
    "questionsTotal": 20
  }
}
```

The response does not include or change `previous` state. The browser continues displaying the previous Q&A, if any, from its existing local state.

The returned Question must be pending in the current Round and different from the submitted Question if there is more than one pending Question for the Round.

Expected errors:

| Status | Code | Condition |
| --- | --- | --- |
| `400` | `INVALID_QUESTION_ID` | `questionId` is missing or malformed. |
| `403` | `SESSION_FORBIDDEN` | The Session belongs to another Student. |
| `404` | `SESSION_NOT_FOUND` | The Session does not exist. |
| `404` | `QUESTION_NOT_IN_SESSION` | The Question is not part of the Session. |
| `409` | `SESSION_ALREADY_COMPLETED` | The Session is no longer active. |
| `409` | `QUESTION_NOT_PENDING` | The submitted Question is not pending in the current Round. |
| `409` | `SKIP_NOT_AVAILABLE` | No other Question is pending in the current Round. |

### Submit Guess

```http
POST /api/sessions/{sessionId}/guesses
```

Evaluates and records one Guess for a Question in an active Session.

Request:

```json
{
  "questionId": 101,
  "guess": "Paris"
}
```

Validation:

- `questionId` must identify an incomplete Question belonging to the Session.
- `guess` must be a string no longer than 100 characters.
- An empty Guess is valid and is evaluated as incorrect.
- The Session must be active and belong to the current Student.

The server reads the Primary Answer, optional first Alternate Answer, all additional Answers, and the optional Memory Tip in one database query. It evaluates the Guess independently against each Answer in TypeScript, then uses the transaction defined in `Database.md` to update durable state. Any available Answer may make the Attempt correct.

Success response when the Session remains active — `200 OK`:

```json
{
  "sessionCompleted": false,
  "previous": {
    "answerTexts": ["Paris"],
    "correct": true,
    "memoryTip": null
  },
  "currentQuestion": {
    "questionId": 102,
    "questionText": "Germany",
    "questionAccuracy": 50
  },
  "session": {
    "roundNumber": 1,
    "questionsAnsweredCorrectly": 5,
    "questionsTotal": 20
  }
}
```

Success response when the Guess completes the Session — `200 OK`:

```json
{
  "sessionCompleted": true
}
```

The Resonse questionId shall be different from the Request questionId, if possible. The only time it is not possible is if there is only one questionId in the Session that has not been completed.

`previous.answerTexts` contains every non-overlapping available Answer without truncation after every Guess: the Primary Answer, the first Alternate Answer when present, then every additional Answer in stored order. A lower-priority Answer is omitted when either normalized Answer contains the other. Supported Answer tokens are replaced with their preferred values before the response is created.

`previous.memoryTip` is the submitted Question's plain-text Memory Tip when `questions.tip_text` is nonempty after trimming, regardless of whether the Guess is correct. It is `null` when the Question does not have a nonempty tip. It belongs to the most recently submitted Question, not `currentQuestion`.

Expected errors:

| Status | Code | Condition |
| --- | --- | --- |
| `400` | `INVALID_GUESS` | Guess is missing, is not a string, or exceeds 100 characters.  |
| `400` | `INVALID_QUESTION_ID` | `questionId` is missing or malformed. |
| `403` | `SESSION_FORBIDDEN` | The Session belongs to another Student. |
| `404` | `SESSION_NOT_FOUND` | The Session does not exist. |
| `404` | `QUESTION_NOT_IN_SESSION` | The Question is not part of the Session. |
| `409` | `SESSION_ALREADY_COMPLETED` | The Session is no longer active. |
| `409` | `QUESTION_ALREADY_COMPLETED` | The Question was already completed in this Session. |

If the guesses API returns an error:
  - log the error in the logs table with details of the error.
  - the client code should display an error to the user with details of the error or use the generic error message "An unexpected server error occurred. Reloading a new question." and attempt to recover from the error.

### Abandon Session

```http
POST /api/sessions/{sessionId}/abandon
```

Marks an active Session as completed after the browser has obtained Student confirmation.

Request body:

```json
{}
```

Success response — `200 OK`:

```json
{
  "completedAt": "2026-08-16T14:30:00.000Z"
}
```

The browser confirmation dialog is a UI concern.

Expected errors:

| Status | Code | Condition |
| --- | --- | --- |
| `403` | `SESSION_FORBIDDEN` | The Session belongs to another Student. |
| `404` | `SESSION_NOT_FOUND` | The Session does not exist. |
| `409` | `SESSION_ALREADY_COMPLETED` | The Session is already completed or abandoned. |

## Server-Rendered Page Data

The following data is expected to be loaded by Server Components through server-side functions rather than by calling the application's own API:

- Landing Page active and historical Session lists.
- Session Creation Subject and Category options.
- Session Complete page details, preferred display forms of Primary Answers, and session-only Question Accuracy results calculated from the completed Session's Attempts, without Attempts from the Student's other Sessions.
- The default Subject from the Student's last completed Session.

These server-side data shapes should be kept close to the pages that use them. They do not need public HTTP contracts in this document unless browser-side requirements later make an endpoint useful.

## Route Handler Placement

Suggested file structure:

```text
src/app/api/
  login/route.ts
  students/route.ts
  sessions/route.ts
  sessions/preview/route.ts
  sessions/[sessionId]/route.ts
  sessions/[sessionId]/guesses/route.ts
  sessions/[sessionId]/skip/route.ts
  sessions/[sessionId]/abandon/route.ts
```

Every Route Handler that uses PostgreSQL must use the Node.js runtime rather than the Edge runtime.

## API Smoke Tests

1. Create a valid Student, set the cookie, and reject an exact duplicate Username.
2. Log in with exact case and reject different case.
3. Preview Session filters, including a zero-Question result.
4. Start a Session and confirm the API returns only the Session identifier, then get the Session and confirm it returns the details, initial Question, and Session state.
5. Reject Session creation when there are no eligible Questions or five active Sessions.
6. Submit incorrect and correct Guesses, including an empty Guess and Guesses matching each available Answer.
7. Confirm Guess responses return the previous answer result, next-Question, and Session state.
8. Complete a Session and return `sessionCompleted: true`.
9. Skip without incrementing Attempts or changing previous answer result.
10. Reject Skip when no other Question is pending in the Round.
11. Abandon an active Session and retain its historical progress.
12. Reject access to another Student's Session.
13. Return the common error shape without exposing internal error details.
