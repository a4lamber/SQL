WITH cte AS
(
SELECT
    b.name AS NAME,
    SUM(amount) AS BALANCE 
FROM
    Transactions AS a
    LEFT JOIN Users AS b
    ON a.account = b.account
GROUP BY b.name
)
SELECT
    *
FROM
    cte
WHERE balance > 10000;
