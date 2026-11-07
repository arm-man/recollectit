"use client";

import { useState } from "react";
import Link from "next/link";

import styles from "./page.module.css";

type CompletedSessionItem = {
  sessionId: number;
  subjectId: number;
  subject: string;
  categories: string[];
  includesAllCategories: boolean;
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

const ALL_SUBJECTS = "";
const MINIMUM_SESSIONS_FOR_FILTER = 6;

export function CompletedSessions({ sessions }: CompletedSessionsProps) {
  const [selectedSubjectId, setSelectedSubjectId] = useState(ALL_SUBJECTS);
  const subjectsById = new Map(
    sessions.map((session) => [session.subjectId, session.subject]),
  );
  const subjects = [...subjectsById]
    .map(([id, title]) => ({ id, title }))
    .sort((left, right) =>
      left.title === right.title
        ? left.id - right.id
        : left.title < right.title
          ? -1
          : 1,
    );
  const shouldShowSubjectFilter =
    sessions.length >= MINIMUM_SESSIONS_FOR_FILTER && subjects.length >= 2;
  const filteredSessions =
    selectedSubjectId === ALL_SUBJECTS
      ? sessions
      : sessions.filter(
          (session) => String(session.subjectId) === selectedSubjectId,
        );
  const selectedSubject = subjects.find(
    (subject) => String(subject.id) === selectedSubjectId,
  );

  return (
    <>
      <div className={styles.completedSessionsHeader}>
        <h2>Completed Sessions</h2>
        {shouldShowSubjectFilter ? (
          <div className={styles.completedSessionsFilter}>
            <label htmlFor="completed-sessions-subject">Subject</label>
            <select
              id="completed-sessions-subject"
              value={selectedSubjectId}
              onChange={(event) => setSelectedSubjectId(event.target.value)}
            >
              <option value={ALL_SUBJECTS}>All subjects</option>
              {subjects.map((subject) => (
                <option value={subject.id} key={subject.id}>
                  {subject.title}
                </option>
              ))}
            </select>
          </div>
        ) : null}
      </div>

      {sessions.length === 0 ? (
        <p className={styles.emptySessions}>No completed sessions.</p>
      ) : filteredSessions.length === 0 ? (
        <p className={styles.emptySessions}>
          No completed sessions for {selectedSubject?.title ?? "this subject"}.
        </p>
      ) : (
        <ul className={styles.completedSessionList}>
          {filteredSessions.map((session) => (
            <li key={session.sessionId}>
              <Link
                href={`/sessions/${session.sessionId}/complete`}
                className={styles.completedSession}
              >
                <div className={styles.completedSessionDetails}>
                  <h3>{session.subject}</h3>
                  {session.categories.length > 0 ? (
                    <p className={styles.sessionCategories}>
                      {session.includesAllCategories
                        ? "All Categories"
                        : session.categories.join(", ")}
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
      )}
    </>
  );
}
