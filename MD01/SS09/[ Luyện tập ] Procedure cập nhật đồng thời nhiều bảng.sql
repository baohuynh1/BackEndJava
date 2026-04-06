-- Tạo bảng Customers
CREATE TABLE Customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           total_spent NUMERIC DEFAULT 0
);

-- Tạo bảng Orders
CREATE TABLE Orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES Customers(customer_id),
                        total_amount NUMERIC NOT NULL
);

-- Thêm dữ liệu mẫu cho khách hàng
INSERT INTO Customers (name, total_spent) VALUES ('Anh Tuấn', 0), ('Chị Lan', 500);

CREATE OR REPLACE PROCEDURE add_order_and_update_customer(
    p_customer_id INT,
    p_amount NUMERIC
)
    LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_exists BOOLEAN;
BEGIN
    -- 1. Kiểm tra sự tồn tại của khách hàng
    SELECT EXISTS(SELECT 1 FROM Customers WHERE customer_id = p_customer_id)
    INTO v_customer_exists;

    IF NOT v_customer_exists THEN
        RAISE EXCEPTION 'Lỗi: Khách hàng với ID % không tồn tại trong hệ thống.', p_customer_id;
    END IF;

    -- 2. Thêm đơn hàng mới vào bảng Orders
    INSERT INTO Orders (customer_id, total_amount)
    VALUES (p_customer_id, p_amount);

    -- 3. Cập nhật total_spent trong bảng Customers
    UPDATE Customers
    SET total_spent = total_spent + p_amount
    WHERE customer_id = p_customer_id;

    RAISE NOTICE 'Thành công: Đã thêm đơn hàng % và cập nhật chi tiêu cho khách hàng %', p_amount, p_customer_id;

EXCEPTION
    WHEN OTHERS THEN
        -- Bắt tất cả các lỗi khác (ví dụ: lỗi kết nối, lỗi kiểu dữ liệu...)
        RAISE EXCEPTION 'Giao dịch thất bại: %', SQLERRM;
END;
$$;

CALL add_order_and_update_customer(1, 1200000);

SELECT * FROM Orders WHERE customer_id = 1;
-- Bạn sẽ thấy một dòng mới với số tiền 1,200,000.

SELECT * FROM Customers WHERE customer_id = 1;
-- Cột total_spent của khách hàng ID 1 sẽ được cộng thêm 1,200,000.

CALL add_order_and_update_customer(999, 500000);
-- Kết quả: Sẽ ném ra Exception "Lỗi: Khách hàng với ID 999 không tồn tại..."