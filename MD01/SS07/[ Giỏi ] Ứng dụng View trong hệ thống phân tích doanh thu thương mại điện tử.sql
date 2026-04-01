-- Bảng Khách hàng
CREATE TABLE customer
(
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100),
    region      VARCHAR(50)
);

-- Bảng Đơn hàng
CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES customer (customer_id),
    total_amount DECIMAL(10, 2),
    order_date   DATE,
    status       VARCHAR(20)
);

-- Bảng Sản phẩm
CREATE TABLE product
(
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(100),
    price      DECIMAL(10, 2),
    category   VARCHAR(50)
);

-- Bảng Chi tiết đơn hàng (Bảng trung gian N-N)
CREATE TABLE order_detail
(
    order_id   INT REFERENCES orders (order_id),
    product_id INT REFERENCES product (product_id),
    quantity   INT
);

CREATE VIEW v_revenue_by_region AS
SELECT c.region,
       SUM(o.total_amount) AS total_revenue
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

SELECT * FROM v_revenue_by_region ORDER BY total_revenue DESC;

SELECT * FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;

CREATE VIEW v_revenue_above_avg AS
SELECT * FROM v_revenue_by_region
WHERE total_revenue > (SELECT AVG(total_revenue) FROM v_revenue_by_region);

SELECT * FROM v_revenue_above_avg;