import "server-only";

import { pool } from "@/server/db";

export type SessionCreationCategory = {
  id: number;
  title: string;
};

export type SessionCreationSubject = {
  id: number;
  title: string;
  categories: SessionCreationCategory[];
};

type SessionCreationOptionRow = {
  subject_id: number;
  subject_title: string;
  category_id: number | null;
  category_title: string | null;
};

type DefaultSubjectRow = {
  subject_id: number;
};

type QuestionCountRow = {
  question_count: number;
};

type ActiveSessionCountRow = {
  active_session_count: number;
};

type EligibleQuestionRow = {
  question_id: number;
};

type InsertSessionRow = {
  session_id: number;
};

type SessionPageRow = {
  student_id: number;
  completed_at: Date | null;
  subject_title: string;
  categories: string[];
  question_id: number | null;
  question_text: string | null;
  questions_answered_correctly: number;
  questions_total: number;
  minimum_pending_attempts: number | null;
  maximum_pending_attempts: number | null;
};

type ActiveSessionRow = {
  session_id: number;
  subject_title: string;
  categories: string[];
  created_at: Date;
};

type SessionOwnershipRow = {
  student_id: number;
  completed_at: Date | null;
};

type CompletedSessionRow = {
  completed_at: Date;
};

type SkipQuestionRow = {
  session_completed_at: Date | null;
  question_attempts: number | null;
  question_completed_at: Date | null;
  minimum_pending_attempts: number | null;
  maximum_pending_attempts: number | null;
  replacement_question_id: number | null;
  replacement_question_text: string | null;
  questions_answered_correctly: number;
  questions_total: number;
};

export type SessionCreationPageData = {
  subjects: SessionCreationSubject[];
  defaultSubjectId: number | null;
};

export type CreateSessionDatabaseResult =
  | { status: "success"; sessionId: number }
  | { status: "no-eligible-questions" }
  | { status: "active-session-limit-reached" };

export type SessionPageRecord = {
  studentId: number;
  completedAt: Date | null;
  subjectTitle: string;
  categories: string[];
  currentQuestion: {
    questionId: number;
    questionText: string;
  } | null;
  roundNumber: number | null;
  questionsAnsweredCorrectly: number;
  questionsTotal: number;
};

export type ActiveSession = {
  sessionId: number;
  subject: string;
  categories: string[];
  createdAt: string;
};

export type SessionOwnershipRecord = {
  studentId: number;
  completedAt: Date | null;
};

export type SkipQuestionRecord = {
  sessionCompletedAt: Date | null;
  questionAttempts: number | null;
  questionCompletedAt: Date | null;
  minimumPendingAttempts: number | null;
  replacementQuestion: {
    questionId: number;
    questionText: string;
  } | null;
  roundNumber: number | null;
  questionsAnsweredCorrectly: number;
  questionsTotal: number;
};

export async function getSessionCreationPageData(
  studentId: number,
): Promise<SessionCreationPageData> {
  const [optionsResult, defaultSubjectResult] = await Promise.all([
    pool.query<SessionCreationOptionRow>(
      `SELECT
         subjects.id AS subject_id,
         subjects.title AS subject_title,
         categories.id AS category_id,
         categories.title AS category_title
       FROM subjects
       LEFT JOIN categories ON categories.subject_id = subjects.id
       ORDER BY subjects.title, subjects.id, categories.title`,
    ),
    pool.query<DefaultSubjectRow>(
      `SELECT subject_id
       FROM sessions
       WHERE student_id = $1
         AND completed_at IS NOT NULL
       ORDER BY completed_at DESC, id DESC
       LIMIT 1`,
      [studentId],
    ),
  ]);

  const subjects: SessionCreationSubject[] = [];

  for (const row of optionsResult.rows) {
    let subject = subjects.at(-1);

    if (!subject || subject.id !== row.subject_id) {
      subject = {
        id: row.subject_id,
        title: row.subject_title,
        categories: [],
      };
      subjects.push(subject);
    }

    if (row.category_id !== null && row.category_title !== null) {
      subject.categories.push({
        id: row.category_id,
        title: row.category_title,
      });
    }
  }

  return {
    subjects,
    defaultSubjectId:
      defaultSubjectResult.rows[0]?.subject_id ?? subjects[0]?.id ?? null,
  };
}

