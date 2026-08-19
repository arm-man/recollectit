CREATE TABLE students (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  username text NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE subjects (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title text NOT NULL CHECK (btrim(title) <> '')
);

CREATE TABLE categories (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  subject_id integer NOT NULL,
  title text NOT NULL CHECK (btrim(title) <> ''),
  UNIQUE (subject_id, id),
  FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT
);

CREATE TABLE questions (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  subject_id integer NOT NULL,
  category_id integer,
  question_text text NOT NULL CHECK (btrim(question_text) <> ''),
  answer_text text NOT NULL CHECK (btrim(answer_text) <> ''),
  FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT,
  FOREIGN KEY (subject_id, category_id)
    REFERENCES categories (subject_id, id)
    ON DELETE RESTRICT
);

CREATE TABLE sessions (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id integer NOT NULL,
  subject_id integer NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  completed_at timestamptz,
  FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE RESTRICT,
  FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE RESTRICT
);

CREATE TABLE session_questions (
  session_id integer NOT NULL,
  question_id integer NOT NULL,
  attempts integer NOT NULL DEFAULT 0 CHECK (attempts >= 0),
  completed_at timestamptz,
  PRIMARY KEY (session_id, question_id),
  FOREIGN KEY (session_id) REFERENCES sessions (id) ON DELETE RESTRICT,
  FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE RESTRICT
);

CREATE TABLE logs (
  severity TEXT NOT NULL DEFAULT 'error',
  message TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX questions_subject_category_idx
  ON questions (subject_id, category_id);

CREATE INDEX sessions_student_completed_idx
  ON sessions (student_id, completed_at);

CREATE INDEX session_questions_question_idx
  ON session_questions (question_id);
