-- 100 common Spanish phrases for Recollect It
-- Third-person-singular display tokens:
--   {3sg-he}  -> display "he"
--   {3sg-she} -> display "she"
--   {3sg-it}  -> display "it"
-- All three tokens may be normalized for answer grading so he/she/it
-- are accepted interchangeably for these third-person-singular forms.
--
-- subject_id is resolved from subjects.title = 'Spanish'
-- category_id is resolved from one of six Spanish phrase category titles

INSERT INTO subjects (title) VALUES ('Spanish Phrases');

INSERT INTO categories (subject_id, title)
SELECT
    s.id,
    c.title
FROM subjects AS s
CROSS JOIN (
    VALUES
        ('Time'),
        ('Connectors'),
        ('Verbal Expressions'),
		('Actions'),
		('Reactions'),
		('Comparison/Conditions/Circumstance')
) AS c(title)
WHERE s.title = 'Spanish Phrases';

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'pese a todo',
    'despite everything',
    'in spite of everything'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'en cuanto a',
    'as for',
    'regarding'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'menos mal que',
    'thank goodness',
    'luckily'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a lo largo de',
    'throughout',
    'over the course of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de vez en cuando',
    'from time to time',
    'once in a while'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por lo tanto',
    'therefore',
    'as a result'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'sin embargo',
    'however',
    'nevertheless'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'en vez de',
    'instead of',
    'rather than'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a pesar de',
    'despite',
    'in spite of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'por si acaso',
    'just in case',
    'in case'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'al fin y al cabo',
    'after all',
    'when all is said and done'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de repente',
    'suddenly',
    'all of a sudden'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'en seguida',
    'right away',
    'immediately'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'poco a poco',
    'little by little',
    'gradually'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'por supuesto',
    'of course',
    'certainly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'de acuerdo con',
    'according to',
    'in accordance with'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en realidad',
    'actually',
    'in fact'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'por lo menos',
    'at least',
    'at the very least'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'en cuanto',
    'as soon as',
    'once'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se darán cuenta de',
    'they will realize',
    'they will become aware of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'me di cuenta de',
    'I realized',
    'I became aware of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'tuvo en cuenta',
    '{3sg-he} took into account',
    '{3sg-he} kept in mind'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'tenemos en cuenta',
    'we take into account',
    'we keep in mind'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se echó de menos',
    '{3sg-she} was missed',
    '{3sg-she} was longed for'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'te echo de menos',
    'I miss you',
    'I long for you'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se puso en marcha',
    '{3sg-it} got underway',
    '{3sg-it} was set in motion'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'pusimos en marcha',
    'we launched',
    'we set in motion'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se llevó a cabo',
    '{3sg-it} was carried out',
    '{3sg-it} took place'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'llevaron a cabo',
    'they carried out',
    'they completed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'me da igual',
    'I don''t care',
    'it''s all the same to me'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'les daba igual',
    'they didn''t care',
    'it was all the same to them'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'vale la pena',
    'it''s worth it',
    'it is worthwhile'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'valió la pena',
    'it was worth it',
    'it was worthwhile'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'está a punto de',
    '{3sg-he} is about to',
    '{3sg-he} is on the verge of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'estamos a punto de',
    'we are about to',
    'we are on the verge of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'acabo de llegar',
    'I just arrived',
    'I have just arrived'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'acaban de salir',
    'they just left',
    'they have just left'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'volvió a empezar',
    '{3sg-she} started again',
    '{3sg-she} restarted'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'volvimos a intentarlo',
    'we tried again',
    'we gave it another try'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'dejó de llover',
    'it stopped raining',
    'the rain stopped'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'dejaron de hablar',
    'they stopped talking',
    'they quit talking'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'siguió adelante',
    '{3sg-he} carried on',
    '{3sg-he} moved forward'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'seguimos adelante',
    'we carried on',
    'we moved forward'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'ten cuidado',
    'be careful',
    'take care'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tuvieron cuidado',
    'they were careful',
    'they took care'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'se dio prisa',
    '{3sg-he} hurried',
    '{3sg-he} rushed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'date prisa',
    'hurry up',
    'get a move on'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tenía prisa',
    '{3sg-she} was in a hurry',
    '{3sg-she} was rushed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tenemos prisa',
    'we are in a hurry',
    'we are rushed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tomó una decisión',
    '{3sg-he} made a decision',
    '{3sg-he} decided'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tomaron una decisión',
    'they made a decision',
    'they decided'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'se lo tomó en serio',
    '{3sg-she} took it seriously',
    '{3sg-she} was serious about it'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'me lo tomo en serio',
    'I take it seriously',
    'I am serious about it'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'hizo caso',
    '{3sg-he} paid attention',
    '{3sg-he} listened'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'no me hizo caso',
    '{3sg-she} ignored me',
    '{3sg-she} didn''t listen to me'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'no importa',
    'it doesn''t matter',
    'never mind'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'qué pena',
    'what a shame',
    'that''s too bad'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'qué lástima',
    'what a pity',
    'that''s a shame'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'por desgracia',
    'unfortunately',
    'sadly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'por suerte',
    'fortunately',
    'luckily'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'por casualidad',
    'by chance',
    'by any chance'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'a propósito',
    'on purpose',
    'by the way'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por cierto',
    'by the way',
    'incidentally'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'en serio',
    'seriously',
    'for real'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en general',
    'in general',
    'generally'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en particular',
    'in particular',
    'particularly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en cambio',
    'on the other hand',
    'by contrast'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por otra parte',
    'on the other hand',
    'besides'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'además de',
    'in addition to',
    'besides'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en primer lugar',
    'first of all',
    'in the first place'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en segundo lugar',
    'secondly',
    'in the second place'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por último',
    'finally',
    'lastly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en resumen',
    'in summary',
    'in short'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'es decir',
    'that is',
    'in other words'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'o sea',
    'in other words',
    'I mean'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a diferencia de',
    'unlike',
    'in contrast to'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'en lugar de',
    'instead of',
    'in place of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'con respecto a',
    'with regard to',
    'regarding'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'con tal de que',
    'provided that',
    'as long as'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'siempre y cuando',
    'provided that',
    'as long as'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a menos que',
    'unless',
    'except if'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'antes de que',
    'before',
    'before the time when'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'después de que',
    'after',
    'after the time when'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'hasta que',
    'until',
    'up until'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'mientras tanto',
    'meanwhile',
    'in the meantime'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de ahora en adelante',
    'from now on',
    'henceforth'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a partir de ahora',
    'from now on',
    'starting now'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de antemano',
    'in advance',
    'beforehand'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a tiempo',
    'on time',
    'in time'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a menudo',
    'often',
    'frequently'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'cada vez más',
    'more and more',
    'increasingly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'cada vez menos',
    'less and less',
    'decreasingly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'una vez más',
    'once again',
    'one more time'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se quedó sin',
    '{3sg-he} ran out of',
    '{3sg-he} was left without'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'me quedé sin',
    'I ran out of',
    'I was left without'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se quedó con',
    '{3sg-she} kept',
    '{3sg-she} ended up with'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'me quedé con',
    'I kept',
    'I ended up with'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'se puso de acuerdo',
    '{3sg-he} reached an agreement',
    '{3sg-he} came to an agreement'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'nos pusimos de acuerdo',
    'we reached an agreement',
    'we agreed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se hizo cargo de',
    '{3sg-she} took charge of',
    '{3sg-she} took responsibility for'
);
