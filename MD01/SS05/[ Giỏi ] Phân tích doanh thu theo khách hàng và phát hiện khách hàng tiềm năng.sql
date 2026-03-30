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
c.customer_name,
SUM(o.total_amount) AS total_revenue,
COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > 2000;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > (
    -- Subquery: Tính doanh thu trung bình trên mỗi khách hàng
    SELECT AVG(customer_total)
    FROM (
             SELECT SUM(total_amount) AS customer_total
             FROM orders
             GROUP BY customer_id
         ) AS sub
);

SELECT
    c.city,
    SUM(o.total_amount) AS city_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY city_revenue DESC
LIMIT 1;

SELECT
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_items_bought,
    SUM(o.total_amount) AS total_spending
FROM customers c
         INNER JOIN orders o ON c.customer_id = o.customer_id
         INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;

