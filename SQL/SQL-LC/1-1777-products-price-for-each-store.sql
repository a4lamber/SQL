# Write your MySQL query statement below


SELECT
    p.product_id,
    SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1,
    SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2,
    SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3
FROM
    Products AS p
GROUP BY product_id
