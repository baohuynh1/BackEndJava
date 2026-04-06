CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);

-- Chèn dữ liệu mẫu để kiểm tra
INSERT INTO inventory (product_name, quantity)
VALUES ('Laptop', 10), ('Mouse', 5);

CREATE OR REPLACE PROCEDURE check_stock(p_id INT, p_qty INT)
    LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INT;
BEGIN
    -- Lấy số lượng tồn kho hiện tại của sản phẩm
    SELECT quantity INTO current_stock
    FROM inventory
    WHERE product_id = p_id;

    -- Kiểm tra nếu không tìm thấy sản phẩm
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Sản phẩm với ID % không tồn tại', p_id;
    END IF;

    -- Kiểm tra tồn kho
    IF current_stock < p_qty THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho (Hiện có: %, Cần: %)', current_stock, p_qty;
    ELSE
        RAISE NOTICE 'Đủ hàng! Có thể tiến hành xuất kho.';
    END IF;
END;
$$;

CALL check_stock(1, 5);
-- Kết quả : Hiển thị thông báo "Đủ hàng! Có thể tiến hành xuất kho."

CALL check_stock(1, 20);
-- Kết quả : Báo lỗi "Không đủ hàng trong kho" và dừng thực thi.