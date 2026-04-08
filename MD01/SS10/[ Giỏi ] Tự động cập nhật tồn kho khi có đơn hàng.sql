-- Bảng sản phẩm (Kho)
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          stock INTEGER NOT NULL DEFAULT 0
);

-- Bảng đơn hàng
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        product_id INTEGER REFERENCES products(id),
                        quantity INTEGER NOT NULL
);

-- Thêm dữ liệu mẫu
INSERT INTO products (name, stock) VALUES ('Bàn phím cơ', 50), ('Chuột Gaming', 100);

-- Bảng sản phẩm (Kho)
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          stock INTEGER NOT NULL DEFAULT 0
);

-- Bảng đơn hàng
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        product_id INTEGER REFERENCES products(id),
                        quantity INTEGER NOT NULL
);

-- Thêm dữ liệu mẫu
INSERT INTO products (name, stock) VALUES ('Bàn phím cơ', 50), ('Chuột Gaming', 100);

CREATE OR REPLACE FUNCTION manage_stock()
    RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;

    ELSIF (TG_OP = 'UPDATE') THEN
        -- Điều chỉnh dựa trên sự chênh lệch (OLD.quantity - NEW.quantity)
        UPDATE products
        SET stock = stock + (OLD.quantity - NEW.quantity)
        WHERE id = NEW.product_id;

    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;
    END IF;

    RETURN NULL; -- AFTER trigger có thể trả về NULL
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_manage_stock
    AFTER INSERT OR UPDATE OR DELETE ON orders
    FOR EACH ROW
EXECUTE FUNCTION manage_stock();

INSERT INTO orders (product_id, quantity) VALUES (1, 10);

-- Kiểm tra tồn kho: 50 - 10 = 40
SELECT * FROM products WHERE id = 1;

UPDATE orders SET quantity = 5 WHERE id = 1;

-- Kiểm tra tồn kho: 40 + (10 - 5) = 45
SELECT * FROM products WHERE id = 1;

DELETE FROM orders WHERE id = 1;

-- Kiểm tra tồn kho: 45 + 5 = 50 (Về trạng thái ban đầu)
SELECT * FROM products WHERE id = 1;

