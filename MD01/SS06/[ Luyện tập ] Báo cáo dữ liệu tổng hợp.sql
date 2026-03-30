CREATE TABLE OldCustomers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE NewCustomers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO OldCustomers (name, city)
VALUES ('Nguyen Van A', 'Ha Noi'),
       ('Tran Thi B', 'Da Nang'),
       ('Le Van C', 'Ho Chi Minh'),
       ('Pham Minh D', 'Ha Noi');

-- Chèn dữ liệu cho khách hàng mới (Có người trùng với bảng cũ)
INSERT INTO NewCustomers (name, city)
VALUES ('Tran Thi B', 'Da Nang'),   -- Trùng tên và thành phố
       ('Hoang Van E', 'Ha Noi'),
       ('Le Van C', 'Ho Chi Minh'), -- Trùng tên và thành phố
       ('Vu Thi F', 'Can Tho');

SELECT name, city FROM OldCustomers
UNION
SELECT name, city FROM NewCustomers;

SELECT name, city FROM OldCustomers
UNION
SELECT name, city FROM NewCustomers;

SELECT name, city FROM OldCustomers
INTERSECT
SELECT name, city FROM NewCustomers;

SELECT city, COUNT(*) AS customer_count
FROM (
         SELECT name, city FROM OldCustomers
         UNION ALL -- Dùng UNION ALL để lấy tất cả, kể cả trùng lặp để đếm chính xác
         SELECT name, city FROM NewCustomers
     ) AS all_customers
GROUP BY city;

SELECT city, COUNT(*) as total
FROM (
         SELECT name, city FROM OldCustomers
         UNION ALL
         SELECT name, city FROM NewCustomers
     ) AS combined
GROUP BY city
HAVING COUNT(*) = (
    -- Subquery: Tìm con số số lượng khách hàng lớn nhất
    SELECT MAX(city_count)
    FROM (
             SELECT COUNT(*) AS city_count
             FROM (
                      SELECT city FROM OldCustomers
                      UNION ALL
                      SELECT city FROM NewCustomers
                  ) AS temp
             GROUP BY city
         ) AS count_table
);

