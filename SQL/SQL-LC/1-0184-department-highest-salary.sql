WITH cte AS(
SELECT
    *,
    RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS 
salary_rank
FROM
    Employee)
SELECT
    b.name AS Department,
    a.name AS Employee,
    a.salary AS Salary
FROM
    cte AS a INNER JOIN Department AS b ON a.departmentId = b.id
WHERE salary_rank = 1;
