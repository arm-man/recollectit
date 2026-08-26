
INSERT INTO subjects (title)
VALUES ('U.S. Capitals')

INSERT INTO categories (subject_id, title)
SELECT
    s.id,
    c.title
FROM subjects AS s
CROSS JOIN (
    VALUES
        ('Eastern States'),
        ('Western States')
) AS c(title)
WHERE s.title = 'U.S. Capitals';

WITH subject AS (
    SELECT id
    FROM subjects
    WHERE title = 'U.S. Capitals'
),
seed_data (category_title, question_text, answer_text) AS (
    VALUES
        ('Eastern States', 'Alabama', 'Montgomery'),
        ('Western States', 'Alaska', 'Juneau'),
        ('Western States', 'Arizona', 'Phoenix'),
        ('Western States', 'Arkansas', 'Little Rock'),
        ('Western States', 'California', 'Sacramento'),
        ('Western States', 'Colorado', 'Denver'),
        ('Eastern States', 'Connecticut', 'Hartford'),
        ('Eastern States', 'Delaware', 'Dover'),
        ('Eastern States', 'Florida', 'Tallahassee'),
        ('Eastern States', 'Georgia', 'Atlanta'),
        ('Western States', 'Hawaii', 'Honolulu'),
        ('Western States', 'Idaho', 'Boise'),
        ('Eastern States', 'Illinois', 'Springfield'),
        ('Eastern States', 'Indiana', 'Indianapolis'),
        ('Western States', 'Iowa', 'Des Moines'),
        ('Western States', 'Kansas', 'Topeka'),
        ('Eastern States', 'Kentucky', 'Frankfort'),
        ('Western States', 'Louisiana', 'Baton Rouge'),
        ('Eastern States', 'Maine', 'Augusta'),
        ('Eastern States', 'Maryland', 'Annapolis'),
        ('Eastern States', 'Massachusetts', 'Boston'),
        ('Eastern States', 'Michigan', 'Lansing'),
        ('Western States', 'Minnesota', 'St. Paul'),
        ('Western States', 'Mississippi', 'Jackson'),
        ('Western States', 'Missouri', 'Jefferson City'),
        ('Western States', 'Montana', 'Helena'),
        ('Western States', 'Nebraska', 'Lincoln'),
        ('Western States', 'Nevada', 'Carson City'),
        ('Eastern States', 'New Hampshire', 'Concord'),
        ('Eastern States', 'New Jersey', 'Trenton'),
        ('Western States', 'New Mexico', 'Santa Fe'),
        ('Eastern States', 'New York', 'Albany'),
        ('Eastern States', 'North Carolina', 'Raleigh'),
        ('Western States', 'North Dakota', 'Bismarck'),
        ('Eastern States', 'Ohio', 'Columbus'),
        ('Western States', 'Oklahoma', 'Oklahoma City'),
        ('Western States', 'Oregon', 'Salem'),
        ('Eastern States', 'Pennsylvania', 'Harrisburg'),
        ('Eastern States', 'Rhode Island', 'Providence'),
        ('Eastern States', 'South Carolina', 'Columbia'),
        ('Western States', 'South Dakota', 'Pierre'),
        ('Eastern States', 'Tennessee', 'Nashville'),
        ('Western States', 'Texas', 'Austin'),
        ('Western States', 'Utah', 'Salt Lake City'),
        ('Eastern States', 'Vermont', 'Montpelier'),
        ('Eastern States', 'Virginia', 'Richmond'),
        ('Western States', 'Washington', 'Olympia'),
        ('Eastern States', 'West Virginia', 'Charleston'),
        ('Eastern States', 'Wisconsin', 'Madison'),
        ('Western States', 'Wyoming', 'Cheyenne'),
        ('Eastern States', 'Puerto Rico', 'San Juan'),
        ('Western States', 'American Samoa', 'Pago Pago')
)
INSERT INTO questions (
    subject_id,
    category_id,
    question_text,
    answer_text
)
SELECT
    s.id,
    c.id,
    d.question_text,
    d.answer_text
FROM seed_data d
CROSS JOIN subject s
JOIN categories c
    ON c.subject_id = s.id
   AND c.title = d.category_title;
