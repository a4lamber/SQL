# Write your MySQL query statement below

WITH CTE AS
(
SELECT
    o.*,
    p.price,
    c.name,
    SUM(price * quantity) AS total
FROM
    Orders AS o
INNER JOIN Product AS p ON o.product_id = p.product_id
INNER JOIN Customers AS c ON o.customer_id = c.customer_id
WHERE YEAR(order_date) = 2020 AND (MONTH(o.order_date) = 6 OR MONTH(o.order_date) = 7)
GROUP BY customer_id, MONTH(order_date)
ORDER BY customer_id, MONTH(order_date)
)
SELECT
    customer_id,
    name 
FROM
    CTE
WHERE total >= 100
GROUP BY customer_id
HAVING COUNT(*) = 2;
