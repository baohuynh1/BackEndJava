-- 2. Tạo bảng Products (Sản phẩm)
CREATE TABLE sales.Products (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
price NUMERIC(12, 2) NOT NULL,
stock_quantity INTEGER NOT NULL DEFAULT 0
);

-- 3. Tạo bảng Orders (Đơn hàng)
CREATE TABLE sales.Orders (
order_id SERIAL PRIMARY KEY,
order_date DATE NOT NULL DEFAULT CURRENT_DATE,
member_id INTEGER REFERENCES library.Members(member_id)
);

-- 4. Tạo bảng OrderDetails (Chi tiết đơn hàng)
CREATE TABLE sales.OrderDetails (
order_detail_id SERIAL PRIMARY KEY,
order_id INTEGER REFERENCES sales.Orders(order_id) ON DELETE CASCADE,
product_id INTEGER REFERENCES sales.Products(product_id),
quantity INTEGER NOT NULL CHECK (quantity > 0)
);