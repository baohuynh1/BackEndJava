-- 1. Tạo bảng nhân viên
CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           name VARCHAR(50),
                           position VARCHAR(50)
);

-- 2. Tạo bảng lưu nhật ký thay đổi
CREATE TABLE employee_log (
                              log_id SERIAL PRIMARY KEY,
                              emp_name VARCHAR(50),
                              action_time TIMESTAMP
);

-- Chèn dữ liệu mẫu
INSERT INTO employees (name, position)
VALUES ('Nguyen Van A', 'Developer'), ('Tran Thi B', 'Designer');

CREATE OR REPLACE FUNCTION log_employee_update()
    RETURNS TRIGGER AS $$
BEGIN
    -- Chỉ ghi log khi thực sự có sự thay đổi dữ liệu
    INSERT INTO employee_log (emp_name, action_time)
    VALUES (NEW.name, NOW());

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_employee_update
    AFTER UPDATE ON employees
    FOR EACH ROW
EXECUTE FUNCTION log_employee_update();

-- Bước 1: Cập nhật chức vụ cho Nguyen Van A
UPDATE employees
SET position = 'Senior Developer'
WHERE name = 'Nguyen Van A';

-- Bước 2: Kiểm tra bảng nhân viên để xác nhận thay đổi
SELECT * FROM employees;

-- Bước 3: Kiểm tra bảng employee_log

SELECT * FROM employee_log;

