# Write your MySQL query statement below

WITH CTE AS
(
SELECT
    project_id,
    rank() over(order by count(employee_id) DESC) AS ranks
FROM
    Project
GROUP BY project_id
)
SELECT project_id FROM CTE WHERE ranks = 1;
