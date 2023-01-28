# Write your MySQL query statement below
WITH CTE AS 
(
SELECT
    a.seat_id AS col_1,
    b.seat_id AS col_2
FROM
    Cinema AS a
LEFT JOIN Cinema AS b
ON a.seat_id +1 = b.seat_id
WHERE a.free = 1 and b.free = 1
)
SELECT col_1 AS seat_id FROM CTE
UNION
SELECT col_2 AS seat_id FROM CTE
ORDER BY seat_id;
