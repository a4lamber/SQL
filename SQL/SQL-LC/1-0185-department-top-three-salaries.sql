WITH updated_emp_table AS 
(
SELECT
    *,
    CASE 
        WHEN salary_rank <= 3 THEN 1 
        ELSE 0
    END AS top_3_earner_or_not
FROM
    (
    SELECT
        *,
        dense_rank() over(partition by departmentId order by salary DESC) 
AS salary_rank
    FROM
    Employee
    ) AS tool
)
SELECT
    b.name AS Department,
    a.name AS Employee,
    a.salary AS Salary
FROM
    updated_emp_table AS a INNER JOIN Department AS b ON a.departmentId = 
b.id
WHERE top_3_earner_or_not = 1;


