-- Tạo bảng accounts theo hình ảnh
CREATE TABLE accounts
(
    account_id   SERIAL PRIMARY KEY,
    account_name VARCHAR(50),
    balance      NUMERIC
);

-- Thêm 2 bản ghi với số dư ban đầu
INSERT INTO accounts (account_name, balance)
VALUES ('Nguyen Van A', 1000.00),
       ('Tran Thi B', 500.00);

-- Kiểm tra dữ liệu ban đầu
SELECT *
FROM accounts;

BEGIN;

-- Bước 1: Trừ tiền tài khoản gửi (kèm điều kiện kiểm tra số dư ngay trong câu lệnh)
UPDATE accounts
SET balance = balance - 200.00
WHERE account_name = 'Nguyen Van A'
  AND balance >= 200.00;

-- Bước 2: Cộng tiền cho tài khoản nhận
UPDATE accounts
SET balance = balance + 200.00
WHERE account_name = 'Tran Thi B';

-- Bước 3: Xác nhận giao dịch
COMMIT;

-- Kết quả: A còn 800, B có 700
SELECT *
FROM accounts;

BEGIN;

-- Bước 1: Cố gắng trừ tiền (Lệnh này sẽ không thay đổi dòng nào vì 800 < 2000)
UPDATE accounts
SET balance = balance - 2000.00
WHERE account_name = 'Nguyen Van A'
  AND balance >= 2000.00;

-- Bước 2: Trong lập trình, chúng ta kiểm tra: "Nếu lệnh trên không cập nhật được dòng nào thì hủy"
-- Giả sử chúng ta phát hiện logic sai, ta gọi Rollback ngay:
ROLLBACK;

-- Kiểm tra: Số dư vẫn giữ nguyên (A: 800, B: 700)
SELECT *
FROM accounts;
