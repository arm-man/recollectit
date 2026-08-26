import { getCurrentStudent } from "@/server/student-identity";
import { logError, logInfo, logUnexpectedError } from "@/server/logs";
import { submitGuess } from "@/server/sessions";

export const runtime = "nodejs";

type ApiErrorCode =
  | "UNAUTHORIZED"
  | "INVALID_SESSION_ID"
  | "INVALID_QUESTION_ID"
  | "INVALID_GUESS"
  | "SESSION_FORBIDDEN"
  | "SESSION_NOT_FOUND"
  | "QUESTION_NOT_IN_SESSION"
  | "SESSION_ALREADY_COMPLETED"
  | "QUESTION_ALREADY_COMPLETED"
  | "INTERNAL_ERROR";

type RouteContext = {
  params: Promise<{ sessionId: string }>;
};

const POSITIVE_INTEGER_PATTERN = /^[1-9]\d*$/;

function errorResponse(code: ApiErrorCode, message: string, status: number) {
  return Response.json({ error: { code, message } }, { status });
}

async function loggedErrorResponse(
  code: ApiErrorCode,
  message: string,
  status: number,
  details: string,
): Promise<Response> {
  try {
    await logError(
      `POST /api/sessions/{sessionId}/guesses returned ${code}: ${details}`,
    );
  } catch {
    // A logging failure must not expose or replace the controlled API response.
  }

  return errorResponse(code, message, status);
}

function parseSessionId(value: string): number | null {
  if (!POSITIVE_INTEGER_PATTERN.test(value)) {
    return null;
  }

  const sessionId = Number(value);
  return Number.isSafeInteger(sessionId) ? sessionId : null;
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
      return loggedErrorResponse(
        "UNAUTHORIZED",
        "Please log in to continue.",
        401,
        "No current Student was available.",
      );
    }

    const { sessionId: sessionIdValue } = await context.params;
    const sessionId = parseSessionId(sessionIdValue);

    if (sessionId === null) {
      return loggedErrorResponse(
        "INVALID_SESSION_ID",
        "The Session identifier is invalid.",
        400,
        `Student ${student.id} submitted an invalid Session identifier.`,
      );
    }

    let body: unknown;

    try {
      body = await request.json();
    } catch {
      return loggedErrorResponse(
        "INVALID_GUESS",
        "The Guess is invalid.",
        400,
        `Student ${student.id}, Session ${sessionId}: request body was not valid JSON.`,
      );
    }

    if (
      typeof body !== "object" ||
      body === null ||
      !("questionId" in body) ||
      !isPositiveInteger(body.questionId)
    ) {
      return loggedErrorResponse(
        "INVALID_QUESTION_ID",
        "The Question identifier is invalid.",
        400,
        `Student ${student.id}, Session ${sessionId}: questionId was missing or invalid.`,
      );
    }

    if (
      !("guess" in body) ||
      typeof body.guess !== "string" ||
      body.guess.length > 100
    ) {
      return loggedErrorResponse(
        "INVALID_GUESS",
        "The Guess is invalid.",
        400,
        `Student ${student.id}, Session ${sessionId}, Question ${body.questionId}: guess was missing, not a string, or exceeded 100 characters.`,
      );
    }

    const result = await submitGuess(
      student.id,
      sessionId,
      body.questionId,
      body.guess,
    );

    if (result.status === "forbidden") {
      return loggedErrorResponse(
        "SESSION_FORBIDDEN",
        "Session belongs to another student.",
        403,
        `Student ${student.id} attempted to submit to Session ${sessionId}.`,
      );
    }

    if (result.status === "not-found") {
      return loggedErrorResponse(
        "SESSION_NOT_FOUND",
        "The Session does not exist.",
        404,
        `Student ${student.id} submitted to missing Session ${sessionId}.`,
      );
    }

    if (result.status === "question-not-in-session") {
      return loggedErrorResponse(
        "QUESTION_NOT_IN_SESSION",
        "The Question does not belong to this Session.",
        404,
        `Student ${student.id}, Session ${sessionId}: Question ${body.questionId} was not in the Session.`,
      );
    }

    if (result.status === "completed") {
      return loggedErrorResponse(
        "SESSION_ALREADY_COMPLETED",
        "This Session has already been completed.",
        409,
        `Student ${student.id} submitted to completed Session ${sessionId}.`,
      );
    }

    if (result.status === "question-already-completed") {
      return loggedErrorResponse(
        "QUESTION_ALREADY_COMPLETED",
        "This Question has already been completed in this Session.",
        409,
        `Student ${student.id}, Session ${sessionId}: Question ${body.questionId} was already completed.`,
      );
    }

    if (result.sessionCompleted) {
      if (result.completedByThisGuess) {
        await logInfo(
          `Student "${student.username}" completed Session ${sessionId} for Subject "${result.subjectTitle}".`,
        );
      }

      return Response.json({
        sessionCompleted: true,
        previous: result.previous,
        summary: result.summary,
      });
    }

    return Response.json({
      sessionCompleted: false,
      previous: result.previous,
      currentQuestion: result.currentQuestion,
      session: result.session,
    });
  } catch (error) {
    try {
      await logUnexpectedError(
        "POST /api/sessions/{sessionId}/guesses failed",
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
