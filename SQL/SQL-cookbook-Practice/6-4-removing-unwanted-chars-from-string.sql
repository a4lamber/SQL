/*
应用场景: 你从数据库导出成csv格式，但是string中含有逗号，
导致无法读成应有的格式.这时候你就需要remove character from string

Problem: 把ename中的vowel都去掉

TRANSLATE (not available in MySQL) and REPLACE 
*/

select 
ename,
replace(
replace(
replace(
replace(
replace(ename,'A',''),'E',''),'I','') ,'O',''),'U','') as vowel_stripped
from emp