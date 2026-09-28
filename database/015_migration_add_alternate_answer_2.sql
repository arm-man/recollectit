ALTER TABLE questions
  ADD COLUMN alternate_answer_text_2 text
  CONSTRAINT questions_alternate_answer_text_2_not_blank
  CHECK (
    alternate_answer_text_2 IS NULL
    OR btrim(alternate_answer_text_2) <> ''
  );
