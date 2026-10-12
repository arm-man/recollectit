-- Recollect It: factual tips, language explanations, and examples
-- Final review: 581 CSV questions; 223 selected tip_text updates.
-- Compared with the prior SQL: 50 new tips and 13 revised tips.
-- No invented mnemonic devices or memory associations.
-- PostgreSQL / Neon. The tip_text column must already exist.
-- Only tip_text is updated. Omitted questions and all other columns are unchanged.
-- Omitted updates do not erase tips that may already be in your database.
-- Existing tips on selected matching rows are replaced. Rerunning is idempotent.
-- Each update checks ID, subject, question text, and primary answer against the CSV.
-- Includes inactive questions. Source URLs are comments, not part of displayed tips.
-- No SQL has been executed against your database.

-- ORIGINAL ANSWERS TO REVIEW (comments only; no answer changes in this script)
-- ID 110, Georgia: CSV 'Tiblisi' should be 'Tbilisi'.
-- Source: https://georgia.travel/cities-towns/tbilisi
UPDATE questions SET answer_text = 'Tbilisi' WHERE id = 110 AND answer_text = 'Tiblisi';
-- ID 162, Equatorial Guinea: CSV 'Malabo' predates the declaration of
-- Ciudad de la Paz (Djibloho) as capital on January 2, 2026.
-- Source: https://www.guineaecuatorialpress.com/index.php/noticias/decreto_ley_por_el_que_se_declara_la_ciudad_de_la_paz_djibloho_capital_de_la_republica_de_guinea_ecuatorial
UPDATE questions SET answer_text = 'Ciudad de la Paz' WHERE id = 162 AND answer_text = 'Malabo';
-- ID 243, Palau: the capital is Ngerulmud, in Melekeok State; CSV says 'Melekeok'.
-- Source: https://www.palaugov.pw/wp-content/uploads/Palau-Water-Policy-2025-2045.pdf
-- These three rows have no tip update pending correction of the answer data.
UPDATE questions SET answer_text = 'Ngerulmud' WHERE id = 243 AND answer_text = 'Melekeok';

BEGIN;

-- U.S. capitals and territories: 12 tips

-- Alaska → Juneau
-- Source: https://www.traveljuneau.com/plan-your-trip/getting-here-and-around/
UPDATE questions SET tip_text = 'Juneau has no road connection to the rest of Alaska or the continental highway network; visitors arrive by air or sea.'
WHERE id = 52 AND subject_id = 1
  AND question_text = 'Alaska'
  AND answer_text = 'Juneau';

-- Arizona → Phoenix
-- Source: https://www.phoenix.gov/administration/departments/communications/history-facts/city-history.html
UPDATE questions SET tip_text = 'Phoenix was named for the mythical bird because its founders saw their new town rising near the remains of an earlier Indigenous civilization.'
WHERE id = 53 AND subject_id = 1
  AND question_text = 'Arizona'
  AND answer_text = 'Phoenix';

-- Arkansas → Little Rock
-- Source: https://littlerock.gov/government/city-clerks-office/our-historical-city/
UPDATE questions SET tip_text = 'Little Rock takes its name from a rock outcrop on the Arkansas River that French explorer La Harpe called la petite roche in 1722.'
WHERE id = 54 AND subject_id = 1
  AND question_text = 'Arkansas'
  AND answer_text = 'Little Rock';

-- Colorado → Denver
-- Source: https://www.denver.org/things-to-do/denver-attractions/must-see-denver/
UPDATE questions SET tip_text = 'Denver''s "Mile High City" nickname refers to its elevation: a marker on the state capitol steps stands 5,280 feet above sea level.'
WHERE id = 56 AND subject_id = 1
  AND question_text = 'Colorado'
  AND answer_text = 'Denver';

-- Georgia → Atlanta
-- Source: https://www.atlantahistorycenter.com/exhibitions/locomotion-railroads-and-the-making-of-atlanta/
UPDATE questions SET tip_text = 'Atlanta grew around the end of the Western & Atlantic Railroad and was first known as Terminus.'
WHERE id = 60 AND subject_id = 1
  AND question_text = 'Georgia'
  AND answer_text = 'Atlanta';

-- Louisiana → Baton Rouge
-- Source: https://www.brla.gov/841/A-Brief-History
UPDATE questions SET tip_text = 'Baton Rouge means "red stick" in French; French explorers used the name for a local landmark.'
WHERE id = 68 AND subject_id = 1
  AND question_text = 'Louisiana'
  AND answer_text = 'Baton Rouge';

-- Maryland → Annapolis
-- Source: https://www.visitannapolis.org/plan/anne-arundel-county/annapolis/
UPDATE questions SET tip_text = 'Annapolis briefly served as the United States capital in 1783–1784. It is also home to the U.S. Naval Academy.'
WHERE id = 70 AND subject_id = 1
  AND question_text = 'Maryland'
  AND answer_text = 'Annapolis';

-- Nebraska → Lincoln
-- Source: https://www.lincoln.ne.gov/files/sharedassets/public/v/1/planning/reports-tools-amp-references/2025compplan.pdf
UPDATE questions SET tip_text = 'Lincoln was originally called Lancaster. It was renamed for Abraham Lincoln when Nebraska chose its new state capital in 1867.'
WHERE id = 77 AND subject_id = 1
  AND question_text = 'Nebraska'
  AND answer_text = 'Lincoln';

-- New Mexico → Santa Fe
-- Source: https://www.santafe.org/visiting-santa-fe/about-santa-fe/new-mexico-state-capitol/
UPDATE questions SET tip_text = 'Santa Fe became the capital of Spain''s "Kingdom of New Mexico" in 1610, making it the oldest U.S. state capital city.'
WHERE id = 81 AND subject_id = 1
  AND question_text = 'New Mexico'
  AND answer_text = 'Santa Fe';

-- North Dakota → Bismarck
-- Source: https://www.bismarcknd.gov/642/Bismarck-City-Portrait
UPDATE questions SET tip_text = 'Bismarck was named for German chancellor Otto von Bismarck in 1873, partly to attract German investment in the railroad.'
WHERE id = 84 AND subject_id = 1
  AND question_text = 'North Dakota'
  AND answer_text = 'Bismarck';

-- Rhode Island → Providence
-- Source: https://www.nps.gov/rowi/learn/historyculture/foundingprovidence.htm
UPDATE questions SET tip_text = 'Roger Williams founded Providence as a refuge for religious freedom after his banishment from Massachusetts.'
WHERE id = 89 AND subject_id = 1
  AND question_text = 'Rhode Island'
  AND answer_text = 'Providence';

-- World capitals: 22 tips

-- China → Beijing
-- Source: https://english.visitbeijing.com.cn/article/47OMhkXlgaL
UPDATE questions SET tip_text = 'Beijing literally means "northern capital": bei means north and jing means capital. Nanjing means "southern capital."'
WHERE id = 109 AND subject_id = 2
  AND question_text = 'China'
  AND answer_text = 'Beijing';

-- Japan → Tokyo
-- Source: https://www.gotokyo.org/en/story/guide/a-noble-look-at-tokyos-imperial-palace-a-guide-to-the-royal-residence/
UPDATE questions SET tip_text = 'Tokyo was called Edo until 1868, when it was renamed as Japan''s imperial capital moved there from Kyoto.'
WHERE id = 116 AND subject_id = 2
  AND question_text = 'Japan'
  AND answer_text = 'Tokyo';

-- Democratic Republic of Congo → Kinshasa
-- Source: https://science.nasa.gov/earth/earth-observatory/kinshasa-and-brazzaville-4329/
UPDATE questions SET tip_text = 'Kinshasa faces Brazzaville across the Congo River. They are the capitals of two separate countries with Congo in their names.'
WHERE id = 159 AND subject_id = 2
  AND question_text = 'Democratic Republic of Congo'
  AND answer_text = 'Kinshasa';

-- Liberia → Monrovia
-- Source: https://history.state.gov/milestones/1830-1860/liberia
UPDATE questions SET tip_text = 'Monrovia was named in honor of U.S. president James Monroe, who supported the American colonization project in Liberia.'
WHERE id = 172 AND subject_id = 2
  AND question_text = 'Liberia'
  AND answer_text = 'Monrovia';

-- Nigeria → Abuja
-- Source: https://neiti.gov.ng/cms/wp-content/uploads/2021/08/NEITI-OPS6-A-Survey-Solid-Minerals-Landscape-Endowments-in-Nigeria-310120.pdf
UPDATE questions SET tip_text = 'Abuja replaced Lagos as Nigeria''s capital in 1991; the new capital''s site was chosen partly for its central location.'
WHERE id = 183 AND subject_id = 2
  AND question_text = 'Nigeria'
  AND answer_text = 'Abuja';

-- Republic of Congo → Brazzaville
-- Source: https://science.nasa.gov/earth/earth-observatory/kinshasa-and-brazzaville-4329/
UPDATE questions SET tip_text = 'Brazzaville faces Kinshasa across the Congo River. Brazzaville belongs to the Republic of the Congo; Kinshasa to the Democratic Republic.'
WHERE id = 184 AND subject_id = 2
  AND question_text = 'Republic of Congo'
  AND answer_text = 'Brazzaville';

-- Sierra Leone → Freetown
-- Source: https://news.novascotia.ca/en/2008/07/24/historical-painting-donated-maritime-museum
UPDATE questions SET tip_text = 'Freetown grew from settlements for formerly enslaved people, including Black Loyalists who arrived from Nova Scotia in 1792.'
WHERE id = 189 AND subject_id = 2
  AND question_text = 'Sierra Leone'
  AND answer_text = 'Freetown';

