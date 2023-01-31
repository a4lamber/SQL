# Write your MySQL query statement below

SELECT
    p.product_name,
    SUM(unit) AS unit
FROM
    Orders AS o
INNER JOIN Products AS p
ON o.product_id = p.product_id
WHERE YEAR(o.order_date) = 2020 AND MONTH(o.order_date) = 2
GROUP BY p.product_id
HAVING SUM(unit) >= 100;
