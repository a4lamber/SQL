# Write your MySQL query statement below

# Solution 1 ranking function
/*
本质上是个排序问题，以player_id为group, 找到里面时间最早的 (也就是ASC排序里的第一位);
但这个解法非常慢 (beats only 8%ppl) 是因为需要建一个CTE的原因,以后再看如何改进吧；
*/
WITH CTE AS 
(SELECT 
    player_id,
    device_id,
    event_date,
    rank() OVER(partition by player_id order by event_date) As login_rank
FROM 
    Activity 
ORDER BY event_date ASC)
SELECT player_id,device_id FROM CTE WHERE login_rank = 1;





