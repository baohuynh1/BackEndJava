-- 1. Tạo bảng khách hàng
CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(100),
    balance     NUMERIC(12, 2)
);

-- 2. Tạo bảng sản phẩm
CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(100),
    stock      INT,
    price      NUMERIC(10, 2)
);

-- 3. Tạo bảng đơn hàng
CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES customers (customer_id),
    total_amount NUMERIC(12, 2),
    created_at   TIMESTAMP   DEFAULT NOW(),
    status       VARCHAR(20) DEFAULT 'PENDING'
);

-- 4. Tạo bảng chi tiết đơn hàng
CREATE TABLE order_items
(
    item_id    SERIAL PRIMARY KEY,
    order_id   INT REFERENCES orders (order_id),
    product_id INT REFERENCES products (product_id),
    quantity   INT,
    subtotal   NUMERIC(10, 2)
);

-- Chèn dữ liệu mẫu
INSERT INTO customers (name, balance)
VALUES ('Tran Thi B', 5000.00);
INSERT INTO products (name, stock, price)
VALUES ('iPhone 15', 10, 1000.00), -- ID 1
       ('Case', 50, 20.00),        -- ID 2
       ('AirPods', 5, 200.00); -- ID 3

BEGIN;

-- Bước 1: Tạo đơn hàng mới ở trạng thái 'PENDING'
INSERT INTO orders (customer_id, total_amount, status)
VALUES (1, 1400.00, 'PENDING');

-- Bước 2: Thêm chi tiết sản phẩm 1 & Giảm kho
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (currval('orders_order_id_seq'), 1, 1, 1000.00);

UPDATE products
SET stock = stock - 1
WHERE product_id = 1
  AND stock >= 1;

-- Bước 3: Thêm chi tiết sản phẩm 3 & Giảm kho
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (currval('orders_order_id_seq'), 3, 2, 400.00);

UPDATE products
SET stock = stock - 2
WHERE product_id = 3
  AND stock >= 2;

-- Bước 4: Trừ tiền khách hàng (Chỉ trừ nếu số dư >= 1400)
UPDATE customers
SET balance = balance - 1400.00
WHERE customer_id = 1
  AND balance >= 1400.00;

-- Bước 5: Nếu mọi thứ ổn, cập nhật trạng thái đơn hàng và xác nhận
UPDATE orders
SET status = 'COMPLETED'
WHERE order_id = currval('orders_order_id_seq');

COMMIT;

-- Kiểm tra kết quả
SELECT *
FROM customers;
SELECT *
FROM products;
SELECT *
FROM orders;

-- Giả sử AirPods hết hàng
UPDATE products
SET stock = 0
WHERE product_id = 3;

BEGIN;

-- Cố gắng thực hiện quy trình như trên
INSERT INTO orders (customer_id, total_amount)
VALUES (1, 1400.00);

-- Trừ kho sản phẩm 1 (Thành công)
UPDATE products
SET stock = stock - 1
WHERE product_id = 1
  AND stock >= 1;

-- Trừ kho sản phẩm 3 (THẤT BẠI vì stock = 0)
-- Trong logic lập trình, bạn sẽ kiểm tra số dòng bị ảnh hưởng (row count)
-- Nếu row count = 0, tức là không đủ hàng -> thực hiện ROLLBACK ngay lập tức.

ROLLBACK;


