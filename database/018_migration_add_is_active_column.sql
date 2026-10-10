-- Add a global active/inactive flag to questions.
-- Existing questions remain active.

ALTER TABLE questions
ADD COLUMN is_active boolean NOT NULL DEFAULT true;

COMMENT ON COLUMN questions.is_active IS
'Controls whether a question is eligible for selection into new sessions. Inactive questions remain in the database and in existing sessions.';

