-- Tạo bảng products
CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(50)    NOT NULL,
    price      NUMERIC(10, 2) NOT NULL,
    stock      INT            NOT NULL
);

-- Tạo bảng orders
CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    product_id   INT REFERENCES products (product_id),
    quantity     INT NOT NULL,
    total_amount NUMERIC(10, 2)
);

-- Tạo bảng order_log
CREATE TABLE order_log
(
    log_id      SERIAL PRIMARY KEY,
    order_id    INT,
    action_time TIMESTAMP DEFAULT NOW()
);

-- Chèn dữ liệu mẫu (Sản phẩm ID 1 có 5 cái)
INSERT INTO products (name, price, stock)
VALUES ('Laptop Gaming', 2000.00, 5);

BEGIN;

-- Bước 1: Giảm tồn kho (Chỉ giảm nếu stock >= quantity)
UPDATE products
SET stock = stock - 2
WHERE product_id = 1
  AND stock >= 2;

-- Bước 2: Thêm đơn hàng vào bảng orders
-- (Lấy giá từ bảng products để tính total_amount)
INSERT INTO orders (product_id, quantity, total_amount)
SELECT 1, 2, price * 2
FROM products
WHERE product_id = 1;

-- Bước 3: Ghi log vào order_log
INSERT INTO order_log (order_id)
VALUES (currval('orders_order_id_seq'));

COMMIT;

-- Kiểm tra kết quả
SELECT *
FROM products; -- stock giảm còn 3
SELECT *
FROM orders; -- 1 đơn hàng mới
SELECT *
FROM order_log; -- 1 dòng nhật ký

BEGIN;

-- Bước 1: Cố gắng giảm tồn kho
-- Lệnh này sẽ không tác động đến dòng nào (Rows affected: 0) vì stock hiện tại là 3 < 10
UPDATE products
SET stock = stock - 10
WHERE product_id = 1
  AND stock >= 10;

-- Trong thực tế, nếu ứng dụng kiểm tra thấy lệnh UPDATE trên không thực hiện được
-- Chúng ta sẽ thực hiện ROLLBACK ngay lập tức để tránh sai sót ở các bước sau.
ROLLBACK;

-- KIỂM TRA LẠI:
-- Tồn kho vẫn là 3, không có đơn hàng nào được tạo, không có log nào được ghi.
SELECT *
FROM products
WHERE product_id = 1;