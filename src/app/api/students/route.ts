import { setCurrentStudentCookie } from "@/server/student-identity";
import { logInfo, logUnexpectedError } from "@/server/logs";
import { createStudent } from "@/server/students";

export const runtime = "nodejs";

type ApiErrorCode =
  "INVALID_USERNAME" | "USERNAME_ALREADY_EXISTS" | "INTERNAL_ERROR";

function errorResponse(code: ApiErrorCode, message: string, status: number) {
  return Response.json({ error: { code, message } }, { status });
}

export async function POST(request: Request): Promise<Response> {
  try {
    let body: unknown;

    try {
      body = await request.json();
    } catch {
      await logInfo(
        "Student creation rejected because the request body is not valid JSON.",
      );

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
      await logInfo(
        "Student creation rejected because the Username is missing or is not a string.",
      );

      return errorResponse(
        "INVALID_USERNAME",
        "Username fails format or length validation.",
        400,
      );
    }

    const result = await createStudent(body.username);

    if (result.status === "invalid") {
      await logInfo(
        "Student creation rejected because the Username fails format or length validation.",
      );

      return errorResponse(
        "INVALID_USERNAME",
        "Username fails format or length validation.",
        400,
      );
    }

    if (result.status === "duplicate") {
      await logInfo(
        `Student creation rejected because the Username already exists. Username: ${result.username}`,
      );

      return errorResponse(
        "USERNAME_ALREADY_EXISTS",
        "The Username already exists, please create a different Username.",
        409,
      );
    }

    await setCurrentStudentCookie(result.student.id);

    return new Response(null, { status: 201 });
  } catch (error) {
    try {
      await logUnexpectedError("POST /api/students failed", error);
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
