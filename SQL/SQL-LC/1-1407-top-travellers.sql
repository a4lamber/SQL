-- Write your MySQL query statement below
-- Option 1:

SELECT
    name,
    CASE WHEN travelled_distance IS NOT NULL then travelled_distance
    ELSE 0 END as travelled_distance
FROM
    Users AS a
LEFT JOIN 
(SELECT
    user_id,
    SUM(distance) AS travelled_distance
FROM
    rides
GROUP BY user_id) AS b
ON a.id = b.user_id
ORDER BY travelled_distance DESC,name ASC

-- Option 2:
-- much cleaner solution

SELECT
    u.name,
    COALESCE(sum(r.distance), 0) as travelled_distance
FROM
    Rides as r
RIGHT JOIN Users as u
ON r.user_id = u.id
GROUP BY user_id
ORDER BY travelled_distance DESC, name ASC;

