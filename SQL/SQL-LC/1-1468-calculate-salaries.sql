# Write your MySQL query statement below


WITH tax AS
(
SELECT
    company_id,
    CASE WHEN max(salary) < 1000 THEN 0
         WHEN max(salary) >=1000 and max(salary)<= 10000 THEN 0.24
         ELSE 0.49 END AS tax_amount
FROM
    Salaries
GROUP BY company_id
)
SELECT
    s.company_id,
    s.employee_id,
    s.employee_name,
    ROUND(s.salary * (1 - t.tax_amount),0) AS salary 
FROM
    Salaries AS s
INNER JOIN tax AS t ON s.company_id = t.company_id;