export async function getActiveSessions(
  studentId: number,
): Promise<ActiveSession[]> {
  const result = await pool.query<ActiveSessionRow>(
    `SELECT
       sessions.id AS session_id,
       subjects.title AS subject_title,
       sessions.created_at,
       COALESCE(
         ARRAY_AGG(DISTINCT categories.title ORDER BY categories.title)
           FILTER (WHERE categories.id IS NOT NULL),
         ARRAY[]::text[]
       ) AS categories
     FROM sessions
     JOIN subjects ON subjects.id = sessions.subject_id
     JOIN session_questions ON session_questions.session_id = sessions.id
     JOIN questions ON questions.id = session_questions.question_id
     LEFT JOIN categories ON categories.id = questions.category_id
     WHERE sessions.student_id = $1
       AND sessions.completed_at IS NULL
     GROUP BY sessions.id, subjects.title
     ORDER BY sessions.created_at DESC, sessions.id DESC`,
    [studentId],
  );

  return result.rows.map((row) => ({
    sessionId: row.session_id,
    subject: row.subject_title,
    categories: row.categories,
    createdAt: row.created_at.toISOString(),
  }));
}

export async function doesSubjectExist(subjectId: number): Promise<boolean> {
  const result = await pool.query(
    `SELECT 1
     FROM subjects
     WHERE id = $1`,
    [subjectId],
  );

  return result.rowCount === 1;
}

export async function doCategoriesBelongToSubject(
  subjectId: number,
  categoryIds: number[],
): Promise<boolean> {
  if (categoryIds.length === 0) {
    return true;
  }

  const result = await pool.query<{ category_count: number }>(
    `SELECT COUNT(*)::integer AS category_count
     FROM categories
     WHERE subject_id = $1
       AND id = ANY($2::integer[])`,
    [subjectId, categoryIds],
  );

  return result.rows[0]?.category_count === categoryIds.length;
}

export async function countEligibleQuestions(
  studentId: number,
  subjectId: number,
  askAllQuestions: boolean,
  categoryIds: number[],
  accuracyOperator: "lte" | "gte",
  accuracyPercent: number,
): Promise<number> {
  const result = await pool.query<QuestionCountRow>(
    `WITH student_question_history AS (
       SELECT
         session_questions.question_id,
         COALESCE(
           COUNT(*) FILTER (
             WHERE session_questions.completed_at IS NOT NULL
           )::numeric / NULLIF(SUM(session_questions.attempts), 0),
           0
         ) AS accuracy
       FROM session_questions
       JOIN sessions ON sessions.id = session_questions.session_id
       WHERE sessions.student_id = $1
       GROUP BY session_questions.question_id
     )
     SELECT COUNT(*)::integer AS question_count
     FROM questions
     LEFT JOIN student_question_history
       ON student_question_history.question_id = questions.id
     WHERE questions.subject_id = $2
       AND (
         $3::boolean
         OR (
           (
             cardinality($4::integer[]) = 0
             OR questions.category_id = ANY($4::integer[])
           )
           AND (
             (
               $5::text = 'lte'
               AND COALESCE(student_question_history.accuracy, 0)
                 <= $6::numeric / 100
             )
             OR (
               $5::text = 'gte'
               AND COALESCE(student_question_history.accuracy, 0)
                 >= $6::numeric / 100
             )
           )
         )
       )`,
    [
      studentId,
      subjectId,
      askAllQuestions,
      categoryIds,
      accuracyOperator,
      accuracyPercent,
    ],
  );

  return result.rows[0]?.question_count ?? 0;
}

