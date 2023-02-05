# Write your MySQL query statement below


WITH CTE AS
(
SELECT
    group_id,
    player_id,
    SUM(score) AS total_score,
    RANK() OVER(PARTITION BY group_id ORDER BY SUM(score) DESC, player_id ASC) AS in_group_rank
FROM
(
(SELECT
    p.*,
    m1.first_score AS score
FROM
    Players AS p
LEFT JOIN Matches AS m1 ON p.player_id = m1.first_player)
UNION ALL
(SELECT
    p.*,
    m2.second_score AS score
FROM
    Players AS p
LEFT JOIN Matches AS m2 ON p.player_id = m2.second_player)
) AS haha
GROUP BY player_id
)
SELECT
    CTE.group_id AS GROUP_ID,
    CTE.player_id AS PLAYER_ID
FROM
    CTE
WHERE
    in_group_rank = 1;


