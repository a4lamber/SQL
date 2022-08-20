/* 
Trick: 如何用aliased name来做where的filtering
Where clause is evaluated before select so it wouldn't know the alias
name "sal AS salary". Therefore, workaround would be subquery as table
or inline view in textbook. 
What you need to do when attempting to reference any of the following
in a WHERE clause:
- Aggregate function
- Scalar subqueries
- Windowing functions
- Aliases
*/

SELECT 
    *
FROM
    (SELECT 
        sal AS salary, comm AS commission
    FROM
        emp) dummy
WHERE
    dummy.salary <= 1000;
