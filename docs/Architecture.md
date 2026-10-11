# Recollect It Architecture

## Overview

Recollect It is a small, cloud-hosted web application.

The architecture should be as simple as practical for development, deployment, hosting, and maintenance.

The initial release will use a **single full-stack Next.js application** connected directly to a managed PostgreSQL database.

`Product.md` defines product behavior. This document defines the technical architecture and should not duplicate product requirements.

## Architecture Principles

1. Prefer the simplest solution that satisfies the current requirements.
2. Do not introduce infrastructure, services, libraries, or abstractions without a demonstrated need.
3. Keep the application as a single deployable application.
4. Use direct SQL rather than an ORM.
5. Use managed cloud services where they eliminate meaningful setup or maintenance.
6. Optimize for the initial release rather than hypothetical future requirements.
7. Add complexity later when a specific requirement justifies it.

## Technology Stack

* **Language:** TypeScript
* **Web framework:** Next.js with App Router
* **UI:** React
* **Database:** PostgreSQL
* **Database access:** Direct parameterized SQL
* **PostgreSQL client:** `pg`
* **Application hosting:** Vercel
* **Web analytics:** Vercel Web Analytics
* **Database hosting:** Neon
* **Log email delivery:** Resend
* **Package manager:** npm
* **Source control:** Git and GitHub

No ORM will be used.

No PostgreSQL installation is required on the development computer.

## High-Level Architecture

```text
Browser
   | page requests and mutation API requests
   v
Next.js Application
   |-- Server Components
   |-- Route Handlers
   |
   | direct SQL
   v
Neon PostgreSQL
```

Each environment consists of one Next.js application connected to one PostgreSQL database. Development and production use separate databases.

The browser never connects directly to PostgreSQL.

Route Handlers provide HTTP API endpoints within the Next.js application. There is no separately deployed backend or API service.

## Environments

Use separate Neon databases for development and production.

```text
Development

Browser
   |
   v
Next.js running locally
   |
   v
Neon Development Database


Production

Browser
   |
   v
Next.js on Vercel
   |
   v
Neon Production Database
```

Local development therefore requires only:

* Git
* Node.js
* npm
* Internet access

A local PostgreSQL installation is not required.

## Application Structure

Keep the source structure small.

A reasonable initial structure is:

```text
src/
  app/
    api/
    ...
  components/
  server/
    db.ts
    students.ts
    student-db.ts
    sessions.ts
    session-db.ts
    guess-evaluation.ts
	...

database/
  001_migration_initial.sql

docs/
  Product.md
  Architecture.md
  Database.md
  API.md
```

Additional directories should be created only when the amount of code makes them useful.

Do not create architectural layers merely to follow a pattern.

## Next.js

Use Next.js for both the UI and server-side application code.

Prefer:

* Server Components for retrieving and rendering server data.
* Route Handlers with explicit HTTP API endpoints for application mutations.
* Client Components only where browser-side interactivity requires them.

Recollect It mutations must use Route Handlers under `src/app/api/` rather than Server Actions.

Examples of mutations include:

* Creating a Student.
* Starting or abandoning a Session.
* Submitting a Guess.

Client Components should call these endpoints using ordinary HTTP requests. Prefer POST for application actions; use other HTTP methods when they make the endpoint clearer.

Each Route Handler should:

1. Validate the request on the server.
2. Call a server-side business function, which coordinates product rules and calls database functions as needed.
3. Return an explicit HTTP status and, when the browser needs data, a small JSON response.

The architecture should have a lightweight separation: Route Handler → business function → database function → PostgreSQL.

The endpoint contracts belong in `API.md`.

Use a consistent minimal JSON error shape across endpoints.

Do not use Server Actions for Recollect It mutations unless this architecture decision is deliberately revisited.

Server Components may retrieve data directly through server-side database modules. They do not need to call the application's own HTTP endpoints for reads.

Do not create a separate REST, GraphQL, or other backend service. The Route Handlers are part of the same Next.js application and deployment.

Server Components and Route Handlers that access PostgreSQL must use the Next.js Node.js runtime rather than the Edge runtime.

## Database Access

Use the `pg` PostgreSQL client and direct SQL.

Create one small server-only database module that initializes and exports a shared `pg` connection pool. Use Neon’s pooled application connection string. Do not add a separate database framework around it.

SQL must:

* Execute only on the server.
* Use parameters for values supplied by users.
* Be kept out of React UI components.

Keep SQL in server-only files rather than React components. Group related queries together when that improves readability; a separate module for every table or query is not required.

Avoid adding:

* An ORM.
* A repository framework.
* A database abstraction framework.
* Generated database models.
* A query builder.

These can be introduced later if direct SQL becomes difficult to maintain.

## Database Schema

PostgreSQL is the authoritative persistent data store.

The detailed schema belongs in `Database.md`.

Use PostgreSQL primary keys, foreign keys, unique constraints, and check constraints to enforce database invariants where practical.

The database will persist the product concepts that require durable state, including:

* Students.
* Subjects.
* Categories.
* Questions and Answers.
* Sessions and their Questions.
* Session Question attempt counts.
* Server-side error and warning logs.

