# Write your MySQL query statement below

SELECT
    a.team_name AS home_team,
    b.team_name AS away_team
FROM
    Teams AS a
CROSS JOIN Teams AS b 
ON a.team_name != b.team_name;
