CREATE TABLE shop.Users (
user_id SERIAL PRIMARY KEY,
username VARCHAR(50) UNIQUE NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
password VARCHAR(100) NOT NULL,
role VARCHAR(20) CHECK (role IN ('Customer', 'Admin')) DEFAULT 'Customer'
);

CREATE TABLE shop.Categories (
category_id SERIAL PRIMARY KEY,
category_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE shop.Orders (
 order_id SERIAL PRIMARY KEY, user_id INT REFERENCES shop.Users(user_id) ON DELETE CASCADE,
 order_date DATE NOT NULL DEFAULT CURRENT_DATE, status VARCHAR(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')) DEFAULT 'Pending'
);

CREATE TABLE shop.OrderDetails (
 order_detail_id SERIAL PRIMARY KEY,
 order_id INT REFERENCES shop.Orders(order_id) ON DELETE CASCADE,
product_id INT REFERENCES shop.Products(product_id) ON DELETE RESTRICT, quantity INT CHECK (quantity > 0),
 price_each NUMERIC(10, 2) CHECK (price_each > 0)
);
CREATE TABLE shop.Products (
 product_id SERIAL PRIMARY KEY,
 product_name VARCHAR(100) NOT NULL,
 price NUMERIC(10, 2) CHECK (price > 0),
 stock INT CHECK (stock >= 0) DEFAULT 0,
 category_id INT REFERENCES shop.Categories(category_id) ON DELETE SET NULL
);
CREATE TABLE shop.Payments (
payment_id SERIAL PRIMARY KEY,
order_id INT REFERENCES shop.Orders(order_id) ON DELETE CASCADE,
amount NUMERIC(10, 2) CHECK (amount >= 0),
payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
method VARCHAR(30) CHECK (method IN ('Credit Card', 'Momo', 'Bank Transfer', 'Cash'))
);