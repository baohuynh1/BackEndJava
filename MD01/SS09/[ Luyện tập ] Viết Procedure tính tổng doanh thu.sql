-- Tạo bảng Sales
CREATE TABLE Sales
(
    sale_id     SERIAL PRIMARY KEY,
    customer_id INT,
    amount      NUMERIC(15, 2) NOT NULL,
    sale_date   DATE           NOT NULL
);

-- Chèn dữ liệu mẫu
INSERT INTO Sales (customer_id, amount, sale_date)
VALUES (1, 500.00, '2024-01-01'),
       (2, 1200.00, '2024-01-05'),
       (1, 300.00, '2024-02-15'),
       (3, 2500.00, '2024-03-10'),
       (2, 450.00, '2024-03-25');

CREATE OR REPLACE PROCEDURE calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    -- Tính tổng amount trong khoảng từ start_date đến end_date (bao gồm cả 2 ngày đó)
    SELECT SUM(amount)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;

    -- Nếu không có doanh thu trong khoảng này (kết quả NULL), gán bằng 0
    IF total IS NULL THEN
        total := 0;
    END IF;

    RAISE NOTICE 'Doanh thu từ ngày % đến % đã được tính toán.', start_date, end_date;
END;
$$;

DO
$$
    DECLARE
        v_total_revenue NUMERIC;
    BEGIN
        -- Gọi procedure với ngày bắt đầu và ngày kết thúc
        CALL calculate_total_sales('2024-01-01', '2024-03-31', v_total_revenue);

        -- Hiển thị kết quả ra màn hình thông báo
        RAISE NOTICE 'Tổng doanh thu là: %', v_total_revenue;
    END
$$;