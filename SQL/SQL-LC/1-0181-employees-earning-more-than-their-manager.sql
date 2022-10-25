# Write your MySQL query statement below

SELECT
    a.name Employee
FROM
    Employee a
INNER JOIN Employee b ON a.managerId = b.id
WHERE a.salary > b.salary;

# Practice table self join
# Self joins occurs when a table's FK refers to PK


