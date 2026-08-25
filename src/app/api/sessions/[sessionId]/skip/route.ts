import { getCurrentStudent } from "@/server/student-identity";
import { logUnexpectedError } from "@/server/logs";
import { skipQuestion } from "@/server/sessions";

export const runtime = "nodejs";

type ApiErrorCode =
  | "UNAUTHORIZED"
  | "INVALID_SESSION_ID"
  | "INVALID_QUESTION_ID"
  | "SESSION_FORBIDDEN"
  | "SESSION_NOT_FOUND"
  | "QUESTION_NOT_IN_SESSION"
  | "SESSION_ALREADY_COMPLETED"
  | "QUESTION_NOT_PENDING"
  | "SKIP_NOT_AVAILABLE"
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

  const parsedValue = Number(value);
  return Number.isSafeInteger(parsedValue) ? parsedValue : null;
}

function isPositiveInteger(value: unknown): value is number {
  return typeof value === "number" && Number.isSafeInteger(value) && value > 0;
}

export async function POST(
  request: Request,
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

    let body: unknown;

    try {
      body = await request.json();
    } catch {
      return errorResponse(
        "INVALID_QUESTION_ID",
        "The Question identifier is invalid.",
        400,
      );
    }

    if (
      typeof body !== "object" ||
      body === null ||
      !("questionId" in body) ||
      !isPositiveInteger(body.questionId)
    ) {
      return errorResponse(
        "INVALID_QUESTION_ID",
        "The Question identifier is invalid.",
        400,
      );
    }

    const result = await skipQuestion(student.id, sessionId, body.questionId);

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

    if (result.status === "question-not-in-session") {
      return errorResponse(
        "QUESTION_NOT_IN_SESSION",
        "The Question does not belong to this Session.",
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

    if (result.status === "question-not-pending") {
      return errorResponse(
        "QUESTION_NOT_PENDING",
        "This Question is not pending in the current Round.",
        409,
      );
    }

    if (result.status === "skip-not-available") {
      return errorResponse(
        "SKIP_NOT_AVAILABLE",
        "There is no other Question available in the current Round.",
        409,
      );
    }

    return Response.json({
      currentQuestion: result.currentQuestion,
      session: result.session,
    });
  } catch (error) {
    try {
      await logUnexpectedError(
        "POST /api/sessions/{sessionId}/skip failed",
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
