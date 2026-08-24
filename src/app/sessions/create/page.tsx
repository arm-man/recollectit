import Link from "next/link";
import { redirect } from "next/navigation";

import { SessionCreationForm } from "./SessionCreationForm";
import styles from "./page.module.css";
import { getSessionCreationPageData } from "@/server/session-db";
import { getCurrentStudent } from "@/server/student-identity";

export const runtime = "nodejs";

export default async function SessionCreationPage() {
  const student = await getCurrentStudent();

  if (!student) {
    redirect("/");
  }

  const pageData = await getSessionCreationPageData(student.id);

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

      <SessionCreationForm {...pageData} />
    </div>
  );
}
