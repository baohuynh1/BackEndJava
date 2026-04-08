-- Bảng sản phẩm
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          stock INT CHECK (stock >= 0) -- Ràng buộc không cho phép tồn kho âm
);

-- Bảng đơn hàng
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        product_id INT REFERENCES products(id),
                        quantity INT NOT NULL,
                        order_status VARCHAR(20) DEFAULT 'completed'
);

-- Dữ liệu mẫu
INSERT INTO products (name, stock) VALUES ('iPhone 15', 10), ('MacBook M3', 5);

CREATE OR REPLACE FUNCTION manage_inventory_logic()
    RETURNS TRIGGER AS $$
DECLARE
    current_stock INT;
BEGIN
    -- 1. TRƯỜNG HỢP: THÊM ĐƠN HÀNG MỚI (INSERT)
    IF (TG_OP = 'INSERT') THEN
        -- Kiểm tra hàng trong kho
        SELECT stock INTO current_stock FROM products WHERE id = NEW.product_id;

        IF current_stock < NEW.quantity THEN
            RAISE EXCEPTION 'Không đủ hàng trong kho! (Còn lại: %)', current_stock;
        END IF;

        -- Giảm tồn kho
        UPDATE products SET stock = stock - NEW.quantity WHERE id = NEW.product_id;
        RETURN NEW;

        -- 2. TRƯỜNG HỢP: CẬP NHẬT ĐƠN HÀNG (UPDATE)
    ELSIF (TG_OP = 'UPDATE') THEN
        SELECT stock INTO current_stock FROM products WHERE id = NEW.product_id;

        -- Tính toán sự chênh lệch (Số lượng mới - Số lượng cũ)
        -- Nếu chênh lệch > số lượng đang có trong kho thì báo lỗi
        IF (NEW.quantity - OLD.quantity) > current_stock THEN
            RAISE EXCEPTION 'Cập nhật thất bại! Kho không đủ hàng để tăng thêm.';
        END IF;

        -- Điều chỉnh tồn kho: Trả lại số cũ, trừ đi số mới
        UPDATE products
        SET stock = stock + OLD.quantity - NEW.quantity
        WHERE id = NEW.product_id;
        RETURN NEW;

        -- 3. TRƯỜNG HỢP: HỦY/XÓA ĐƠN HÀNG (DELETE)
    ELSIF (TG_OP = 'DELETE') THEN
        -- Trả lại số lượng vào kho
        UPDATE products SET stock = stock + OLD.quantity WHERE id = OLD.product_id;
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_stock_update
    BEFORE INSERT OR UPDATE OR DELETE
    ON orders
    FOR EACH ROW
EXECUTE FUNCTION manage_inventory_logic();

INSERT INTO orders (product_id, quantity) VALUES (1, 3);
-- Kết quả: Tồn kho iPhone 15 giảm từ 10 xuống 7.
SELECT * FROM products;

INSERT INTO orders (product_id, quantity) VALUES (2, 10);
-- Kết quả: Báo lỗi "Không đủ hàng trong kho! (Còn lại: 5)"

-- Đang mua 3 chiếc iPhone (ID=1), đổi thành mua 5 chiếc
UPDATE orders SET quantity = 5 WHERE id = 1;
-- Kết quả: Tồn kho iPhone 15 giảm thêm 2 chiếc (còn lại 5).

DELETE FROM orders WHERE id = 1;
-- Kết quả: Tồn kho iPhone 15 được cộng trả lại 5 chiếc (về lại 10).