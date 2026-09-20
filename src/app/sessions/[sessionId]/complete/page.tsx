import type { ReactNode } from "react";
import Link from "next/link";
import { redirect } from "next/navigation";

import styles from "./page.module.css";
import { logError, logUnexpectedError } from "@/server/logs";
import { getSessionComplete } from "@/server/sessions";
import { getCurrentStudent } from "@/server/student-identity";

export const runtime = "nodejs";

type SessionCompletePageProps = {
  params: Promise<{ sessionId: string }>;
};

const POSITIVE_INTEGER_PATTERN = /^[1-9]\d*$/;
const DATE_FORMATTER = new Intl.DateTimeFormat("en-US", {
  year: "numeric",
  month: "long",
  day: "numeric",
  timeZone: "UTC",
});

function parseSessionId(value: string): number | null {
  if (!POSITIVE_INTEGER_PATTERN.test(value)) {
    return null;
  }

  const sessionId = Number(value);
  return Number.isSafeInteger(sessionId) ? sessionId : null;
}

async function logPageError(message: string): Promise<void> {
  try {
    await logError(message);
  } catch {
    // A logging failure must not prevent the controlled page from rendering.
  }
}

type SessionCompleteLoadResult =
  | Awaited<ReturnType<typeof getSessionComplete>>
  | { status: "unexpected-error" };

async function loadSessionComplete(
  studentId: number,
  sessionId: number,
): Promise<SessionCompleteLoadResult> {
  try {
    return await getSessionComplete(studentId, sessionId);
  } catch (error) {
    try {
      await logUnexpectedError(
        `Session Complete page failed for Session ${sessionId}, Student ${studentId}`,
        error,
      );
    } catch {
      // A logging failure must not replace the generic page error.
    }

    return { status: "unexpected-error" };
  }
}

function PageShell({ children }: { children: ReactNode }) {
  return (
    <div className={styles.page}>
      <header className={styles.header}>
        <Link
          href="/landing"
          className={styles.wordmark}
          aria-label="Recollect It — Home"
        >
          <span>Recollect</span>
          <span className={styles.wordmarkAccent}>It</span>
        </Link>
      </header>
      {children}
    </div>
  );
}

function ErrorContent({ message }: { message: string }) {
  return (
    <main className={styles.main}>
      <section className={styles.errorCard} aria-live="assertive">
        <h1>Unable to display Session</h1>
        <p>{message}</p>
      </section>
    </main>
  );
}

export default async function SessionCompletePage({
  params,
}: SessionCompletePageProps) {
  const student = await getCurrentStudent();

  if (!student) {
    redirect("/");
  }

  const { sessionId: sessionIdValue } = await params;
  const sessionId = parseSessionId(sessionIdValue);

  if (sessionId === null) {
    await logPageError(
      `Session Complete page received an invalid Session identifier from Student ${student.id}.`,
    );
    return (
      <PageShell>
        <ErrorContent message="The Session identifier is invalid." />
      </PageShell>
    );
  }

  const result = await loadSessionComplete(student.id, sessionId);

  if (result.status === "unexpected-error") {
    return (
      <PageShell>
        <ErrorContent message="Something went wrong while loading this Session." />
      </PageShell>
    );
  }

  if (result.status === "not-found") {
    await logPageError(
      `Session Complete page could not find Session ${sessionId} for Student ${student.id}.`,
    );
    return (
      <PageShell>
        <ErrorContent message="The Session does not exist." />
      </PageShell>
    );
  }

  if (result.status === "forbidden") {
    await logPageError(
      `Student "${student.username}" attempted to view Session Complete page for Session ${sessionId}.`,
    );
    return (
      <PageShell>
        <ErrorContent message="This Session belongs to another Student." />
      </PageShell>
    );
  }

  if (result.status === "in-progress") {
    await logPageError(
      `Student ${student.id} opened Session Complete page for active Session ${sessionId}.`,
    );
    return (
      <PageShell>
        <ErrorContent message="This Session is still in progress." />
      </PageShell>
    );
  }

  const { session } = result;

  return (
    <PageShell>
      <main className={styles.main}>
        <section className={styles.completionBanner}>
          <p className={styles.eyebrow}>Session ended</p>
          <h1>
            {session.isAbandoned ? "Session abandoned" : "Session complete"}
          </h1>
          <p>
            {session.isAbandoned
              ? "This Session ended after it was abandoned."
              : "Good job!"}
          </p>
        </section>

        <section className={styles.sessionDetails} aria-label="Session details">
          <div>
            <p>Subject</p>
            <h2>{session.subject}</h2>
          </div>
          {session.categories.length > 0 ? (
            <div>
              <p>Categories</p>
              <p>{session.categories.join(", ")}</p>
            </div>
          ) : null}
          <div>
            <p>Completed</p>
            <time dateTime={session.completedAt.toISOString()}>
              {DATE_FORMATTER.format(session.completedAt)}
            </time>
          </div>
        </section>

        <dl className={styles.summaryGrid}>
          {!session.isAbandoned && session.sessionAccuracy !== null ? (
            <div className={styles.accuracySummary}>
              <dt>Session Accuracy</dt>
              <dd>{session.sessionAccuracy}%</dd>
            </div>
          ) : null}
          <div>
            <dt>Unique Questions</dt>
            <dd>{session.uniqueQuestionCount}</dd>
          </div>
          <div>
            <dt>Total Attempts</dt>
            <dd>{session.guessCount}</dd>
          </div>
        </dl>

        {!session.isAbandoned ? (
          <section className={styles.questionResults}>
            <h2>Question Results</h2>
            <div className={styles.tableContainer}>
              <table>
                <thead>
                  <tr>
                    <th scope="col">Question</th>
                    <th scope="col">Answer</th>
                    <th scope="col">Attempts</th>
                    <th scope="col">Question Accuracy</th>
                  </tr>
                </thead>
                <tbody>
                  {session.questions.map((question) => (
                    <tr key={question.questionId}>
                      <td>{question.question}</td>
                      <td>{question.answer}</td>
                      <td>{question.attempts}</td>
                      <td>{question.questionAccuracy}%</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </section>
        ) : null}
      </main>
    </PageShell>
  );
}
