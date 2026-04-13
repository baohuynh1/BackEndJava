-- Tạo bảng sản phẩm
CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(50),
    price      NUMERIC(10, 2)
);

-- Tạo bảng đơn hàng (như trong hình bạn gửi)
CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    product_id   INT REFERENCES products (product_id),
    quantity     INT,
    total_amount NUMERIC
);

-- Chèn dữ liệu mẫu cho sản phẩm
INSERT INTO products (name, price)
VALUES ('Chuột không dây', 200.00),
       ('Bàn phím cơ', 1500.00);

CREATE OR REPLACE FUNCTION calculate_total_amount()
    RETURNS TRIGGER AS
$$
DECLARE
    unit_price NUMERIC;
BEGIN
    -- Lấy đơn giá từ bảng products dựa trên product_id đang chèn
    SELECT price
    INTO unit_price
    FROM products
    WHERE product_id = NEW.product_id;

    -- Tính tổng tiền = đơn giá * số lượng
    NEW.total_amount := unit_price * NEW.quantity;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auto_total_amount
    BEFORE INSERT
    ON orders
    FOR EACH ROW
EXECUTE FUNCTION calculate_total_amount();

-- Thêm đơn hàng: Mua 3 con chuột (ID 1, giá 200)
INSERT INTO orders (product_id, quantity)
VALUES (1, 3);

-- Thêm đơn hàng: Mua 2 bàn phím (ID 2, giá 1500)
INSERT INTO orders (product_id, quantity)
VALUES (2, 2);

-- Kiểm tra kết quả
SELECT o.order_id, p.name, o.quantity, p.price, o.total_amount
FROM orders o
         JOIN products p ON o.product_id = p.product_id;