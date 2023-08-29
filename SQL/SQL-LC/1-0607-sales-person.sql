-- option 1
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



-- option 2
-- 对于option 1的一种优化，毕竟where clause in option 1
-- WHERE b.com_id = (SELECT com_id FROM Company WHERE name = "RED")) 和  where company.name = 'RED'
-- 起到的效果是一样的
select
    name
from
    SalesPerson
where sales_id not in (
    select
        sales_id
    from
        orders
    inner join company 
    on orders.com_id = company.com_id
    where company.name = 'RED'
)
