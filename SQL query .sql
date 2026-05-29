 --Combining the order years 
WITH ALL_ORDERS AS (

SELECT 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM DBO.Orders_2023

UNION ALL

SELECT 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM DBO.Orders_2024

UNION ALL


SELECT 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM DBO.Orders_2025)

--building the main dataset query

select
a.OrderID,
a.CustomerID,
c.Region,
a.ProductID,
c.CustomerJoinDate,
a.OrderDate,
dateadd(week,datediff(week , 0 , a.OrderDate),0)as week,
a.Quantity,
a.Revenue,
case when a.Revenue is null then p.Price * a.Quantity else a.revenue end as CleanedRevenue,
a.Revenue-a.COGS as profit,
a.COGS,
p.ProductName,
p.ProductCategory,
p.Price,
p.Base_Cost
from ALL_ORDERS a
left join customers c
on a.CustomerID = c.CustomerID
left join products p
on a.ProductID = p.ProductID
where a.CustomerID is not null 
-- droping the non customer ids