Do not duplicate detailed table definitions in this document.

## Database Changes

Database changes should be written as ordinary SQL and stored in source control.

Example:

```text
database/
  001_migration_initial.sql
  002_seed_world_capitals.sql
  003_migration_example_change.sql
```

For the initial release, migration SQL may be applied manually to Neon.

Every `.sql` filename must begin with its numeric sequence followed by either `migration` or `seed`, using the format `<number>_migration_<description>.sql` or `<number>_seed_<description>.sql`.

A dedicated migration framework is not required.

Introduce migration tooling only if manually applying versioned SQL becomes burdensome or error-prone.

Migration files must be applied in numeric order. Once a migration has been applied to production, it must not be edited; corrections require a new migration file. Apply and verify migrations in development before applying them to production.

## Application State

PostgreSQL should contain durable state needed to resume a Session.

Temporary UI state should remain in the browser or React component state when it does not need to survive navigation or refresh.

Do not add:

* Redis.
* A distributed cache.
* A server-side session store.
* A separate state-management system such as Redux.

Use ordinary React state when local browser state is sufficient.

## Student Identity

The initial release intentionally does not provide secure Student authentication.

Students identify themselves using the Username rules defined in `Product.md`.

The application stores the current Student identifier in a browser cookie so the Student does not need to re-enter it during ordinary navigation.

The current-Student cookie should be set by the server and use `HttpOnly`, `SameSite=Lax`, and `Secure` in production. It must not be treated as proof of authenticated identity.

Logging out uses a normal HTML form that sends `POST /api/logout` to a Route Handler. The Route Handler deletes the current-Student cookie and redirects the browser to `/`. Client-side JavaScript cannot delete the cookie because it is `HttpOnly`.

The application recognizes a current Student only when the cookie contains a valid Student ID that resolves to an existing `students` row. The Student Access page at `/` redirects a recognized Student to `/landing`; `/landing` redirects a visitor without a recognized Student back to `/`.

Because anyone who knows another Student's Username can already access that Student's account, the cookie is a convenience mechanism rather than an authentication credential.

Do not introduce an authentication framework for the initial release.

Authentication can be redesigned if passwords or stronger identity verification are added in a future release.

## Administration

Do not build a separate administrative application or administrative UI for the initial release unless it becomes necessary.

Initially, the Administrator may create, edit, or delete Subjects, Categories, Questions, and Answers directly through Neon using SQL.

This avoids building:

* Administrator authentication.
* Administrator pages.
* Administrator forms.
* Administrator authorization logic.
* Additional CRUD application code.

If direct database administration becomes inconvenient, a simple administrative UI can be added later.

Students must not have access to these database-management capabilities.

## Business Logic

Product rules that affect trusted or persistent behavior must be enforced on the server, using straightforward TypeScript, SQL, or PostgreSQL constraints as appropriate. Keep related code together and extract reusable functions only when useful.

Keep Route Handlers focused on HTTP concerns. Put product rules and operation coordination in small server-side business functions. Business functions may call small database functions containing direct parameterized SQL. Do not introduce additional service, repository, use-case, or dependency-injection layers.

Examples include:

* Session creation.
* Question filtering.
* Round progression.
* Random Question selection.
* Skip behavior.
* Guess normalization.
* Damerau-Levenshtein comparison.
* Accuracy calculation.
* Session completion.

Keep rules that do not require database access as ordinary TypeScript functions when practical.

This makes them easier to understand and test without creating a formal business-logic framework.

## Transactions

Use PostgreSQL transactions only where multiple database changes must succeed or fail together to preserve valid data.

Do not wrap ordinary single-statement operations in unnecessary transactions.

## Concurrency

The expected initial audience is small.

Do not introduce distributed locking or other specialized concurrency infrastructure.

Use normal PostgreSQL constraints and transactions where correctness requires them.

More sophisticated concurrency controls should be added only if actual usage demonstrates a problem.

- Student creation relies on the database unique constraint to resolve concurrent duplicate Username creation.
- Session creation recalculates eligibility and active Session count on the server. The known rare race that could create a sixth active Session is acceptable under `Database.md`.
- The browser should disable an action button while its request is pending to reduce accidental duplicate requests.
- No idempotency-key framework is required initially.

## Guess Evaluation

Guess evaluation should be implemented as ordinary TypeScript code rather than in PostgreSQL.

The implementation should:

1. Expand supported Answer tokens into validation variants through a centralized, pure TypeScript token processor.
2. Normalize the Guess once and normalize each available Answer variant according to `Product.md`.
3. Compare the Guess independently with every available Answer variant.
4. Calculate Damerau-Levenshtein distance and apply the threshold for the particular Answer variant being compared.
5. Return true when any variant matches.

Keep this logic independent enough to unit test directly.

The same token processor must provide the preferred display form before a Primary Answer is returned to browser-facing code. Unknown or malformed tokens remain literal and are reported through the centralized server logging flow without failing the Session workflow.

