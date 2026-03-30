CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50)
);

-- Tạo bảng đơn hàng
CREATE TABLE orders (
order_id INT PRIMARY KEY,
product_id INT REFERENCES products(product_id),
quantity INT,
total_price NUMERIC(10, 2)
);

-- Chèn dữ liệu vào bảng products
INSERT INTO products VALUES
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Bàn học gỗ', 'Furniture'),
(4, 'Ghế xoay', 'Furniture');

-- Chèn dữ liệu vào bảng orders
INSERT INTO orders VALUES
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

SELECT
p.category,
SUM(o.total_price) AS total_sales,
SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;