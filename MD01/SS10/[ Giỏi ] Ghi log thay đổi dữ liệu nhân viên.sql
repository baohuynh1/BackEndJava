-- Bảng nhân viên chính
CREATE TABLE employees
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    salary   DECIMAL(15, 2)
);

-- Bảng lưu vết lịch sử
CREATE TABLE employees_log
(
    log_id      SERIAL PRIMARY KEY,
    employee_id INTEGER,
    operation   VARCHAR(10),
    old_data    JSONB,
    new_data    JSONB,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE OR REPLACE FUNCTION log_employee_changes()
    RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO employees_log (employee_id, operation, new_data)
        VALUES (NEW.id, 'INSERT', to_jsonb(NEW));
        RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO employees_log (employee_id, operation, old_data, new_data)
        VALUES (NEW.id, 'UPDATE', to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;

    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO employees_log (employee_id, operation, old_data)
        VALUES (OLD.id, 'DELETE', to_jsonb(OLD));
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_employee_audit
    AFTER INSERT OR UPDATE OR DELETE
    ON employees
    FOR EACH ROW
EXECUTE FUNCTION log_employee_changes();

INSERT INTO employees (name, position, salary)
VALUES ('Trần Văn B', 'Developer', 2000.00);

-- Kiểm tra log
SELECT *
FROM employees_log;

UPDATE employees
SET salary   = 2500.00,
    position = 'Senior Developer'
WHERE name = 'Trần Văn B';

-- Kiểm tra log
SELECT *
FROM employees_log
WHERE operation = 'UPDATE';

DELETE
FROM employees
WHERE id = 1;

-- Kiểm tra log
SELECT *
FROM employees_log
WHERE operation = 'DELETE';