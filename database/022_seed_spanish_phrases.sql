-- Add four Spanish phrase flashcards plus additional accepted answers.
-- Assumes:
--   questions(subject_id, category_id, question_text, answer_text, alternate_answer_text)
--   alternate_answers(question_id, answer_text)
--   UNIQUE (question_id, answer_text)

-- 1) ¿Qué tiene eso que ver?
INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
SELECT
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    '¿Qué tiene eso que ver?',
    'What does that have to do with anything?',
    'What does that have to do with it?'
WHERE NOT EXISTS (
    SELECT 1
    FROM questions q
    WHERE q.subject_id = (SELECT id FROM subjects WHERE title = 'Spanish Phrases')
      AND q.question_text = '¿Qué tiene eso que ver?'
);

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, v.answer_text
FROM questions q
JOIN subjects s ON s.id = q.subject_id
CROSS JOIN (VALUES
    ('What does that have to do with this?'),
    ('What does that have to do with anything at all?')
) AS v(answer_text)
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = '¿Qué tiene eso que ver?'
ON CONFLICT (question_id, answer_text) DO NOTHING;

-- 2) Que así sea
INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
SELECT
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'Que así sea',
    'So be it',
    'Let it be so'
WHERE NOT EXISTS (
    SELECT 1
    FROM questions q
    WHERE q.subject_id = (SELECT id FROM subjects WHERE title = 'Spanish Phrases')
      AND q.question_text = 'Que así sea'
);

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, v.answer_text
FROM questions q
JOIN subjects s ON s.id = q.subject_id
CROSS JOIN (VALUES
    ('May it be so')
) AS v(answer_text)
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'Que así sea'
ON CONFLICT (question_id, answer_text) DO NOTHING;

-- 3) A partir de ahora
INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
SELECT
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'A partir de ahora',
    'From now on',
    'Starting now'
WHERE NOT EXISTS (
    SELECT 1
    FROM questions q
    WHERE q.subject_id = (SELECT id FROM subjects WHERE title = 'Spanish Phrases')
      AND q.question_text = 'A partir de ahora'
);

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, v.answer_text
FROM questions q
JOIN subjects s ON s.id = q.subject_id
CROSS JOIN (VALUES
    ('From this point on'),
    ('Going forward')
) AS v(answer_text)
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'A partir de ahora'
ON CONFLICT (question_id, answer_text) DO NOTHING;

-- 4) ¿A que sí?
INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
SELECT
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    '¿A que sí?',
    'Isn''t that right?',
    'Right?'
WHERE NOT EXISTS (
    SELECT 1
    FROM questions q
    WHERE q.subject_id = (SELECT id FROM subjects WHERE title = 'Spanish Phrases')
      AND q.question_text = '¿A que sí?'
);

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, v.answer_text
FROM questions q
JOIN subjects s ON s.id = q.subject_id
CROSS JOIN (VALUES
    ('Don''t you think so?'),
    ('Isn''t that so?')
) AS v(answer_text)
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = '¿A que sí?'
ON CONFLICT (question_id, answer_text) DO NOTHING;
