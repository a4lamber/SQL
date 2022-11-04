# Write your MySQL query statement below

WITH cte AS
(
SELECT
    a.id,
    a.student AS old,
    b.student AS even_tool,
    c.student AS odd_tool
FROM
    Seat AS a
LEFT JOIN Seat AS b
ON a.id = b.id + 1
LEFT JOIN Seat AS c
ON a.id = c.id - 1
)
SELECT
    id,
    CASE WHEN MOD(id,2) = 1 AND id = (SELECT MAX(id) FROM cte) THEN old
         WHEN MOD(id,2) = 1 THEN odd_tool
         WHEN MOD(id,2) = 0 THEN even_tool
         ELSE NULL END AS student
FROM
    cte

/*
Mod() VS '%' operator for modulus calculation in SQL
intuition of 1 lag and 1 lead column for swapping is important
this trick could be implemented by both window function or "staggered" 
JOIN
*/
