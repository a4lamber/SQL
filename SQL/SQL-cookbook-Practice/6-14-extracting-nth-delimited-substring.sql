/*
Problem
-------------------------------------------------------------------------
对于以下view v4
nam
-------------------
mo,larry,curly
tina,gina,jaunita,regina,leena

选取每一行第二个名字作为return,
nam
-------------------
larry
gina

思路
-------------------------------------------------------------------------
*/
-- DROP TABLE IF EXISTS v4;

-- create view v4 as
-- select 'mo,larry,curly' as nam
--  from t1
--  union all
-- select 'tina,gina,jaunita,regina,leena' as nam
--  from t1;

SELECT
    x.positional_nam
FROM
(
SELECT 
	substring_index(substring_index(a.nam,',',b.id),',',-1) AS positional_nam,
    a.nam,
    b.id AS iterator
FROM
(SELECT nam FROM v4) AS a 
    CROSS JOIN (SELECT id FROM t20) AS b
) AS x
WHERE x.iterator = 2
