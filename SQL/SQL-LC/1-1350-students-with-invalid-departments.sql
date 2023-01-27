# Write your MySQL query statement below

SELECT
    s.name,
    s.id
FROM
    Students AS s
LEFT JOIN
    Departments AS d ON s.department_id = d.id
WHERE d.id IS NULL;
