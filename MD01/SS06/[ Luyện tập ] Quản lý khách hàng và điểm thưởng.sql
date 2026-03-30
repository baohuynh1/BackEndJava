-- Tạo bảng Customer
CREATE TABLE Customer
(
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(100),
    email          VARCHAR(100),
    loyalty_points INT
);

-- Thêm 7 khách hàng mới
INSERT INTO Customer (name, email, loyalty_points)
VALUES ('Nguyen Van An', 'an@gmail.com', 500),
       ('Tran Thi Binh', 'binh@gmail.com', 1200),
       ('Le Quoc Anh', 'anhle@gmail.com', 800),
       ('Nguyen Van An', 'an.new@gmail.com', 300), -- Trùng tên để test DISTINCT
       ('Pham Minh Duc', NULL, 150),               -- Không có email
       ('Hoang Bao Ngoc', 'ngoc@gmail.com', 2000), -- Cao điểm nhất (sẽ bị OFFSET bỏ qua)
       ('Dang Quang Minh', 'minh@gmail.com', 950);

SELECT DISTINCT name
FROM Customer;

SELECT * FROM Customer
WHERE email IS NULL;

SELECT * FROM Customer
ORDER BY loyalty_points DESC
LIMIT 3 OFFSET 1;

SELECT * FROM Customer
ORDER BY name DESC;