export async function createSessionWithQuestions(
  studentId: number,
  subjectId: number,
  askAllQuestions: boolean,
  categoryIds: number[],
  accuracyOperator: "lte" | "gte",
  accuracyPercent: number,
): Promise<CreateSessionDatabaseResult> {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // Eligibility is recalculated inside the transaction so the rows inserted
    // into session_questions are the authoritative, fixed Session membership.
    const eligibleQuestionsResult = await client.query<EligibleQuestionRow>(
      `WITH student_question_history AS (
         SELECT
           session_questions.question_id,
           COALESCE(
             COUNT(*) FILTER (
               WHERE session_questions.completed_at IS NOT NULL
             )::numeric / NULLIF(SUM(session_questions.attempts), 0),
             0
           ) AS accuracy
         FROM session_questions
         JOIN sessions ON sessions.id = session_questions.session_id
         WHERE sessions.student_id = $1
         GROUP BY session_questions.question_id
       )
       SELECT questions.id AS question_id
       FROM questions
       LEFT JOIN student_question_history
         ON student_question_history.question_id = questions.id
       WHERE questions.subject_id = $2
         AND (
           $3::boolean
           OR (
             (
               cardinality($4::integer[]) = 0
               OR questions.category_id = ANY($4::integer[])
             )
             AND (
               (
                 $5::text = 'lte'
                 AND COALESCE(student_question_history.accuracy, 0)
                   <= $6::numeric / 100
               )
               OR (
                 $5::text = 'gte'
                 AND COALESCE(student_question_history.accuracy, 0)
                   >= $6::numeric / 100
               )
             )
           )
         )
       ORDER BY questions.id`,
      [
        studentId,
        subjectId,
        askAllQuestions,
        categoryIds,
        accuracyOperator,
        accuracyPercent,
      ],
    );

    if (eligibleQuestionsResult.rows.length === 0) {
      await client.query("ROLLBACK");
      return { status: "no-eligible-questions" };
    }

    const activeSessionCountResult =
      await client.query<ActiveSessionCountRow>(
        `SELECT COUNT(*)::integer AS active_session_count
         FROM sessions
         WHERE student_id = $1
           AND completed_at IS NULL`,
        [studentId],
      );

    if (
      (activeSessionCountResult.rows[0]?.active_session_count ?? 0) >= 5
    ) {
      await client.query("ROLLBACK");
      return { status: "active-session-limit-reached" };
    }

    const sessionResult = await client.query<InsertSessionRow>(
      `INSERT INTO sessions (student_id, subject_id)
       VALUES ($1, $2)
       RETURNING id AS session_id`,
      [studentId, subjectId],
    );
    const sessionId = sessionResult.rows[0]?.session_id;

    if (sessionId === undefined) {
      throw new Error("Session insert did not return an identifier.");
    }

    await client.query(
      `INSERT INTO session_questions (session_id, question_id)
       SELECT $1, selected_questions.question_id
       FROM unnest($2::integer[]) AS selected_questions(question_id)`,
      [
        sessionId,
        eligibleQuestionsResult.rows.map((row) => row.question_id),
      ],
    );

    await client.query("COMMIT");
    return { status: "success", sessionId };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
}

export async function getSessionPageRecord(
  sessionId: number,
): Promise<SessionPageRecord | null> {
  const result = await pool.query<SessionPageRow>(
    `WITH selected_session AS (
       SELECT
         sessions.id,
         sessions.student_id,
         sessions.completed_at,
         subjects.title AS subject_title
       FROM sessions
       JOIN subjects ON subjects.id = sessions.subject_id
       WHERE sessions.id = $1
     ),
     session_state AS (
       SELECT
         COUNT(*)::integer AS questions_total,
         COUNT(*) FILTER (
           WHERE completed_at IS NOT NULL
         )::integer AS questions_answered_correctly,
         MIN(attempts) FILTER (
           WHERE completed_at IS NULL
         )::integer AS minimum_pending_attempts,
         MAX(attempts) FILTER (
           WHERE completed_at IS NULL
         )::integer AS maximum_pending_attempts
       FROM session_questions
       WHERE session_id = $1
     ),
     session_categories AS (
       SELECT COALESCE(
         ARRAY_AGG(DISTINCT categories.title ORDER BY categories.title)
           FILTER (WHERE categories.id IS NOT NULL),
         ARRAY[]::text[]
       ) AS categories
       FROM session_questions
       JOIN questions ON questions.id = session_questions.question_id
       LEFT JOIN categories ON categories.id = questions.category_id
       WHERE session_questions.session_id = $1
     ),
     current_question AS (
       SELECT
         questions.id AS question_id,
         questions.question_text
       FROM session_questions
       JOIN questions ON questions.id = session_questions.question_id
       WHERE session_questions.session_id = $1
         AND session_questions.completed_at IS NULL
         AND session_questions.attempts = (
           SELECT MIN(attempts)
           FROM session_questions
           WHERE session_id = $1
             AND completed_at IS NULL
         )
       ORDER BY RANDOM()
       LIMIT 1
     )
     SELECT
       selected_session.student_id,
       selected_session.completed_at,
       selected_session.subject_title,
       session_categories.categories,
       current_question.question_id,
       current_question.question_text,
       session_state.questions_answered_correctly,
       session_state.questions_total,
       session_state.minimum_pending_attempts,
       session_state.maximum_pending_attempts
     FROM selected_session
     CROSS JOIN session_state
     CROSS JOIN session_categories
     LEFT JOIN current_question ON TRUE`,
    [sessionId],
  );
  const row = result.rows[0];

  if (!row) {
    return null;
  }

  const roundNumber =
    row.minimum_pending_attempts === null ||
    row.maximum_pending_attempts === null
      ? null
      : row.minimum_pending_attempts === row.maximum_pending_attempts
        ? row.minimum_pending_attempts + 1
        : row.maximum_pending_attempts;

  return {
    studentId: row.student_id,
    completedAt: row.completed_at,
    subjectTitle: row.subject_title,
    categories: row.categories,
    currentQuestion:
      row.question_id === null || row.question_text === null
        ? null
        : {
            questionId: row.question_id,
            questionText: row.question_text,
          },
    roundNumber,
    questionsAnsweredCorrectly: row.questions_answered_correctly,
    questionsTotal: row.questions_total,
  };
}

