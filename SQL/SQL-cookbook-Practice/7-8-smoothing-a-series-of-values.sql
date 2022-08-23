/*
Problem
-------------------------------------------------------------------------
对时间序列数据，lots of variations from point to point but you are interested
in the overall trend. Therefore, a smoother is needed in this case to smooth
out the data.

知识点
-------------------------------------------------------------------------
- LAG() and LEAD() are window functions

Reference
-------------------------------------------------------------------------
https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html
*/

-- drop table if exists sales;

-- CREATE TABLE sales (
--   date1 date default NULL,
--   sales decimal(7,2) default NULL
-- );

-- INSERT INTO sales VALUES ('2022-01-01',647);
-- INSERT INTO sales VALUES ('2022-01-02',561);
-- INSERT INTO sales VALUES ('2022-01-03',741);
-- INSERT INTO sales VALUES ('2022-01-04',978);
-- INSERT INTO sales VALUES ('2022-01-05',1062);
-- INSERT INTO sales VALUES ('2022-01-06',1072);
-- INSERT INTO sales VALUES ('2022-01-07',805);
-- INSERT INTO sales VALUES ('2022-01-08',662);
-- INSERT INTO sales VALUES ('2022-01-09',1083);
-- INSERT INTO sales VALUES ('2022-01-10',970);

# Solution:
select 
	date1,
    sales,
    lag(sales,1) over (order by date1) as salesLagOne,
    lag(sales,2) over (order by date1) as salesLagTwo,
    (sales
    + (lag(sales,1) over (order by date1))
    + lag(sales,2) over (order by date1))/3 as MovingAvg
from 
	sales


