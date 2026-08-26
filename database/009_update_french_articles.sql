-- Add definite articles to French noun answers and preserve the
-- article-free form in alternate_answer_text.
-- Generated from french.json.

BEGIN;

UPDATE questions
SET answer_text = 'Le petit-déjeuner',
    alternate_answer_text = 'Petit-déjeuner'
WHERE id = 317;

UPDATE questions
SET answer_text = 'Le déjeuner',
    alternate_answer_text = 'Déjeuner'
WHERE id = 318;

UPDATE questions
SET answer_text = 'Le dîner',
    alternate_answer_text = 'Dîner'
WHERE id = 319;

UPDATE questions
SET answer_text = 'La serviette',
    alternate_answer_text = 'Serviette'
WHERE id = 323;

UPDATE questions
SET answer_text = 'La fourchette',
    alternate_answer_text = 'Fourchette'
WHERE id = 324;

UPDATE questions
SET answer_text = 'La cuillère',
    alternate_answer_text = 'Cuillère'
WHERE id = 325;

UPDATE questions
SET answer_text = 'Le couteau',
    alternate_answer_text = 'Couteau'
WHERE id = 326;

UPDATE questions
SET answer_text = 'La tasse',
    alternate_answer_text = 'Tasse'
WHERE id = 329;

UPDATE questions
SET answer_text = 'L''entrée',
    alternate_answer_text = 'Entrée'
WHERE id = 330;

UPDATE questions
SET answer_text = 'Le dessert',
    alternate_answer_text = 'Dessert'
WHERE id = 331;

UPDATE questions
SET answer_text = 'Le serveur',
    alternate_answer_text = 'Serveur'
WHERE id = 332;

UPDATE questions
SET answer_text = 'La serveuse',
    alternate_answer_text = 'Serveuse'
WHERE id = 333;

UPDATE questions
SET answer_text = 'Le sel',
    alternate_answer_text = 'Sel'
WHERE id = 335;

UPDATE questions
SET answer_text = 'Le poivre',
    alternate_answer_text = 'Poivre'
WHERE id = 336;

UPDATE questions
SET answer_text = 'Le sucre',
    alternate_answer_text = 'Sucre'
WHERE id = 337;

UPDATE questions
SET answer_text = 'La soupe',
    alternate_answer_text = 'Soupe'
WHERE id = 338;

UPDATE questions
SET answer_text = 'Le pain',
    alternate_answer_text = 'Pain'
WHERE id = 339;

UPDATE questions
SET answer_text = 'Le riz',
    alternate_answer_text = 'Riz'
WHERE id = 340;

UPDATE questions
SET answer_text = 'Les légumes',
    alternate_answer_text = 'Légumes'
WHERE id = 341;

UPDATE questions
SET answer_text = 'Les frites',
    alternate_answer_text = 'Frites'
WHERE id = 342;

UPDATE questions
SET answer_text = 'Le ragoût',
    alternate_answer_text = 'Ragoût'
WHERE id = 343;

UPDATE questions
SET answer_text = 'La viande',
    alternate_answer_text = 'Viande'
WHERE id = 344;

UPDATE questions
SET answer_text = 'Le porc',
    alternate_answer_text = 'Porc'
WHERE id = 345;

UPDATE questions
SET answer_text = 'Le poulet',
    alternate_answer_text = 'Poulet'
WHERE id = 346;

UPDATE questions
SET answer_text = 'Le poisson',
    alternate_answer_text = 'Poisson'
WHERE id = 347;

UPDATE questions
SET answer_text = 'Les fruits de mer',
    alternate_answer_text = 'Fruits de mer'
WHERE id = 348;

UPDATE questions
SET answer_text = 'Les pommes de terre',
    alternate_answer_text = 'Pommes de terre'
WHERE id = 349;

UPDATE questions
SET answer_text = 'La pomme',
    alternate_answer_text = 'Pomme'
WHERE id = 350;

UPDATE questions
SET answer_text = 'Le citron',
    alternate_answer_text = 'Citron'
WHERE id = 351;

UPDATE questions
SET answer_text = 'La cerise',
    alternate_answer_text = 'Cerise'
WHERE id = 352;

UPDATE questions
SET answer_text = 'La grenade',
    alternate_answer_text = 'Grenade'
WHERE id = 353;

UPDATE questions
SET answer_text = 'Le poivron',
    alternate_answer_text = 'Poivron'
WHERE id = 354;

UPDATE questions
SET answer_text = 'Les épinards',
    alternate_answer_text = 'Épinards'
WHERE id = 355;

UPDATE questions
SET answer_text = 'L''oignon',
    alternate_answer_text = 'Oignon'
WHERE id = 356;

UPDATE questions
SET answer_text = 'L''ail',
    alternate_answer_text = 'Ail'
WHERE id = 357;

UPDATE questions
SET answer_text = 'L''aubergine',
    alternate_answer_text = 'Aubergine'
WHERE id = 358;

UPDATE questions
SET answer_text = 'L''asperge',
    alternate_answer_text = 'Asperge'
WHERE id = 359;

UPDATE questions
SET answer_text = 'Le chou-fleur',
    alternate_answer_text = 'Chou-fleur'
WHERE id = 360;

UPDATE questions
SET answer_text = 'Le champignon',
    alternate_answer_text = 'Champignon'
WHERE id = 361;

UPDATE questions
SET answer_text = 'La patate douce',
    alternate_answer_text = 'Patate douce'
WHERE id = 362;

UPDATE questions
SET answer_text = 'Le bœuf',
    alternate_answer_text = 'Bœuf'
WHERE id = 363;

UPDATE questions
SET answer_text = 'La dinde',
    alternate_answer_text = 'Dinde'
WHERE id = 364;

UPDATE questions
SET answer_text = 'Le veau',
    alternate_answer_text = 'Veau'
WHERE id = 365;

UPDATE questions
SET answer_text = 'Le jambon',
    alternate_answer_text = 'Jambon'
WHERE id = 366;

UPDATE questions
SET answer_text = 'Le lait',
    alternate_answer_text = 'Lait'
WHERE id = 367;

UPDATE questions
SET answer_text = 'Le fromage',
    alternate_answer_text = 'Fromage'
WHERE id = 368;

UPDATE questions
SET answer_text = 'La crème',
    alternate_answer_text = 'Crème'
WHERE id = 369;

UPDATE questions
SET answer_text = 'La moutarde',
    alternate_answer_text = 'Moutarde'
WHERE id = 370;

COMMIT;
