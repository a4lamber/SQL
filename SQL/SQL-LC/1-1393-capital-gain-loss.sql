
SELECT
    tool.stock_name,
    SUM(cash_flow) AS capital_gain_loss
FROM
(SELECT
    *,
    CASE 
        WHEN operation = 'Buy' THEN -1*price 
        ELSE price
    END AS cash_flow
FROM
    Stocks) AS tool
GROUP BY stock_name;
