-- Tạo bảng accounts
CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,
                          owner_name VARCHAR(100),
                          balance NUMERIC(10,2)
);

-- Chèn dữ liệu mẫu
INSERT INTO accounts (owner_name, balance)
VALUES ('A', 500.00), ('B', 300.00);

-- Xem dữ liệu hiện tại
SELECT * FROM accounts;

-- Bắt đầu giao dịch
BEGIN;

-- Bước 1: Giảm số dư tài khoản A
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Bước 2: Tăng số dư tài khoản B
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'B';

-- Hoàn tất giao dịch
COMMIT;

-- Kiểm tra lại số dư
-- Kết quả kỳ vọng: A còn 400.00, B có 400.00
SELECT * FROM accounts;

-- Bắt đầu giao dịch mới
BEGIN;

-- Bước 1: Giảm số dư tài khoản A (400.00 - 100.00 = 300.00)
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Bước 2: Cập nhật sai ID người nhận (Giả sử ID 999 không tồn tại)
-- Trong thực tế, nếu câu lệnh này không cập nhật được dòng nào hoặc gặp lỗi ràng buộc,
-- ta cần phải hủy bỏ toàn bộ.
UPDATE accounts
SET balance = balance + 100.00
WHERE account_id = 999;

-- Phát hiện có lỗi hoặc không có dòng nào được cập nhật -> Hủy giao dịch
ROLLBACK;

-- KIỂM TRA LẠI:
-- Số dư của A vẫn phải là 400.00 (không bị trừ mất 100.00 ở Bước 1)
SELECT * FROM accounts;


