/*
Problem: Find the sum of salaries for employees in department 10
along with the sum of their bonus (more than one for some ppl).
For typ 1 bonus, 10% salaray, 2 for 20% salary, 3 for 30% salary.
也就是计算Dept#10中总薪资
*/

/* Solution 1: My solution
解题思路:
1. 遇到error code 1055, 用以下command规避
# SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
2. emp和emp_bounus table 做个left outer join, 不漏过每一个row, 主要是Miller拿了两个bonus,不然用inner就可以了
3. CASE 判断每个人获得几个bonus
4. CASE 判断每个bonus对应多少钱
5. 按员工号进行groupby, 之后加括号让其变为subquery
6. 按deptno进行第二次groupby
*/
SELECT
dummy.deptno,
SUM(dummy.SAL) as dept_10_total_salary,
SUM(dummy.totalBonus) as dept_10_total_bonus
FROM
(SELECT 
    e.empno,
    e.ename,
    e.deptno,
# 判断拿了多少个bonus.
    CASE
    WHEN eb.typ is NULL and count(*) = 1 THEN 0
    ELSE count(*) 
    END as numBonusReceived,
# aggregate fcn求SUM(bonus) = 总收入  
        SUM(CASE
        WHEN eb.typ = 1 THEN e.sal * 0.1
        WHEN eb.typ = 2 THEN e.sal * 0.2
        WHEN eb.typ = 3 THEN e.sal * 0.3
        ELSE 0
		END) AS totalBonus,
# 按每个人的aggregate fcn的salary求平均，仍是其自身 
        AVG(e.sal) as SAL
FROM
    emp e
        LEFT OUTER JOIN
    emp_bonus eb ON e.empno = eb.empno
# 过滤下department# = 10的人
WHERE e.deptno = 10
GROUP BY e.empno) as dummy
GROUP BY deptno

# Solution 2: textbook solution
# Almost the same.


