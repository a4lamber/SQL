# Write your MySQL query statement below

SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM
    Activity
GROUP BY activity_date
HAVING activity_date > DATE_ADD('2019-07-27',INTERVAL -30 day) AND 
activity_date <= '2019-07-27' AND COUNT(user_id) != 0


