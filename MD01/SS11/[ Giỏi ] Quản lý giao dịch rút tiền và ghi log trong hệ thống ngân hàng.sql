-- Tạo bảng accounts
CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,
                          customer_name VARCHAR(100),
                          balance NUMERIC(12,2)
);

-- Tạo bảng transactions để ghi log
CREATE TABLE transactions (
                              trans_id SERIAL PRIMARY KEY,
                              account_id INT REFERENCES accounts(account_id),
                              amount NUMERIC(12,2),
                              trans_type VARCHAR(20), -- 'WITHDRAW' hoặc 'DEPOSIT'
                              created_at TIMESTAMP DEFAULT NOW()
);

-- Chèn dữ liệu mẫu cho khách hàng "Nguyen Van A" với 1000$
INSERT INTO accounts (customer_name, balance)
VALUES ('Nguyen Van A', 1000.00);

BEGIN;

-- 1. Trừ số dư trong bảng accounts (kèm điều kiện kiểm tra số dư > 200)
UPDATE accounts
SET balance = balance - 200.00
WHERE customer_name = 'Nguyen Van A' AND balance >= 200.00;

-- 2. Ghi log vào bảng transactions
INSERT INTO transactions (account_id, amount, trans_type)
VALUES ((SELECT account_id FROM accounts WHERE customer_name = 'Nguyen Van A'), 200.00, 'WITHDRAW');

COMMIT;

-- Kiểm tra kết quả
SELECT * FROM accounts;      -- Số dư sẽ là 800.00
SELECT * FROM transactions;  -- Xuất hiện 1 dòng log rút 200.00

BEGIN;

-- 1. Trừ số dư (800 - 100 = 700)
UPDATE accounts
SET balance = balance - 100.00
WHERE customer_name = 'Nguyen Van A';

-- 2. Cố tình gây lỗi khóa ngoại (Foreign Key) do ID 999 không tồn tại
-- Lệnh này sẽ văng lỗi ERROR: insert or update on table "transactions" violates foreign key constraint
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (999, 100.00, 'WITHDRAW');

-- 3. Vì bước trên lỗi, ta thực hiện ROLLBACK
ROLLBACK;

-- CHỨNG MINH: Số dư của Nguyen Van A vẫn phải là 800.00, không bị trừ mất 100.00
SELECT * FROM accounts WHERE customer_name = 'Nguyen Van A';
-- Bảng transactions không có thêm log mới nào
SELECT * FROM transactions;

-- Tổng số dư ban đầu (1000) trừ đi tổng các giao dịch WITHDRAW
-- phải bằng số dư hiện tại trong bảng accounts.
SELECT
    a.customer_name,
    a.balance AS balance_in_table,
    (1000.00 - SUM(t.amount)) AS calculated_balance
FROM accounts a
         JOIN transactions t ON a.account_id = t.account_id
WHERE t.trans_type = 'WITHDRAW'
GROUP BY a.customer_name, a.balance;

