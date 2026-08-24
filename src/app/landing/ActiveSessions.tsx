"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState } from "react";

import styles from "./page.module.css";

type ActiveSessionItem = {
  sessionId: number;
  subject: string;
  categories: string[];
  createdAt: string;
};

type ActiveSessionsProps = {
  sessions: ActiveSessionItem[];
};

const GENERIC_ERROR_MESSAGE = "Something went wrong. Please try again.";
const DATE_FORMATTER = new Intl.DateTimeFormat("en-US", {
  year: "numeric",
  month: "short",
  day: "numeric",
  timeZone: "UTC",
});

function getResponseErrorMessage(body: unknown): string | null {
  if (typeof body !== "object" || body === null || !("error" in body)) {
    return null;
  }

  const error = body.error;

  if (typeof error !== "object" || error === null || !("message" in error)) {
    return null;
  }

  return typeof error.message === "string" ? error.message : null;
}

export function ActiveSessions({ sessions }: ActiveSessionsProps) {
  const router = useRouter();
  const [abandoningSessionId, setAbandoningSessionId] = useState<number | null>(
    null,
  );
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  async function abandon(session: ActiveSessionItem): Promise<void> {
    const confirmed = window.confirm(
      `Abandon the ${session.subject} Session? This cannot be undone.`,
    );

    if (!confirmed) {
      return;
    }

    setAbandoningSessionId(session.sessionId);
    setErrorMessage(null);

    try {
      const response = await fetch(
        `/api/sessions/${session.sessionId}/abandon`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({}),
        },
      );
      const responseBody: unknown = await response.json().catch(() => null);

      if (response.status === 401) {
        router.replace("/");
        return;
      }

      if (!response.ok) {
        setErrorMessage(
          getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE,
        );
        return;
      }

      router.refresh();
    } catch {
      setErrorMessage(GENERIC_ERROR_MESSAGE);
    } finally {
      setAbandoningSessionId(null);
    }
  }

  if (sessions.length === 0) {
    return <p className={styles.emptySessions}>No active sessions.</p>;
  }

  return (
    <>
      <ul className={styles.activeSessionList}>
        {sessions.map((session) => (
          <li className={styles.activeSession} key={session.sessionId}>
            <div className={styles.activeSessionDetails}>
              <h3>{session.subject}</h3>
              {session.categories.length > 0 ? (
                <p className={styles.sessionCategories}>
                  {session.categories.join(", ")}
                </p>
              ) : null}
              <p className={styles.sessionDate}>
                Created{" "}
                <time dateTime={session.createdAt}>
                  {DATE_FORMATTER.format(new Date(session.createdAt))}
                </time>
              </p>
            </div>

            <div className={styles.sessionActions}>
              <Link
                href={`/sessions/${session.sessionId}`}
                className={styles.resumeButton}
              >
                Resume
              </Link>
              <button
                type="button"
                className={styles.abandonButton}
                disabled={abandoningSessionId !== null}
                onClick={() => void abandon(session)}
              >
                {abandoningSessionId === session.sessionId
                  ? "Abandoning…"
                  : "Abandon"}
              </button>
            </div>
          </li>
        ))}
      </ul>

      {errorMessage ? (
        <p className={styles.sessionError} aria-live="assertive">
          {errorMessage}
        </p>
      ) : null}
    </>
  );
}
