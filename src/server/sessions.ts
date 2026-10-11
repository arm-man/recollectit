import "server-only";

import { formatAnswerForDisplay } from "@/server/answer-tokens";
import {
  countEligibleQuestions,
  createSessionWithQuestions,
  doCategoriesBelongToSubject,
  doesSubjectExist,
  getGuessQuestionRecord,
  getSessionCompleteRecord,
  getSessionOwnershipRecord,
  getSessionPageRecord,
  getSkipQuestionRecord,
  markSessionCompleted,
  recordGuess,
} from "@/server/session-db";
import {
  getAcceptableAnswerTexts,
  getAnswerTextsForFeedback,
  isGuessCorrect,
} from "@/server/guess-evaluation";
import { logError } from "@/server/logs";
import { getMemoryTipForFeedback } from "@/server/memory-tip";

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
        questionAccuracy: number | null;
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
  | { status: "success"; completedAt: Date; subjectTitle: string }
  | { status: "not-found" }
  | { status: "forbidden" }
  | { status: "completed" };

export type SkipQuestionResult =
  | {
      status: "success";
      currentQuestion: {
        questionId: number;
        questionText: string;
        questionAccuracy: number | null;
      };
      session: {
        roundNumber: number;
        questionsAnsweredCorrectly: number;
        questionsTotal: number;
      };
    }
  | { status: "not-found" }
  | { status: "forbidden" }
  | { status: "completed" }
  | { status: "question-not-in-session" }
  | { status: "question-not-pending" }
  | { status: "skip-not-available" };

export type SubmitGuessResult =
  | {
      status: "success";
      sessionCompleted: false;
      previous: {
        answerTexts: string[];
        correct: boolean;
        memoryTip: string | null;
      };
      currentQuestion: {
        questionId: number;
        questionText: string;
        questionAccuracy: number | null;
      };
      session: {
        roundNumber: number;
        questionsAnsweredCorrectly: number;
        questionsTotal: number;
      };
    }
  | {
      status: "success";
      sessionCompleted: true;
      completedByThisGuess: boolean;
      subjectTitle: string;
    }
  | { status: "not-found" }
  | { status: "forbidden" }
  | { status: "completed" }
  | { status: "question-not-in-session" }
  | { status: "question-already-completed" };

export type GetSessionCompleteResult =
  | {
      status: "success";
      session: {
        completedAt: Date;
        subject: string;
        categories: string[];
        isAbandoned: boolean;
        uniqueQuestionCount: number;
        guessCount: number;
        sessionAccuracy: number | null;
        questions: {
          questionId: number;
          question: string;
          answer: string;
          attempts: number;
          questionAccuracy: number;
        }[];
      };
    }
  | { status: "not-found" }
  | { status: "forbidden" }
  | { status: "in-progress" };

async function logAnswerTokenErrors(
  context: string,
  errors: ReadonlySet<string>,
): Promise<void> {
  if (errors.size === 0) {
    return;
  }

  try {
    await logError(`${context}: ${Array.from(errors).join(" ")}`);
  } catch {
    // Invalid Answer data must not prevent the Session workflow from running.
  }
}

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

