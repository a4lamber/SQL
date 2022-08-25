/*
应用场景
-------------------------------------------------------------------------
US Census需要解决同一个姓名或者地区的多种不同拼法(英式美式,dialect,misspelling),
但都代表着同样的意思 (phonetically similar)

思路
-------------------------------------------------------------------------
- 写了个built-in function SOUNDEX来量化两个string的相似程度from 1 - 4 with 4 being perfect match
- self join
*/

-- drop table if exists sound;

-- CREATE TABLE sound (
--   aname varchar(12) default NULL
-- );


-- INSERT INTO sound VALUES ('Johnson');
-- INSERT INTO sound VALUES ('Jonson');
-- INSERT INTO sound VALUES ('Jonsen');
-- INSERT INTO sound VALUES ('Jensen');
-- INSERT INTO sound VALUES ('Johnsen');
-- INSERT INTO sound VALUES ('Shakespeare');
-- INSERT INTO sound VALUES ('Shakspear');
-- INSERT INTO sound VALUES ('Shaekspir');
-- INSERT INTO sound VALUES ('Shakespar');

SELECT 
	an1.aname AS name1,
    an2.aname AS name2,
    SOUNDEX(an1.aname) AS Soundex_Name
FROM sound an1 
JOIN sound an2
ON SOUNDEX(an1.aname) = SOUNDEX(an2.aname)
AND an1.aname NOT LIKE an2.aname 