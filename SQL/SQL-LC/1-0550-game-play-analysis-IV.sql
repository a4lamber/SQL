# Write your MySQL query statement below

WITH CTE AS
(
SELECT
    *,
    RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS ranks
FROM
    Activity
)
SELECT
    ROUND(COUNT(a.player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity)*1.0,2) AS fraction
FROM
    CTE AS a
INNER JOIN CTE AS b ON (a.ranks+1 = b.ranks AND a.player_id = b.player_id)
WHERE DATEDIFF(a.event_date,b.event_date) = -1 AND a.ranks = 1; 




# In MySQL: SELECT datediff('2016-03-01','2016-03-02') --> -1
