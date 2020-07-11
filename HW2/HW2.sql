select stockitemname
from Warehouse.StockItems
where stockitemname like '%urgent%' or stockitemname like 'Animal%'

select Suppliername, PurchaseOrderID
from  Purchasing.Suppliers as s  left join Purchasing.PurchaseOrders  as p
on s.SupplierID = p.SupplierID
where PurchaseOrderID is null

select o.OrderID , convert( varchar(16), orderdate, 104) as DATEORDER,
DATEPART( mm, orderdate) as MONTH , 
DATEPART ( qq, orderdate ) as Quarter,
ceiling (convert(float, month(orderdate))/4) as ThirdYear,
c.CustomerName
from  Sales.Orders as o  join  Sales.OrderLines as  l  on o.OrderId = l.OrderID
join   Sales.Customers as c  on c.CustomerID = o.CustomerID
where (UnitPrice > 100  or Quantity > 20 ) and o.PickingCompletedWhen is not null
order by ThirdYear,  Quarter, DATEORDER
offset 1000 rows fetch next 100 rows only

select d.DeliveryMethodName,
p.ExpectedDeliveryDate,
a.fullname,
s.SupplierName
from Application.People as a
join Purchasing.PurchaseOrders  as p on a.personID = p.contactpersonID
join Application.DeliveryMethods as d    on p.DeliveryMethodID = d.DeliveryMethodID
join  Purchasing.Suppliers as s on  s.SupplierID = p.SupplierID
where ExpectedDeliveryDate like '2014-01%'  and  DeliveryMethodName  in ('Air Freight', 'Refrigerated Air Freight')


select top(10) orderdate, fullname, CustomerName
from  sales.orders as o
join Application.People as a on a.personid = o.SalespersonPersonid
join sales.customers as c on c.customerid = o.customerid 
order by orderdate desc

select c.customerid,  CustomerName, phonenumber
from 
sales.customers as c
join sales.orders as o on c.customerID = o.customerID
join  sales.orderlines as o1 on o1.orderID = o.orderID
join Warehouse.StockItems as s on s.stockitemid = o1.stockitemid
where stockitemname = 'Chocolate frogs 250g'







