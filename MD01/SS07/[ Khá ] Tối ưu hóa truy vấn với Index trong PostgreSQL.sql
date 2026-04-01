CREATE TABLE book (
                      book_id SERIAL PRIMARY KEY,
                      title VARCHAR(255),
                      author VARCHAR(100),
                      genre VARCHAR(50),
                      price DECIMAL(10,2),
                      description TEXT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_book_genre ON book(genre);
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_book_author_trgm ON book USING gin (author gin_trgm_ops);

EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
-- Sau khi tạo index Execution Time: 0.059 ms--

EXPLAIN ANALYZE SELECT * FROM book WHERE description LIKE '%magic%';
-- Kết quả: Seq Scan
-- Tạo chỉ mục trên vector ngôn ngữ tiếng Anh
CREATE INDEX idx_book_desc_fulltext ON book USING GIN (to_tsvector('english', description));

EXPLAIN ANALYZE
SELECT * FROM book
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'magic');
-- Kết quả: "Bitmap Heap Scan"

CLUSTER book USING idx_book_genre;



