import { getDatabaseTime } from "@/server/db";
import styles from "./page.module.css";

export default async function Home() {
  const databaseTime = await getDatabaseTime();

  return (
    <div className={styles.page}>
      <main className={styles.main}>
        <div className={styles.intro}>
          <h1>Recollect It</h1>
          <p>Database connection successful</p>
          <time dateTime={databaseTime.toISOString()}>
            {databaseTime.toISOString()}
          </time>
        </div>
      </main>
    </div>
  );
}
