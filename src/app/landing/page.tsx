import Link from "next/link";
import { redirect } from "next/navigation";

import { ActiveSessions } from "./ActiveSessions";
import styles from "./page.module.css";
import { getActiveSessions } from "@/server/session-db";
import { getCurrentStudent } from "@/server/student-identity";

export const runtime = "nodejs";

export default async function LandingPage() {
  const student = await getCurrentStudent();

  if (!student) {
    redirect("/");
  }

  const activeSessions = await getActiveSessions(student.id);

  return (
    <div className={styles.page}>
      <header className={styles.header}>
        <div className={styles.wordmark} aria-label="Recollect It">
          <span>Recollect</span>
          <span className={styles.wordmarkAccent}>It</span>
        </div>
      </header>

      <main className={styles.main}>
        <div className={styles.introduction}>
          <p className={styles.eyebrow}>Landing Page</p>
          <h1>
            Welcome, <span>{student.username}</span>
          </h1>
        </div>

        <section className={styles.createSession} aria-label="New session">
          <Link href="/sessions/create" className={styles.createSessionButton}>
            Create New Session
          </Link>
        </section>

        <div className={styles.sessionSections}>
          <section className={styles.sessionSection}>
            <h2>Active Sessions</h2>
            <ActiveSessions sessions={activeSessions} />
          </section>

          <section className={styles.sessionSection}>
            <h2>Completed Sessions</h2>
            <p>No completed sessions.</p>
          </section>
        </div>
      </main>
    </div>
  );
}