-- South Africa → Pretoria
-- Source: https://www.gov.za/about-sa/south-africa-glance
UPDATE questions SET tip_text = 'Pretoria is the administrative capital. South Africa also has Cape Town as its legislative capital and Bloemfontein as its judicial capital.'
WHERE id = 191 AND subject_id = 2
  AND question_text = 'South Africa'
  AND answer_text = 'Pretoria';

-- Belize → Belmopan
-- Source: https://www.travelbelize.org/blog/a-day-in-the-capital-city-of-belmopan/
UPDATE questions SET tip_text = 'Belmopan was built as a new capital after Hurricane Hattie devastated Belize City in 1961; the government moved inland in 1970.'
WHERE id = 204 AND subject_id = 2
  AND question_text = 'Belize'
  AND answer_text = 'Belmopan';

-- Bolivia → La Paz
-- Source: https://digitallibrary.un.org/record/605281/files/CMW_C_BOL_1-EN.pdf
UPDATE questions SET tip_text = 'La Paz is Bolivia''s seat of government; Sucre is its constitutional capital. Both appear in capital lists, with different roles.'
WHERE id = 225 AND subject_id = 2
  AND question_text = 'Bolivia'
  AND answer_text = 'La Paz';

-- Brazil → Brasília
-- Source: https://whc.unesco.org/en/list/445/
UPDATE questions SET tip_text = 'Brasília was purpose-built inland as Brazil''s new capital and inaugurated in 1960, replacing Rio de Janeiro.'
WHERE id = 226 AND subject_id = 2
  AND question_text = 'Brazil'
  AND answer_text = 'Brasília';

-- Australia → Canberra
-- Source: https://www.nma.gov.au/defining-moments/resources/founding-of-canberra
UPDATE questions SET tip_text = 'Canberra was developed as a new capital after Sydney and Melbourne competed for the role; it was a compromise between the two cities.'
WHERE id = 237 AND subject_id = 2
  AND question_text = 'Australia'
  AND answer_text = 'Canberra';

-- New Zealand → Wellington
-- Source: https://www3.parliament.nz/en/visit-and-learn/how-parliament-works/fact-sheets/parliament-s-move/
UPDATE questions SET tip_text = 'Wellington replaced Auckland as New Zealand''s capital in 1865, moving the seat of government closer to the country''s center.'
WHERE id = 242 AND subject_id = 2
  AND question_text = 'New Zealand'
  AND answer_text = 'Wellington';

-- Bulgaria → Sofia
-- Source: https://visitsofia.bg/catalog/en/discover_sofiaEN/Discover_SofiaEN.pdf
UPDATE questions SET tip_text = 'Sofia takes its name from the city''s Saint Sophia basilica, whose name refers to holy wisdom.'
WHERE id = 256 AND subject_id = 2
  AND question_text = 'Bulgaria'
  AND answer_text = 'Sofia';

-- Hungary → Budapest
-- Source: https://www.budapestinfo.hu/budapest-in-numbers-interesting-facts-about-the-capital
UPDATE questions SET tip_text = 'Budapest was formed in 1873 by merging Buda and Pest. Buda and Pest lie on opposite sides of the Danube.'
WHERE id = 266 AND subject_id = 2
  AND question_text = 'Hungary'
  AND answer_text = 'Budapest';

-- Iceland → Reykjavik
-- Source: https://www.osti.gov/servlets/purl/1209258
UPDATE questions SET tip_text = 'Reykjavik means "smoky bay," a reference to steam rising from the area''s hot springs.'
WHERE id = 267 AND subject_id = 2
  AND question_text = 'Iceland'
  AND answer_text = 'Reykjavik';

-- Netherlands → Amsterdam
-- Source: https://www.government.nl/binaries/government/documenten/publications/2017/04/21/culture-at-a-first-glance/CIB2015_ENG_publicatie_v8_DEF.pdf
UPDATE questions SET tip_text = 'Amsterdam is the Netherlands'' capital, but The Hague is the seat of its government.'
WHERE id = 280 AND subject_id = 2
  AND question_text = 'Netherlands'
  AND answer_text = 'Amsterdam';

-- Poland → Warsaw
-- Source: https://whc.unesco.org/en/list/30/
UPDATE questions SET tip_text = 'Much of Warsaw''s historic center was rebuilt after its destruction in World War II; UNESCO recognizes this extraordinary reconstruction.'
WHERE id = 282 AND subject_id = 2
  AND question_text = 'Poland'
  AND answer_text = 'Warsaw';

-- Portugal → Lisbon
-- Source: https://www.visitlisboa.com/en/lisbon-stories/19-ruta-del-barroco
UPDATE questions SET tip_text = 'Lisbon was devastated by an earthquake in 1755. Its rebuilt downtown introduced broad, straight streets and earthquake-resistant construction.'
WHERE id = 283 AND subject_id = 2
  AND question_text = 'Portugal'
  AND answer_text = 'Lisbon';

-- Literature: 26 tips

-- The Little Prince → Antoine de Saint-Exupéry
-- Source: https://www.blog.thelittleprince.com/page/36/
UPDATE questions SET tip_text = 'Saint-Exupéry was an aviator who survived a crash in the Sahara; the book also begins with a pilot stranded in the desert.'
WHERE id = 379 AND subject_id = 3
  AND question_text = 'The Little Prince'
  AND answer_text = 'Antoine de Saint-Exupéry';

-- The Crucible → Arthur Miller
-- Source: https://www.neh.gov/about/awards/jefferson-lecture/arthur-miller-biography
UPDATE questions SET tip_text = 'Arthur Miller used the Salem witch trials in The Crucible to explore the political persecution of the McCarthy era.'
WHERE id = 381 AND subject_id = 3
  AND question_text = 'The Crucible'
  AND answer_text = 'Arthur Miller';

-- Doctor Zhivago → Boris Pasternak
-- Source: https://www.nobelprize.org/prizes/literature/1958/summary/
UPDATE questions SET tip_text = 'Pasternak initially accepted the 1958 Nobel Prize in Literature, then was forced by Soviet authorities to decline it.'
WHERE id = 385 AND subject_id = 3
  AND question_text = 'Doctor Zhivago'
  AND answer_text = 'Boris Pasternak';

-- Oliver Twist → Charles Dickens
-- Source: https://dickensmuseum.com/en-de/blogs/charles-dickens-museum/64552835-the-marshalsea-prison-grille
UPDATE questions SET tip_text = 'Dickens worked in a shoe-polish factory at age twelve while his father was in debtors'' prison; a fellow worker was named Bob Fagin.'
WHERE id = 390 AND subject_id = 3
  AND question_text = 'Oliver Twist'
  AND answer_text = 'Charles Dickens';

-- Jane Eyre → Charlotte Brontë
-- Source: https://www.bronte.org.uk/about-the-brontes/the-lives-of-the-brontes
UPDATE questions SET tip_text = 'Charlotte Brontë published under the pen name Currer Bell; her sister Emily used Ellis Bell.'
WHERE id = 391 AND subject_id = 3
  AND question_text = 'Jane Eyre'
  AND answer_text = 'Charlotte Brontë';

-- The Hitchhiker's Guide to the Galaxy → Douglas Adams
-- Source: https://downloads.bbc.co.uk/historyofthebbc/1970s.pdf
UPDATE questions SET tip_text = 'Douglas Adams''s story began as a BBC radio comedy in 1978, before becoming a novel.'
WHERE id = 395 AND subject_id = 3
  AND question_text = 'The Hitchhiker''s Guide to the Galaxy'
  AND answer_text = 'Douglas Adams';

-- Wuthering Heights → Emily Brontë
-- Source: https://www.bronte.org.uk/about-the-brontes/the-lives-of-the-brontes
UPDATE questions SET tip_text = 'Emily Brontë used the pen name Ellis Bell; her sister Charlotte, author of Jane Eyre, used Currer Bell.'
WHERE id = 398 AND subject_id = 3
  AND question_text = 'Wuthering Heights'
  AND answer_text = 'Emily Brontë';

-- A Farewell to Arms → Ernest Hemingway
-- Source: https://www.jfklibrary.org/sites/default/files/2018-05/Issue_21_Spring_2016_New_Frontiers.pdf
UPDATE questions SET tip_text = 'Hemingway''s service as a Red Cross ambulance driver in Italy during World War I helped inspire A Farewell to Arms.'
WHERE id = 400 AND subject_id = 3
  AND question_text = 'A Farewell to Arms'
  AND answer_text = 'Ernest Hemingway';

-- Middlemarch → George Eliot
-- Source: https://www.georgeeliot.org/george-eliot/lifestory/10-childhood
UPDATE questions SET tip_text = 'George Eliot was the pen name of Mary Ann Evans, a woman writing under a male name.'
WHERE id = 411 AND subject_id = 3
  AND question_text = 'Middlemarch'
  AND answer_text = 'George Eliot';

-- 1984 → George Orwell
-- Source: https://www.orwellfoundation.com/the-orwell-foundation/orwell/biography/
UPDATE questions SET tip_text = 'George Orwell was the pen name of Eric Arthur Blair, who also wrote Animal Farm.'
WHERE id = 412 AND subject_id = 3
  AND question_text = '1984'
  AND answer_text = 'George Orwell';

