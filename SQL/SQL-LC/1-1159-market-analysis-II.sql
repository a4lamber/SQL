WITH cte AS
(
SELECT
    buyer_id,
    COUNT(distinct order_id) AS num_of_orders
FROM
    Orders as a
WHERE YEAR(order_date) = '2019'
GROUP BY buyer_id
)
SELECT 
    user_id AS buyer_id,
    join_date,
    COALESCE(num_of_orders,0) AS orders_in_2019
FROM
    Users AS a
LEFT JOIN cte AS b
ON a.user_id = b.buyer_id

