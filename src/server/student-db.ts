import "server-only";

import { pool } from "@/server/db";

export type Student = {
  id: number;
  username: string;
};

export async function findStudentById(
  studentId: number,
): Promise<Student | null> {
  const result = await pool.query<Student>(
    `SELECT id, username
     FROM students
     WHERE id = $1`,
    [studentId],
  );

  return result.rows[0] ?? null;
}

export async function doesStudentUsernameExist(
  username: string,
): Promise<boolean> {
  const result = await pool.query(
    `SELECT 1
     FROM students
     WHERE username = $1`,
    [username],
  );

  return result.rowCount === 1;
}

export async function insertStudent(username: string): Promise<Student | null> {
  try {
    const result = await pool.query<Student>(
      `INSERT INTO students (username)
       VALUES ($1)
       RETURNING id, username`,
      [username],
    );

    return result.rows[0] ?? null;
  } catch (error) {
    if (isUniqueConstraintViolation(error)) {
      return null;
    }

    throw error;
  }
}

function isUniqueConstraintViolation(error: unknown): boolean {
  return (
    typeof error === "object" &&
    error !== null &&
    "code" in error &&
    error.code === "23505"
  );
}
