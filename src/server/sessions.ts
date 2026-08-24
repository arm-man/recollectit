import "server-only";

import {
  countEligibleQuestions,
  doCategoriesBelongToSubject,
  doesSubjectExist,
} from "@/server/session-db";

export type AccuracyOperator = "lte" | "gte";

export type AccuracyPercent =
  0 | 10 | 20 | 30 | 40 | 50 | 60 | 70 | 80 | 90 | 100;

export type SessionFilters =
  | { askAllQuestions: true }
  | {
      askAllQuestions: false;
      categoryIds: number[];
      accuracyOperator: AccuracyOperator;
      accuracyPercent: AccuracyPercent;
    };

export type PreviewSessionResult =
  | { status: "success"; questionCount: number }
  | { status: "subject-not-found" }
  | { status: "category-subject-mismatch" };

export async function previewSessionQuestionCount(
  studentId: number,
  subjectId: number,
  filters: SessionFilters,
): Promise<PreviewSessionResult> {
  if (!(await doesSubjectExist(subjectId))) {
    return { status: "subject-not-found" };
  }

  if (
    !filters.askAllQuestions &&
    !(await doCategoriesBelongToSubject(subjectId, filters.categoryIds))
  ) {
    return { status: "category-subject-mismatch" };
  }

  const categoryIds = filters.askAllQuestions ? [] : filters.categoryIds;
  const accuracyOperator = filters.askAllQuestions
    ? "lte"
    : filters.accuracyOperator;
  const accuracyPercent = filters.askAllQuestions
    ? 100
    : filters.accuracyPercent;

  const questionCount = await countEligibleQuestions(
    studentId,
    subjectId,
    filters.askAllQuestions,
    categoryIds,
    accuracyOperator,
    accuracyPercent,
  );

  return { status: "success", questionCount };
}
