-- Tạo bảng Customers
CREATE TABLE Customers
(
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE
);

-- Tạo bảng Orders
CREATE TABLE Orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers (customer_id),
    amount      NUMERIC(12, 2) NOT NULL,
    order_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Chèn dữ liệu mẫu
INSERT INTO Customers (name, email)
VALUES ('Nguyễn Văn A', 'vanya@example.com'),
       ('Trần Thị B', 'thib@example.com');

CREATE OR REPLACE PROCEDURE add_order(
    p_customer_id INT,
    p_amount NUMERIC
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_customer_exists BOOLEAN;
BEGIN
    -- 1. Kiểm tra xem customer_id có tồn tại trong bảng Customers không
    SELECT EXISTS(SELECT 1 FROM Customers WHERE customer_id = p_customer_id)
    INTO v_customer_exists;

    -- 2. Nếu không tồn tại, ném lỗi và dừng thực thi
    IF NOT v_customer_exists THEN
        RAISE EXCEPTION 'Lỗi: Khách hàng với ID % không tồn tại. Không thể thêm đơn hàng.', p_customer_id;
    END IF;

    -- 3. Nếu khách hàng tồn tại, thực hiện thêm đơn hàng mới
    INSERT INTO Orders (customer_id, amount)
    VALUES (p_customer_id, p_amount);

    RAISE NOTICE 'Thành công: Đã thêm đơn hàng trị giá % cho khách hàng ID %', p_amount, p_customer_id;

EXCEPTION
    WHEN OTHERS THEN
        -- Báo lỗi nếu có bất kỳ vấn đề nào khác phát sinh
        RAISE EXCEPTION 'Giao dịch thất bại: %', SQLERRM;
END;
$$;

CALL add_order(1, 1500000);
-- Kết quả: Đơn hàng sẽ được thêm thành công vào bảng Orders.

CALL add_order(99, 500000);
-- Kết quả: Hệ thống sẽ báo lỗi "Lỗi: Khách hàng với ID 99 không tồn tại..."

