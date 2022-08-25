/*
Problem
-------------------------------------------------------------------------
Of the employees in departments 10 and 20, you want to return 
only those that have either an "I" somewhere in their name
or a job title ending with "ER".

Note
-------------------------------------------------------------------------
- AND的优先级比OR高,所以记得要加括号来改变优先级，同时加()也是良好的习惯.
*/
SELECT 
    ename, job
FROM
    emp
WHERE
    deptno IN (10 , 20)
        AND (ename LIKE '%I%' OR job LIKE '%ER')