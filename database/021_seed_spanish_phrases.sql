
-- fix the nosotros question that can be both present tense and preterite
UPDATE questions
SET
    question_text = 'seguirán adelante',
    answer_text = 'they will carry on',
    alternate_answer_text = 'they will move forward',
    alternate_answer_text_2 = 'they will press on'
WHERE
    question_text = 'seguimos adelante'
    AND subject_id = (SELECT id FROM subjects WHERE title = 'Spanish')
    AND category_id = (SELECT id FROM categories WHERE title = 'Actions');

-- migrate the alternate_answer_text_2 to the new table
INSERT INTO alternate_answers (question_id, answer_text)
SELECT id, alternate_answer_text_2
FROM questions
WHERE NULLIF(btrim(alternate_answer_text_2), '') IS NOT NULL
ON CONFLICT (question_id, answer_text) DO NOTHING;

-- Additional accepted English answers for Spanish phrase questions.
-- 143 additional accepted answers across 94 of the 100 Spanish phrase questions.
-- Assumes alternate_answers(question_id, answer_text) with
-- UNIQUE (question_id, answer_text).
-- Existing questions.answer_text, questions.alternate_answer_text,
-- and already-migrated answers are not changed.
-- Safe to rerun.

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'even so'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'pese a todo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'nevertheless'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'pese a todo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'with regard to'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en cuanto a'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'concerning'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en cuanto a'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it''s a good thing'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'menos mal que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'fortunately'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'menos mal que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'during'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a lo largo de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'over'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a lo largo de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'every now and then'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de vez en cuando'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'now and then'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de vez en cuando'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'thus'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por lo tanto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'hence'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por lo tanto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'still'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'sin embargo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'yet'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'sin embargo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'as opposed to'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en vez de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'notwithstanding'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a pesar de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'just to be safe'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por si acaso'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'in the end'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'al fin y al cabo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'at the end of the day'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'al fin y al cabo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'all at once'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de repente'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'abruptly'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de repente'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'at once'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en seguida'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'promptly'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en seguida'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'a little while ago'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'hace poco'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'a short time ago'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'hace poco'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'naturally'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por supuesto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'definitely'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por supuesto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'on the other hand'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'ahora bien'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'still'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'ahora bien'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'indeed'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de hecho'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'at the minimum'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por lo menos'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they''ll figure out'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se darán cuenta de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they''ll become conscious of'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se darán cuenta de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I figured out'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me di cuenta de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it dawned on me'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me di cuenta de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} took into consideration'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tuvo en cuenta'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} allowed for'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tuvo en cuenta'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we take into consideration'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tenemos en cuenta'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we allow for'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tenemos en cuenta'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} was missed greatly'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se echó de menos'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I miss having you here'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'te echo de menos'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-it} began'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se puso en marcha'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-it} got started'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se puso en marcha'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we started'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'pusimos en marcha'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we got started'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'pusimos en marcha'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-it} happened'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se llevó a cabo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-it} was performed'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se llevó a cabo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they performed'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'llevaron a cabo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they conducted'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'llevaron a cabo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it doesn''t matter to me'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me da igual'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'either way is fine with me'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me da igual'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it didn''t matter to them'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'les daba igual'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they didn''t mind'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'les daba igual'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it''s worth doing'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'vale la pena'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it''s worthwhile'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'vale la pena'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it turned out to be worth it'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'valió la pena'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} is just going to'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'está a punto de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we are just going to'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'estamos a punto de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I only just got here'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'acabo de llegar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I just got here'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'acabo de llegar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they only just left'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'acaban de salir'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} started over'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'volvió a empezar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} began anew'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'volvió a empezar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we tried once more'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'volvimos a intentarlo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it quit raining'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'dejó de llover'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'the rain ended'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'dejó de llover'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they fell silent'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'dejaron de hablar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} went on'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'siguió adelante'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} kept going'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'siguió adelante'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they will go on'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'seguirán adelante'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they will keep going'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'seguirán adelante'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'look out'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'ten cuidado'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'mind yourself'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'ten cuidado'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they acted carefully'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tuvieron cuidado'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} hurried up'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se dio prisa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'get moving'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'date prisa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'hurry'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'date prisa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} was short on time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tenía prisa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we are short on time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tenemos prisa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'they made up their minds'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tomaron una decisión'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} took it to heart'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se lo tomó en serio'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I take it to heart'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me lo tomo en serio'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} took notice'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'hizo caso'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} heeded'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'hizo caso'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} wouldn''t listen to me'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'no me hizo caso'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'that''s okay'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'no importa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it makes no difference'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'no importa'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'that''s a shame'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'qué pena'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'what a shame'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'qué lástima'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'sad to say'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por desgracia'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'as luck would have it'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por suerte'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'only just'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a duras penas'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'with great effort'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a duras penas'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'not a chance'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'qué va'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'nothing of the sort'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'qué va'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'while we''re on the subject'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por cierto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'not a chance'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'ni hablar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'out of the question'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'ni hablar'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'if truth be told'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a decir verdad'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'frankly'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a decir verdad'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'having said that'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'eso sí'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'though'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'eso sí'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'in contrast'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en cambio'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'whereas'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'en cambio'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'then again'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por otra parte'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'on the flip side'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por otra parte'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'all the same'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'aun así'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'nonetheless'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'aun así'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'even so'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'dicho esto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'that''s why'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de ahí que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'for that reason'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de ahí que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'last of all'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por último'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'in any case'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'sea como sea'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'anyway'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'sea como sea'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'or rather'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'más bien'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'that is'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'o sea'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'in contrast with'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a diferencia de'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'more than sufficient'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de sobra'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'no matter how'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por más que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'although'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por más que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'so long as'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'con tal de que'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'on the condition that'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'siempre y cuando'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'later on'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'al rato'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'after some time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'al rato'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'at this point in time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a estas alturas'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'at one point or another'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'tarde o temprano'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'for the time being'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'mientras tanto'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'around that time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'por aquel entonces'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'in time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a la larga'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'ahead of time'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'de antemano'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'shortly'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'dentro de poco'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'in a bit'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'dentro de poco'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'quite often'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'a menudo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'it''s no big deal'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'no pasa nada'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'nothing''s wrong'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'no pasa nada'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} used up all of'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se quedó sin'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} had run out of'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se quedó sin'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I used up all of'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me quedé sin'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I had run out of'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me quedé sin'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-she} retained'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se quedó con'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'I retained'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'me quedé con'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, '{3sg-he} saw eye to eye'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'se puso de acuerdo'
ON CONFLICT (question_id, answer_text) DO NOTHING;

INSERT INTO alternate_answers (question_id, answer_text)
SELECT q.id, 'we saw eye to eye'
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.title = 'Spanish Phrases'
  AND q.question_text = 'nos pusimos de acuerdo'
ON CONFLICT (question_id, answer_text) DO NOTHING;
