# Write your MySQL query statement below

WITH CTE AS
(
SELECT
    event_type,
    SUM(occurences)/count(*) AS average
FROM
    Events
GROUP BY event_type
)
SELECT
    business_id
FROM
    Events AS a
INNER JOIN CTE AS b ON a.event_type = b.event_type
GROUP BY business_id
HAVING COUNT(CASE WHEN occurences > average THEN 1 ELSE NULL END) > 1
ORDER BY business_id ASC;
