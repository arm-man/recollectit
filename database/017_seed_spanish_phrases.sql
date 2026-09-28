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
-- alternate_answer_text_2 supplies an optional third accepted English answer
-- Phrases with straightforward word-for-word English equivalents were replaced with less literal expressions.

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

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'pese a todo',
    'despite everything',
    'in spite of everything',
    'all the same'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'en cuanto a',
    'as for',
    'regarding',
    'as regards'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'menos mal que',
    'thank goodness',
    'luckily',
    'thankfully'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a lo largo de',
    'throughout',
    'over the course of',
    'all through'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de vez en cuando',
    'from time to time',
    'once in a while',
    'occasionally'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por lo tanto',
    'therefore',
    'as a result',
    'consequently'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'sin embargo',
    'however',
    'nevertheless',
    'even so'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'en vez de',
    'instead of',
    'rather than',
    'in place of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a pesar de',
    'despite',
    'in spite of',
    'regardless of'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'por si acaso',
    'just in case',
    'in case',
    NULL
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'al fin y al cabo',
    'after all',
    'when all is said and done',
    'ultimately'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de repente',
    'suddenly',
    'all of a sudden',
    'out of nowhere'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'en seguida',
    'right away',
    'immediately',
    'straight away'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'hace poco',
    'recently',
    'a short while ago',
    'not long ago'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'por supuesto',
    'of course',
    'certainly',
    'sure'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'ahora bien',
    'however',
    'that said',
    'now then'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'de hecho',
    'in fact',
    'actually',
    'as a matter of fact'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'por lo menos',
    'at least',
    'at the very least',
    'at minimum'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'en cuanto',
    'as soon as',
    'once',
    'the moment'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se darán cuenta de',
    'they will realize',
    'they will become aware of',
    'they will notice'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'me di cuenta de',
    'I realized',
    'I became aware of',
    'I noticed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'tuvo en cuenta',
    '{3sg-he} took into account',
    '{3sg-he} kept in mind',
    '{3sg-he} considered'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'tenemos en cuenta',
    'we take into account',
    'we keep in mind',
    'we consider'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se echó de menos',
    '{3sg-she} was missed',
    '{3sg-she} was longed for',
    '{3sg-she} was sorely missed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'te echo de menos',
    'I miss you',
    'I long for you',
    'I miss having you around'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se puso en marcha',
    '{3sg-it} got underway',
    '{3sg-it} was set in motion',
    '{3sg-it} started up'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'pusimos en marcha',
    'we launched',
    'we set in motion',
    'we got underway'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se llevó a cabo',
    '{3sg-it} was carried out',
    '{3sg-it} took place',
    '{3sg-it} was conducted'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'llevaron a cabo',
    'they carried out',
    'they completed',
    'they executed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'me da igual',
    'I don''t care',
    'it''s all the same to me',
    'it makes no difference to me'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'les daba igual',
    'they didn''t care',
    'it was all the same to them',
    'it made no difference to them'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'vale la pena',
    'it''s worth it',
    'it is worthwhile',
    'it is worth doing'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'valió la pena',
    'it was worth it',
    'it was worthwhile',
    'it proved worthwhile'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'está a punto de',
    '{3sg-he} is about to',
    '{3sg-he} is on the verge of',
    '{3sg-he} is just about to'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'estamos a punto de',
    'we are about to',
    'we are on the verge of',
    'we are just about to'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'acabo de llegar',
    'I just arrived',
    'I have just arrived',
    'I only just arrived'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'acaban de salir',
    'they just left',
    'they have just left',
    'they have only just left'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'volvió a empezar',
    '{3sg-she} started again',
    '{3sg-she} restarted',
    '{3sg-she} began again'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'volvimos a intentarlo',
    'we tried again',
    'we gave it another try',
    'we had another try'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'dejó de llover',
    'it stopped raining',
    'the rain stopped',
    'the rain let up'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'dejaron de hablar',
    'they stopped talking',
    'they quit talking',
    'they ceased talking'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'siguió adelante',
    '{3sg-he} carried on',
    '{3sg-he} moved forward',
    '{3sg-he} pressed on'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'seguimos adelante',
    'we carried on',
    'we moved forward',
    'we pressed on'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'ten cuidado',
    'be careful',
    'take care',
    'watch out'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tuvieron cuidado',
    'they were careful',
    'they took care',
    'they proceeded carefully'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'se dio prisa',
    '{3sg-he} hurried',
    '{3sg-he} rushed',
    '{3sg-he} made haste'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'date prisa',
    'hurry up',
    'get a move on',
    'be quick'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tenía prisa',
    '{3sg-she} was in a hurry',
    '{3sg-she} was rushed',
    '{3sg-she} was pressed for time'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tenemos prisa',
    'we are in a hurry',
    'we are rushed',
    'we are pressed for time'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tomó una decisión',
    '{3sg-he} made a decision',
    '{3sg-he} decided',
    '{3sg-he} came to a decision'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'tomaron una decisión',
    'they made a decision',
    'they decided',
    'they came to a decision'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'se lo tomó en serio',
    '{3sg-she} took it seriously',
    '{3sg-she} was serious about it',
    '{3sg-she} treated it seriously'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'me lo tomo en serio',
    'I take it seriously',
    'I am serious about it',
    'I treat it seriously'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'hizo caso',
    '{3sg-he} paid attention',
    '{3sg-he} listened',
    '{3sg-he} paid heed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'no me hizo caso',
    '{3sg-she} ignored me',
    '{3sg-she} didn''t listen to me',
    '{3sg-she} paid no attention to me'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'no importa',
    'it doesn''t matter',
    'never mind',
    'no matter'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'qué pena',
    'what a shame',
    'that''s too bad',
    'what a pity'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'qué lástima',
    'what a pity',
    'that''s a shame',
    'too bad'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'por desgracia',
    'unfortunately',
    'sadly',
    'regrettably'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'por suerte',
    'fortunately',
    'luckily',
    'thankfully'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a duras penas',
    'barely',
    'with great difficulty',
    'hardly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'qué va',
    'no way',
    'not at all',
    'absolutely not'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por cierto',
    'by the way',
    'incidentally',
    'speaking of which'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'ni hablar',
    'no way',
    'absolutely not',
    'forget it'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'a decir verdad',
    'truth be told',
    'to tell the truth',
    'honestly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'eso sí',
    'mind you',
    'that said',
    'however'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'en cambio',
    'on the other hand',
    'by contrast',
    'instead'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por otra parte',
    'on the other hand',
    'besides',
    'on another note'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'aun así',
    'even so',
    'nevertheless',
    'still'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'dicho esto',
    'that said',
    'having said that',
    'with that said'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'de ahí que',
    'which is why',
    'hence',
    'therefore'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por último',
    'finally',
    'lastly',
    'in the end'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'sea como sea',
    'be that as it may',
    'either way',
    'whatever happens'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'más bien',
    'rather',
    'more like',
    'instead'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'o sea',
    'in other words',
    'I mean',
    'that is to say'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a diferencia de',
    'unlike',
    'in contrast to',
    'as opposed to'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'de sobra',
    'more than enough',
    'plenty',
    'to spare'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Connectors'),
    'por más que',
    'no matter how much',
    'however much',
    'even though'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'con tal de que',
    'provided that',
    'as long as',
    'on condition that'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'siempre y cuando',
    'provided that',
    'as long as',
    'so long as'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'a menos que',
    'unless',
    'except if',
    'except when'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'al rato',
    'after a while',
    'a little later',
    'shortly afterward'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a estas alturas',
    'by now',
    'at this point',
    'at this stage'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'tarde o temprano',
    'sooner or later',
    'eventually',
    'at some point'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'mientras tanto',
    'meanwhile',
    'in the meantime',
    'in the interim'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'por aquel entonces',
    'back then',
    'at that time',
    'in those days'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a la larga',
    'in the long run',
    'eventually',
    'over time'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'de antemano',
    'in advance',
    'beforehand',
    'ahead of time'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'dentro de poco',
    'soon',
    'before long',
    'in a little while'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Time'),
    'a menudo',
    'often',
    'frequently',
    'regularly'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'cada vez más',
    'more and more',
    'increasingly',
    'progressively more'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Comparison/Conditions/Circumstance'),
    'cada vez menos',
    'less and less',
    'decreasingly',
    'progressively less'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Reactions'),
    'no pasa nada',
    'it''s okay',
    'no problem',
    'don''t worry'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se quedó sin',
    '{3sg-he} ran out of',
    '{3sg-he} was left without',
    '{3sg-he} had none left'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'me quedé sin',
    'I ran out of',
    'I was left without',
    'I had none left'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se quedó con',
    '{3sg-she} kept',
    '{3sg-she} ended up with',
    '{3sg-she} held on to'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'me quedé con',
    'I kept',
    'I ended up with',
    'I held on to'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'se puso de acuerdo',
    '{3sg-he} reached an agreement',
    '{3sg-he} came to an agreement',
    '{3sg-he} agreed'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Actions'),
    'nos pusimos de acuerdo',
    'we reached an agreement',
    'we agreed',
    'we came to an agreement'
);

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text, alternate_answer_text_2)
VALUES (
    (SELECT id FROM subjects WHERE title = 'Spanish Phrases'),
    (SELECT id FROM categories WHERE title = 'Verbal Expressions'),
    'se hizo cargo de',
    '{3sg-she} took charge of',
    '{3sg-she} took responsibility for',
    '{3sg-she} assumed responsibility for'
);
