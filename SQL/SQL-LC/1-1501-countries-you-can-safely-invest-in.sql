# Write your MySQL query statement below

WITH CTE AS(
SELECT
    a.caller_id AS id,
    c.name AS name,
    a.duration
FROM
    Calls AS a
INNER JOIN Person AS b ON a.caller_id = b.id
INNER JOIN Country AS c ON SUBSTR(b.phone_number,1,3) = c.country_code

UNION ALL

SELECT
    a.callee_id AS id,
    e.name AS name,
    a.duration
FROM
    Calls AS a
INNER JOIN Person AS d ON a.callee_id = d.id
INNER JOIN Country AS e ON SUBSTR(d.phone_number,1,3) = e.country_code
)
SELECT
    CTE.name AS country
FROM
    CTE
GROUP BY name
HAVING AVG(duration) > (SELECT AVG(duration) FROM CTE);
