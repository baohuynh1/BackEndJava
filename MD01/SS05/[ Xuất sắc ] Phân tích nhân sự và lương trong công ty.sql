-- 1. Tạo bảng Phòng ban
CREATE TABLE departments (
dept_id SERIAL PRIMARY KEY,
dept_name VARCHAR(100) NOT NULL
);

-- 2. Tạo bảng Nhân viên
CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
emp_name VARCHAR(100) NOT NULL,
dept_id INT REFERENCES departments(dept_id) ON DELETE SET NULL,
salary NUMERIC(10, 2) DEFAULT 0.00,
hire_date DATE DEFAULT CURRENT_DATE
);

-- 3. Tạo bảng Dự án
CREATE TABLE projects (
project_id SERIAL PRIMARY KEY,
project_name VARCHAR(100) NOT NULL,
dept_id INT REFERENCES departments(dept_id) ON DELETE CASCADE
);

INSERT INTO departments (dept_name)
VALUES
    ('Phòng Kỹ thuật'),
    ('Phòng Kinh doanh'),
    ('Phòng Nhân sự'),
    ('Phòng Marketing'),
    ('Phòng Kế toán');

-- 2. Thêm dữ liệu vào bảng employees
-- Lưu ý: dept_id từ 1 đến 5 tương ứng với thứ tự insert ở trên
INSERT INTO employees (emp_name, dept_id, salary, hire_date)
VALUES
    ('Nguyễn Văn A', 1, 1500.00, '2023-01-15'),
    ('Trần Thị B', 1, 1600.50, '2023-03-20'),
    ('Lê Văn C', 2, 1200.00, '2023-06-10'),
    ('Phạm Minh D', 3, 1100.00, '2024-01-05'),
    ('Hoàng Thị Eo', 4, 170000000, '2024-02-12'),
    ('Hoàng Thị Én', 4, 16000000, '2024-02-12'),
    ('Hoàng Thị Énm', 4, 1600000000, '2024-02-12');

-- 3. Thêm dữ liệu vào bảng projects
INSERT INTO projects (project_name, dept_id)
VALUES
    ('Nâng cấp Hệ thống', 1),
    ('Ứng dụng Mobile mới', 1),
    ('Chiến dịch Mùa hè', 4),
    ('Tuyển dụng Thực tập sinh', 3),
    ('Mở rộng Thị trường Miền Nam', 2);
--1--
select
    e.emp_name as "Tên nhân viên",
    d.dept_name as "Phòng ban",
    e.salary as "Lương"
from employees e inner join departments d on e.dept_id=d.dept_id
--2--
select sum(e.salary),avg(e.salary),max(e.salary),min(e.salary),count(e.emp_id)
from employees e;
--3--
select
    d.dept_name as "Phòng ban", avg(e.salary) as "Lương"
from employees e inner join departments d on e.dept_id=d.dept_id
group by d.dept_name having avg(e.salary) > 1500
--4--
select p.project_name, d.dept_name,e.emp_name
from projects p
inner join departments d on p.dept_id=d.dept_id
inner join employees e on d.dept_id=e.dept_id
order by p.project_name;
--5--
select e.*
from employees e
where (e.dept_id,e.salary) in(
    select e.dept_id, max(e.salary)
    from employees e
    group by e.dept_id
    );

