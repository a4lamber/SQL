# Solution 1 with LEFT JOIN

SELECT
    a.name Customers
FROM Customers a 
    LEFT JOIN
    Orders b
ON a.id = b.customerId
WHERE b.customerID IS NULL;

# Solutio 2 
# SOLVE IT WITH MEMBERSHIP CONDITION AND SUBQUERY
