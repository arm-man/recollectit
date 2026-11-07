import "server-only";

import { cookies } from "next/headers";

import { findStudentById, type Student } from "@/server/student-db";

const CURRENT_STUDENT_COOKIE = "recollect_student";
const COOKIE_MAX_AGE_SECONDS = 60 * 60 * 24 * 365;
const POSITIVE_INTEGER_PATTERN = /^[1-9]\d*$/;

export async function getCurrentStudent(): Promise<Student | null> {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get(CURRENT_STUDENT_COOKIE)?.value;

  if (!cookieValue || !POSITIVE_INTEGER_PATTERN.test(cookieValue)) {
    return null;
  }

  const studentId = Number(cookieValue);

  if (!Number.isSafeInteger(studentId)) {
    return null;
  }

  return findStudentById(studentId);
}

export async function setCurrentStudentCookie(
  studentId: number,
): Promise<void> {
  const cookieStore = await cookies();

  cookieStore.set(CURRENT_STUDENT_COOKIE, String(studentId), {
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: COOKIE_MAX_AGE_SECONDS,
  });
}

export async function clearCurrentStudentCookie(): Promise<void> {
  const cookieStore = await cookies();

  cookieStore.delete(CURRENT_STUDENT_COOKIE);
}
