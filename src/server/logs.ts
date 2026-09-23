import "server-only";

import { pool } from "@/server/db";
import { sendLogEmail } from "@/server/log-email";

async function insertLog(
  severity: "error" | "info",
  message: string,
): Promise<void> {
  await pool.query(
    `INSERT INTO logs (severity, message)
     VALUES ($1, $2)`,
    [severity, message],
  );

  await sendLogEmail(message);
}

export async function logInfo(message: string): Promise<void> {
  await insertLog("info", message);
}

export async function logError(message: string): Promise<void> {
  await insertLog("error", message);
}

export async function logUnexpectedError(
  context: string,
  error: unknown,
): Promise<void> {
  const errorDescription =
    error instanceof Error
      ? `${error.name}: ${error.message}`
      : "Unknown error";

  await insertLog("error", `${context}: ${errorDescription}`);
}
