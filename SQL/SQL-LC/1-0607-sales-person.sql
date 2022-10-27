SELECT
    name
FROM
    SalesPerson
WHERE name NOT IN
(SELECT 
    a.name
FROM
    SalesPerson a
INNER JOIN
    Orders b ON a.sales_id = b.sales_id
WHERE b.com_id = (SELECT com_id FROM Company WHERE name = "RED"));



