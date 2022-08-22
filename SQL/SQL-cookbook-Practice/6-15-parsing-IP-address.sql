/*
Problem
-------------------------------------------------------------------------
You want to Parse an IP address's field into columns.
Consider the following IP
address:
111.22.3.4
You would like the result of your query to be:
A       B     C    D
----- ----- ----- ---
111     22     3   4


思路:
-------------------------------------------------------------------------
这道题来解释一下nested substring_index()函数为啥可以用来对delimited string进行一个分解吧
Step1:
substring_index(tool.ip,'.',1)	111.22.3.4 --> 111
substring_index(tool.ip,'.',2)	111.22.3.4 --> 111.22
substring_index(tool.ip,'.',3)	111.22.3.4 --> 111.22.3
substring_index(tool.ip,'.',4)	111.22.3.4 --> 111.22.3.4
Step2:    																	left-most			right-most     result
substring_index(substring_index(tool.ip,'.',1),'.',-1) as A,	111.22.3.4 --> 111		  -->        111	-->	111
substring_index(substring_index(tool.ip,'.',2),'.',-1) as B,	111.22.3.4 --> 111.22	  -->     111.22	--> 22
substring_index(substring_index(tool.ip,'.',3),'.',-1) as C,	111.22.3.4 --> 111.22.3	  -->   111.22.3	--> 3
substring_index(substring_index(tool.ip,'.',4),'.',-1) as D		111.22.3.4 --> 111.22.3.4 --> 111.22.3.4	--> 4

利用substring_index(string,delimiter,-1)从右往左数的特性, 只需要讲ip address中每一个filed从左往右或从右往左暴露出来就可以了
*/


select 
	substring_index(substring_index(tool.ip,'.',1),'.',-1) as A,
	substring_index(substring_index(tool.ip,'.',2),'.',-1) as B,
	substring_index(substring_index(tool.ip,'.',3),'.',-1) as C,
	substring_index(substring_index(tool.ip,'.',4),'.',-1) as D
from
(select '111.22.3.4' ip from t1) as tool