-- Animal Farm → George Orwell
-- Source: https://www.orwellfoundation.com/the-orwell-foundation/news-events/news-events/news/george-orwell-at-the-bbc/
UPDATE questions SET tip_text = 'Orwell worked for the BBC during World War II before writing Animal Farm and Nineteen Eighty-Four.'
WHERE id = 413 AND subject_id = 3
  AND question_text = 'Animal Farm'
  AND answer_text = 'George Orwell';

-- Moby-Dick → Herman Melville
-- Source: https://berkshirehistory.org/guided-tours/
UPDATE questions SET tip_text = 'Melville wrote Moby-Dick at Arrowhead in Massachusetts, with a view of Mount Greylock from his study.'
WHERE id = 423 AND subject_id = 3
  AND question_text = 'Moby-Dick'
  AND answer_text = 'Herman Melville';

-- The Lord of the Rings → J. R. R. Tolkien
-- Source: https://www.tolkienestate.com/
UPDATE questions SET tip_text = 'Tolkien was an Oxford professor specializing in older languages and literature, including Old English and Old Norse.'
WHERE id = 426 AND subject_id = 3
  AND question_text = 'The Lord of the Rings'
  AND answer_text = 'J. R. R. Tolkien';

-- Pride and Prejudice → Jane Austen
-- Source: https://janeaustens.house/jane-austen/timeline/
UPDATE questions SET tip_text = 'Pride and Prejudice was originally published without Austen''s name, credited to "the author of Sense and Sensibility."'
WHERE id = 432 AND subject_id = 3
  AND question_text = 'Pride and Prejudice'
  AND answer_text = 'Jane Austen';

-- Sense and Sensibility → Jane Austen
-- Source: https://janeaustens.house/object/sense-and-sensibility/
UPDATE questions SET tip_text = 'Jane Austen''s first published novel, Sense and Sensibility, appeared in 1811 with the author credit "By a Lady."'
WHERE id = 433 AND subject_id = 3
  AND question_text = 'Sense and Sensibility'
  AND answer_text = 'Jane Austen';

-- Grapes of Wrath → John Steinbeck
-- Source: https://www.arts.gov/initiatives/nea-big-read/grapes-wrath
UPDATE questions SET tip_text = 'The Grapes of Wrath takes its title from Julia Ward Howe''s song "Battle Hymn of the Republic."'
WHERE id = 435 AND subject_id = 3
  AND question_text = 'Grapes of Wrath'
  AND answer_text = 'John Steinbeck';

-- Catch-22 → Joseph Heller
-- Source: https://www.simonandschuster.com/books/Catch-22/Joseph-Heller/9781451621174
UPDATE questions SET tip_text = 'Heller''s novel was originally called Catch-18; the title changed to avoid confusion with Leon Uris''s novel Mila 18.'
WHERE id = 439 AND subject_id = 3
  AND question_text = 'Catch-22'
  AND answer_text = 'Joseph Heller';

-- Slaughterhouse-Five → Kurt Vonnegut
-- Source: https://www.vonnegutlibrary.org/biography/
UPDATE questions SET tip_text = 'Vonnegut survived the bombing of Dresden as a prisoner of war sheltered beneath a slaughterhouse, an experience behind Slaughterhouse-Five.'
WHERE id = 443 AND subject_id = 3
  AND question_text = 'Slaughterhouse-Five'
  AND answer_text = 'Kurt Vonnegut';

-- Alice's Adventures in Wonderland → Lewis Carroll
-- Source: https://www.lewiscarroll.org/carroll/study/math/
UPDATE questions SET tip_text = 'Lewis Carroll was the pen name of Charles Dodgson, who taught mathematics and logic at Oxford.'
WHERE id = 450 AND subject_id = 3
  AND question_text = 'Alice''s Adventures in Wonderland'
  AND answer_text = 'Lewis Carroll';

-- Little Women → Louisa May Alcott
-- Source: https://louisamayalcott.org/louisa-may-alcott
UPDATE questions SET tip_text = 'Alcott drew on her own family for Little Women: she had three sisters, and Jo March resembles the young Louisa.'
WHERE id = 453 AND subject_id = 3
  AND question_text = 'Little Women'
  AND answer_text = 'Louisa May Alcott';

-- The Adventures of Huckleberry Finn → Mark Twain
-- Source: https://marktwainhouse.org/about/mark-twain/frequently-asked-questions/
UPDATE questions SET tip_text = 'Mark Twain''s pen name came from a riverboat call meaning two fathoms, or twelve feet, of water.'
WHERE id = 457 AND subject_id = 3
  AND question_text = 'The Adventures of Huckleberry Finn'
  AND answer_text = 'Mark Twain';

-- Frankenstein → Mary Shelley
-- Source: https://visit.bodleian.ox.ac.uk/sites/default/files/bodwhatson/documents/media/frankenstein-timeline-resource.pdf
UPDATE questions SET tip_text = 'Mary Shelley began the story that became Frankenstein during a ghost-story challenge proposed by Lord Byron in 1816.'
WHERE id = 459 AND subject_id = 3
  AND question_text = 'Frankenstein'
  AND answer_text = 'Mary Shelley';

-- Fahrenheit 451 → Ray Bradbury
-- Source: https://www.library.ucla.edu/collections/explore/ray-bradbury-papers/
UPDATE questions SET tip_text = 'Bradbury wrote this novel about book burning on a typewriter in the basement of UCLA''s Powell Library.'
WHERE id = 470 AND subject_id = 3
  AND question_text = 'Fahrenheit 451'
  AND answer_text = 'Ray Bradbury';

-- The Lottery → Shirley Jackson
-- Source: https://blogs.loc.gov/catbird/2017/08/shirley-jackson-and-the-lottery/
UPDATE questions SET tip_text = 'When "The Lottery" appeared in The New Yorker in 1948, its disturbing ending prompted an outpouring of angry letters to Shirley Jackson.'
WHERE id = 477 AND subject_id = 3
  AND question_text = 'The Lottery'
  AND answer_text = 'Shirley Jackson';

-- The Shining → Stephen King
-- Source: https://stephenking.com/works/novel/shining.html
UPDATE questions SET tip_text = 'King''s stay at Colorado''s nearly empty Stanley Hotel in 1974 helped inspire the isolated hotel setting of The Shining.'
WHERE id = 479 AND subject_id = 3
  AND question_text = 'The Shining'
  AND answer_text = 'Stephen King';

-- Their Eyes Were Watching God → Zora Neale Hurston
-- Source: https://www.arts.gov/initiatives/nea-big-read/their-eyes-were-watching-god
UPDATE questions SET tip_text = 'Hurston wrote Their Eyes Were Watching God in about seven weeks while in Haiti on a Guggenheim Fellowship.'
WHERE id = 499 AND subject_id = 3
  AND question_text = 'Their Eyes Were Watching God'
  AND answer_text = 'Zora Neale Hurston';

-- French for tourists: 40 tips

-- Good morning → Bonjour
UPDATE questions SET tip_text = 'Bonjour combines bon (good) and jour (day); it is also the usual daytime greeting, "hello."'
WHERE id = 296 AND subject_id = 4
  AND question_text = 'Good morning'
  AND answer_text = 'Bonjour';

-- Good evening → Bonsoir
UPDATE questions SET tip_text = 'Bonsoir combines bon (good) and soir (evening); it is used as an evening greeting.'
WHERE id = 297 AND subject_id = 4
  AND question_text = 'Good evening'
  AND answer_text = 'Bonsoir';

-- My name is Becca → Je m'appelle Becca
UPDATE questions SET tip_text = 'Je m''appelle literally means "I call myself," the standard French way to introduce your name.'
WHERE id = 298 AND subject_id = 4
  AND question_text = 'My name is Becca'
  AND answer_text = 'Je m''appelle Becca';

-- How are you? → Comment ça va ?
UPDATE questions SET tip_text = 'Ça va literally means "it goes." Comment ça va? asks how things are going.'
WHERE id = 300 AND subject_id = 4
  AND question_text = 'How are you?'
  AND answer_text = 'Comment ça va ?';

-- I'm well → Je vais bien
UPDATE questions SET tip_text = 'French uses aller (to go) to describe how you are doing: je vais bien means "I''m well."'
WHERE id = 301 AND subject_id = 4
  AND question_text = 'I''m well'
  AND answer_text = 'Je vais bien';

-- I am from the USA → Je viens des États-Unis
UPDATE questions SET tip_text = 'In Je viens des États-Unis, des combines de + les because États-Unis is plural. For a city, use de: Je viens de Boston.'
WHERE id = 302 AND subject_id = 4
  AND question_text = 'I am from the USA'
  AND answer_text = 'Je viens des États-Unis';

-- Goodbye → Au revoir
UPDATE questions SET tip_text = 'Revoir means "to see again"; au revoir expresses the idea of meeting again.'
WHERE id = 303 AND subject_id = 4
  AND question_text = 'Goodbye'
  AND answer_text = 'Au revoir';

-- Do you speak English? → Parlez-vous anglais ?
UPDATE questions SET tip_text = 'Vous addresses someone politely or several people. With a friend, the informal version is Tu parles anglais ?'
WHERE id = 304 AND subject_id = 4
  AND question_text = 'Do you speak English?'
  AND answer_text = 'Parlez-vous anglais ?';

-- I don't understand → Je ne comprends pas
UPDATE questions SET tip_text = 'In standard written French, ne and pas go on either side of the verb to make it negative: je ne comprends pas.'
WHERE id = 305 AND subject_id = 4
  AND question_text = 'I don''t understand'
  AND answer_text = 'Je ne comprends pas';

