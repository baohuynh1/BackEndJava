SELECT
p.product_name,
SUM(o.total_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.total_price) = (
    -- Subquery: Tìm giá trị doanh thu cao nhất của một sản phẩm bất kỳ
SELECT MAX(revenue_per_product)
FROM (
SELECT SUM(total_price) AS revenue_per_product
FROM orders
GROUP BY product_id
) AS sub
);

-- Sử dụng INTERSECT để tìm điểm giao thoa
SELECT product_id FROM orders GROUP BY product_id HAVING SUM(total_price) > 2000
INTERSECT
SELECT product_id FROM products WHERE category = 'Electronics';