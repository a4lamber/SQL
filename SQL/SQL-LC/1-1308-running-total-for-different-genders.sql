# Write your MySQL query statement below

SELECT
    s.gender,
    s.day,
    SUM(score_points) OVER(Partition BY gender Order by day ASC) AS total
FROM
    Scores AS s
