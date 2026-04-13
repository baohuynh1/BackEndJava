-- 1. Tạo bảng khách hàng
CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(50),
    email       VARCHAR(50)
);

-- 2. Tạo bảng lưu nhật ký (log)
CREATE TABLE customer_log
(
    log_id        SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    action_time   TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_customer_insert()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO customer_log (customer_name, action_time)
    VALUES (NEW.name, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_customer_insert
    AFTER INSERT
    ON customers
    FOR EACH ROW
EXECUTE FUNCTION log_customer_insert();

-- Thêm bản ghi vào bảng customers
INSERT INTO customers (name, email)
VALUES ('Nguyen Van A', 'a@gmail.com');
INSERT INTO customers (name, email)
VALUES ('Tran Thi B', 'b@example.com');

-- Kiểm tra bảng customers
SELECT *
FROM customers;

-- Kiểm tra bảng customer_log (Kết quả sẽ tự động xuất hiện ở đây)
SELECT *
FROM customer_log;