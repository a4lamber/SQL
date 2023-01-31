# Write your MySQL query statement below

# Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.

SELECT DISTINCT
    c.title
FROM
    Content AS c
INNER JOIN TVProgram AS t
ON c.content_id = t.content_id
WHERE YEAR(t.program_date) = 2020
AND MONTH(t.program_date) = 6
AND c.Kids_content = 'Y'
AND c.content_type = 'Movies';