export async function getSessionOwnershipRecord(
  sessionId: number,
): Promise<SessionOwnershipRecord | null> {
  const result = await pool.query<SessionOwnershipRow>(
    `SELECT student_id, completed_at
     FROM sessions
     WHERE id = $1`,
    [sessionId],
  );
  const row = result.rows[0];

  return row
    ? { studentId: row.student_id, completedAt: row.completed_at }
    : null;
}

export async function getSkipQuestionRecord(
  sessionId: number,
  questionId: number,
): Promise<SkipQuestionRecord> {
  const result = await pool.query<SkipQuestionRow>(
    `WITH selected_session AS (
       SELECT completed_at AS session_completed_at
       FROM sessions
       WHERE id = $1
     ),
     session_state AS (
       SELECT
         COUNT(*)::integer AS questions_total,
         COUNT(*) FILTER (
           WHERE completed_at IS NOT NULL
         )::integer AS questions_answered_correctly,
         MIN(attempts) FILTER (
           WHERE completed_at IS NULL
         )::integer AS minimum_pending_attempts,
         MAX(attempts) FILTER (
           WHERE completed_at IS NULL
         )::integer AS maximum_pending_attempts
       FROM session_questions
       WHERE session_id = $1
     ),
     selected_question AS (
       SELECT
         attempts AS question_attempts,
         completed_at AS question_completed_at
       FROM session_questions
       WHERE session_id = $1
         AND question_id = $2
     ),
     replacement_question AS (
       SELECT
         questions.id AS replacement_question_id,
         questions.question_text AS replacement_question_text
       FROM session_questions
       JOIN questions ON questions.id = session_questions.question_id
       CROSS JOIN session_state
       WHERE session_questions.session_id = $1
         AND session_questions.question_id <> $2
         AND session_questions.completed_at IS NULL
         AND session_questions.attempts = session_state.minimum_pending_attempts
       ORDER BY RANDOM()
       LIMIT 1
     )
     SELECT
       selected_session.session_completed_at,
       selected_question.question_attempts,
       selected_question.question_completed_at,
       session_state.minimum_pending_attempts,
       session_state.maximum_pending_attempts,
       replacement_question.replacement_question_id,
       replacement_question.replacement_question_text,
       session_state.questions_answered_correctly,
       session_state.questions_total
     FROM selected_session
     CROSS JOIN session_state
     LEFT JOIN selected_question ON TRUE
     LEFT JOIN replacement_question ON TRUE`,
    [sessionId, questionId],
  );
  const row = result.rows[0];

  if (!row) {
    throw new Error("Skip state query did not return a row.");
  }

  const roundNumber =
    row.minimum_pending_attempts === null ||
    row.maximum_pending_attempts === null
      ? null
      : row.minimum_pending_attempts === row.maximum_pending_attempts
        ? row.minimum_pending_attempts + 1
        : row.maximum_pending_attempts;

  return {
    sessionCompletedAt: row.session_completed_at,
    questionAttempts: row.question_attempts,
    questionCompletedAt: row.question_completed_at,
    minimumPendingAttempts: row.minimum_pending_attempts,
    replacementQuestion:
      row.replacement_question_id === null ||
      row.replacement_question_text === null
        ? null
        : {
            questionId: row.replacement_question_id,
            questionText: row.replacement_question_text,
          },
    roundNumber,
    questionsAnsweredCorrectly: row.questions_answered_correctly,
    questionsTotal: row.questions_total,
  };
}

export async function markSessionCompleted(
  sessionId: number,
  studentId: number,
): Promise<Date | null> {
  const result = await pool.query<CompletedSessionRow>(
    `UPDATE sessions
     SET completed_at = NOW()
     WHERE id = $1
       AND student_id = $2
       AND completed_at IS NULL
     RETURNING completed_at`,
    [sessionId, studentId],
  );

  return result.rows[0]?.completed_at ?? null;
}
