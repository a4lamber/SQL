# Write your MySQL query statement below

SELECT
    a.player_id,
    a.event_date,
    SUM(a.games_played) OVER(PARTITION BY player_id ORDER BY event_date ASC) AS games_played_so_far
FROM
    Activity AS a;
