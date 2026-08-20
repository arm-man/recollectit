-- Seed categories for continents

INSERT INTO categories (subject_id, title)
SELECT
    s.id,
    c.title
FROM subjects AS s
CROSS JOIN (
    VALUES
        ('Africa'),
        ('Asia'),
        ('Europe'),
        ('North America'),
        ('Oceania'),
        ('South America')
) AS c(title)
WHERE s.title = 'World Capitals';
