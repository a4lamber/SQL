-- option 1:
-- 
-- 

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


-- option 2:
-- 基于第一种条件的优化，把where clause合并入join condition中去了;
-- 分解需求
-- features:
-- players who logged in on the day after they first logged in --> some sort of sorting --> ranking
-- 由于要求fraction, 分子或者分母很可能需要scalar subquery
WITH CTE AS (
SELECT
    *, -- fix this later
    rank() over(partition by player_id order by event_date) as log_in_rank
FROM
    Activity)
SELECT
    round(count(*)/(select count(distinct player_id) from Activity),2) AS fraction
FROM
    CTE AS a INNER JOIN CTE as b
    ON a.player_id = b.player_id and a.log_in_rank + 1= b.log_in_rank and datediff(a.event_date,b.event_date) = -1

-- In MySQL: SELECT datediff('2016-03-01','2016-03-02') --> -1
