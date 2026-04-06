CREATE TABLE order_detail
(
    id           SERIAL PRIMARY KEY,
    order_id     INT,
    product_name VARCHAR(100),
    quantity     INT,
    unit_price   NUMERIC
);

CREATE OR REPLACE PROCEDURE calculate_order_total(
    order_id_input INT,
    OUT total NUMERIC
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    -- Tính tổng tiền của đơn hàng dựa trên order_id_input
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;

    -- Nếu không tìm thấy dòng nào, gán total bằng 0 thay vì để NULL
    IF total IS NULL THEN
        total := 0;
    END IF;
END;
$$;

DO
$$
    DECLARE
        order_total NUMERIC;
    BEGIN
        -- Gọi procedure với order_id là 1 (ví dụ)
        CALL calculate_order_total(1, order_total);

        -- Hiển thị kết quả
        RAISE NOTICE 'Tổng giá trị đơn hàng là: %', order_total;
    END
$$;
