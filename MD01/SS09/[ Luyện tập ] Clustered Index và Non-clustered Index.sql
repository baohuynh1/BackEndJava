CREATE TABLE Products (
                          product_id INT PRIMARY KEY, -- Mặc định thường là Clustered Index nếu không chỉ định khác
                          name VARCHAR(100),
                          category_id INT,
                          price NUMERIC(12, 2),
                          stock_quantity INT
);

-- Tạo Clustered Index
CREATE CLUSTERED INDEX IX_Products_Category
ON Products(category_id);

-- Tạo Non-Clustered Index
CREATE NONCLUSTERED INDEX IX_Products_Price
ON Products(price);

SELECT * FROM Products
WHERE category_id = 10
ORDER BY price;