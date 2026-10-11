
CREATE TABLE alternate_answers (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question_id integer NOT NULL
        REFERENCES questions(id) ON DELETE CASCADE,
    answer_text text NOT NULL
        CHECK (btrim(answer_text) <> ''),
    UNIQUE (question_id, answer_text)
);

