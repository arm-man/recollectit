import Link from "next/link";
import { redirect } from "next/navigation";

import { SessionQuestionPage } from "./SessionQuestionPage";
import styles from "./page.module.css";
import { getCurrentStudent } from "@/server/student-identity";

export const runtime = "nodejs";

type SessionPageProps = {
  params: Promise<{ sessionId: string }>;
};

export default async function SessionPage({ params }: SessionPageProps) {
  const student = await getCurrentStudent();

  if (!student) {
    redirect("/");
  }

  const { sessionId } = await params;

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

      <SessionQuestionPage sessionId={sessionId} />
    </div>
  );
}
