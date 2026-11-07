import { NextResponse, type NextRequest } from "next/server";

const CURRENT_STUDENT_COOKIE = "recollect_student";
const COOKIE_MAX_AGE_SECONDS = 60 * 60 * 24 * 365;
const POSITIVE_INTEGER_PATTERN = /^[1-9]\d*$/;

export function proxy(request: NextRequest): NextResponse {
  const response = NextResponse.next();
  const studentId = request.cookies.get(CURRENT_STUDENT_COOKIE)?.value;

  // Only renew a cookie that can identify a Student. Pages and API handlers
  // still check whether the Student exists before granting access.
  if (
    studentId &&
    POSITIVE_INTEGER_PATTERN.test(studentId) &&
    Number.isSafeInteger(Number(studentId))
  ) {
    response.cookies.set(CURRENT_STUDENT_COOKIE, studentId, {
      httpOnly: true,
      sameSite: "lax",
      secure: process.env.NODE_ENV === "production",
      path: "/",
      maxAge: COOKIE_MAX_AGE_SECONDS,
    });
  }

  return response;
}

export const config = {
  matcher: ["/", "/landing", "/sessions/:path*", "/api/sessions/:path*"],
};
