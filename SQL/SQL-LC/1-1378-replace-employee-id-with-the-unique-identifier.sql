# Write your MySQL query statement below
SELECT
    b.unique_id,
    a.name
FROM
    Employees AS a 
LEFT JOIN EmployeeUNI AS b ON a.id = b.id
