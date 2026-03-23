CREATE TABLE library.Books (
book_id SERIAL PRIMARY KEY,
title VARCHAR(100) NOT NULL,
author VARCHAR(50) NOT NULL,
published_year INTEGER,
price DECIMAL(10, 2)
);
--a--
SELECT datname FROM pg_database;
--b--
SELECT schema_name FROM information_schema.schemata;
--c--
SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema = 'library' AND table_name = 'books';
