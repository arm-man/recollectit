INSERT INTO subjects (title) VALUES	('Artists');
	
INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Mona Lisa', 'Leonardo da Vinci', 'da Vinci');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Last Supper', 'Leonardo da Vinci', 'da Vinci');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Starry Night', 'Vincent van Gogh', 'van Gogh');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Sunflowers', 'Vincent van Gogh', 'van Gogh');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Scream', 'Edvard Munch', 'Munch');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Girl with a Pearl Earring', 'Johannes Vermeer', 'Vermeer');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Night Watch', 'Rembrandt van Rijn', 'Rembrandt');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Birth of Venus', 'Sandro Botticelli', 'Botticelli');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Creation of Adam', 'Michelangelo Buonarroti', 'Michelangelo');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'David (sculpture)', 'Michelangelo Buonarroti', 'Michelangelo');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Persistence of Memory', 'Salvador Dalí', 'Dalí');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Guernica', 'Pablo Picasso', 'Picasso');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Three Musicians', 'Pablo Picasso', 'Picasso');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Water Lilies', 'Claude Monet', 'Monet');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Impression, Sunrise', 'Claude Monet', 'Monet');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'American Gothic', 'Grant Wood', 'Wood');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Nighthawks', 'Edward Hopper', 'Hopper');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Campbell''s Soup Cans', 'Andy Warhol', 'Warhol');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Son of Man', 'René Magritte', 'Magritte');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'A Sunday Afternoon on the Island of La Grande Jatte', 'Georges Seurat', 'Seurat');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Great Wave off Kanagawa (woodblock print)', 'Katsushika Hokusai', 'Hokusai');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'The Thinker (sculpture)', 'Auguste Rodin', 'Rodin');

INSERT INTO questions (subject_id, question_text, answer_text, alternate_answer_text)
VALUES ((SELECT id FROM subjects WHERE title = 'Artists'), 'Napoleon crossing the Alps', 'Jacques-Louis David', 'David');
