
-- North America
UPDATE questions SET is_active = false WHERE subject_id = (
    SELECT id
    FROM subjects
    WHERE title = 'World Capitals'
)
AND question_text in ('Antigua and Barbuda', 'Saint Kitts and Nevis', 'Saint Vincent and the Grenadines', 'Dominica');

-- Asia
UPDATE questions SET is_active = false WHERE subject_id = (
    SELECT id
    FROM subjects
    WHERE title = 'World Capitals'
)
AND question_text in ('Tajikistan', 'Kyrgyzstan', 'Timor-Leste/East Timor');

-- Africa recommended
UPDATE questions SET is_active = false WHERE subject_id = (
    SELECT id
    FROM subjects
    WHERE title = 'World Capitals'
)
AND question_text in ('Benin', 'Burkina Faso', 'Burundi', 'Central African Republic', 'Chad', 'Comoros', 'Republic of Congo', 'Djibouti', 'Equatorial Guinea', 'Eritrea', 'Eswatini', 'Gabon', 'Gambia', 'Guinea', 'Guinea-Bissau', 'Lesotho', 'Malawi', 'Mauritania', 'Niger', 'São Tomé and Príncipe', 'Sierra Leone', 'Togo');

-- Africa borderline
UPDATE questions SET is_active = false WHERE subject_id = (
    SELECT id
    FROM subjects
    WHERE title = 'World Capitals'
)
AND question_text in ('Botswana', 'Cape Verde', 'Cameroon', 'Côte d’Ivoire', 'Mozambique', 'Namibia', 'Senegal', 'Seychelles', 'Zambia', 'Zimbabwe');

-- Oceania
UPDATE questions SET is_active = false WHERE subject_id = (
    SELECT id
    FROM subjects
    WHERE title = 'World Capitals'
)
AND question_text in ('Kiribati', 'Marshall Islands', 'Federated States of Micronesia', 'Nauru', 'Palau', 'Tuvalu', 'Solomon Islands', 'Tonga', 'Vanuatu');
