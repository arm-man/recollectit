import { redirect } from "next/navigation";

import styles from "./page.module.css";
import { getCurrentStudent } from "@/server/student-identity";

export default async function LandingPage() {
  const student = await getCurrentStudent();

  if (!student) {
    redirect("/");
  }

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
          <button type="button" disabled>
            Create New Session
          </button>
        </section>

        <div className={styles.sessionSections}>
          <section className={styles.sessionSection}>
            <h2>Active Sessions</h2>
            <p>No active sessions.</p>
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
