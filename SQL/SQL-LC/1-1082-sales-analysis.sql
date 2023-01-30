# Write your MySQL query statement below


WITH CTE AS
(
SELECT
    *,
    rank() over(order by SUM(price) DESC) AS ranks
FROM
    Sales
GROUP BY seller_id
)
SELECT seller_id FROM CTE WHERE ranks = 1;

