SELECT 
    DISTINCT a.num AS ConsecutiveNums
FROM
    Logs AS a 
    INNER JOIN "Logs" AS b 
    ON a.id + 1 = b.id and a.num = b.num
    INNER JOIN "Logs" AS c
    ON b.id + 1 = c.id and b.num = c.num;
/*Practice ur multiple self join with it.*/
