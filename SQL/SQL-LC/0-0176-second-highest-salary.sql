
# Option 1: using ranking fcn but needs to debug
# SELECT
#     salary AS SecondHighestSalary
# FROM
# (
# select
#     *,
#     rank() OVER(order by salary DESC) AS rank_tool
# from
#     Employee

# ) AS tool
# WHERE rank_tool = 2;

# Option 2:
SELECT MAX(salary) AS SecondHighestSalary FROM Employee WHERE salary not 
in (select max(salary) from Employee);



