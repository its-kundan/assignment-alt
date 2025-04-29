-- Task 2: Customer Analysis
-- Customer Segmentation
WITH customer_stats AS (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) AS order_count,
        SUM(order_amount) AS total_spend,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date
    FROM customer_orders
    GROUP BY customer_id
)
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 3 THEN 'Repeat'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    AVG(total_spend) AS avg_spend,
    AVG(order_count) AS avg_orders
FROM customer_stats
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- Customer Acquisition Over Time
SELECT 
    DATE_TRUNC('month', first_order_date) AS cohort_month,
    COUNT(DISTINCT customer_id) AS new_customers
FROM (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM customer_orders
    GROUP BY customer_id
) AS first_orders
GROUP BY cohort_month
ORDER BY cohort_month;