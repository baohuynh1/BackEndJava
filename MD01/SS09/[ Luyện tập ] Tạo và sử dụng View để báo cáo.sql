CREATE TABLE Sales (
                       sale_id SERIAL PRIMARY KEY,
                       customer_id INT,
                       product_id INT,
                       sale_date DATE,
                       amount NUMERIC(15, 2)
);

INSERT INTO Sales (customer_id, product_id, sale_date, amount) VALUES
                                                                   (1, 101, '2024-01-01', 500),
                                                                   (1, 102, '2024-01-05', 700),
                                                                   (2, 101, '2024-01-10', 300),
                                                                   (3, 103, '2024-02-01', 1500),
                                                                   (2, 102, '2024-02-15', 900);

CREATE OR REPLACE VIEW CustomerSales AS
SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;

SELECT * FROM CustomerSales
WHERE total_amount > 1000;

UPDATE CustomerSales
SET total_amount = 2000
WHERE customer_id = 1;

