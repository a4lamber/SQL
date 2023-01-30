# Write your MySQL query statement below

WITH CTE AS 
(
SELECT
    s.buyer_id,
    COUNT(CASE WHEN product_name = 'S8' THEN 1 ELSE NULL END) AS get_S8,
    COUNT(CASE WHEN product_name = 'iPhone' THEN 1 ELSE NULL END) AS get_iphone
FROM
    Sales AS s
INNER JOIN Product AS p
ON s.product_id = p.product_id
GROUP BY buyer_id
)
SELECT buyer_id FROM CTE WHERE get_S8 != 0 AND get_iphone = 0;
