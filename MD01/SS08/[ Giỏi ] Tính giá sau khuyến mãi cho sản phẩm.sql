CREATE TABLE products
(
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(100),
    price            NUMERIC,
    discount_percent INT
);

-- Thêm dữ liệu mẫu để kiểm tra
INSERT INTO products (name, price, discount_percent)
VALUES ('Điện thoại A', 10000000, 10),
       ('Tai nghe B', 2000000, 60), -- Trường hợp giảm > 50%
       ('Sạc dự phòng C', 500000, 25);

CREATE OR REPLACE PROCEDURE calculate_discount(
    p_id INT,
    OUT p_final_price NUMERIC
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_price    NUMERIC;
    v_discount INT;
BEGIN
    -- 1. Lấy giá gốc và phần trăm giảm giá của sản phẩm
    SELECT price, discount_percent
    INTO v_price, v_discount
    FROM products
    WHERE id = p_id;

    -- Kiểm tra nếu không tìm thấy sản phẩm
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Sản phẩm có ID % không tồn tại', p_id;
    END IF;

    -- 2. Logic giới hạn giảm giá tối đa 50%
    IF v_discount > 50 THEN
        v_discount := 50;
    END IF;

    -- 3. Tính giá sau giảm
    p_final_price := v_price - (v_price * v_discount / 100);

    -- 4. Cập nhật lại cột price trong bảng products
    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;

    RAISE NOTICE 'Sản phẩm ID % đã được cập nhật giá mới: %', p_id, p_final_price;
END;
$$;

DO
$$
    DECLARE
        p_final_price NUMERIC;
    BEGIN
        -- Gọi procedure cho sản phẩm có ID = 2
        CALL calculate_discount(2, p_final_price);

        -- Hiển thị kết quả giá cuối cùng
        RAISE NOTICE 'Giá sau giảm là: %', p_final_price;
    END
$$;