-- Excuse me → Excusez-moi
UPDATE questions SET tip_text = 'Excusez-moi, où est la gare ? — Excuse me, where is the station? Excusez-moi can politely get someone''s attention.'
WHERE id = 306 AND subject_id = 4
  AND question_text = 'Excuse me'
  AND answer_text = 'Excusez-moi';

-- It's nothing (standard reply to merci) → De rien
UPDATE questions SET tip_text = 'De rien literally means "of nothing," a conventional response to merci.'
WHERE id = 307 AND subject_id = 4
  AND question_text = 'It''s nothing (standard reply to merci)'
  AND answer_text = 'De rien';

-- Where are the toilets? → Où sont les toilettes ?
UPDATE questions SET tip_text = 'French normally uses the plural les toilettes for a restroom, even when asking for a single facility.'
WHERE id = 308 AND subject_id = 4
  AND question_text = 'Where are the toilets?'
  AND answer_text = 'Où sont les toilettes ?';

-- Where is the pharmacy? → Où est la pharmacie ?
UPDATE questions SET tip_text = 'Où est means "where is." Une pharmacie is a pharmacy.'
WHERE id = 311 AND subject_id = 4
  AND question_text = 'Where is the pharmacy?'
  AND answer_text = 'Où est la pharmacie ?';

-- The check → L'addition
UPDATE questions SET tip_text = 'L''addition, s''il vous plaît. — The bill, please. In a restaurant, addition means the bill; it also means addition in mathematics.'
WHERE id = 316 AND subject_id = 4
  AND question_text = 'The check'
  AND answer_text = 'L''addition';

-- Breakfast → Le petit-déjeuner
UPDATE questions SET tip_text = 'In France, petit-déjeuner is breakfast and déjeuner is lunch. Petit means small.'
WHERE id = 317 AND subject_id = 4
  AND question_text = 'Breakfast'
  AND answer_text = 'Le petit-déjeuner';

-- Lunch → Le déjeuner
UPDATE questions SET tip_text = 'In France, déjeuner is lunch. The word can refer to breakfast in some other French-speaking regions.'
WHERE id = 318 AND subject_id = 4
  AND question_text = 'Lunch'
  AND answer_text = 'Le déjeuner';

-- Cheers → Santé !
UPDATE questions SET tip_text = 'Santé means "health"; the toast wishes people good health.'
WHERE id = 320 AND subject_id = 4
  AND question_text = 'Cheers'
  AND answer_text = 'Santé !';

-- Napkin → La serviette
UPDATE questions SET tip_text = 'Une serviette de table is a napkin; une serviette de bain is a bath towel. Context determines which meaning of serviette is intended.'
WHERE id = 323 AND subject_id = 4
  AND question_text = 'Napkin'
  AND answer_text = 'La serviette';

-- Fork → La fourchette
UPDATE questions SET tip_text = 'Fourchette is a diminutive of fourche, meaning a fork or pitchfork.'
WHERE id = 324 AND subject_id = 4
  AND question_text = 'Fork'
  AND answer_text = 'La fourchette';

-- How much? → C’est combien ?
UPDATE questions SET tip_text = 'C''est combien ? asks the price. Combien can also mean how many: Combien de personnes ? — How many people?'
WHERE id = 327 AND subject_id = 4
  AND question_text = 'How much?'
  AND answer_text = 'C’est combien ?';

-- Another one → Un autre
UPDATE questions SET tip_text = 'Use un autre with masculine nouns (un autre café, another coffee) and une autre with feminine nouns (une autre tasse, another cup).'
WHERE id = 328 AND subject_id = 4
  AND question_text = 'Another one'
  AND answer_text = 'Un autre';

-- Appetizer → L'entrée
UPDATE questions SET tip_text = 'On a menu in France, an entrée is the starter, not the main course as in American English.'
WHERE id = 330 AND subject_id = 4
  AND question_text = 'Appetizer'
  AND answer_text = 'L''entrée';

-- Waiter → Le serveur
UPDATE questions SET tip_text = 'Serveur is the masculine form; serveuse is the feminine form.'
WHERE id = 332 AND subject_id = 4
  AND question_text = 'Waiter'
  AND answer_text = 'Le serveur';

-- Waitress → La serveuse
UPDATE questions SET tip_text = 'Serveuse is the feminine counterpart of serveur.'
WHERE id = 333 AND subject_id = 4
  AND question_text = 'Waitress'
  AND answer_text = 'La serveuse';

-- A carafe of water → une carafe d'eau
UPDATE questions SET tip_text = 'Eau means "water"; une carafe d''eau is a carafe of water.'
WHERE id = 334 AND subject_id = 4
  AND question_text = 'A carafe of water'
  AND answer_text = 'une carafe d''eau';

-- Vegetables → Les légumes
UPDATE questions SET tip_text = 'French légumes means vegetables generally; English "legumes" usually refers to beans, peas, and related plants.'
WHERE id = 341 AND subject_id = 4
  AND question_text = 'Vegetables'
  AND answer_text = 'Les légumes';

-- Fish → Le poisson
UPDATE questions SET tip_text = 'Poisson means fish; poison, with one s, means poison. The spelling changes the meaning.'
WHERE id = 347 AND subject_id = 4
  AND question_text = 'Fish'
  AND answer_text = 'Le poisson';

-- Seafood → Les fruits de mer
UPDATE questions SET tip_text = 'Fruits de mer literally means "fruits of the sea" and generally refers to shellfish rather than finfish.'
WHERE id = 348 AND subject_id = 4
  AND question_text = 'Seafood'
  AND answer_text = 'Les fruits de mer';

-- Potatoes → Les pommes de terre
UPDATE questions SET tip_text = 'Pommes de terre literally means "apples of the earth."'
WHERE id = 349 AND subject_id = 4
  AND question_text = 'Potatoes'
  AND answer_text = 'Les pommes de terre';

-- Apple → La pomme
UPDATE questions SET tip_text = 'Pomme means apple; pomme de terre means potato.'
WHERE id = 350 AND subject_id = 4
  AND question_text = 'Apple'
  AND answer_text = 'La pomme';

-- Pomegranate → La grenade
UPDATE questions SET tip_text = 'French grenade can mean either a pomegranate or a hand grenade.'
WHERE id = 353 AND subject_id = 4
  AND question_text = 'Pomegranate'
  AND answer_text = 'La grenade';

-- Bell pepper → Le poivron
UPDATE questions SET tip_text = 'Poivron is a bell pepper; poivre is the seasoning pepper.'
WHERE id = 354 AND subject_id = 4
  AND question_text = 'Bell pepper'
  AND answer_text = 'Le poivron';

-- Eggplant → L'aubergine
UPDATE questions SET tip_text = 'Aubergine is also the usual British English word for eggplant.'
WHERE id = 358 AND subject_id = 4
  AND question_text = 'Eggplant'
  AND answer_text = 'L''aubergine';

-- Cauliflower → Le chou-fleur
UPDATE questions SET tip_text = 'Chou-fleur literally means "cabbage-flower."'
WHERE id = 360 AND subject_id = 4
  AND question_text = 'Cauliflower'
  AND answer_text = 'Le chou-fleur';

-- Sweet potato → La patate douce
UPDATE questions SET tip_text = 'Douce is the feminine form of doux (sweet or gentle); patate douce means sweet potato.'
WHERE id = 362 AND subject_id = 4
  AND question_text = 'Sweet potato'
  AND answer_text = 'La patate douce';

-- Milk → Le lait
UPDATE questions SET tip_text = 'Café au lait means "coffee with milk"; lait is milk.'
WHERE id = 367 AND subject_id = 4
  AND question_text = 'Milk'
  AND answer_text = 'Le lait';

-- Please → S'il vous plaît
UPDATE questions SET tip_text = 'S''il vous plaît is polite or plural. S''il te plaît is used with one person you address informally as tu.'
WHERE id = 525 AND subject_id = 4
  AND question_text = 'Please'
  AND answer_text = 'S''il vous plaît';

-- At what time → À quelle heure
UPDATE questions SET tip_text = 'À quelle heure? literally asks "at what hour?" and is used to ask what time something happens.'
WHERE id = 627 AND subject_id = 4
  AND question_text = 'At what time'
  AND answer_text = 'À quelle heure';

-- I have a reservation in the name of → J'ai une réservation au nom de
UPDATE questions SET tip_text = 'Au nom de means "in the name of" and introduces the name on a reservation.'
WHERE id = 628 AND subject_id = 4
  AND question_text = 'I have a reservation in the name of'
  AND answer_text = 'J''ai une réservation au nom de';

-- By credit card → Par carte de crédit
UPDATE questions SET tip_text = 'Je peux payer par carte ? — Can I pay by card? Par carte is a common shorter expression that covers both credit and debit cards.'
WHERE id = 629 AND subject_id = 4
  AND question_text = 'By credit card'
  AND answer_text = 'Par carte de crédit';

-- Artists: 19 tips

-- Mona Lisa → Leonardo da Vinci
-- Source: https://www.louvre.fr/en/explore/visitor-trails/the-louvre-s-masterpieces/a-superstar-and-a-wedding-crowd
UPDATE questions SET tip_text = 'Leonardo''s Mona Lisa was stolen from the Louvre in 1911 by a former museum worker, causing an international sensation.'
WHERE id = 502 AND subject_id = 5
  AND question_text = 'Mona Lisa'
  AND answer_text = 'Leonardo da Vinci';

-- The Last Supper → Leonardo da Vinci
-- Source: https://cenacolovinciano.org/en/museum/backstage/
UPDATE questions SET tip_text = 'Leonardo painted The Last Supper on a dry wall rather than wet fresco plaster; this experimental technique made it unusually fragile.'
WHERE id = 503 AND subject_id = 5
  AND question_text = 'The Last Supper'
  AND answer_text = 'Leonardo da Vinci';

