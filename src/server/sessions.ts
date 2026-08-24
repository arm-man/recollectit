import "server-only";

import {
  countEligibleQuestions,
  createSessionWithQuestions,
  doCategoriesBelongToSubject,
  doesSubjectExist,
  getSessionOwnershipRecord,
  getSessionPageRecord,
  markSessionCompleted,
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

export type StartSessionResult =
  | { status: "success"; sessionId: number }
  | { status: "subject-not-found" }
  | { status: "category-subject-mismatch" }
  | { status: "no-eligible-questions" }
  | { status: "active-session-limit-reached" };

export type GetSessionResult =
  | {
      status: "success";
      sessionDetails: {
        subject: string;
        categories: string[];
      };
      currentQuestion: {
        questionId: number;
        questionText: string;
      };
      session: {
        roundNumber: number;
        questionsAnsweredCorrectly: number;
        questionsTotal: number;
      };
    }
  | { status: "not-found" }
  | { status: "forbidden" }
  | { status: "completed" };

export type AbandonSessionResult =
  | { status: "success"; completedAt: Date }
  | { status: "not-found" }
  | { status: "forbidden" }
  | { status: "completed" };

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

export async function startSession(
  studentId: number,
  subjectId: number,
  filters: SessionFilters,
): Promise<StartSessionResult> {
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

  return createSessionWithQuestions(
    studentId,
    subjectId,
    filters.askAllQuestions,
    categoryIds,
    accuracyOperator,
    accuracyPercent,
  );
}

export async function getSession(
  studentId: number,
  sessionId: number,
): Promise<GetSessionResult> {
  const record = await getSessionPageRecord(sessionId);

  if (!record) {
    return { status: "not-found" };
  }

  if (record.studentId !== studentId) {
    return { status: "forbidden" };
  }

  if (
    record.completedAt !== null ||
    record.currentQuestion === null ||
    record.roundNumber === null
  ) {
    return { status: "completed" };
  }

  return {
    status: "success",
    sessionDetails: {
      subject: record.subjectTitle,
      categories: record.categories,
    },
    currentQuestion: record.currentQuestion,
    session: {
      roundNumber: record.roundNumber,
      questionsAnsweredCorrectly: record.questionsAnsweredCorrectly,
      questionsTotal: record.questionsTotal,
    },
  };
}

export async function abandonSession(
  studentId: number,
  sessionId: number,
): Promise<AbandonSessionResult> {
  const record = await getSessionOwnershipRecord(sessionId);

  if (!record) {
    return { status: "not-found" };
  }

  if (record.studentId !== studentId) {
    return { status: "forbidden" };
  }

  if (record.completedAt !== null) {
    return { status: "completed" };
  }

  const completedAt = await markSessionCompleted(sessionId, studentId);

  return completedAt
    ? { status: "success", completedAt }
    : { status: "completed" };
}
