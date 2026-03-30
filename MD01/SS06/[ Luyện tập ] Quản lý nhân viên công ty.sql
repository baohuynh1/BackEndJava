CREATE TABLE Employee
(
    emp_id     SERIAL PRIMARY KEY,
    emp_name   VARCHAR(100),
    department VARCHAR(50),
    salary     NUMERIC(15, 2),
    hire_date  DATE
);

-- Thêm 6 nhân viên mới
INSERT INTO Employee (emp_name, department, salary, hire_date)
VALUES ('Nguyen Van An', 'IT', 15000000, '2023-05-15'),
       ('Tran Thi Binh', 'HR', 8000000, '2022-10-20'),
       ('Le Quoc Anh', 'IT', 12000000, '2023-11-01'),
       ('Pham Thanh an', 'Marketing', 5500000, '2023-02-10'), -- Lương thấp để test DELETE
       ('Hoang Minh Duc', 'IT', 9000000, '2024-01-15'),
       ('Dang Bao Ngoc', 'Accounting', 7500000, '2023-12-25');

UPDATE Employee
SET salary = salary * 1.1
WHERE department = 'IT';

DELETE FROM Employee
WHERE salary < 6000000;

-- Dành cho PostgreSQL (Không phân biệt hoa thường)
SELECT * FROM Employee
WHERE emp_name ILIKE '%An%';

SELECT * FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';