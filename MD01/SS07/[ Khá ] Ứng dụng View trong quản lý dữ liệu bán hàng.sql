CREATE TABLE customer
(
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100),
    phone       VARCHAR(15)
);

CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES customer (customer_id),
    total_amount DECIMAL(10, 2),
    order_date   DATE
);

-- Tạo View
CREATE VIEW v_order_summary AS
SELECT
    c.full_name,
    o.total_amount,
    o.order_date
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id;

-- Truy vấn dữ liệu từ View
SELECT * FROM v_order_summary;

-- Tạo View cho đơn hàng lớn
CREATE VIEW v_high_value_orders AS
SELECT * FROM orders
WHERE total_amount >= 1000000;

-- Cập nhật 1 bản ghi thông qua View
-- Lưu ý: Trong PostgreSQL, View có thể cập nhật (Updatable View) nếu nó chỉ truy vấn từ 1 bảng duy nhất và không chứa hàm gộp (Aggregate functions).
UPDATE v_high_value_orders
SET total_amount = 1200000
WHERE order_id = 1;

CREATE VIEW v_monthly_sales AS
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month DESC;

DROP VIEW v_order_summary;


