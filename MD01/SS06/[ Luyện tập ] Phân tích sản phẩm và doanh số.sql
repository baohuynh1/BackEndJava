-- Tạo bảng Product
CREATE TABLE Product
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100),
    category VARCHAR(50),
    price    NUMERIC(10, 2)
);

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetail
(
    id         SERIAL PRIMARY KEY,
    order_id   INT,
    product_id INT REFERENCES Product (id),
    quantity   INT
);

-- Chèn dữ liệu sản phẩm
INSERT INTO Product (name, category, price)
VALUES ('iPhone 15 Pro', 'Electronics', 30000000),
       ('Samsung S24', 'Electronics', 25000000),
       ('Bàn làm việc', 'Furniture', 5000000),
       ('Ghế Gaming', 'Furniture', 4000000),
       ('Macbook M3', 'Electronics', 45000000),
       ('Tủ sách', 'Furniture', 2000000);
-- Sản phẩm chưa có đơn hàng

-- Chèn dữ liệu đơn hàng
INSERT INTO OrderDetail (order_id, product_id, quantity)
VALUES (101, 1, 2), -- iPhone: 60tr
       (102, 2, 1), -- Samsung: 25tr
       (103, 3, 5), -- Bàn: 25tr
       (104, 4, 3), -- Ghế: 12tr
       (105, 5, 1); -- Macbook: 45tr

SELECT
    p.name AS product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.id, p.name;

SELECT
    p.category,
    AVG(p.price * od.quantity) AS avg_category_revenue
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category
HAVING AVG(p.price * od.quantity) > 20000000;

SELECT
    p.name,
    SUM(p.price * od.quantity) AS product_revenue
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.id, p.name
HAVING SUM(p.price * od.quantity) > (
    -- Subquery: Doanh thu trung bình toàn bộ các dòng đơn hàng
    SELECT AVG(p2.price * od2.quantity)
    FROM Product p2
             JOIN OrderDetail od2 ON p2.id = od2.product_id
);

SELECT
    p.name,
    COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
FROM Product p
         LEFT JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.id, p.name
ORDER BY total_quantity_sold DESC;


