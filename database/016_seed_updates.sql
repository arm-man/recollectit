
UPDATE questions SET alternate_answer_text = 'Moi, c''est Becca' WHERE question_text = 'My name is Becca';

UPDATE questions SET question_text = 'A carafe of water', answer_text = 'une carafe d''eau' WHERE question_text = 'A glass of water';

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text) 
SELECT s.id, c.id, 'Here', 'Ici', 'Voilà'
FROM subjects s 
JOIN categories c ON s.id = c.subject_id 
WHERE s.title = 'French For Tourists' AND c.title = 'At the Restaurant';

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text) 
SELECT s.id, c.id, 'At what time', 'À quelle heure', NULL
FROM subjects s 
JOIN categories c ON s.id = c.subject_id 
WHERE s.title = 'French For Tourists' AND c.title = 'Greetings & Basics';

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text) 
SELECT s.id, c.id, 'I have a reservation in the name of', 'J''ai une réservation au nom de', NULL
FROM subjects s 
JOIN categories c ON s.id = c.subject_id 
WHERE s.title = 'French For Tourists' AND c.title = 'Greetings & Basics';

INSERT INTO questions (subject_id, category_id, question_text, answer_text, alternate_answer_text) 
SELECT s.id, c.id, 'By credit card', 'Par carte de crédit', 'Par carte'
FROM subjects s 
JOIN categories c ON s.id = c.subject_id 
WHERE s.title = 'French For Tourists' AND c.title = 'Greetings & Basics';

UPDATE questions SET answer_text = 'Rembrandt', alternate_answer_text = 'Rembrandt van Rijn' WHERE answer_text = 'Rembrandt van Rijn';
UPDATE questions SET answer_text = 'Michelangelo', alternate_answer_text = 'Michelangelo Buonarroti' WHERE answer_text = 'Michelangelo Buonarroti';
