# Write your MySQL query statement below


WITH cte AS
(
SELECT
    c.trans_id AS id,
    t.country,
    "back" AS state,
    t.amount,
    DATE_FORMAT(c.trans_date, "%Y-%m") AS trans_date
FROM
    Chargebacks AS c
INNER JOIN
    Transactions AS t ON c.trans_id = t.id
UNION ALL
(SELECT
    t.id,
    t.country,
    t.state,
    t.amount,
    DATE_FORMAT(t.trans_date, "%Y-%m") AS trans_date
FROM
    Transactions AS t)
)
SELECT
    trans_date AS month,
    country,
    COUNT(CASE WHEN state = 'approved' THEN 1 ELSE NULL END) AS approved_count,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount, 
    COUNT(CASE WHEN state = 'back' THEN 1 ELSE NULL END) AS chargeback_count,
    SUM(CASE WHEN state = 'back' THEN amount ELSE 0 END) AS chargeback_amount 
FROM
    cte
GROUP BY trans_date, country
HAVING 
(COUNT(CASE WHEN state = 'back' THEN 1 ELSE NULL END) > 0 
OR COUNT(CASE WHEN state = 'approved' THEN 1 ELSE NULL END) > 0) 
ORDER BY trans_date ASC;

# excluding all 0 rows are tricky;
