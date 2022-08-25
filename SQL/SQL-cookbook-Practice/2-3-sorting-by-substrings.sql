/*
Problem
-------------------------------------------------------------------------
You want to sort the results of query by specific parts of a string.
For example, last two characters.

SUBSTR(string,start,length):
string (required): string to extract from.
start (required): the start position. If positive, count from the beginning. If negative, count from the end.
length (optional): number of characters to extract. If omitted, the whole string will be returned from the start position.

Note
-------------------------------------------------------------------------
- 和python list一样，可以倒着来取,还是蛮方便的, 估计是用linked list，所以正反找都方便.

Question
-------------------------------------------------------------------------
Q: 我记得每个row, 是定义50chars,如果是"hello"，则实际上在DB中，"hello      "是这样存的，
那么这样在反着提取SUBSTR的时候会有区别吗? 我试了一下，似乎不影响，why?是因为我create emp TABLE的时候
没有这样定义吗？

*/
SELECT 
    *
FROM
    emp
ORDER BY SUBSTR(job,-2)
-- ORDER BY SUBSTR(job, LENGTH(job) - 1)