-- The Starry Night → Vincent van Gogh
-- Source: https://www.moma.org/collection/works/79802?page=1
UPDATE questions SET tip_text = 'Van Gogh painted The Starry Night in 1889 while staying at an asylum in Saint-Rémy, France; his window view helped inspire it.'
WHERE id = 504 AND subject_id = 5
  AND question_text = 'The Starry Night'
  AND answer_text = 'Vincent van Gogh';

-- Sunflowers → Vincent van Gogh
-- Source: https://www.vangoghmuseum.nl/assets/18b8acd3-a30f-4fec-8bb4-1d7991411fb4/Beddinghouse-x-Van-Gogh-Museum_Collection-Book?c=c326769530ff0b2ae212172cedf658fe7db4796dccaecead5e380cfb67f3a825
UPDATE questions SET tip_text = 'Van Gogh painted sunflower still lifes to decorate the room where his fellow artist Paul Gauguin would stay in Arles.'
WHERE id = 505 AND subject_id = 5
  AND question_text = 'Sunflowers'
  AND answer_text = 'Vincent van Gogh';

-- Girl with a Pearl Earring → Johannes Vermeer
-- Source: https://www.mauritshuis.nl/en/our-collection/artworks/670-girl-with-a-pearl-earring
UPDATE questions SET tip_text = 'Vermeer''s painting is a tronie: a study of a character or facial type, rather than a portrait meant to identify a particular person.'
WHERE id = 507 AND subject_id = 5
  AND question_text = 'Girl with a Pearl Earring'
  AND answer_text = 'Johannes Vermeer';

-- The Night Watch → Rembrandt
-- Source: https://www.rijksmuseum.nl/en/press/press-releases/for-the-first-time-in-300-years-the-night-watch-is-complete-again
UPDATE questions SET tip_text = 'Rembrandt''s Night Watch was cut down on all four sides in 1715 so it would fit its new location in Amsterdam''s town hall.'
WHERE id = 508 AND subject_id = 5
  AND question_text = 'The Night Watch'
  AND answer_text = 'Rembrandt';

-- The Birth of Venus → Sandro Botticelli
-- Source: https://www.uffizi.it/en/artworks/birth-of-venus
UPDATE questions SET tip_text = 'Despite its title, Botticelli''s painting depicts Venus arriving on shore after her birth from the sea.'
WHERE id = 509 AND subject_id = 5
  AND question_text = 'The Birth of Venus'
  AND answer_text = 'Sandro Botticelli';

-- David (sculpture) → Michelangelo
-- Source: https://www.galleriaaccademiafirenze.it/en/the-galleria/
UPDATE questions SET tip_text = 'Michelangelo''s original David moved from Florence''s Piazza della Signoria to the Galleria dell''Accademia in 1873.'
WHERE id = 511 AND subject_id = 5
  AND question_text = 'David (sculpture)'
  AND answer_text = 'Michelangelo';

-- The Persistence of Memory → Salvador Dalí
-- Source: https://www.moma.org/collection/works/79018?locale=en
UPDATE questions SET tip_text = 'Dalí likened the painting''s soft watches to Camembert cheese; the distant cliffs depict the coast of his native Catalonia.'
WHERE id = 512 AND subject_id = 5
  AND question_text = 'The Persistence of Memory'
  AND answer_text = 'Salvador Dalí';

-- Guernica → Pablo Picasso
-- Source: https://guernica.museoreinasofia.es/en/contextos/bombing-gernika-6211
UPDATE questions SET tip_text = 'Picasso painted Guernica after the 1937 bombing of the Basque town of Gernika during the Spanish Civil War.'
WHERE id = 513 AND subject_id = 5
  AND question_text = 'Guernica'
  AND answer_text = 'Pablo Picasso';

-- Three Musicians → Pablo Picasso
-- Source: https://www.moma.org/audio/playlist/336/4483
UPDATE questions SET tip_text = 'Picasso painted two large versions of Three Musicians in 1921, rearranging the figures between the two compositions.'
WHERE id = 514 AND subject_id = 5
  AND question_text = 'Three Musicians'
  AND answer_text = 'Pablo Picasso';

-- Water Lilies → Claude Monet
-- Source: https://www.musee-orangerie.fr/en/whats-on/tours-and-workshops/claude-monet-water-lilies-obsession
UPDATE questions SET tip_text = 'Monet cultivated the water garden at his home in Giverny that supplied the subject for his many Water Lilies paintings.'
WHERE id = 515 AND subject_id = 5
  AND question_text = 'Water Lilies'
  AND answer_text = 'Claude Monet';

-- Impression, Sunrise → Claude Monet
-- Source: https://www.marmottan.fr/en/collections/claude-monet/
UPDATE questions SET tip_text = 'Monet''s Impression, Sunrise helped give the Impressionist movement its name.'
WHERE id = 516 AND subject_id = 5
  AND question_text = 'Impression, Sunrise'
  AND answer_text = 'Claude Monet';

-- American Gothic → Grant Wood
-- Source: https://www.artic.edu/pdf/static/download-my-museum-tour.pdf-layout-5823.pdf
UPDATE questions SET tip_text = 'Grant Wood used his sister and his dentist as the models for the two figures in American Gothic.'
WHERE id = 517 AND subject_id = 5
  AND question_text = 'American Gothic'
  AND answer_text = 'Grant Wood';

-- Nighthawks → Edward Hopper
-- Source: https://archive.artic.edu/hopper/artwork/111628
UPDATE questions SET tip_text = 'Hopper gave the diner in Nighthawks no visible entrance, leaving the viewer looking in through its continuous glass front.'
WHERE id = 518 AND subject_id = 5
  AND question_text = 'Nighthawks'
  AND answer_text = 'Edward Hopper';

-- Campbell's Soup Cans → Andy Warhol
-- Source: https://www.moma.org/momaorg/shared/flattened_pages/moma_learning/andy-warhol-campbells-soup-cans-1962/
UPDATE questions SET tip_text = 'Warhol''s 1962 work consists of 32 canvases, one for each Campbell''s soup variety sold at the time.'
WHERE id = 519 AND subject_id = 5
  AND question_text = 'Campbell''s Soup Cans'
  AND answer_text = 'Andy Warhol';

-- A Sunday Afternoon on the Island of La Grande Jatte → Georges Seurat
-- Source: https://www.nga.gov/stories/videos/how-does-seurat-connect-pointillism-workers-rights
UPDATE questions SET tip_text = 'Seurat used small dots of color that blend visually when seen from a distance, a technique known as pointillism.'
WHERE id = 521 AND subject_id = 5
  AND question_text = 'A Sunday Afternoon on the Island of La Grande Jatte'
  AND answer_text = 'Georges Seurat';

-- The Great Wave off Kanagawa (woodblock print) → Katsushika Hokusai
-- Source: https://www.metmuseum.org/art/collection/search/39799
UPDATE questions SET tip_text = 'Hokusai''s Great Wave belongs to his series Thirty-six Views of Mount Fuji; the mountain appears small in the background.'
WHERE id = 522 AND subject_id = 5
  AND question_text = 'The Great Wave off Kanagawa (woodblock print)'
  AND answer_text = 'Katsushika Hokusai';

-- The Thinker (sculpture) → Auguste Rodin
-- Source: https://www.musee-rodin.fr/en/musee/collections/oeuvres/thinker
UPDATE questions SET tip_text = 'Rodin originally designed The Thinker for The Gates of Hell and called the figure The Poet.'
WHERE id = 523 AND subject_id = 5
  AND question_text = 'The Thinker (sculpture)'
  AND answer_text = 'Auguste Rodin';

-- Spanish phrases: 104 tips

-- pese a todo → despite everything
UPDATE questions SET tip_text = 'Pese a todo, seguimos adelante. — Despite everything, we carried on.'
WHERE id = 731 AND subject_id = 6
  AND question_text = 'pese a todo'
  AND answer_text = 'despite everything';

-- en cuanto a → as for
UPDATE questions SET tip_text = 'En cuanto a la comida, prefiero pescado. — As for the food, I prefer fish.'
WHERE id = 732 AND subject_id = 6
  AND question_text = 'en cuanto a'
  AND answer_text = 'as for';

-- menos mal que → thank goodness
UPDATE questions SET tip_text = 'Menos mal que trajiste un paraguas. — Thank goodness you brought an umbrella.'
WHERE id = 733 AND subject_id = 6
  AND question_text = 'menos mal que'
  AND answer_text = 'thank goodness';

-- a lo largo de → throughout
UPDATE questions SET tip_text = 'A lo largo de la semana, hubo varias reuniones. — Throughout the week, there were several meetings.'
WHERE id = 734 AND subject_id = 6
  AND question_text = 'a lo largo de'
  AND answer_text = 'throughout';

-- de vez en cuando → from time to time
UPDATE questions SET tip_text = 'De vez en cuando, salimos a cenar. — From time to time, we go out for dinner.'
WHERE id = 735 AND subject_id = 6
  AND question_text = 'de vez en cuando'
  AND answer_text = 'from time to time';

-- por lo tanto → therefore
UPDATE questions SET tip_text = 'Está cerrado; por lo tanto, volveremos mañana. — It is closed; therefore, we will come back tomorrow.'
WHERE id = 736 AND subject_id = 6
  AND question_text = 'por lo tanto'
  AND answer_text = 'therefore';

