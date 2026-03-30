-- Tạo bảng Product
CREATE TABLE Product
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100),
    category VARCHAR(50),
    price    NUMERIC(10, 2),
    stock    INT
);

-- Thêm 5 sản phẩm mới
INSERT INTO Product (name, category, price, stock)
VALUES ('iPhone 15', 'Điện tử', 22000000, 50),
       ('Chuột không dây', 'Điện tử', 500000, 150),
       ('Bàn làm việc', 'Nội thất', 2500000, 20),
       ('Tai nghe Sony', 'Điện tử', 8000000, 35),
       ('Loa Bluetooth', 'Điện tử', 1500000, 10);

SELECT * FROM Product;

SELECT * FROM Product
ORDER BY price DESC
LIMIT 3;

SELECT * FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;

SELECT * FROM Product
ORDER BY stock ASC;
