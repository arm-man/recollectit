import "server-only";

import { Pool } from "pg";

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is required.");
}

export const pool: Pool = new Pool({ connectionString });

export async function getDatabaseTime(): Promise<Date> {
  const result = await pool.query<{ currentTime: Date }>(
    'SELECT NOW() AS "currentTime"',
  );

  return result.rows[0].currentTime;
}
