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

select
	x.positional_nam
from
(
select 
	substring_index(substring_index(a.nam,',',b.id),',',-1) as positional_nam,
    a.nam,
    b.id as iterator
from
(select nam from v4) as a cross join (select id from t20) as b
) as x
where x.iterator = 2
