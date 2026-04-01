CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100) UNIQUE,
    city        VARCHAR(50)
);

-- 2. Bảng Sản phẩm
CREATE TABLE products
(
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category     TEXT[],
    price        NUMERIC(10, 2)
);

-- 3. Bảng Đơn hàng
CREATE TABLE orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers (customer_id),
    product_id  INT REFERENCES products (product_id),
    order_date  DATE,
    quantity    INT
);

-- Thêm 5 khách hàng
INSERT INTO customers (full_name, email, city)
VALUES ('Nguyen Van A', 'a@gmail.com', 'Ha Noi'),
       ('Tran Thi B', 'b@yahoo.com', 'TP HCM'),
       ('Le Van C', 'c@outlook.com', 'Da Nang'),
       ('Pham Thi D', 'd@gmail.com', 'Ha Noi'),
       ('Hoang Van E', 'e@company.com', 'Can Tho');

-- Thêm 5 sản phẩm (Lưu ý: category là kiểu mảng TEXT[])
INSERT INTO products (product_name, category, price)
VALUES ('Laptop Dell', ARRAY ['Electronics', 'Work'], 1500.00),
       ('iPhone 15', ARRAY ['Electronics', 'Mobile'], 1200.00),
       ('Ban phim co', ARRAY ['Electronics', 'Accessories'], 150.00),
       ('Sach SQL', ARRAY ['Education', 'Books'], 25.00),
       ('Chuot khong day', ARRAY ['Electronics', 'Accessories'], 50.00);

-- Thêm 10 đơn hàng
INSERT INTO orders (customer_id, product_id, order_date, quantity)
VALUES (1, 1, '2024-03-01', 1),
       (1, 3, '2024-03-05', 2),
       (2, 2, '2024-03-10', 1),
       (2, 5, '2024-03-12', 3),
       (3, 4, '2024-03-15', 5),
       (3, 1, '2024-03-18', 1),
       (4, 2, '2024-03-20', 1),
       (4, 3, '2024-03-22', 1),
       (5, 5, '2024-03-25', 10),
       (5, 4, '2024-03-28', 2);

-- B-tree cho email (Mặc định, tốt nhất cho tìm kiếm chính xác)
CREATE INDEX idx_customers_email ON customers(email);

-- Hash Index cho city (Chỉ hỗ trợ so sánh bằng '=', nhanh hơn B-tree cho kiểu chuỗi cố định)
CREATE INDEX idx_customers_city_hash ON customers USING HASH (city);

-- GIN Index cho mảng category (Hỗ trợ toán tử chứa @>)
CREATE INDEX idx_products_category_gin ON products USING GIN (category);

-- GiST Index cho khoảng giá (Cần cài đặt btree_gist extension để dùng GiST cho kiểu số)
CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE INDEX idx_products_price_gist ON products USING GIST (price);

EXPLAIN ANALYZE SELECT * FROM customers WHERE email = 'a@gmail.com';

EXPLAIN ANALYZE SELECT * FROM products WHERE category @> ARRAY['Electronics'];

EXPLAIN ANALYZE SELECT * FROM products WHERE price <@ numrange(500, 1000);

-- Bước 1: Tạo Index trước
CREATE INDEX idx_orders_date ON orders(order_date);

-- Bước 2: Thực hiện Cluster
CLUSTER orders USING idx_orders_date;

-- Top 3 khách hàng mua nhiều nhất (theo số lượng đơn hàng)
CREATE VIEW v_top_customers AS
SELECT c.full_name, COUNT(o.order_id) as total_orders
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY total_orders DESC
LIMIT 3;

-- Tổng doanh thu theo từng sản phẩm
CREATE VIEW v_product_revenue AS
SELECT p.product_name, SUM(p.price * o.quantity) as total_revenue
FROM products p
         JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Tạo View cho phép chỉnh sửa city
CREATE VIEW v_customer_city AS
SELECT customer_id, full_name, city
FROM customers;

-- Thực hiện cập nhật qua View
UPDATE v_customer_city
SET city = 'Da Nang'
WHERE full_name = 'Nguyen Van A';

-- Cập nhật dữ liệu thông qua View
UPDATE v_customer_city
SET city = 'Hai Phong'
WHERE full_name = 'Nguyen Van A';

-- Kiểm tra bảng gốc
SELECT * FROM customers WHERE full_name = 'Nguyen Van A';