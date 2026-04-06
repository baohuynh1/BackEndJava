-- Tạo bảng employees
CREATE TABLE employees
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary     NUMERIC(10, 2),
    bonus      NUMERIC(10, 2) DEFAULT 0,
    status     TEXT -- Thêm cột này để lưu trạng thái Junior/Mid/Senior
);

-- Chèn dữ liệu mẫu từ hình ảnh
INSERT INTO employees (name, department, salary)
VALUES ('Nguyen Van A', 'HR', 4000),
       ('Tran Thi B', 'IT', 6000),
       ('Le Van C', 'Finance', 10500),
       ('Pham Thi D', 'IT', 8000),
       ('Do Van E', 'HR', 12000);

CREATE OR REPLACE PROCEDURE update_employee_status(
    p_emp_id INT,
    OUT p_status TEXT
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_salary NUMERIC;
BEGIN
    -- 1. Lấy lương của nhân viên dựa trên ID
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE id = p_emp_id;

    -- 2. Kiểm tra nếu nhân viên không tồn tại
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Employee not found';
    END IF;

    -- 3. Xác định trạng thái dựa trên mức lương
    IF v_salary < 5000 THEN
        p_status := 'Junior';
    ELSIF v_salary >= 5000 AND v_salary <= 10000 THEN
        p_status := 'Mid-level';
    ELSE
        p_status := 'Senior';
    END IF;

    -- 4. Cập nhật vào bảng
    UPDATE employees
    SET status = p_status
    WHERE id = p_emp_id;

END;
$$;

DO
$$
    DECLARE
        v_out_status TEXT;
    BEGIN
        CALL update_employee_status(5, v_out_status);
        RAISE NOTICE 'Trạng thái nhân viên: %', v_out_status;
    END
$$;

CALL update_employee_status(99, NULL);
-- Kết quả dự kiến: ERROR: Employee not found