CREATE TABLE library.Books (
book_id SERIAL PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(100),
published_year INTEGER,
available BOOLEAN DEFAULT TRUE
);

CREATE TABLE library.Members (
member_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
join_date DATE DEFAULT CURRENT_DATE
);

SELECT datname FROM pg_database WHERE datistemplate = false;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'library';

SELECT column_name, data_type, column_default, is_nullable
FROM information_schema.columns
WHERE table_schema = 'library' AND table_name = 'books';