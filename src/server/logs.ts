import "server-only";

import { pool } from "@/server/db";

export async function logInfo(message: string): Promise<void> {
  await pool.query(
    `INSERT INTO logs (severity, message)
     VALUES ('info', $1)`,
    [message],
  );
}

export async function logError(message: string): Promise<void> {
  await pool.query(`INSERT INTO logs (message) VALUES ($1)`, [message]);
}

export async function logUnexpectedError(
  context: string,
  error: unknown,
): Promise<void> {
  const errorDescription =
    error instanceof Error
      ? `${error.name}: ${error.message}`
      : "Unknown error";

  await pool.query(`INSERT INTO logs (message) VALUES ($1)`, [
    `${context}: ${errorDescription}`,
  ]);
}
