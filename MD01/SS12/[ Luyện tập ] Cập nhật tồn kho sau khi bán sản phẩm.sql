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

CREATE OR REPLACE FUNCTION update_stock_after_sale()
    RETURNS TRIGGER AS
$$
BEGIN
    -- Cập nhật giảm số lượng tồn kho
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_sale_insert
    AFTER INSERT
    ON sales
    FOR EACH ROW
EXECUTE FUNCTION update_stock_after_sale();

-- Bước 1: Kiểm tra kho trước khi bán (iPhone 15 đang có 10)
SELECT *
FROM products
WHERE name = 'iPhone 15';

-- Bước 2: Thêm đơn hàng bán 3 chiếc iPhone 15
INSERT INTO sales (product_id, quantity)
VALUES (1, 3);

-- Bước 3: Kiểm tra lại bảng products
-- Kết quả kỳ vọng: stock của iPhone 15 phải tự động giảm xuống còn 7
SELECT *
FROM products;

-- Kiểm tra bảng sales để xác nhận đơn hàng đã lưu
SELECT *
FROM sales;