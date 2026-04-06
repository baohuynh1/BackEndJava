CREATE TABLE employees
(
    emp_id    SERIAL PRIMARY KEY,
    emp_name  VARCHAR(100),
    job_level INT,
    salary    NUMERIC
);

-- Thêm dữ liệu mẫu để chạy thử
INSERT INTO employees (emp_name, job_level, salary)
VALUES ('Nguyen Van A', 1, 1000),
       ('Tran Thi B', 2, 2000),
       ('Le Van C', 3, 3000);

CREATE OR REPLACE PROCEDURE adjust_salary(
    p_emp_id INT,
    OUT p_new_salary NUMERIC
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    -- Cập nhật lương dựa trên job_level và trả về lương mới ngay lập tức
    UPDATE employees
    SET salary = CASE
                     WHEN job_level = 1 THEN salary * 1.05
                     WHEN job_level = 2 THEN salary * 1.10
                     WHEN job_level = 3 THEN salary * 1.15
                     ELSE salary -- Không đổi nếu level không khớp
        END
    WHERE emp_id = p_emp_id
    RETURNING salary INTO p_new_salary;

    -- Kiểm tra nếu không tìm thấy emp_id
    IF p_new_salary IS NULL THEN
        RAISE NOTICE 'Không tìm thấy nhân viên có ID %', p_emp_id;
    END IF;
END;
$$;

DO
$$
    DECLARE
        p_new_salary NUMERIC;
    BEGIN
        -- Gọi procedure cho nhân viên có ID = 3
        CALL adjust_salary(3, p_new_salary);

        -- Hiển thị kết quả lương mới
        RAISE NOTICE 'Lương mới sau khi cập nhật là: %', p_new_salary;
    END
$$;