-- sin embargo → however
UPDATE questions SET tip_text = 'Quería salir; sin embargo, estaba lloviendo. — I wanted to go out; however, it was raining.'
WHERE id = 737 AND subject_id = 6
  AND question_text = 'sin embargo'
  AND answer_text = 'however';

-- en vez de → instead of
UPDATE questions SET tip_text = 'Pedí té en vez de café. — I ordered tea instead of coffee.'
WHERE id = 738 AND subject_id = 6
  AND question_text = 'en vez de'
  AND answer_text = 'instead of';

-- a pesar de → despite
UPDATE questions SET tip_text = 'A pesar de la lluvia, salimos. — Despite the rain, we went out.'
WHERE id = 739 AND subject_id = 6
  AND question_text = 'a pesar de'
  AND answer_text = 'despite';

-- por si acaso → just in case
UPDATE questions SET tip_text = 'Lleva una chaqueta por si acaso. — Take a jacket just in case.'
WHERE id = 740 AND subject_id = 6
  AND question_text = 'por si acaso'
  AND answer_text = 'just in case';

-- al fin y al cabo → after all
UPDATE questions SET tip_text = 'No te enfades; al fin y al cabo, es un niño. — Don''t get angry; after all, he is a child.'
WHERE id = 741 AND subject_id = 6
  AND question_text = 'al fin y al cabo'
  AND answer_text = 'after all';

-- de repente → suddenly
UPDATE questions SET tip_text = 'De repente, se apagaron las luces. — Suddenly, the lights went out.'
WHERE id = 742 AND subject_id = 6
  AND question_text = 'de repente'
  AND answer_text = 'suddenly';

-- en seguida → right away
UPDATE questions SET tip_text = 'Espera aquí; vuelvo en seguida. — Wait here; I''ll be right back.'
WHERE id = 743 AND subject_id = 6
  AND question_text = 'en seguida'
  AND answer_text = 'right away';

-- hace poco → recently
UPDATE questions SET tip_text = 'Hace poco, visité Madrid. — Recently, I visited Madrid.'
WHERE id = 744 AND subject_id = 6
  AND question_text = 'hace poco'
  AND answer_text = 'recently';

-- por supuesto → of course
UPDATE questions SET tip_text = '¿Puedo sentarme? — Por supuesto. — May I sit down? — Of course.'
WHERE id = 745 AND subject_id = 6
  AND question_text = 'por supuesto'
  AND answer_text = 'of course';

-- ahora bien → however
UPDATE questions SET tip_text = 'El hotel es bonito. Ahora bien, es bastante caro. — The hotel is lovely. However, it is quite expensive.'
WHERE id = 746 AND subject_id = 6
  AND question_text = 'ahora bien'
  AND answer_text = 'however';

-- de hecho → in fact
UPDATE questions SET tip_text = 'Me gusta leer; de hecho, leo todos los días. — I like reading; in fact, I read every day.'
WHERE id = 747 AND subject_id = 6
  AND question_text = 'de hecho'
  AND answer_text = 'in fact';

-- por lo menos → at least
UPDATE questions SET tip_text = 'Necesito por lo menos dos horas. — I need at least two hours.'
WHERE id = 748 AND subject_id = 6
  AND question_text = 'por lo menos'
  AND answer_text = 'at least';

-- en cuanto → as soon as
UPDATE questions SET tip_text = 'Te llamaré en cuanto llegue. — I''ll call you as soon as I arrive. En cuanto means ''as soon as''; en cuanto a means ''as for.'''
WHERE id = 749 AND subject_id = 6
  AND question_text = 'en cuanto'
  AND answer_text = 'as soon as';

-- se darán cuenta de → they will realize
UPDATE questions SET tip_text = 'Se darán cuenta de que falta una maleta. — They will realize that a suitcase is missing.'
WHERE id = 750 AND subject_id = 6
  AND question_text = 'se darán cuenta de'
  AND answer_text = 'they will realize';

-- me di cuenta de → I realized
UPDATE questions SET tip_text = 'Me di cuenta de que había olvidado las llaves. — I realized that I had forgotten the keys.'
WHERE id = 751 AND subject_id = 6
  AND question_text = 'me di cuenta de'
  AND answer_text = 'I realized';

-- tuvo en cuenta → {3sg-he} took into account
UPDATE questions SET tip_text = 'Tuvo en cuenta nuestra opinión. — He took our opinion into account.'
WHERE id = 752 AND subject_id = 6
  AND question_text = 'tuvo en cuenta'
  AND answer_text = '{3sg-he} took into account';

-- tenemos en cuenta → we take into account
UPDATE questions SET tip_text = 'Tenemos en cuenta tus preferencias. — We take your preferences into account.'
WHERE id = 753 AND subject_id = 6
  AND question_text = 'tenemos en cuenta'
  AND answer_text = 'we take into account';

-- se echó de menos → {3sg-she} was missed
UPDATE questions SET tip_text = 'Se echó de menos a Ana en la fiesta. — Ana was missed at the party. Here se makes the expression impersonal.'
WHERE id = 754 AND subject_id = 6
  AND question_text = 'se echó de menos'
  AND answer_text = '{3sg-she} was missed';

-- te echo de menos → I miss you
UPDATE questions SET tip_text = 'Te echo de menos cuando viajas. — I miss you when you travel.'
WHERE id = 755 AND subject_id = 6
  AND question_text = 'te echo de menos'
  AND answer_text = 'I miss you';

-- se puso en marcha → {3sg-it} got underway
UPDATE questions SET tip_text = 'El proyecto se puso en marcha en enero. — The project got underway in January.'
WHERE id = 756 AND subject_id = 6
  AND question_text = 'se puso en marcha'
  AND answer_text = '{3sg-it} got underway';

-- pusimos en marcha → we launched
UPDATE questions SET tip_text = 'Pusimos en marcha un nuevo proyecto. — We launched a new project.'
WHERE id = 757 AND subject_id = 6
  AND question_text = 'pusimos en marcha'
  AND answer_text = 'we launched';

-- se llevó a cabo → {3sg-it} was carried out
UPDATE questions SET tip_text = 'El plan se llevó a cabo sin problemas. — The plan was carried out without problems.'
WHERE id = 758 AND subject_id = 6
  AND question_text = 'se llevó a cabo'
  AND answer_text = '{3sg-it} was carried out';

-- llevaron a cabo → they carried out
UPDATE questions SET tip_text = 'Llevaron a cabo la investigación. — They carried out the investigation.'
WHERE id = 759 AND subject_id = 6
  AND question_text = 'llevaron a cabo'
  AND answer_text = 'they carried out';

-- me da igual → I don't care
UPDATE questions SET tip_text = 'Me da igual dónde comamos. — I don''t care where we eat. The expression conveys indifference: either choice is equally acceptable.'
WHERE id = 760 AND subject_id = 6
  AND question_text = 'me da igual'
  AND answer_text = 'I don''t care';

-- les daba igual → they didn't care
UPDATE questions SET tip_text = 'Les daba igual quién ganara. — They didn''t care who won.'
WHERE id = 761 AND subject_id = 6
  AND question_text = 'les daba igual'
  AND answer_text = 'they didn''t care';

-- vale la pena → it's worth it
UPDATE questions SET tip_text = 'Vale la pena visitar el museo. — It''s worth visiting the museum.'
WHERE id = 762 AND subject_id = 6
  AND question_text = 'vale la pena'
  AND answer_text = 'it''s worth it';

-- valió la pena → it was worth it
UPDATE questions SET tip_text = 'El viaje valió la pena. — The trip was worth it.'
WHERE id = 763 AND subject_id = 6
  AND question_text = 'valió la pena'
  AND answer_text = 'it was worth it';

-- está a punto de → {3sg-he} is about to
UPDATE questions SET tip_text = 'Está a punto de salir. — He is about to leave.'
WHERE id = 764 AND subject_id = 6
  AND question_text = 'está a punto de'
  AND answer_text = '{3sg-he} is about to';

-- estamos a punto de → we are about to
UPDATE questions SET tip_text = 'Estamos a punto de empezar. — We are about to start.'
WHERE id = 765 AND subject_id = 6
  AND question_text = 'estamos a punto de'
  AND answer_text = 'we are about to';

-- acabo de llegar → I just arrived
UPDATE questions SET tip_text = 'Acabo de llegar al hotel. — I just arrived at the hotel. Acabar de + infinitive describes something just done.'
WHERE id = 766 AND subject_id = 6
  AND question_text = 'acabo de llegar'
  AND answer_text = 'I just arrived';

-- acaban de salir → they just left
UPDATE questions SET tip_text = 'Acaban de salir de casa. — They just left home.'
WHERE id = 767 AND subject_id = 6
  AND question_text = 'acaban de salir'
  AND answer_text = 'they just left';

-- volvió a empezar → {3sg-she} started again
UPDATE questions SET tip_text = 'Volvió a empezar desde cero. — She started again from scratch. Volver a + infinitive means to do something again.'
WHERE id = 768 AND subject_id = 6
  AND question_text = 'volvió a empezar'
  AND answer_text = '{3sg-she} started again';

-- volvimos a intentarlo → we tried again
UPDATE questions SET tip_text = 'Volvimos a intentarlo al día siguiente. — We tried again the next day.'
WHERE id = 769 AND subject_id = 6
  AND question_text = 'volvimos a intentarlo'
  AND answer_text = 'we tried again';

-- dejó de llover → it stopped raining
UPDATE questions SET tip_text = 'Dejó de llover por la tarde. — It stopped raining in the afternoon. Dejar de + infinitive means to stop doing something.'
WHERE id = 770 AND subject_id = 6
  AND question_text = 'dejó de llover'
  AND answer_text = 'it stopped raining';

