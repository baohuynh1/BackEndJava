-- Tạo bảng khách hàng
CREATE TABLE customers
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(255)   NOT NULL,
    credit_limit DECIMAL(12, 2) NOT NULL
);

-- Tạo bảng đơn hàng
CREATE TABLE orders
(
    id           SERIAL PRIMARY KEY,
    customer_id  INTEGER REFERENCES customers (id),
    order_amount DECIMAL(12, 2) NOT NULL
);

CREATE OR REPLACE FUNCTION check_credit_limit()
    RETURNS TRIGGER AS
$$
DECLARE
    current_total_spent DECIMAL(12, 2);
    allowed_limit       DECIMAL(12, 2);
BEGIN
    -- 1. Lấy hạn mức tín dụng của khách hàng
    SELECT credit_limit
    INTO allowed_limit
    FROM customers
    WHERE id = NEW.customer_id;

    -- 2. Tính tổng tiền các đơn hàng đã có
    SELECT COALESCE(SUM(order_amount), 0)
    INTO current_total_spent
    FROM orders
    WHERE customer_id = NEW.customer_id;

    -- 3. Kiểm tra xem đơn hàng mới có làm vượt hạn mức không
    IF (current_total_spent + NEW.order_amount) > allowed_limit THEN
        RAISE EXCEPTION 'Vượt hạn mức tín dụng! Hạn mức: %, Đã dùng: %, Đơn mới: %',
            allowed_limit, current_total_spent, NEW.order_amount;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_credit
    BEFORE INSERT
    ON orders
    FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

INSERT INTO customers (name, credit_limit)
VALUES ('Nguyễn Văn A', 10000000); -- 10 triệu

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 4000000);

-- Kiểm tra: Thành công
SELECT *
FROM orders;

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 7000000);

SELECT *
FROM orders;
-- Bạn sẽ thấy chỉ có đơn hàng 4 triệu ban đầu tồn tại.