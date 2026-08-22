import "server-only";

import {
  doesStudentUsernameExist,
  insertStudent,
  type Student,
} from "@/server/student-db";

const MAX_USERNAME_LENGTH = 25;
const WHITESPACE_PATTERN = /\s/u;
const CONTROL_OR_FORMATTING_PATTERN = /[\p{Cc}\p{Cf}]/u;

export type CreateStudentResult =
  | { status: "created"; student: Student }
  | { status: "invalid" }
  | { status: "duplicate"; username: string };

export function normalizeUsername(username: string): string {
  return username.trim().normalize("NFC");
}

export function isValidUsername(username: string): boolean {
  const characterCount = Array.from(username).length;

  return (
    characterCount > 0 &&
    characterCount <= MAX_USERNAME_LENGTH &&
    !WHITESPACE_PATTERN.test(username) &&
    !CONTROL_OR_FORMATTING_PATTERN.test(username)
  );
}

export async function createStudent(
  submittedUsername: string,
): Promise<CreateStudentResult> {
  const username = normalizeUsername(submittedUsername);

  if (!isValidUsername(username)) {
    return { status: "invalid" };
  }

  if (await doesStudentUsernameExist(username)) {
    return { status: "duplicate", username };
  }

  const student = await insertStudent(username);

  if (!student) {
    return { status: "duplicate", username };
  }

  return { status: "created", student };
}
