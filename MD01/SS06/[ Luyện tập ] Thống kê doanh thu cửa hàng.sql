-- Tạo bảng Orders (nếu bạn chưa tạo)
CREATE TABLE Orders
(
    id           SERIAL PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);

-- Chèn dữ liệu mẫu
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES (1, '2023-05-10', 15000000),
       (2, '2023-08-20', 40000000), -- Tổng 2023: 55tr (>50tr)
       (1, '2024-01-15', 10000000),
       (3, '2024-03-12', 5000000),  -- Tổng 2024: 15tr (<50tr)
       (4, '2025-02-01', 60000000), -- Tổng 2025: 110tr (>50tr)
       (2, '2025-05-20', 50000000),
       (5, '2025-12-25', 2000000),
       (3, '2025-06-15', 12000000),
       (1, '2024-11-11', 8000000);

SELECT SUM(total_amount) AS total_revenue,
       COUNT(id)         AS total_orders,
       AVG(total_amount) AS average_order_value
FROM Orders;

SELECT EXTRACT(YEAR FROM order_date) AS order_year,
       SUM(total_amount)             AS yearly_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year;

SELECT EXTRACT(YEAR FROM order_date) AS order_year,
       SUM(total_amount)             AS yearly_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
HAVING SUM(total_amount) > 50000000;

SELECT *
FROM Orders
ORDER BY total_amount DESC
LIMIT 5;
