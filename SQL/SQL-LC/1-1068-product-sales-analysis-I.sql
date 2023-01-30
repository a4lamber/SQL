# Write your MySQL query statement below

SELECT
    p.product_name,
    s.year AS year,
    s.price AS price
FROM
    Sales AS s INNER JOIN Product AS p
ON s.product_id = p.product_id;
