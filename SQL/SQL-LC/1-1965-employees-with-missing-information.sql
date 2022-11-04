# Write your MySQL query statement below

WITH total_table AS
(
SELECT
    e.employee_id,
    name AS checker
FROM
    Employees AS e LEFT JOIN Salaries AS s
ON e.employee_id = s.employee_id
WHERE s.employee_id IS NULL

UNION ALL

SELECT
    s.employee_id,
    salary AS checker
FROM
    Employees AS e RIGHT JOIN Salaries AS s
ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL
)
SELECT
    employee_id
FROM
    total_table
ORDER BY employee_id ASC;
