# Write your MySQL query statement below

# Hint: The indirect relation between managers will not exceed three managers as the company is small;

SELECT
    a.employee_id AS employee_id
FROM
    Employees AS a
INNER JOIN
    EMPLOYEES AS b ON a.manager_id = b.employee_id
INNER JOIN
    EMPLOYEES AS c ON b.manager_id = c.employee_id
WHERE c.manager_id = 1 and a.employee_id != 1;


