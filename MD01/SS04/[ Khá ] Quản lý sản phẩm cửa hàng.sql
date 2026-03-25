CREATE TABLE san_pham (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
category VARCHAR(50),
price DECIMAL(10,2),
stock INT
);

INSERT INTO san_pham (name, category, price, stock) VALUES
('Laptop Dell', 'Electronics', 1500.00, 5),
('Chuột Logitech', 'Electronics', 25.50, 50),
('Bàn phím Razer', 'Electronics', 120.00, 20),
('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
('Máy giặt Samsung', 'Home Appliances', 600.00, 2);

INSERT INTO san_pham (name, category, price, stock)
VALUES ('Điều hòa Panasonic', 'Home Appliances', 400.00, 10);

UPDATE san_pham
SET stock = 7
WHERE name = 'Laptop Dell';

DELETE FROM san_pham
WHERE stock = 0;

SELECT * FROM san_pham
ORDER BY price ASC;

SELECT DISTINCT category
FROM san_pham;

SELECT * FROM san_pham
WHERE price BETWEEN 100 AND 1000;


SELECT * FROM san_pham
WHERE name ILIKE '%LG%' OR name ILIKE '%Samsung%';

SELECT * FROM san_pham
ORDER BY price DESC
LIMIT 2;

SELECT * FROM san_pham
ORDER BY id ASC
LIMIT 2 OFFSET 1;
