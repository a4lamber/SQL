-- Write your MySQL query statement below
-- option 1:
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

-- option 2:
-- 比option 1 看着更干净一些;
-- 先确定average activity

with cte as (
    select
        business_id,
        event_type,
        avg(occurences) as avg_occurences
    from
        events
    group by event_type
)
select
    e.business_id
from
    cte
inner join events as e on 
cte.business_id = e.business_id and 
cte.event_type = e.event_type
group by e.business_id
-- more than 1 active business
having count(case when occurences > avg_occurences then 1 else null end) > 1;

