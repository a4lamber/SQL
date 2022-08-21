/*
Problem: count the number of times a character or substring
occurs within a given string.
*/

# Solution 1 (Mine, using string walk):  
select hello,count(*) num_of_comma
from
(select substr(e.comment,d.id,1) as hello,d.id
from
		   (select '10,CLARK,MANAGER' as comment from t1) e 
cross join (select id from t20) d
where id <= length(e.comment)) as dummy
group by hello
having hello = ',';

# Solution 2 (LENGRH,REPLACE and substraction):
-- select (length('10,CLARK,MANAGER') - length(replace('10,CLARK,MANAGER',',',''))) as num_of_comma from t1