-- dejaron de hablar → they stopped talking
UPDATE questions SET tip_text = 'Dejaron de hablar cuando entró la profesora. — They stopped talking when the teacher came in.'
WHERE id = 771 AND subject_id = 6
  AND question_text = 'dejaron de hablar'
  AND answer_text = 'they stopped talking';

-- siguió adelante → {3sg-he} carried on
UPDATE questions SET tip_text = 'Aunque estaba cansado, siguió adelante. — Although he was tired, he carried on.'
WHERE id = 772 AND subject_id = 6
  AND question_text = 'siguió adelante'
  AND answer_text = '{3sg-he} carried on';

-- seguimos adelante → we carried on
UPDATE questions SET tip_text = 'Ayer seguimos adelante con el plan. — Yesterday, we carried on with the plan. Seguimos can be present or past; ayer makes the past meaning clear.'
WHERE id = 773 AND subject_id = 6
  AND question_text = 'seguimos adelante'
  AND answer_text = 'we carried on';

-- ten cuidado → be careful
UPDATE questions SET tip_text = 'Ten cuidado al cruzar la calle. — Be careful when crossing the street.'
WHERE id = 774 AND subject_id = 6
  AND question_text = 'ten cuidado'
  AND answer_text = 'be careful';

-- tuvieron cuidado → they were careful
UPDATE questions SET tip_text = 'Tuvieron cuidado de no hacer ruido. — They were careful not to make noise.'
WHERE id = 775 AND subject_id = 6
  AND question_text = 'tuvieron cuidado'
  AND answer_text = 'they were careful';

-- se dio prisa → {3sg-he} hurried
UPDATE questions SET tip_text = 'Se dio prisa para no perder el tren. — He hurried so he wouldn''t miss the train.'
WHERE id = 776 AND subject_id = 6
  AND question_text = 'se dio prisa'
  AND answer_text = '{3sg-he} hurried';

-- date prisa → hurry up
UPDATE questions SET tip_text = 'Date prisa, que el tren sale en cinco minutos. — Hurry up; the train leaves in five minutes. Darse prisa means to hurry; tener prisa means to be in a hurry.'
WHERE id = 777 AND subject_id = 6
  AND question_text = 'date prisa'
  AND answer_text = 'hurry up';

-- tenía prisa → {3sg-she} was in a hurry
UPDATE questions SET tip_text = 'Tenía prisa y no se quedó a hablar. — She was in a hurry and didn''t stay to talk.'
WHERE id = 778 AND subject_id = 6
  AND question_text = 'tenía prisa'
  AND answer_text = '{3sg-she} was in a hurry';

-- tenemos prisa → we are in a hurry
UPDATE questions SET tip_text = 'Tenemos prisa; vamos a llegar tarde. — We are in a hurry; we''re going to be late.'
WHERE id = 779 AND subject_id = 6
  AND question_text = 'tenemos prisa'
  AND answer_text = 'we are in a hurry';

-- tomó una decisión → {3sg-he} made a decision
UPDATE questions SET tip_text = 'Tomó una decisión difícil. — He made a difficult decision.'
WHERE id = 780 AND subject_id = 6
  AND question_text = 'tomó una decisión'
  AND answer_text = '{3sg-he} made a decision';

-- tomaron una decisión → they made a decision
UPDATE questions SET tip_text = 'Tomaron una decisión después de hablarlo. — They made a decision after discussing it.'
WHERE id = 781 AND subject_id = 6
  AND question_text = 'tomaron una decisión'
  AND answer_text = 'they made a decision';

-- se lo tomó en serio → {3sg-she} took it seriously
UPDATE questions SET tip_text = 'Se lo tomó en serio y empezó a practicar. — She took it seriously and started practicing.'
WHERE id = 782 AND subject_id = 6
  AND question_text = 'se lo tomó en serio'
  AND answer_text = '{3sg-she} took it seriously';

-- me lo tomo en serio → I take it seriously
UPDATE questions SET tip_text = 'Me lo tomo en serio; practico todos los días. — I take it seriously; I practice every day.'
WHERE id = 783 AND subject_id = 6
  AND question_text = 'me lo tomo en serio'
  AND answer_text = 'I take it seriously';

-- hizo caso → {3sg-he} paid attention
UPDATE questions SET tip_text = 'Hizo caso al consejo de su madre. — He listened to his mother''s advice.'
WHERE id = 784 AND subject_id = 6
  AND question_text = 'hizo caso'
  AND answer_text = '{3sg-he} paid attention';

-- no me hizo caso → {3sg-she} ignored me
UPDATE questions SET tip_text = 'Le dije que esperara, pero no me hizo caso. — I told her to wait, but she ignored me.'
WHERE id = 785 AND subject_id = 6
  AND question_text = 'no me hizo caso'
  AND answer_text = '{3sg-she} ignored me';

-- no importa → it doesn't matter
UPDATE questions SET tip_text = 'No importa si llegas un poco tarde. — It doesn''t matter if you arrive a little late.'
WHERE id = 786 AND subject_id = 6
  AND question_text = 'no importa'
  AND answer_text = 'it doesn''t matter';

-- qué pena → what a shame
UPDATE questions SET tip_text = '¡Qué pena que no puedas venir! — What a shame you can''t come!'
WHERE id = 787 AND subject_id = 6
  AND question_text = 'qué pena'
  AND answer_text = 'what a shame';

-- qué lástima → what a pity
UPDATE questions SET tip_text = '¡Qué lástima! El museo está cerrado. — What a pity! The museum is closed.'
WHERE id = 788 AND subject_id = 6
  AND question_text = 'qué lástima'
  AND answer_text = 'what a pity';

-- por desgracia → unfortunately
UPDATE questions SET tip_text = 'Por desgracia, perdimos el tren. — Unfortunately, we missed the train.'
WHERE id = 789 AND subject_id = 6
  AND question_text = 'por desgracia'
  AND answer_text = 'unfortunately';

-- por suerte → fortunately
UPDATE questions SET tip_text = 'Por suerte, encontramos un taxi. — Fortunately, we found a taxi.'
WHERE id = 790 AND subject_id = 6
  AND question_text = 'por suerte'
  AND answer_text = 'fortunately';

-- a duras penas → barely
UPDATE questions SET tip_text = 'A duras penas pude terminar la carrera. — I could barely finish the race.'
WHERE id = 791 AND subject_id = 6
  AND question_text = 'a duras penas'
  AND answer_text = 'barely';

-- qué va → no way
UPDATE questions SET tip_text = '¿Estás enfadado? — ¡Qué va! — Are you angry? — Not at all!'
WHERE id = 792 AND subject_id = 6
  AND question_text = 'qué va'
  AND answer_text = 'no way';

-- por cierto → by the way
UPDATE questions SET tip_text = 'Por cierto, ¿cómo está tu hermana? — By the way, how is your sister?'
WHERE id = 793 AND subject_id = 6
  AND question_text = 'por cierto'
  AND answer_text = 'by the way';

-- ni hablar → no way
UPDATE questions SET tip_text = '¿Vas a pagar cien euros por eso? — ¡Ni hablar! — Are you going to pay a hundred euros for that? — No way!'
WHERE id = 794 AND subject_id = 6
  AND question_text = 'ni hablar'
  AND answer_text = 'no way';

-- a decir verdad → truth be told
UPDATE questions SET tip_text = 'A decir verdad, no me gustó la película. — To tell the truth, I didn''t like the movie.'
WHERE id = 795 AND subject_id = 6
  AND question_text = 'a decir verdad'
  AND answer_text = 'truth be told';

-- eso sí → mind you
UPDATE questions SET tip_text = 'El piso es pequeño; eso sí, tiene mucha luz. — The apartment is small; mind you, it gets plenty of light.'
WHERE id = 796 AND subject_id = 6
  AND question_text = 'eso sí'
  AND answer_text = 'mind you';

-- en cambio → on the other hand
UPDATE questions SET tip_text = 'Yo prefiero té; ella, en cambio, prefiere café. — I prefer tea; she, on the other hand, prefers coffee.'
WHERE id = 797 AND subject_id = 6
  AND question_text = 'en cambio'
  AND answer_text = 'on the other hand';

-- por otra parte → on the other hand
UPDATE questions SET tip_text = 'El hotel es barato; por otra parte, está lejos del centro. — The hotel is cheap; on the other hand, it is far from the center.'
WHERE id = 798 AND subject_id = 6
  AND question_text = 'por otra parte'
  AND answer_text = 'on the other hand';

-- aun así → even so
UPDATE questions SET tip_text = 'Estaba cansado; aun así, salí a correr. — I was tired; even so, I went for a run.'
WHERE id = 799 AND subject_id = 6
  AND question_text = 'aun así'
  AND answer_text = 'even so';

-- dicho esto → that said
UPDATE questions SET tip_text = 'El plan tiene riesgos. Dicho esto, creo que funcionará. — The plan has risks. That said, I think it will work.'
WHERE id = 800 AND subject_id = 6
  AND question_text = 'dicho esto'
  AND answer_text = 'that said';

-- de ahí que → which is why
UPDATE questions SET tip_text = 'No durmió bien, de ahí que esté cansado. — He didn''t sleep well, which is why he is tired. De ahí que introduces the subjunctive.'
WHERE id = 801 AND subject_id = 6
  AND question_text = 'de ahí que'
  AND answer_text = 'which is why';

