-- Tạo bảng Orders
CREATE TABLE Customer
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer (id),
    order_date  DATE,
    total_price NUMERIC(10, 2)
);

-- Chèn dữ liệu mẫu
INSERT INTO Customer (name)
VALUES ('Nguyen Van A'),
       ('Tran Thi B'),
       ('Le Van C'),
       ('Pham Minh D'); -- Khách hàng này chưa mua hàng

INSERT INTO Orders (customer_id, order_date, total_price)
VALUES (1, '2024-01-10', 5000),
       (1, '2024-02-15', 3000),  -- A tổng chi: 8000
       (2, '2024-03-05', 12000), -- B tổng chi: 12000 (Cao nhất)
       (3, '2024-03-20', 2000); -- C tổng chi: 2000

SELECT c.name             AS "Tên khách hàng",
       SUM(o.total_price) AS "Tổng chi tiêu"
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY "Tổng chi tiêu" DESC;

SELECT c.name
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_price) = (
    -- Subquery: Tìm giá trị tổng chi tiêu lớn nhất
    SELECT MAX(customer_sum)
    FROM (SELECT SUM(total_price) AS customer_sum
          FROM Orders
          GROUP BY customer_id) AS sub);

SELECT c.name
FROM Customer c
         LEFT JOIN Orders o ON c.id = o.customer_id
WHERE o.order_id IS NULL;

SELECT c.name,
       SUM(o.total_price) AS total_spent
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_price) > (
    -- Subquery: Tính mức chi tiêu trung bình dựa trên tổng chi của mỗi khách hàng
    SELECT AVG(total_per_person)
    FROM (SELECT SUM(total_price) AS total_per_person
          FROM Orders
          GROUP BY customer_id) AS average_table);


