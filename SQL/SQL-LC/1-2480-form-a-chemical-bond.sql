# Write your MySQL query statement below

/*
考点是笛卡尔积，很少用到的一个join type, 也是return最多结果的一个join type, 
不实用;
*/
select
    a.symbol as metal,
    b.symbol as nonmetal
FROM
(select symbol from elements where type = 'Metal') as a
cross join
(select symbol from elements where type = 'Nonmetal') as b

