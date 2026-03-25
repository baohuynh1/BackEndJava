CREATE TABLE sinh_vien (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
age INT,
major VARCHAR(50),
gpa DECIMAL(3,2)
);

INSERT INTO sinh_vien (name, age, major, gpa) VALUES
('An', 20, 'CNTT', 3.5),
('Bình', 21, 'Toán', 3.2),
('Cường', 22, 'CNTT', 3.8),
('Dương', 20, 'Vật lý', 3.0),
('Em', 21, 'CNTT', 2.9);

INSERT INTO sinh_vien (name, age, major, gpa)
VALUES ('Hùng', 23, 'Hóa học', 3.4);

UPDATE sinh_vien
SET gpa = 3.6
WHERE name = 'Bình';

DELETE FROM sinh_vien
WHERE gpa < 3.0;

SELECT name, major
FROM sinh_vien
ORDER BY gpa DESC;

SELECT DISTINCT name
FROM sinh_vien
WHERE major = 'CNTT';

SELECT * FROM sinh_vien
WHERE gpa BETWEEN 3.0 AND 3.6;


SELECT * FROM sinh_vien
WHERE name ILIKE 'C%';

SELECT * FROM sinh_vien
ORDER BY name ASC
LIMIT 3;

SELECT * FROM sinh_vien
ORDER BY id ASC
LIMIT 3 OFFSET 1;

