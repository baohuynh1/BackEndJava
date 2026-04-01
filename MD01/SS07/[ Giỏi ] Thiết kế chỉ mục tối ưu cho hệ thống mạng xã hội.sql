CREATE TABLE post
(
    post_id    SERIAL PRIMARY KEY,
    user_id    INT NOT NULL,
    content    TEXT,
    tags       TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public  BOOLEAN   DEFAULT TRUE
);

CREATE TABLE post_like
(
    user_id  INT NOT NULL,
    post_id  INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id)
);

-- Tạo Expression Index
CREATE INDEX idx_post_content_lower ON post (LOWER(content));

-- Để tận dụng Index này, hãy viết lại truy vấn một chút:
SELECT * FROM post
WHERE is_public = TRUE AND LOWER(content) LIKE LOWER('%du lịch%');

-- Kích hoạt extension
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_post_content_trgm ON post USING gin (content gin_trgm_ops);

CREATE INDEX idx_post_public_content_trgm
    ON post USING gin (content gin_trgm_ops)
    WHERE is_public = TRUE;

EXPLAIN ANALYZE
SELECT * FROM post WHERE is_public = TRUE AND content ILIKE '%du lịch%';
--Trước khi tạo index: Seq Scan on post,Execution Time: 0.020 ms
--Sau khi tạo:

CREATE INDEX idx_post_tags_gin ON post USING GIN (tags);

EXPLAIN ANALYZE
SELECT * FROM post WHERE tags @> ARRAY['travel'];

CREATE INDEX idx_post_recent_public
    ON post(created_at DESC)
    WHERE is_public = TRUE;

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE AND created_at >= NOW() - INTERVAL '7 days';

SELECT * FROM post
WHERE is_public = TRUE
ORDER BY created_at DESC
LIMIT 20; -- Cực kỳ nhanh vì index đã sắp xếp sẵn

CREATE INDEX idx_user_recent_posts
    ON post (user_id, created_at DESC);

EXPLAIN ANALYZE
SELECT * FROM post
WHERE user_id IN (101, 102, 103)
ORDER BY user_id, created_at DESC
LIMIT 10;