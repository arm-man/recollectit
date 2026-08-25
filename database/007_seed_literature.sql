-- Seed Literature questions from literature_180_by_author(1).csv
-- question_text = work title; answer_text = author.
-- Source file contains 129 entries.

INSERT INTO categories (subject_id, title)
SELECT
    s.id,
    c.title
FROM subjects AS s
CROSS JOIN (
    VALUES
        ('American Classics'),
        ('American Modern'),
        ('British & Irish'),
		('European'),
		('World')
) AS c(title)
WHERE s.title = 'Literature';

BEGIN;

DO $$
DECLARE
    v_subject_id integer;
    v_american_classics_id integer;
    v_american_modern_id integer;
    v_british_irish_id integer;
    v_european_id integer;
    v_world_id integer;
BEGIN
    SELECT id INTO STRICT v_subject_id FROM subjects WHERE title = 'Literature';
    SELECT id INTO STRICT v_american_classics_id FROM categories WHERE subject_id = v_subject_id AND title = 'American Classics';
    SELECT id INTO STRICT v_american_modern_id FROM categories WHERE subject_id = v_subject_id AND title = 'American Modern';
    SELECT id INTO STRICT v_british_irish_id FROM categories WHERE subject_id = v_subject_id AND title = 'British & Irish';
    SELECT id INTO STRICT v_european_id FROM categories WHERE subject_id = v_subject_id AND title = 'European';
    SELECT id INTO STRICT v_world_id FROM categories WHERE subject_id = v_subject_id AND title = 'World';

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Stranger', 'Albert Camus');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Brave New World', 'Aldous Huxley');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'One Day in the Life of Ivan Denisovich', 'Alexander Solzhenitsyn');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Count of Monte Cristo', 'Alexandre Dumas');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Three Musketeers', 'Alexandre Dumas');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Color Purple', 'Alice Walker');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Joy Luck Club', 'Amy Tan');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'A Clockwork Orange', 'Anthony Burgess');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Little Prince', 'Antoine de Saint-Exupéry');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Death of a Salesman', 'Arthur Miller');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Crucible', 'Arthur Miller');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'The God of Small Things', 'Arundhati Roy');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Fountainhead', 'Ayn Rand');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Poisonwood Bible', 'Barbara Kingsolver');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Doctor Zhivago', 'Boris Pasternak');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Dracula', 'Bram Stoker');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Chronicles of Narnia', 'C. S. Lewis');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'A Tale of Two Cities', 'Charles Dickens');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Great Expectations', 'Charles Dickens');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Oliver Twist', 'Charles Dickens');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Jane Eyre', 'Charlotte Brontë');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Da Vinci Code', 'Dan Brown');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Robinson Crusoe', 'Daniel Defoe');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Flowers for Algernon', 'Daniel Keyes');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Fifty Shades of Grey', 'E. L. James');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Age of Innocence', 'Edith Wharton');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Wuthering Heights', 'Emily Brontë');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'All Quiet on the Western Front', 'Erich Maria Remarque');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'A Farewell to Arms', 'Ernest Hemingway');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'For Whom the Bell Tolls', 'Ernest Hemingway');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Old Man and the Sea', 'Ernest Hemingway');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Sun Also Rises', 'Ernest Hemingway');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Great Gatsby', 'F. Scott Fitzgerald');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Dune', 'Frank Herbert');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Metamorphosis', 'Franz Kafka');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Crime and Punishment', 'Fyodor Dostoevsky');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Brothers Karamazov', 'Fyodor Dostoevsky');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'One Hundred Years of Solitude', 'Gabriel García Márquez');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Canterbury Tales', 'Geoffrey Chaucer');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Middlemarch', 'George Eliot');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, '1984', 'George Orwell');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Animal Farm', 'George Orwell');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'A Game of Thrones', 'George R. R. Martin');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Madame Bovary', 'Gustave Flaubert');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Time Machine', 'H. G. Wells');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The War of the Worlds', 'H. G. Wells');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'To Kill a Mockingbird', 'Harper Lee');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Uncle Tom''s Cabin', 'Harriet Beecher Stowe');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'A Doll''s House', 'Henrik Ibsen');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Walden', 'Henry David Thoreau');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Turn of the Screw', 'Henry James');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Moby-Dick', 'Herman Melville');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Siddhartha', 'Hermann Hesse');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'I, Robot', 'Isaac Asimov');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Lord of the Rings', 'J. R. R. Tolkien');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Catcher in the Rye', 'J.D. Salinger');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'On the Road', 'Jack Kerouac');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Call of the Wild', 'Jack London');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Last of the Mohicans', 'James Fenimore Cooper');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Emma', 'Jane Austen');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Pride and Prejudice', 'Jane Austen');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Sense and Sensibility', 'Jane Austen');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Pilgrim''s Progress', 'John Bunyan');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Grapes of Wrath', 'John Steinbeck');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Of Mice and Men', 'John Steinbeck');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Gulliver''s Travels', 'Jonathan Swift');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Heart of Darkness', 'Joseph Conrad');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Catch-22', 'Joseph Heller');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Awakening', 'Kate Chopin');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Wind in the Willows', 'Kenneth Grahame');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'The Kite Runner', 'Khaled Hosseini');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Slaughterhouse-Five', 'Kurt Vonnegut');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Wonderful Wizard of Oz', 'L. Frank Baum');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'Anne of Green Gables', 'L. M. Montgomery');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Little House on the Prairie', 'Laura Ingalls Wilder');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Anna Karenina', 'Leo Tolstoy');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Death of Ivan Ilyich', 'Leo Tolstoy');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'War and Peace', 'Leo Tolstoy');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Alice''s Adventures in Wonderland', 'Lewis Carroll');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Giver', 'Lois Lowry');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'A Raisin in the Sun', 'Lorraine Hansberry');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Little Women', 'Louisa May Alcott');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'The Handmaid''s Tale', 'Margaret Atwood');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Gone with the Wind', 'Margaret Mitchell');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Godfather', 'Mario Puzo');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Adventures of Huckleberry Finn', 'Mark Twain');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'The Book Thief', 'Markus Zusak');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Frankenstein', 'Mary Shelley');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'I Know Why the Caged Bird Sings', 'Maya Angelou');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Jurassic Park', 'Michael Crichton');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Don Quixote', 'Miguel de Cervantes');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The House of the Seven Gables', 'Nathaniel Hawthorne');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Scarlet Letter', 'Nathaniel Hawthorne');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'The Picture of Dorian Gray', 'Oscar Wilde');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Esperanza Rising', 'Pam Muñoz Ryan');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'The Alchemist', 'Paulo Coelho');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Good Earth', 'Pearl S. Buck');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Invisible Man', 'Ralph Ellison');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Fahrenheit 451', 'Ray Bradbury');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Watership Down', 'Richard Adams');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Native Son', 'Richard Wright');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Strange Case of Dr Jekyll and Mr Hyde', 'Robert Louis Stevenson');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Treasure Island', 'Robert Louis Stevenson');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The House on Mango Street', 'Sandra Cisneros');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Winesburg, Ohio', 'Sherwood Anderson');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Lottery', 'Shirley Jackson');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Red Badge of Courage', 'Stephen Crane');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Shining', 'Stephen King');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Twilight', 'Stephenie Meyer');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Secret Life of Bees', 'Sue Monk Kidd');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Hunger Games', 'Suzanne Collins');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Bell Jar', 'Sylvia Plath');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'A Streetcar Named Desire', 'Tennessee Williams');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Tess of the d''Urbervilles', 'Thomas Hardy');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Our Town', 'Thornton Wilder');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'The Hunt for Red October', 'Tom Clancy');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'Beloved', 'Toni Morrison');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_modern_id, 'In Cold Blood', 'Truman Capote');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Jungle', 'Upton Sinclair');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Les Misérables', 'Victor Hugo');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'The Hunchback of Notre-Dame', 'Victor Hugo');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_european_id, 'Candide', 'Voltaire');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'My Ántonia', 'Willa Cather');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'As I Lay Dying', 'William Faulkner');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'The Sound and the Fury', 'William Faulkner');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_british_irish_id, 'Lord of the Flies', 'William Golding');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_world_id, 'Life of Pi', 'Yann Martel');

    INSERT INTO questions (subject_id, category_id, question_text, answer_text)
    VALUES (v_subject_id, v_american_classics_id, 'Their Eyes Were Watching God', 'Zora Neale Hurston');

END $$;

COMMIT;
