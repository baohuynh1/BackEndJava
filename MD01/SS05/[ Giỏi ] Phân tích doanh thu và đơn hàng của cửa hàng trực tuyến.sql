CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50)
);

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(customer_id),
order_date DATE,
total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
item_id SERIAL PRIMARY KEY,
order_id INT REFERENCES orders(order_id),
product_name VARCHAR(100),
quantity INT,
price NUMERIC(10,2)
);

INSERT INTO customers (customer_name, city) VALUES
('Nguyen Van A', 'Ha Noi'),
('Tran Thi B', 'Ho Chi Minh'),
('Le Van C', 'Ha Noi'),
('Pham Minh D', 'Da Nang');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-10-01', 5000),
(1, '2023-10-05', 6000), -- Tổng Ha Noi của A là 11000
(2, '2023-10-02', 2000),
(3, '2023-10-03', 1500),
(4, '2023-10-04', 12000); -- Da Nang > 10000

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop', 1, 5000),
(2, 'iPhone', 1, 6000),
(3, 'Mouse', 2, 1000),
(4, 'Keyboard', 1, 1500),
(5, 'Monitor', 2, 6000);

SELECT
c.customer_name AS "Tên khách",
o.order_date AS "Ngày đặt hàng",
o.total_amount AS "Tổng tiền"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT
SUM(total_amount) AS "Tổng doanh thu",
AVG(total_amount) AS "Giá trị trung bình",
MAX(total_amount) AS "Đơn hàng lớn nhất",
MIN(total_amount) AS "Đơn hàng nhỏ nhất",
COUNT(order_id) AS "Số lượng đơn hàng"
FROM orders;

SELECT
c.city,
SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

SELECT
c.customer_name,
o.order_date,
oi.product_name,
oi.quantity,
oi.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id;

SELECT customer_name
FROM customers
WHERE customer_id = (
SELECT customer_id
FROM orders
GROUP BY customer_id
ORDER BY SUM(total_amount) DESC
LIMIT 1
);