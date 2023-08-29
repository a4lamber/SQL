-- Option 1:
-- SELECT 
--     a.id
-- FROM
--     Weather a, Weather b
-- WHERE DATEDIFF(a.recordDate,b.recordDate) = 1 AND a.temperature > 
-- b.temperature;

-- Option 2: 
select
    a.id
from
    Weather as a
LEFT JOIN weather as b
ON datediff(a.recordDate,b.recordDate) = 1
where a.temperature > b.temperature

-- # The trick is to select a table twice. The 2nd one being the dummy
-- # for filtering operation

-- # Option 3: not working when recordDate is not continuous
-- # SELECT
-- #     id
-- # FROM
-- # (SELECT
-- #     *,
-- #     temperature - LAG(temperature) OVER(ORDER BY recordDate) pre_temp
-- # FROM 
-- #     Weather) dummy
-- #  WHERE dummy.pre_temp IS NOT NULL and dummy.pre_temp > 0;
