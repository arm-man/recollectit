import type {
  AccuracyPercent,
  SessionFilters,
} from "@/server/sessions";

export type SessionRequest = {
  subjectId: number;
  filters: SessionFilters;
};

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

export function parseSessionRequest(body: unknown): SessionRequest | null {
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
