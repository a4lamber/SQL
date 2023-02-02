# Write your MySQL query statement below

WITH user1_friends AS
(
SELECT
    CASE WHEN user1_id = 1 THEN user2_id
         ELSE user1_id END AS friends
FROM
    Friendship AS f
WHERE user1_id = 1 OR user2_id = 1
)
SELECT DISTINCT
    b.page_id AS recommended_page
FROM
    user1_friends AS a
INNER JOIN Likes AS b ON a.friends = b.user_id
WHERE b.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1);
