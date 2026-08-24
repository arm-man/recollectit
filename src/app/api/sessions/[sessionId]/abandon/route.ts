import { getCurrentStudent } from "@/server/student-identity";
import { logUnexpectedError } from "@/server/logs";
import { abandonSession } from "@/server/sessions";

export const runtime = "nodejs";

type ApiErrorCode =
  | "UNAUTHORIZED"
  | "INVALID_SESSION_ID"
  | "SESSION_FORBIDDEN"
  | "SESSION_NOT_FOUND"
  | "SESSION_ALREADY_COMPLETED"
  | "INTERNAL_ERROR";

type RouteContext = {
  params: Promise<{ sessionId: string }>;
};

const POSITIVE_INTEGER_PATTERN = /^[1-9]\d*$/;

function errorResponse(code: ApiErrorCode, message: string, status: number) {
  return Response.json({ error: { code, message } }, { status });
}

function parseSessionId(value: string): number | null {
  if (!POSITIVE_INTEGER_PATTERN.test(value)) {
    return null;
  }

  const sessionId = Number(value);
  return Number.isSafeInteger(sessionId) ? sessionId : null;
}

export async function POST(
  _request: Request,
  context: RouteContext,
): Promise<Response> {
  try {
    const student = await getCurrentStudent();

    if (!student) {
      return errorResponse("UNAUTHORIZED", "Please log in to continue.", 401);
    }

    const { sessionId: sessionIdValue } = await context.params;
    const sessionId = parseSessionId(sessionIdValue);

    if (sessionId === null) {
      return errorResponse(
        "INVALID_SESSION_ID",
        "The Session identifier is invalid.",
        400,
      );
    }

    const result = await abandonSession(student.id, sessionId);

    if (result.status === "forbidden") {
      return errorResponse(
        "SESSION_FORBIDDEN",
        "Session belongs to another student.",
        403,
      );
    }

    if (result.status === "not-found") {
      return errorResponse(
        "SESSION_NOT_FOUND",
        "The Session does not exist.",
        404,
      );
    }

    if (result.status === "completed") {
      return errorResponse(
        "SESSION_ALREADY_COMPLETED",
        "This Session has already been completed.",
        409,
      );
    }

    return Response.json({ completedAt: result.completedAt.toISOString() });
  } catch (error) {
    try {
      await logUnexpectedError(
        "POST /api/sessions/{sessionId}/abandon failed",
        error,
      );
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
