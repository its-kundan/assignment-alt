-- Task 4: Order Details Report
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    o.order_status,
    p.payment_id,
    p.payment_method,
    p.payment_status,
    p.payment_amount,
    p.payment_date,
    DATEDIFF(day, o.order_date, p.payment_date) AS days_to_payment,
    CASE 
        WHEN p.payment_status = 'failed' AND DATEDIFF(day, o.order_date, CURRENT_DATE) > 7 THEN 'Needs Followup'
        WHEN p.payment_status = 'pending' AND DATEDIFF(day, o.order_date, CURRENT_DATE) > 3 THEN 'Review Required'
        ELSE 'Normal'
    END AS order_priority
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
ORDER BY o.order_date DESC;