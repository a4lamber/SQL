# Write your MySQL query statement below

SELECT
    p.product_id AS product_id,
    ROUND(SUM(p.price * u.units)/SUM(u.units),2) AS average_price
FROM Prices AS p
INNER JOIN UnitsSold AS u
ON p.product_id = u.product_id
WHERE u.purchase_date BETWEEN p.start_date and p.end_date
GROUP BY p.product_id;
