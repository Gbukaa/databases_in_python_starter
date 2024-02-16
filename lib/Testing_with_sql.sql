-- Create a database:
-- Enter local host using command:
psql -h 127.0.0.1
-- Create a database using the CREATE command:
CREATE DATABASE database_name_here
--or for a real example:
CREATE DATABASE music_library

-- Seeding your database:
-- Seed your database with data inside a file, in this example, the music_library.sql seed file
psql -h 127.0.0.1 music_library < music_library.sql
-- Due to the instructions inside the music_library.sql file, this will create the tables
-- artists and albums, with the columns 'id' 'name' 'genre' in artists 
-- and 'id' 'title' 'release year' and 'artist_id' in albums

-- Using commands to query your database:
-- Once seeded, we can query the database and select, update, delete etc. using various commands.

-- First enter into the databse using:
psql -h 127.0.0.1 music_library

-- We can select all from artists table for example:
SELECT * FROM artists;

-- We can refine our search more using other syntax:
SELECT name FROM artists;
-- This will show only the names column from the artists table.

SELECT id, title FROM albums;
-- This will select multiple columns from the albums table, id and title.

-- We can also filter records by addding more conditions to the query, using WHERE:
SELECT [columns to select] FROM [table name] WHERE [conditions];
--e.g.
SELECT id, title, release_year FROM albums WHERE id = 2
SELECT id, title, release_year FROM albums WHERE title - 'Doolittle'
SELECT id, title, release_year FROM albums WHERE release_year > 1980
--We can also use the AND and OR syntax to combine conditions. e.g.
SELECT id, title, release_year, artist_id 
FROM albums 
WHERE release_year > 1989 
AND artist_id = 1;

--The columns 'id' and 'artist_id' are keys. 'id' is a primary key, and 'artist_id' is a foreign key.
-- The primary key is always called id and is the first column. This uniquely identifies each record.
-- the second column 'artist_id' in the albums table is a foreign key 
-- and is used to indicate which artist record (in artists table) 
-- is associated with the album record. So it links the two tables. e.g.

albums                                                    artists

id |        title         | artist_id |                  | id |     name     
----+----------------------+-----------+                  |----+--------------
1 | Doolittle            |         1 | ---------------> |  1 | Pixies
2 | Surfer Rosa          |         1 |                  |    |
3 | Waterloo             |         2 | ---------------> |  2 | ABBA
4 | Super Trouper        |         2 |                  
5 | Bossanova            |         1 |                                



-- Exercise 1: Run a SELECT query to list values for the column release_year from the albums table.
SELECT release_year FROM albums;

-- Exercise 2: Run a filtered SELECT query to list only the release_year of the album with title 'Bossanova'.
SELECT release_year FROM albums WHERE title = 'Bossanova';


-- Challenge 1: Find the titles of the albums released by 'Pixies' and released between 1980 and 1990.
-- Output =     
-- title    
-------------
-- Doolittle
-- Surfer Rosa
-- Bossanova
--(3 rows)

-- 2 ways of completing. If you know the artist_id:
SELECT title FROM albums 
WHERE artist_id = 1 
AND release_year BETWEEN 1980 AND 1990;

-- If you don't know the artist_id and need to join the two tables:

SELECT albums.title
FROM albums
INNER JOIN artists ON albums.artist_id = artists.id
WHERE artists.name = 'Pixies'
AND albums.release_year BETWEEN 1980 AND 1990;

-- The INNER JOIN keyword tells the database to only include rows where there's a match between the two tables.
-- The join condition is specified after the ON keyword: albums.artist_id = artists.id. 
-- This means that only rows where the artist_id in the albums table (albums.artist_id) matches 
-- the id in the artists table (artists.id) will be included in the result.

-- Somewhat 'simplified' version that outputs the same result. May help with clarity.
SELECT title
FROM albums
INNER JOIN artists ON artist_id = artists.id
WHERE name = 'Pixies'
AND release_year BETWEEN 1980 AND 1990;

-- Updating Records:
-- General syntax of UPDATE is:
UPDATE [table_name] SET [column_name] = [new_value]
WHERE [conditions];
-- Make sure you always have a WHERE condition, else you may re-write massive amounts of data!

-- you can update multiple columns, for example:
UPDATE albums 
SET release_year = '1986', title = 'Master of Puppets'
WHERE id = '1';


-- Creating new records using INSERT:
INSERT INTO [table_name]
( [list_of_column_titles])
VALUES( [list_of_values_to_insert] );

-- For example:
INSERT INTO artists
(name, genre)
VALUES ('Metallica', 'Metal');


--Deleting Records using DELETE:
DELETE FROM [table_name] WHERE [conditions]
-- Or delete ALL records! (almost NEVER USE THIS)
DELETE FROM [table_name]
--for example:
DELETE FROM artists WHERE name = 'Metallica'


-- Exercise:
-- Update the release_year of the album with ID 3 to the value 1972.
-- Use a SELECT query to get that specific record and verify it has been updated.

UPDATE albums SET release_year = '1972'
WHERE id = 3;

SELECT * FROM albums WHERE id =  3;

--Challenge:
-- Delete the album with ID 12.
-- Use a SELECT query to get the list of albums and verify that one has been deleted.

DELETE FROM albums WHERE id = 12;

SELECT * FROM albums;

-- Exercise:
-- INSERT a new record in albums with title 'Mezzanine', and release year 1998.
-- We forgot to link this new record with the correct artist. 
-- Use an UPDATE query to update the artist_id of that new album with Massive Attack 
-- (it should have the id value 5).
INSERT INTO albums
(title, release_year)
VALUES('Mezzanine', '1998');
-- Now update this to have the artist ID for Massive Attack in the artists table

UPDATE albums SET artist_id = '6' WHERE id = '13';

-- Challenge:
-- Insert a new artist of your choice, and a new album related to that artist
-- Then run a SELECT query to check the new artist is now in the table.

INSERT INTO artists
(name, genre)
VALUES ('Metallica', 'Metal');

INSERT INTO albums
(title, release_year, artist_id)
VALUES ('Master of Puppets', '1986', 7);

SELECT * FROM artists;
SELECT * FROM albums;
