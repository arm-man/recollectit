BEGIN;

UPDATE questions
SET alternate_answer_text = 'Sucre'
WHERE answer_text = 'La Paz';

UPDATE questions
SET alternate_answer_text = 'Lobamba'
WHERE answer_text = 'Mbabane';

UPDATE questions
SET alternate_answer_text = 'Comayagüela'
WHERE answer_text = 'Tegucigalpa';

UPDATE questions
SET alternate_answer_text = 'Putrajaya'
WHERE answer_text = 'Kuala Lumpur';

UPDATE questions
SET alternate_answer_text = 'Cape Town'
WHERE answer_text = 'Pretoria';

-- change the answer
UPDATE questions
SET answer_text = 'Gitega'
WHERE answer_text = 'Bujumbura';

UPDATE questions
SET answer_text = 'Sri Jayawardenepura Kotte'
WHERE answer_text = 'Colombo';

-- alternate spellings
UPDATE questions
SET alternate_answer_text = 'Kotte'
WHERE answer_text = 'Sri Jayawardenepura Kotte';

UPDATE questions
SET alternate_answer_text = 'Ulan Bator'
WHERE answer_text = 'Ulaanbaatar';

UPDATE questions
SET alternate_answer_text = 'Naypyidaw'
WHERE answer_text = 'Nay Pyi Taw';

UPDATE questions
SET alternate_answer_text = 'Katmandu'
WHERE answer_text = 'Kathmandu';

UPDATE questions
SET alternate_answer_text = 'San''a'
WHERE answer_text = 'Sana''a';

UPDATE questions
SET alternate_answer_text = 'Kiev'
WHERE answer_text = 'Kyiv';

UPDATE questions
SET alternate_answer_text = 'Kishinev'
WHERE answer_text = 'Chisinau';

UPDATE questions
SET alternate_answer_text = 'Dacca'
WHERE answer_text = 'Dhaka';

UPDATE questions
SET alternate_answer_text = 'Teheran'
WHERE answer_text = 'Tehran';

UPDATE questions
SET alternate_answer_text = 'Khartum'
WHERE answer_text = 'Khartoum';

COMMIT;