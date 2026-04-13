-- Tạo bảng sản phẩm
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          product_name VARCHAR(100),
                          stock INT,
                          price NUMERIC(10,2)
);

-- Tạo bảng đơn hàng
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_name VARCHAR(100),
                        total_amount NUMERIC(10,2),
                        created_at TIMESTAMP DEFAULT NOW()
);

-- Tạo bảng chi tiết đơn hàng
CREATE TABLE order_items (
                             order_item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_id INT REFERENCES products(product_id),
                             quantity INT,
                             subtotal NUMERIC(10,2)
);

-- Chèn dữ liệu mẫu
INSERT INTO products (product_name, stock, price)
VALUES ('Laptop', 10, 1500.00), ('Mouse', 5, 25.00);

BEGIN;

-- 1. Tạo đơn hàng mới và lấy order_id vừa tạo
INSERT INTO orders (customer_name, total_amount)
VALUES ('Nguyen Van A', 3025.00);

-- 2. Thêm chi tiết cho Laptop (ID 1)
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (currval('orders_order_id_seq'), 1, 2, 3000.00);

-- 3. Cập nhật tồn kho Laptop
UPDATE products SET stock = stock - 2 WHERE product_id = 1;

-- 4. Thêm chi tiết cho Mouse (ID 2)
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (currval('orders_order_id_seq'), 2, 1, 25.00);

-- 5. Cập nhật tồn kho Mouse
UPDATE products SET stock = stock - 1 WHERE product_id = 2;

COMMIT;

-- Kiểm tra kết quả
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

-- Chuẩn bị: Cho Mouse hết hàng
UPDATE products SET stock = 0 WHERE product_id = 2;

BEGIN;

-- Giả sử chúng ta có câu lệnh kiểm tra tồn kho trước khi Update
-- Nếu (stock < quantity) thì ROLLBACK;

-- Bước 1: Trừ kho Laptop (Vẫn thành công vì còn hàng)
UPDATE products SET stock = stock - 2 WHERE product_id = 1 AND stock >= 2;

-- Bước 2: Trừ kho Mouse (Sẽ thất bại hoặc không có dòng nào bị ảnh hưởng vì stock = 0)
UPDATE products SET stock = stock - 1 WHERE product_id = 2 AND stock >= 1;

-- Ở đây chúng ta kiểm tra: nếu bước trên không thành công (số dòng update = 0), ta gọi Rollback
ROLLBACK;

