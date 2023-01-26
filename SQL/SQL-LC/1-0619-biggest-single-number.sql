/* Write your T-SQL query statement below */

WITH CTE AS
(
SELECT
    num,
    count(*) AS total_num
FROM MyNumbers
GROUP BY num
HAVING count(*) = 1
)
SELECT MAX(num) AS num FROM CTE
