# Write your MySQL query statement below

SELECT
    a.name,
    b.bonus
FROM
    Employee AS a 
LEFT JOIN Bonus AS b ON a.empId = b.empId
WHERE b.empId is Null or bonus < 1000;
