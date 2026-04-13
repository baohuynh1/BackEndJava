-- Tạo bảng sản phẩm
CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(50),
    stock      INT
);

-- Tạo bảng bán hàng
CREATE TABLE sales
(
    sale_id    SERIAL PRIMARY KEY,
    product_id INT REFERENCES products (product_id),
    quantity   INT
);

-- Chèn dữ liệu mẫu
INSERT INTO products (name, stock)
VALUES ('iPhone 15', 5),
       ('Macbook M3', 2);

CREATE OR REPLACE FUNCTION check_stock_before_sale()
    RETURNS TRIGGER AS
$$
DECLARE
    current_stock INT;
BEGIN
    -- Lấy số lượng tồn kho hiện tại của sản phẩm
    SELECT stock
    INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    -- Kiểm tra nếu số lượng mua lớn hơn tồn kho
    IF NEW.quantity > current_stock THEN
        RAISE EXCEPTION 'Lỗi: Không đủ hàng trong kho! (Hiện có: %, Yêu cầu: %)', current_stock, NEW.quantity;
    END IF;

    -- Nếu đủ hàng, tự động trừ kho trước khi dòng dữ liệu được chèn vào bảng sales
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
    BEFORE INSERT
    ON sales
    FOR EACH ROW
EXECUTE FUNCTION check_stock_before_sale();

-- Mua 2 iPhone (Tồn kho 5 -> Còn 3)
INSERT INTO sales (product_id, quantity)
VALUES (1, 2);

-- Kiểm tra kết quả
SELECT *
FROM products
WHERE product_id = 1; -- stock sẽ là 3
SELECT *
FROM sales;

-- Thử mua 10 iPhone (Trong khi kho chỉ còn 3)
INSERT INTO sales (product_id, quantity)
VALUES (1, 10);