# Option 1 Group by
SELECT
    player_id,
    MIN(event_date) AS first_login
FROM
    Activity
GROUP BY player_id
ORDER BY event_date ASC, player_id ASC;


