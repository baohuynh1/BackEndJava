
CREATE TABLE sales.Customers (
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
phone VARCHAR(20)
);


CREATE TABLE sales.Products (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
price DECIMAL(12, 2) NOT NULL,
stock_quantity INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE sales.Orders (
order_id SERIAL PRIMARY KEY,
customer_id INTEGER REFERENCES sales.Customers(customer_id),
order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Chi tiết đơn hàng
CREATE TABLE sales.OrderItems (
order_item_id SERIAL PRIMARY KEY,
order_id INTEGER REFERENCES sales.Orders(order_id) ON DELETE CASCADE,
product_id INTEGER REFERENCES sales.Products(product_id),
quantity INTEGER NOT NULL CHECK (quantity >= 1)
);

SELECT datname FROM pg_database WHERE datistemplate = false;

SELECT schema_name FROM information_schema.schemata
WHERE schema_name = 'sales';

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'sales';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'sales' AND table_name = 'orderitems';