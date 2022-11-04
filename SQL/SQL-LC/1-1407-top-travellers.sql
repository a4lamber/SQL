# Write your MySQL query statement below

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

