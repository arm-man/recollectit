import { setCurrentStudentCookie } from "@/server/student-identity";
import { logUnexpectedError } from "@/server/logs";
import { findStudentForLogin } from "@/server/students";

export const runtime = "nodejs";

type ApiErrorCode =
  "INVALID_USERNAME" | "USERNAME_NOT_FOUND" | "INTERNAL_ERROR";

function errorResponse(code: ApiErrorCode, message: string, status: number) {
  return Response.json({ error: { code, message } }, { status });
}

export async function POST(request: Request): Promise<Response> {
  try {
    let body: unknown;

    try {
      body = await request.json();
    } catch {
      return errorResponse(
        "INVALID_USERNAME",
        "Username fails format or length validation.",
        400,
      );
    }

    if (
      typeof body !== "object" ||
      body === null ||
      !("username" in body) ||
      typeof body.username !== "string"
    ) {
      return errorResponse(
        "INVALID_USERNAME",
        "Username fails format or length validation.",
        400,
      );
    }

    const result = await findStudentForLogin(body.username);

    if (result.status === "invalid") {
      return errorResponse(
        "INVALID_USERNAME",
        "Username fails format or length validation.",
        400,
      );
    }

    if (result.status === "not-found") {
      return errorResponse(
        "USERNAME_NOT_FOUND",
        "That Username does not exist.",
        404,
      );
    }

    await setCurrentStudentCookie(result.student.id);

    return new Response(null, { status: 204 });
  } catch (error) {
    try {
      await logUnexpectedError("POST /api/login failed", error);
    } catch {
      // A logging failure must not expose or replace the generic API response.
    }

    return errorResponse(
      "INTERNAL_ERROR",
      "Something went wrong. Please try again.",
      500,
    );
  }
}
