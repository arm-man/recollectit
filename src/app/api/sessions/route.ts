import { parseSessionRequest } from "./session-request";
import { getCurrentStudent } from "@/server/student-identity";
import { logUnexpectedError } from "@/server/logs";
import { startSession } from "@/server/sessions";

export const runtime = "nodejs";

type ApiErrorCode =
  | "UNAUTHORIZED"
  | "INVALID_SESSION_FILTERS"
  | "SUBJECT_NOT_FOUND"
  | "CATEGORY_SUBJECT_MISMATCH"
  | "NO_ELIGIBLE_QUESTIONS"
  | "ACTIVE_SESSION_LIMIT_REACHED"
  | "INTERNAL_ERROR";

function errorResponse(code: ApiErrorCode, message: string, status: number) {
  return Response.json({ error: { code, message } }, { status });
}

export async function POST(request: Request): Promise<Response> {
  try {
    const student = await getCurrentStudent();

    if (!student) {
      return errorResponse("UNAUTHORIZED", "Please log in to continue.", 401);
    }

    let body: unknown;

    try {
      body = await request.json();
    } catch {
      return errorResponse(
        "INVALID_SESSION_FILTERS",
        "The Session filters are invalid.",
        400,
      );
    }

    const sessionRequest = parseSessionRequest(body);

    if (!sessionRequest) {
      return errorResponse(
        "INVALID_SESSION_FILTERS",
        "The Session filters are invalid.",
        400,
      );
    }

    const result = await startSession(
      student.id,
      sessionRequest.subjectId,
      sessionRequest.filters,
    );

    if (result.status === "subject-not-found") {
      return errorResponse(
        "SUBJECT_NOT_FOUND",
        "The selected Subject does not exist.",
        404,
      );
    }

    if (result.status === "category-subject-mismatch") {
      return errorResponse(
        "CATEGORY_SUBJECT_MISMATCH",
        "A selected Category does not belong to the selected Subject.",
        409,
      );
    }

    if (result.status === "no-eligible-questions") {
      return errorResponse(
        "NO_ELIGIBLE_QUESTIONS",
        "The selected options do not produce any Questions.",
        409,
      );
    }

    if (result.status === "active-session-limit-reached") {
      return errorResponse(
        "ACTIVE_SESSION_LIMIT_REACHED",
        "You already have five active Sessions.",
        409,
      );
    }

    return Response.json({ sessionId: result.sessionId }, { status: 201 });
  } catch (error) {
    try {
      await logUnexpectedError("POST /api/sessions failed", error);
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
