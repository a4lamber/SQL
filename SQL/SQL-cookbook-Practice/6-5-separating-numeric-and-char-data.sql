/*
应用场景
-------------------------------------------------------------------------
某一列是 'AUD$200', '100 km',这你就得把numeric和character拆开了.

Problem
-------------------------------------------------------------------------
separate the following data.

My SQL doesn't have TRANSLATE function. Gotta do it on other platform.
*/




# 创建一个表来分割开charcter and numeric out of string
-- DROP TABLE IF EXISTS charNum;

-- CREATE TABLE charNum (
--   mix varchar(10) default NULL
-- );


-- INSERT into charNum values ('SMITH800');
-- INSERT into charNum values ('ALLEN1600');
-- INSERT into charNum values ('WARD1250');
-- INSERT into charNum values ('JONES2975');
-- INSERT into charNum values ('MARTIN1250');
-- INSERT into charNum values ('BLAKE2850');
-- INSERT into charNum values ('CLARK2450');

SELECT * from charNum