export async function getSessionComplete(
  studentId: number,
  sessionId: number,
): Promise<GetSessionCompleteResult> {
  const record = await getSessionCompleteRecord(sessionId);

  if (!record) {
    return { status: "not-found" };
  }

  if (record.studentId !== studentId) {
    return { status: "forbidden" };
  }

  if (record.completedAt === null) {
    return { status: "in-progress" };
  }

  const tokenErrors = new Set<string>();
  const questions = record.questions.map((question) => ({
    ...question,
    answer: formatAnswerForDisplay(question.answer, (message) =>
      tokenErrors.add(`Question ${question.questionId}: ${message}`),
    ),
  }));

  await logAnswerTokenErrors(
    `Session Complete Answer token processing failed for Session ${sessionId}`,
    tokenErrors,
  );

  return {
    status: "success",
    session: {
      completedAt: record.completedAt,
      subject: record.subject,
      categories: record.categories,
      isAbandoned: record.isAbandoned,
      uniqueQuestionCount: record.uniqueQuestionCount,
      guessCount: record.guessCount,
      sessionAccuracy: record.sessionAccuracy,
      questions,
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
    ? { status: "success", completedAt, subjectTitle: record.subjectTitle }
    : { status: "completed" };
}

export async function skipQuestion(
  studentId: number,
  sessionId: number,
  questionId: number,
): Promise<SkipQuestionResult> {
  const sessionRecord = await getSessionOwnershipRecord(sessionId);

  if (!sessionRecord) {
    return { status: "not-found" };
  }

  if (sessionRecord.studentId !== studentId) {
    return { status: "forbidden" };
  }

  if (sessionRecord.completedAt !== null) {
    return { status: "completed" };
  }

  const skipRecord = await getSkipQuestionRecord(sessionId, questionId);

  if (skipRecord.sessionCompletedAt !== null) {
    return { status: "completed" };
  }

  if (skipRecord.questionAttempts === null) {
    return { status: "question-not-in-session" };
  }

  if (
    skipRecord.questionCompletedAt !== null ||
    skipRecord.minimumPendingAttempts === null ||
    skipRecord.questionAttempts !== skipRecord.minimumPendingAttempts
  ) {
    return { status: "question-not-pending" };
  }

  if (
    skipRecord.replacementQuestion === null ||
    skipRecord.roundNumber === null
  ) {
    return { status: "skip-not-available" };
  }

  return {
    status: "success",
    currentQuestion: skipRecord.replacementQuestion,
    session: {
      roundNumber: skipRecord.roundNumber,
      questionsAnsweredCorrectly: skipRecord.questionsAnsweredCorrectly,
      questionsTotal: skipRecord.questionsTotal,
    },
  };
}

export async function submitGuess(
  studentId: number,
  sessionId: number,
  questionId: number,
  guess: string,
): Promise<SubmitGuessResult> {
  const questionRecord = await getGuessQuestionRecord(sessionId, questionId);

  if (!questionRecord) {
    return { status: "not-found" };
  }

  if (questionRecord.studentId !== studentId) {
    return { status: "forbidden" };
  }

  if (questionRecord.sessionCompletedAt !== null) {
    return { status: "completed" };
  }

  if (
    questionRecord.questionId === null ||
    questionRecord.answerText === null
  ) {
    return { status: "question-not-in-session" };
  }

  if (questionRecord.questionCompletedAt !== null) {
    return { status: "question-already-completed" };
  }

  const tokenErrors = new Set<string>();
  const answers = getAcceptableAnswerTexts(
    questionRecord.answerText,
    questionRecord.alternateAnswerText,
    questionRecord.additionalAnswerTexts,
  );
  const correct = isGuessCorrect(
    guess,
    answers,
    (message) => tokenErrors.add(message),
  );
  const displayAnswerTexts = getAnswerTextsForFeedback(
    answers,
    correct,
    (message) => tokenErrors.add(message),
  );

  await logAnswerTokenErrors(
    `Answer token processing failed for Session ${sessionId}, Question ${questionId}`,
    tokenErrors,
  );

  const result = await recordGuess(sessionId, questionId, correct);

  if (result.status === "not-recorded") {
    // Re-read the durable state to translate the rare concurrent update into
    // the same controlled response the initial validation would have returned.
    const currentRecord = await getGuessQuestionRecord(sessionId, questionId);

    if (currentRecord && currentRecord.sessionCompletedAt !== null) {
      return { status: "completed" };
    }

    if (currentRecord && currentRecord.questionCompletedAt !== null) {
      return { status: "question-already-completed" };
    }

    throw new Error("Guess could not be recorded for an active Question.");
  }

  if (result.status === "session-completed") {
    return {
      status: "success",
      sessionCompleted: true,
      completedByThisGuess: result.completedByThisGuess,
      subjectTitle: questionRecord.subjectTitle,
    };
  }

  const previous = {
    answerTexts: displayAnswerTexts,
    correct,
    memoryTip: getMemoryTipForFeedback(questionRecord.tipText, correct),
  };

  return {
    status: "success",
    sessionCompleted: false,
    previous,
    currentQuestion: result.currentQuestion,
    session: {
      roundNumber: result.roundNumber,
      questionsAnsweredCorrectly: result.questionsAnsweredCorrectly,
      questionsTotal: result.questionsTotal,
    },
  };
}