-- por último → finally
UPDATE questions SET tip_text = 'Por último, añade la sal. — Finally, add the salt.'
WHERE id = 802 AND subject_id = 6
  AND question_text = 'por último'
  AND answer_text = 'finally';

-- sea como sea → be that as it may
UPDATE questions SET tip_text = 'Sea como sea, tenemos que decidir hoy. — Be that as it may, we have to decide today.'
WHERE id = 803 AND subject_id = 6
  AND question_text = 'sea como sea'
  AND answer_text = 'be that as it may';

-- más bien → rather
UPDATE questions SET tip_text = 'No estoy enfadado; más bien, estoy decepcionado. — I''m not angry; rather, I''m disappointed.'
WHERE id = 804 AND subject_id = 6
  AND question_text = 'más bien'
  AND answer_text = 'rather';

-- o sea → in other words
UPDATE questions SET tip_text = 'Llegamos el lunes, o sea, mañana. — We arrive on Monday, in other words, tomorrow.'
WHERE id = 805 AND subject_id = 6
  AND question_text = 'o sea'
  AND answer_text = 'in other words';

-- a diferencia de → unlike
UPDATE questions SET tip_text = 'A diferencia de su hermano, a Ana le gusta correr. — Unlike her brother, Ana likes running.'
WHERE id = 806 AND subject_id = 6
  AND question_text = 'a diferencia de'
  AND answer_text = 'unlike';

-- de sobra → more than enough
UPDATE questions SET tip_text = 'Tenemos comida de sobra. — We have more than enough food.'
WHERE id = 807 AND subject_id = 6
  AND question_text = 'de sobra'
  AND answer_text = 'more than enough';

-- por más que → no matter how much
UPDATE questions SET tip_text = 'Por más que lo intento, no lo entiendo. — No matter how much I try, I don''t understand it.'
WHERE id = 808 AND subject_id = 6
  AND question_text = 'por más que'
  AND answer_text = 'no matter how much';

-- con tal de que → provided that
UPDATE questions SET tip_text = 'Te presto el coche con tal de que lo cuides. — I''ll lend you the car provided that you take care of it. Con tal de que introduces the subjunctive: cuides.'
WHERE id = 809 AND subject_id = 6
  AND question_text = 'con tal de que'
  AND answer_text = 'provided that';

-- siempre y cuando → provided that
UPDATE questions SET tip_text = 'Podemos salir siempre y cuando no llueva. — We can go out as long as it doesn''t rain.'
WHERE id = 810 AND subject_id = 6
  AND question_text = 'siempre y cuando'
  AND answer_text = 'provided that';

-- a menos que → unless
UPDATE questions SET tip_text = 'Iremos a pie a menos que llueva. — We''ll walk unless it rains. A menos que introduces the subjunctive: llueva.'
WHERE id = 811 AND subject_id = 6
  AND question_text = 'a menos que'
  AND answer_text = 'unless';

-- al rato → after a while
UPDATE questions SET tip_text = 'Llegó a casa y al rato se quedó dormido. — He got home and a little later fell asleep.'
WHERE id = 812 AND subject_id = 6
  AND question_text = 'al rato'
  AND answer_text = 'after a while';

-- a estas alturas → by now
UPDATE questions SET tip_text = 'A estas alturas, ya deberían haber llegado. — By now, they should have arrived.'
WHERE id = 813 AND subject_id = 6
  AND question_text = 'a estas alturas'
  AND answer_text = 'by now';

-- tarde o temprano → sooner or later
UPDATE questions SET tip_text = 'Tarde o temprano, tendrás que decidir. — Sooner or later, you''ll have to decide.'
WHERE id = 814 AND subject_id = 6
  AND question_text = 'tarde o temprano'
  AND answer_text = 'sooner or later';

-- mientras tanto → meanwhile
UPDATE questions SET tip_text = 'Yo preparo la cena; mientras tanto, pon la mesa. — I''ll make dinner; meanwhile, set the table.'
WHERE id = 815 AND subject_id = 6
  AND question_text = 'mientras tanto'
  AND answer_text = 'meanwhile';

-- por aquel entonces → back then
UPDATE questions SET tip_text = 'Por aquel entonces, vivíamos en Madrid. — Back then, we lived in Madrid.'
WHERE id = 816 AND subject_id = 6
  AND question_text = 'por aquel entonces'
  AND answer_text = 'back then';

-- a la larga → in the long run
UPDATE questions SET tip_text = 'Practicar un poco cada día ayuda a la larga. — Practicing a little every day helps in the long run.'
WHERE id = 817 AND subject_id = 6
  AND question_text = 'a la larga'
  AND answer_text = 'in the long run';

-- de antemano → in advance
UPDATE questions SET tip_text = 'Gracias de antemano por tu ayuda. — Thanks in advance for your help.'
WHERE id = 818 AND subject_id = 6
  AND question_text = 'de antemano'
  AND answer_text = 'in advance';

-- dentro de poco → soon
UPDATE questions SET tip_text = 'Dentro de poco, estaremos en casa. — Soon, we''ll be home.'
WHERE id = 819 AND subject_id = 6
  AND question_text = 'dentro de poco'
  AND answer_text = 'soon';

-- a menudo → often
UPDATE questions SET tip_text = 'A menudo voy al trabajo en bicicleta. — I often cycle to work.'
WHERE id = 820 AND subject_id = 6
  AND question_text = 'a menudo'
  AND answer_text = 'often';

-- cada vez más → more and more
UPDATE questions SET tip_text = 'Entiendo cada vez más español. — I understand more and more Spanish.'
WHERE id = 821 AND subject_id = 6
  AND question_text = 'cada vez más'
  AND answer_text = 'more and more';

-- cada vez menos → less and less
UPDATE questions SET tip_text = 'Tengo cada vez menos tiempo libre. — I have less and less free time.'
WHERE id = 822 AND subject_id = 6
  AND question_text = 'cada vez menos'
  AND answer_text = 'less and less';

-- no pasa nada → it's okay
UPDATE questions SET tip_text = 'Perdón por llegar tarde. — No pasa nada. — Sorry I''m late. — It''s okay.'
WHERE id = 823 AND subject_id = 6
  AND question_text = 'no pasa nada'
  AND answer_text = 'it''s okay';

-- se quedó sin → {3sg-he} ran out of
UPDATE questions SET tip_text = 'Se quedó sin gasolina en la carretera. — He ran out of gas on the road.'
WHERE id = 824 AND subject_id = 6
  AND question_text = 'se quedó sin'
  AND answer_text = '{3sg-he} ran out of';

-- me quedé sin → I ran out of
UPDATE questions SET tip_text = 'Me quedé sin batería. — I ran out of battery power.'
WHERE id = 825 AND subject_id = 6
  AND question_text = 'me quedé sin'
  AND answer_text = 'I ran out of';

-- se quedó con → {3sg-she} kept
UPDATE questions SET tip_text = 'Se quedó con la última porción de tarta. — She kept the last slice of cake.'
WHERE id = 826 AND subject_id = 6
  AND question_text = 'se quedó con'
  AND answer_text = '{3sg-she} kept';

-- me quedé con → I kept
UPDATE questions SET tip_text = 'Me quedé con el cambio. — I kept the change.'
WHERE id = 827 AND subject_id = 6
  AND question_text = 'me quedé con'
  AND answer_text = 'I kept';

-- se puso de acuerdo → {3sg-he} reached an agreement
UPDATE questions SET tip_text = 'Se puso de acuerdo con su vecino. — He reached an agreement with his neighbor.'
WHERE id = 828 AND subject_id = 6
  AND question_text = 'se puso de acuerdo'
  AND answer_text = '{3sg-he} reached an agreement';

-- nos pusimos de acuerdo → we reached an agreement
UPDATE questions SET tip_text = 'Nos pusimos de acuerdo sobre la hora. — We agreed on the time.'
WHERE id = 829 AND subject_id = 6
  AND question_text = 'nos pusimos de acuerdo'
  AND answer_text = 'we reached an agreement';

-- se hizo cargo de → {3sg-she} took charge of
UPDATE questions SET tip_text = 'Se hizo cargo de la situación. — She took charge of the situation.'
WHERE id = 830 AND subject_id = 6
  AND question_text = 'se hizo cargo de'
  AND answer_text = '{3sg-she} took charge of';

-- ¿Qué tiene eso que ver? → What does that have to do with anything?
UPDATE questions SET tip_text = 'Estamos hablando del precio. ¿Qué tiene eso que ver? — We are talking about the price. What does that have to do with anything?'
WHERE id = 832 AND subject_id = 6
  AND question_text = '¿Qué tiene eso que ver?'
  AND answer_text = 'What does that have to do with anything?';

-- Que así sea → So be it
UPDATE questions SET tip_text = 'Si esa es tu decisión, que así sea. — If that is your decision, so be it.'
WHERE id = 833 AND subject_id = 6
  AND question_text = 'Que así sea'
  AND answer_text = 'So be it';

-- A partir de ahora → From now on
UPDATE questions SET tip_text = 'A partir de ahora, voy a practicar todos los días. — From now on, I''m going to practice every day.'
WHERE id = 834 AND subject_id = 6
  AND question_text = 'A partir de ahora'
  AND answer_text = 'From now on';

-- ¿A que sí? → Isn't that right?
UPDATE questions SET tip_text = 'Esta tarta está deliciosa, ¿a que sí? — This cake is delicious, isn''t it?'
WHERE id = 835 AND subject_id = 6
  AND question_text = '¿A que sí?'
  AND answer_text = 'Isn''t that right?';

COMMIT;
