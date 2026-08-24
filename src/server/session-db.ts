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

export type SessionCreationPageData = {
  subjects: SessionCreationSubject[];
  defaultSubjectId: number | null;
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
