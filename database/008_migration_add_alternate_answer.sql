ALTER TABLE questions
  ADD COLUMN alternate_answer_text text
  CONSTRAINT questions_alternate_answer_text_not_blank
  CHECK (
    alternate_answer_text IS NULL
    OR btrim(alternate_answer_text) <> ''
  );
