
UPDATE questions SET question_text = 'The check', answer_text = 'L''addition' WHERE question_text = 'The check, please';
UPDATE questions SET question_text = 'A table for three', answer_text = 'Une table pour trois' WHERE question_text = 'A table for four, please';
UPDATE questions SET question_text = 'Another one', answer_text = 'Un autre' WHERE question_text = 'Another one, please';

INSERT INTO questions (subject_id, question_text, answer_text, category)
VALUES ((SELECT id FROM subjects WHERE title = 'French For Tourists'), 'Please', 'S''il vous plaît', (SELECT id FROM categories WHERE title = 'Greetings & Basics'));
