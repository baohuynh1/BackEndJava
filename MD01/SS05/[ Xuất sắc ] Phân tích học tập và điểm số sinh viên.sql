-- Tạo bảng
CREATE TABLE students
(
    student_id SERIAL PRIMARY KEY,
    full_name  VARCHAR(100),
    major      VARCHAR(50)
);

CREATE TABLE courses
(
    course_id   SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credit      INT
);

CREATE TABLE enrollments
(
    student_id INT REFERENCES students (student_id),
    course_id  INT REFERENCES courses (course_id),
    score      NUMERIC(5, 2)
);

-- Chèn dữ liệu mẫu
INSERT INTO students (full_name, major)
VALUES ('Nguyen Van An', 'IT'),
       ('Tran Thi Binh', 'IT'),
       ('Le Quoc Anh', 'Business'),
       ('Pham Minh Duc', 'Marketing');

INSERT INTO courses (course_name, credit)
VALUES ('SQL Database', 3),
       ('Python Programming', 4),
       ('Marketing Basics', 2);

INSERT INTO enrollments
VALUES (1, 1, 8.5),
       (1, 2, 9.0), -- An (IT) điểm cao
       (2, 1, 7.0),
       (2, 2, 6.5), -- Binh (IT) điểm trung bình
       (3, 3, 9.5), -- Anh (Business) điểm cao
       (4, 3, 5.0);

SELECT s.full_name   AS "Tên sinh viên",
       c.course_name AS "Môn học",
       e.score       AS "Điểm"
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
         JOIN courses c ON e.course_id = c.course_id;

SELECT s.full_name,
       AVG(e.score) AS "Điểm trung bình",
       MAX(e.score) AS "Điểm cao nhất",
       MIN(e.score) AS "Điểm thấp nhất"
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name;

SELECT s.major,
       AVG(e.score) AS avg_major_score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

SELECT s.full_name,
       c.course_name,
       c.credit,
       e.score
FROM students s
         INNER JOIN enrollments e ON s.student_id = e.student_id
         INNER JOIN courses c ON e.course_id = c.course_id;

SELECT s.full_name,
       AVG(e.score) AS individual_avg
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (
    -- Subquery: Tính điểm trung bình của tất cả các bản ghi điểm trong trường
    SELECT AVG(score)
    FROM enrollments);