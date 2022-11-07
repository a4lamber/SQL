# Write your MySQL query statement below

# Solution with window fcn
WITH cte AS
(
SELECT
    *,
    LEAD(people,1) OVER() AS lead_1,
    LEAD(people,2) OVER() AS lead_2,
    LAG(people,1) OVER() AS lag_1,
    LAG(people,2) OVER() AS lag_2
FROM
    Stadium
)
SELECT 
    id,
    visit_date,
    people
FROM
    cte
WHERE (people >= 100 AND lead_1 >= 100 AND lead_2 >= 100) OR
      (people >= 100 AND lag_1 >= 100 AND lag_2 >= 100) OR
      (people >= 100 AND lag_1 >= 100 AND lead_1 >= 100);

/*
The window function solution is way faster than left join one cuz it is 
faster (No need to create exponentially large table)
*/
