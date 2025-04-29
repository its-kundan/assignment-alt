-- Task 1: Order and Sales Analysis
-- Order Status Distribution
SELECT 
    order_status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_orders), 2) AS percentage
FROM customer_orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Monthly Sales Trend
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(order_amount) AS total_revenue,
    AVG(order_amount) AS avg_order_value
FROM customer_orders
WHERE order_status = 'completed'
GROUP BY month
ORDER BY month;

-- Top Selling Months
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(order_amount) AS revenue,
    RANK() OVER (ORDER BY SUM(order_amount) DESC) AS revenue_rank
FROM customer_orders
GROUP BY month
LIMIT 5;