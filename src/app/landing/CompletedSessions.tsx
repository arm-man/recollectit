import Link from "next/link";

import styles from "./page.module.css";

type CompletedSessionItem = {
  sessionId: number;
  subject: string;
  categories: string[];
  completedAt: string;
  isAbandoned: boolean;
  sessionAccuracy: number | null;
};

type CompletedSessionsProps = {
  sessions: CompletedSessionItem[];
};

const DATE_FORMATTER = new Intl.DateTimeFormat("en-US", {
  year: "numeric",
  month: "short",
  day: "numeric",
  timeZone: "UTC",
});

export function CompletedSessions({ sessions }: CompletedSessionsProps) {
  if (sessions.length === 0) {
    return <p className={styles.emptySessions}>No completed sessions.</p>;
  }

  return (
    <ul className={styles.completedSessionList}>
      {sessions.map((session) => (
        <li key={session.sessionId}>
          <Link
            href={`/sessions/${session.sessionId}/complete`}
            className={styles.completedSession}
          >
            <div className={styles.completedSessionDetails}>
              <h3>{session.subject}</h3>
              {session.categories.length > 0 ? (
                <p className={styles.sessionCategories}>
                  {session.categories.join(", ")}
                </p>
              ) : null}
              <p className={styles.sessionDate}>
                Completed{" "}
                <time dateTime={session.completedAt}>
                  {DATE_FORMATTER.format(new Date(session.completedAt))}
                </time>
              </p>
            </div>

            <p
              className={
                session.isAbandoned
                  ? styles.abandonedLabel
                  : styles.accuracyLabel
              }
            >
              {session.isAbandoned
                ? "Abandoned"
                : `${session.sessionAccuracy}% accuracy`}
            </p>
          </Link>
        </li>
      ))}
    </ul>
  );
}
