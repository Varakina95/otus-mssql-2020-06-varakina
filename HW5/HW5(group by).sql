--1. Посчитать среднюю цену товара, общую сумму продажи по месяцам
--Вывести:
--* Год продажи
--* Месяц продажи
--* Средняя цена за месяц по всем товарам
--* Общая сумма продаж

SELECT DATEPART(yy,(i.InvoiceDate)) as 'year',
    DATENAME(month, i.InvoiceDate) as 'month',
	   AVG(l.UnitPrice) as 'average price' ,
	   SUM(l.UnitPrice) as 'Total sales'
FROM Sales.Invoices  as i 
join Sales.InvoiceLines as l 
on i.InvoiceID = l.InvoiceID
GROUP BY  DATEPART(yy,i.InvoiceDate),DATENAME(month, i.InvoiceDate)
ORDER BY DATEPART(yy,i.InvoiceDate), DATENAME(month, i.InvoiceDate)


--2. Отобразить все месяцы, где общая сумма продаж превысила 10 000
--Вывести:
--* Год продажи
--* Месяц продажи
--* Общая сумма продаж
SELECT DATEPART(yy,(i.InvoiceDate)) as 'year',
       DATENAME(month, i.InvoiceDate) as 'month',
	   SUM(l.UnitPrice) as 'Total sales'
FROM Sales.Invoices  as i 
join Sales.InvoiceLines as l 
on i.InvoiceID = l.InvoiceID
GROUP BY DATEPART(yy,i.InvoiceDate), DATENAME(month, i.InvoiceDate)
HAVING SUM(l.UnitPrice) > 10000
ORDER BY DATEPART(yy,i.InvoiceDate), DATENAME(month, i.InvoiceDate)

--3. Вывести сумму продаж, дату первой продажи и количество проданного по месяцам, по товарам, продажи которых менее 50 ед в месяц.
--Группировка должна быть по году, месяцу, товару.
--Вывести:
--* Год продажи
--* Месяц продажи
--* Наименование товара
--* Сумма продаж
--* Дата первой продажи
--* Количество проданного
SELECT DATEPART(yy,(i.InvoiceDate)) as 'year',
       DATENAME(month, i.InvoiceDate) as 'month',
	   w.StockItemName,
	   SUM(l.UnitPrice) as 'Sales amount',
	   SUM(l.Quantity) as 'Quantity sold',
	   Min(i.InvoiceDate) as 'first day of sale'
FROM Sales.Invoices  as i 
join Sales.InvoiceLines as l 
on i.InvoiceID = l.InvoiceID
join Warehouse.StockItems as w
on l.StockItemID = w.StockItemID		
GROUP BY DATEPART(yy,i.InvoiceDate),  DATENAME(month, i.InvoiceDate), w.StockItemName
HAVING SUM(l.Quantity) < 50
ORDER BY DATEPART(yy,i.InvoiceDate),  DATENAME(month, i.InvoiceDate)

--4. Написать рекурсивный CTE sql запрос и заполнить им временную таблицу и табличную переменную

CREATE TABLE dbo.MyEmployees
(
EmployeeID smallint NOT NULL,
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(40) NOT NULL,
Title nvarchar(50) NOT NULL,
DeptID smallint NOT NULL,
ManagerID int NULL,
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
)

INSERT INTO dbo.MyEmployees VALUES
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273)
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274)
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285)
,(16, N'David',N'Bradley', N'Marketing Manager', 4, 273)
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);
 
 select * from dbo.MyEmployees

CREATE TABLE #TABLEct
(EmployeeID int,
Name varchar(50),
Title varchar(50),
EmployeeLevel int);

WITH RecCTE (EmployeeID, FirstName, LastName, Title,ManagerID,   EmployeeLevel) as
(SELECT EmployeeID, FirstName, LastName, Title, ManagerID, 1 as EmployeeLevel
FROM dbo.MyEmployees 
WHERE ManagerID is null
UNION ALL
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Title,e.ManagerID, EmployeeLevel+1
FROM RecCTE as c
join dbo.MyEmployees  as e
on c.EmployeeID = e.ManagerID)


INSERT INTO #TABLEct
(EmployeeID, Name, Title,EmployeeLevel )
SELECT EmployeeID, REPLICATE( '|',EmployeeLevel-1) +( FirstName + LastName), Title,EmployeeLevel FROM RecCTE



 DECLARE @TABLEct TABLE
(EmployeeID int,
Name varchar(50),
Title varchar(50),
EmployeeLevel int);

WITH RecCTE (EmployeeID, FirstName, LastName, Title,ManagerID,   EmployeeLevel) as
(SELECT EmployeeID, FirstName, LastName, Title, ManagerID, 1 as EmployeeLevel
FROM dbo.MyEmployees 
WHERE ManagerID is null
UNION ALL
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Title,e.ManagerID, EmployeeLevel+1
FROM RecCTE as c
join dbo.MyEmployees  as e
on c.EmployeeID = e.ManagerID)

INSERT INTO @TABLEct
(EmployeeID, Name, Title,EmployeeLevel )
SELECT EmployeeID, REPLICATE( '|',EmployeeLevel-1) +( FirstName + LastName), Title,EmployeeLevel FROM RecCTE
select * from @TABLEct

