-- Tạo bảng Products
CREATE TABLE Products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          price NUMERIC(12, 2) NOT NULL,
                          category_id INT
);

-- Chèn dữ liệu mẫu
INSERT INTO Products (name, price, category_id) VALUES
                                                    ('iPhone 15', 20000000, 1),
                                                    ('Samsung S24', 18000000, 1),
                                                    ('MacBook Air', 25000000, 2),
                                                    ('Dell XPS', 30000000, 2);

CREATE OR REPLACE PROCEDURE update_product_price(
    p_category_id INT,
    p_increase_percent NUMERIC
)
    LANGUAGE plpgsql
AS $$
DECLARE
    -- Khai báo biến để lưu trữ thông tin từng dòng trong vòng lặp
    r_product RECORD;
    v_new_price NUMERIC;
BEGIN
    -- Kiểm tra nếu phần trăm tăng trưởng không hợp lệ
    IF p_increase_percent < 0 THEN
        RAISE EXCEPTION 'Phần trăm tăng giá không được nhỏ hơn 0';
    END IF;

    -- Vòng lặp duyệt qua tất cả sản phẩm thuộc category_id được truyền vào
    FOR r_product IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
        LOOP
        -- Tính giá mới dựa trên phần trăm tăng và lưu vào biến v_new_price
        -- Công thức: Giá mới = Giá cũ * (1 + %tăng / 100)
            v_new_price := r_product.price * (1 + p_increase_percent / 100);

            -- Cập nhật giá mới cho sản phẩm hiện tại trong vòng lặp
            UPDATE Products
            SET price = v_new_price
            WHERE product_id = r_product.product_id;

            RAISE NOTICE 'Sản phẩm ID %: Giá cũ % -> Giá mới %',
                r_product.product_id, r_product.price, v_new_price;
        END LOOP;

    -- Thông báo hoàn tất
    RAISE NOTICE 'Đã cập nhật giá cho tất cả sản phẩm thuộc danh mục %', p_category_id;
END;
$$;

CALL update_product_price(1, 10);

SELECT * FROM Products WHERE category_id = 1;