The normalized values do not need to be stored in the database unless a future requirement demonstrates a reason to do so.
Answers remain server-only until the existing Guess-feedback workflow permits revealing them. Current-Question responses never expose Answers; after a Guess, the API returns only the Primary Answer for a correct Guess and every non-overlapping available Answer for an incorrect Guess. Server-rendered completion data exposes only the Primary Answer.

## Random Question Selection

Question ordering is randomized according to `Product.md`.

No specialized randomization service is needed.

Use normal application logic and PostgreSQL data to determine eligible Questions, then select among them according to the Session rules.

Cryptographically secure randomness is not required.

## Validation

Validate all untrusted request data on the server. Validation is required before using input in database operations or business logic.

Client-side validation may also be used when it improves the user experience, but it should remain simple.

Do not introduce a separate validation framework unless native TypeScript/application validation becomes cumbersome.

## Secrets and Configuration

The application requires a PostgreSQL connection string. Log email notifications also require a Resend API key and destination email address.

Database credentials must not be committed to Git.

Use:

* `.env.local` for development environment variables.
* Vercel environment variables for production configuration.

Use these server-only environment variables:

* `DATABASE_URL` for the PostgreSQL connection string.
* `RESEND_API_KEY` for the Resend API key.
* `LOG_EMAIL_TO` for the log notification recipient.

Any future credentials or authentication secrets should be handled the same way.

Vercel preview deployments must not receive the production database connection string. Initially, previews may use the development database or have no database configured.

## Error Handling

Handle expected errors with simple user-facing messages.

Examples include:

* Username already exists.
* Session filters produce zero Questions.
* The Student has reached the active-Session limit.
* A Question cannot currently be skipped.

Unexpected server errors should be written to the `logs` table without exposing database credentials, SQL internals, or stack traces to Students.

Do not create a custom error-handling framework unless one becomes useful.

## Logging and Monitoring

Write server-side errors and operational warnings to the PostgreSQL `logs` table. Errors use the default `error` severity; warnings use severity `warning`. Log messages must not contain credentials, connection strings, or other secrets.

After each successful application insert into `logs`, send a plain-text email through Resend, except when Student ID `1` completes a Session. That completion message remains in the `logs` table but does not send an email. The email body is the exact stored log message. Email delivery is best-effort: a send failure is written to the server console and must not roll back the log insert or fail the user-facing operation. Keep this behavior in the centralized logging flow so callers do not implement email delivery separately.

Use Vercel Web Analytics for privacy-friendly aggregate website traffic analytics. Integrate it through the root application layout using the `@vercel/analytics` package; it does not require application environment variables.

Do not introduce another logging, monitoring, tracing, or observability service beyond this Resend notification initially.

Add one only if troubleshooting actual production use demonstrates a need.

## Testing

Testing should concentrate on logic where mistakes would affect product behavior.

### Unit Tests

Initial unit tests should focus on the most consequential pure logic, especially:

* Guess normalization.
* Damerau-Levenshtein evaluation.
* Available Answer evaluation, including Answer-specific distance thresholds.
* Accuracy calculations.
* Question eligibility.
* Round progression.
* Skip behavior.
* Session completion.

### Database and Workflow Testing

For the initial release, verify the principal database workflows using a short, repeatable manual smoke-test checklist. This should include Student creation, Session creation, Guess processing, Session abandonment, and Session completion.

Add automated database tests when regressions or increasing development activity justify their setup and maintenance.

### Browser Tests

Do not build a large end-to-end browser test suite initially.

Add a small number of end-to-end tests later if they provide enough value to justify their maintenance.

## Deployment

Production deployment is:

```text
GitHub
   |
   v
Vercel
   |
   v
Next.js
   |
   v
Neon PostgreSQL
```

Vercel deploys the Next.js application from GitHub.

Neon hosts PostgreSQL separately.

No production server needs to be manually maintained.

## Hosting Cost

The application should initially use hosting tiers appropriate for its small audience and low traffic.

Avoid paid infrastructure until application usage or service restrictions require it.

Hosting choices may change later without changing the fundamental application architecture.

## Initial Release Non-Goals

Do not introduce the following unless a requirement changes:

* Separate frontend and backend applications.
* Separate API service.
* Microservices.
* ORM.
* Query builder.
* Local PostgreSQL.
* Docker.
* Kubernetes.
* Redis.
* Message queues.
* GraphQL.
* WebSockets.
* Serverless infrastructure beyond what the hosting platform provides automatically.
* Dedicated authentication framework.
* Administrative application or UI.
* Dedicated migration framework.
* Repository pattern.
* Dependency injection framework.
* Distributed caching.
* Dedicated logging platform.
* Dedicated monitoring platform.
* Dedicated analytics infrastructure beyond Vercel Web Analytics.
* Search engine.
* CDN configuration beyond hosting defaults.

## When to Add Complexity

A technology or architectural layer should be added only when:

1. An existing Product.md requirement cannot reasonably be implemented without it; or
2. The current implementation has demonstrated a concrete maintainability, reliability, security, performance, or operational problem.

Do not add infrastructure merely because it may become useful someday.
