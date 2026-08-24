import { getCurrentStudent } from "@/server/student-identity";
import { logUnexpectedError } from "@/server/logs";
import {
  previewSessionQuestionCount,
  type AccuracyPercent,
  type SessionFilters,
} from "@/server/sessions";

export const runtime = "nodejs";

type ApiErrorCode =
  | "UNAUTHORIZED"
  | "INVALID_SESSION_FILTERS"
  | "SUBJECT_NOT_FOUND"
  | "CATEGORY_SUBJECT_MISMATCH"
  | "INTERNAL_ERROR";

type SessionPreviewRequest = {
  subjectId: number;
  filters: SessionFilters;
};

function errorResponse(code: ApiErrorCode, message: string, status: number) {
  return Response.json({ error: { code, message } }, { status });
}

function isPositiveInteger(value: unknown): value is number {
  return typeof value === "number" && Number.isSafeInteger(value) && value > 0;
}

function areUniquePositiveIntegerIds(value: unknown): value is number[] {
  return (
    Array.isArray(value) &&
    value.every(isPositiveInteger) &&
    new Set(value).size === value.length
  );
}

function isAccuracyPercent(value: unknown): value is AccuracyPercent {
  return (
    typeof value === "number" &&
    Number.isInteger(value) &&
    value >= 0 &&
    value <= 100 &&
    value % 10 === 0
  );
}

function parseRequest(body: unknown): SessionPreviewRequest | null {
  if (
    typeof body !== "object" ||
    body === null ||
    !("subjectId" in body) ||
    !isPositiveInteger(body.subjectId) ||
    !("filters" in body) ||
    typeof body.filters !== "object" ||
    body.filters === null ||
    !("askAllQuestions" in body.filters) ||
    typeof body.filters.askAllQuestions !== "boolean"
  ) {
    return null;
  }

  if (body.filters.askAllQuestions) {
    return {
      subjectId: body.subjectId,
      filters: { askAllQuestions: true },
    };
  }

  if (
    !("categoryIds" in body.filters) ||
    !areUniquePositiveIntegerIds(body.filters.categoryIds) ||
    !("accuracyOperator" in body.filters) ||
    (body.filters.accuracyOperator !== "lte" &&
      body.filters.accuracyOperator !== "gte") ||
    !("accuracyPercent" in body.filters) ||
    !isAccuracyPercent(body.filters.accuracyPercent)
  ) {
    return null;
  }

  return {
    subjectId: body.subjectId,
    filters: {
      askAllQuestions: false,
      categoryIds: body.filters.categoryIds,
      accuracyOperator: body.filters.accuracyOperator,
      accuracyPercent: body.filters.accuracyPercent,
    },
  };
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

    const previewRequest = parseRequest(body);

    if (!previewRequest) {
      return errorResponse(
        "INVALID_SESSION_FILTERS",
        "The Session filters are invalid.",
        400,
      );
    }

    const result = await previewSessionQuestionCount(
      student.id,
      previewRequest.subjectId,
      previewRequest.filters,
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

    return Response.json({ questionCount: result.questionCount });
  } catch (error) {
    try {
      await logUnexpectedError("POST /api/sessions/preview failed", error);
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
