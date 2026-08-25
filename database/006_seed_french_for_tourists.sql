
INSERT INTO subjects (
	title
)
VALUES
	('French For Tourists');

INSERT INTO categories (subject_id, title)
SELECT
    s.id,
    c.title
FROM subjects AS s
CROSS JOIN (
    VALUES
        ('Greetings & Basics'),
        ('At the Restaurant'),
        ('Food & Drink')
) AS c(title)
WHERE s.title = 'French For Tourists';

BEGIN;

DO $seed$
DECLARE
  v_subject_id integer;
  v_greetings_category_id integer;
  v_restaurant_category_id integer;
  v_food_category_id integer;
BEGIN
  SELECT id INTO STRICT v_subject_id
  FROM subjects
  WHERE title = 'French For Tourists';

  SELECT id INTO STRICT v_greetings_category_id
  FROM categories
  WHERE title = 'Greetings & Basics';

  SELECT id INTO STRICT v_restaurant_category_id
  FROM categories
  WHERE title = 'At the Restaurant';

  SELECT id INTO STRICT v_food_category_id
  FROM categories
  WHERE title = 'Food & Drink';

  INSERT INTO questions (subject_id, category_id, question_text, answer_text)
  VALUES
    (v_subject_id, v_greetings_category_id, 'Good morning', 'Bonjour'),
    (v_subject_id, v_greetings_category_id, 'Good evening', 'Bonsoir'),
    (v_subject_id, v_greetings_category_id, 'My name is Becca', 'Je m''appelle Becca'),
    (v_subject_id, v_greetings_category_id, 'What''s your name?', 'Comment vous appelez-vous ?'),
    (v_subject_id, v_greetings_category_id, 'How are you?', 'Comment ça va ?'),
    (v_subject_id, v_greetings_category_id, 'I''m well', 'Je vais bien'),
    (v_subject_id, v_greetings_category_id, 'I am from the USA', 'Je viens des États-Unis'),
    (v_subject_id, v_greetings_category_id, 'Goodbye', 'Au revoir'),
    (v_subject_id, v_greetings_category_id, 'Do you speak English?', 'Parlez-vous anglais ?'),
    (v_subject_id, v_greetings_category_id, 'I don''t understand', 'Je ne comprends pas'),
    (v_subject_id, v_greetings_category_id, 'Excuse me', 'Excusez-moi'),
    (v_subject_id, v_greetings_category_id, 'It''s nothing (standard reply to merci)', 'De rien'),
    (v_subject_id, v_greetings_category_id, 'Where are the toilets?', 'Où sont les toilettes ?'),
    (v_subject_id, v_greetings_category_id, 'The key', 'La clé'),
    (v_subject_id, v_greetings_category_id, 'Help!', 'Au secours !'),
    (v_subject_id, v_greetings_category_id, 'Where is the pharmacy?', 'Où est la pharmacie ?'),
    (v_subject_id, v_greetings_category_id, 'North', 'Nord'),
    (v_subject_id, v_greetings_category_id, 'South', 'Sud'),
    (v_subject_id, v_greetings_category_id, 'East', 'Est'),
    (v_subject_id, v_greetings_category_id, 'West', 'Ouest'),
    (v_subject_id, v_restaurant_category_id, 'The check, please', 'L''addition, s''il vous plaît'),
    (v_subject_id, v_restaurant_category_id, 'Breakfast', 'Petit-déjeuner'),
    (v_subject_id, v_restaurant_category_id, 'Lunch', 'Déjeuner'),
    (v_subject_id, v_restaurant_category_id, 'Dinner', 'Dîner'),
    (v_subject_id, v_restaurant_category_id, 'Cheers', 'Santé !'),
    (v_subject_id, v_restaurant_category_id, 'Enjoy your meal', 'Bon appétit'),
    (v_subject_id, v_restaurant_category_id, 'A table for four, please', 'Une table pour quatre, s''il vous plaît'),
    (v_subject_id, v_restaurant_category_id, 'Napkin', 'Serviette'),
    (v_subject_id, v_restaurant_category_id, 'Fork', 'Fourchette'),
    (v_subject_id, v_restaurant_category_id, 'Spoon', 'Cuillère'),
    (v_subject_id, v_restaurant_category_id, 'Knife', 'Couteau'),
    (v_subject_id, v_restaurant_category_id, 'How much?', 'C’est combien ?'),
    (v_subject_id, v_restaurant_category_id, 'Another one, please', 'Un autre, s''il vous plaît'),
    (v_subject_id, v_restaurant_category_id, 'Cup', 'Tasse'),
    (v_subject_id, v_restaurant_category_id, 'Appetizer', 'Entrée'),
    (v_subject_id, v_restaurant_category_id, 'Dessert', 'Dessert'),
    (v_subject_id, v_restaurant_category_id, 'Waiter', 'Serveur'),
    (v_subject_id, v_restaurant_category_id, 'Waitress', 'Serveuse'),
    (v_subject_id, v_food_category_id, 'A glass of water', 'Un verre d''eau'),
    (v_subject_id, v_food_category_id, 'Salt', 'Sel'),
    (v_subject_id, v_food_category_id, 'Pepper', 'Poivre'),
    (v_subject_id, v_food_category_id, 'Sugar', 'Sucre'),
    (v_subject_id, v_food_category_id, 'Soup', 'Soupe'),
    (v_subject_id, v_food_category_id, 'Bread', 'Pain'),
    (v_subject_id, v_food_category_id, 'Rice', 'Riz'),
    (v_subject_id, v_food_category_id, 'Vegetables', 'Légumes'),
    (v_subject_id, v_food_category_id, 'French fries', 'Frites'),
    (v_subject_id, v_food_category_id, 'Stew', 'Ragoût'),
    (v_subject_id, v_food_category_id, 'Meat', 'Viande'),
    (v_subject_id, v_food_category_id, 'Pork', 'Porc'),
    (v_subject_id, v_food_category_id, 'Chicken', 'Poulet'),
    (v_subject_id, v_food_category_id, 'Fish', 'Poisson'),
    (v_subject_id, v_food_category_id, 'Seafood', 'Fruits de mer'),
    (v_subject_id, v_food_category_id, 'Potatoes', 'Pommes de terre'),
    (v_subject_id, v_food_category_id, 'Apple', 'Pomme'),
    (v_subject_id, v_food_category_id, 'Lemon', 'Citron'),
    (v_subject_id, v_food_category_id, 'Cherry', 'Cerise'),
    (v_subject_id, v_food_category_id, 'Pomegranate', 'Grenade'),
    (v_subject_id, v_food_category_id, 'Bell pepper', 'Poivron'),
    (v_subject_id, v_food_category_id, 'Spinach', 'Épinards'),
    (v_subject_id, v_food_category_id, 'Onion', 'Oignon'),
    (v_subject_id, v_food_category_id, 'Garlic', 'Ail'),
    (v_subject_id, v_food_category_id, 'Eggplant', 'Aubergine'),
    (v_subject_id, v_food_category_id, 'Asparagus', 'Asperge'),
    (v_subject_id, v_food_category_id, 'Cauliflower', 'Chou-fleur'),
    (v_subject_id, v_food_category_id, 'Mushroom', 'Champignon'),
    (v_subject_id, v_food_category_id, 'Sweet potato', 'Patate douce'),
    (v_subject_id, v_food_category_id, 'Beef', 'Bœuf'),
    (v_subject_id, v_food_category_id, 'Turkey', 'Dinde'),
    (v_subject_id, v_food_category_id, 'Veal', 'Veau'),
    (v_subject_id, v_food_category_id, 'Ham', 'Jambon'),
    (v_subject_id, v_food_category_id, 'Milk', 'Lait'),
    (v_subject_id, v_food_category_id, 'Cheese', 'Fromage'),
    (v_subject_id, v_food_category_id, 'Cream', 'Crème'),
    (v_subject_id, v_food_category_id, 'Mustard', 'Moutarde');
END
$seed$;

COMMIT;
