-- Task 3: Payment Status Analysis
-- Payment Status Distribution
SELECT 
    payment_status,
    COUNT(*) AS payment_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM payments), 2) AS percentage
FROM payments
GROUP BY payment_status
ORDER BY payment_count DESC;

-- Payment Failure Analysis by Method
SELECT 
    payment_method,
    payment_status,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY payment_method), 2) AS percentage
FROM payments
GROUP BY payment_method, payment_status
ORDER BY payment_method, payment_status;

-- Payment Delay Analysis
SELECT 
    AVG(DATEDIFF(day, o.order_date, p.payment_date)) AS avg_payment_delay,
    MAX(DATEDIFF(day, o.order_date, p.payment_date)) AS max_payment_delay,
    payment_status
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY payment_status;