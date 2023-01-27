# Write your MySQL query statement below

SELECT
    s.user_id,
    SUM(quantity * price) AS spending
FROM
    Sales AS s
INNER JOIN Product AS p
ON s.product_id = p.product_id
GROUP BY s.user_id
ORDER BY spending DESC;
