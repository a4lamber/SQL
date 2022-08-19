/*
COALESCE: come together to form on mass or whole.
COALESCE(a,b,c,..):  evaluates the arguments in order
and returns the current value of first expression
that initially doesn't evaluate to NULL.
For example, SELECT COALESCE(NULL,NULL,'third_value','fourth_value') 
would return 'third_value' since it is the first non-null value in the argument.
解释:
实际上我们call了COALESCE这个函数N次，N等于len(comm). 
在遍历过程中，在个iteration里
如果遇到一个NULL,我就在argument里寻找，第一个non null value, 
那就return 0
如果没遇到Null, 而是另一个数var
那就return var

可以看一下python等效代码 for details.
*/
SELECT 
    COALESCE(comm, 0) AS commission
FROM
    emp