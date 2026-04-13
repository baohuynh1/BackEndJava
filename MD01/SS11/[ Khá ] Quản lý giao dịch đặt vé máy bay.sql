-- Tạo bảng flights (chuyến bay)
CREATE TABLE flights
(
    flight_id       SERIAL PRIMARY KEY,
    flight_name     VARCHAR(100),
    available_seats INT
);

-- Tạo bảng bookings (đặt chỗ)
CREATE TABLE bookings
(
    booking_id    SERIAL PRIMARY KEY,
    flight_id     INT REFERENCES flights (flight_id),
    customer_name VARCHAR(100)
);

-- Chèn dữ liệu mẫu vào bảng flights
INSERT INTO flights (flight_name, available_seats)
VALUES ('VN123', 3),
       ('VN456', 2);

BEGIN;

-- 1. Giảm số ghế của VN123 đi 1
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- 2. Thêm thông tin đặt vé (Sử dụng subquery để lấy đúng flight_id của VN123)
INSERT INTO bookings (flight_id, customer_name)
VALUES ((SELECT flight_id FROM flights WHERE flight_name = 'VN123'), 'Nguyen Van A');

COMMIT;

-- Kiểm tra kết quả
SELECT * FROM flights;   -- VN123 sẽ còn 2 ghế
SELECT * FROM bookings;  -- Xuất hiện 1 dòng của Nguyen Van A

BEGIN;

-- 1. Giảm số ghế của VN123 đi 1 (Từ 2 ghế xuống còn 1 ghế)
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- 2. Thử thêm vé với flight_id không tồn tại (Gây lỗi Foreign Key)
-- Lệnh này sẽ báo lỗi: insert or update on table "bookings" violates foreign key constraint...
INSERT INTO bookings (flight_id, customer_name)
VALUES (999, 'Khách Hàng Lỗi');

-- 3. Vì lệnh trên lỗi, ta thực hiện ROLLBACK để khôi phục trạng thái
ROLLBACK;

-- KIỂM TRA LẠI:
-- Số ghế của VN123 vẫn sẽ là 2 (không bị trừ mất 1 ghế vô lý)
SELECT * FROM flights WHERE flight_name = 'VN123';
-- Bảng bookings không có thêm dòng mới nào
SELECT * FROM bookings;

