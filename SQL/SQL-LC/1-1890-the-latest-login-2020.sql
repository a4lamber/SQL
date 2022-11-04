# Write your MySQL query statement below
WITH CTE AS
(
SELECT
    user_id,
    rank() OVER(PARTITION BY user_id ORDER BY time_stamp DESC) AS 
position,
    time_stamp AS last_stamp
FROM
    Logins
WHERE YEAR(time_stamp) = '2020'
)
SELECT
    user_id,
    last_stamp
FROM
    CTE
WHERE position = 1;

