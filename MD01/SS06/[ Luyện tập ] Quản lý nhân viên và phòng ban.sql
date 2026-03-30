CREATE TABLE Department
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

-- Tạo bảng Employee
CREATE TABLE Employee
(
    id            SERIAL PRIMARY KEY,
    full_name     VARCHAR(100),
    department_id INT REFERENCES Department (id),
    salary        NUMERIC(10, 2)
);

-- Chèn dữ liệu phòng ban
INSERT INTO Department (name)
VALUES ('Phòng Kỹ thuật'),
       ('Phòng Kinh doanh'),
       ('Phòng Nhân sự'),
       ('Phòng Pháp chế');
-- Phòng này sẽ trống

-- Chèn dữ liệu nhân viên
INSERT INTO Employee (full_name, department_id, salary)
VALUES ('Nguyen Van A', 1, 15000000),
       ('Tran Thi B', 1, 12000000),
       ('Le Van C', 2, 9000000),
       ('Pham Minh D', 2, 8000000),
       ('Hoang Thi E', 3, 11000000);

SELECT e.full_name AS "Tên nhân viên",
       d.name      AS "Tên phòng ban"
FROM Employee e
         INNER JOIN Department d ON e.department_id = d.id;

SELECT d.name        AS department_name,
       AVG(e.salary) AS avg_salary
FROM Department d
         INNER JOIN Employee e ON d.id = e.department_id
GROUP BY d.name;

SELECT d.name        AS department_name,
       AVG(e.salary) AS avg_salary
FROM Department d
         INNER JOIN Employee e ON d.id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 10000000;

SELECT d.name AS "Phòng ban trống"
FROM Department d
         LEFT JOIN Employee e ON d.id = e.department_id
WHERE e.id IS NULL;



