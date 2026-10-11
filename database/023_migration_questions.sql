
ALTER TABLE questions
ADD COLUMN tip_text text;

ALTER TABLE questions
ADD CONSTRAINT questions_tip_text_not_blank
CHECK (tip_text IS NULL OR btrim(tip_text) <> '');