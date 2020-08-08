--1. Напишите запрос с временной таблицей и перепишите его с табличной переменной. Сравните планы.
--В качестве запроса с временной таблицей и табличной переменной можно взять свой запрос или следующий запрос:
--Сделать расчет суммы продаж нарастающим итогом по месяцам с 2015 года (в рамках одного месяца он будет одинаковый, нарастать будет в течение времени выборки)
--Выведите id продажи, название клиента, дату продажи, сумму продажи, сумму нарастающим итогом. Нарастающий итог должен быть без оконной функции.

set statistics time on;

DROP TABLE IF EXISTS #INVOICES

CREATE TABLE #INVOICES
(ID_Sales int,
Name_Customer nvarchar(50),
Date_sales date,
Total_sum decimal
);


INSERT INTO #INVOICES (ID_Sales, Name_Customer, Date_sales,Total_sum)
SELECT I.InvoiceID,
       C.CustomerName,
	   I.InvoiceDate,
	   SUM(il.Quantity*IL.UnitPrice) as total
FROM Sales.InvoiceLines as il
	   JOIN Sales.Invoices AS I
	   ON I.InvoiceID = IL.InvoiceID
	   JOIN Sales.Customers as c
	   ON i.CustomerID = c.CustomerID
WHERE I.InvoiceDate >= '2015-01-01'
GROUP BY I.InvoiceID,C.CustomerName,I.InvoiceDate 
 

SELECT t1.ID_Sales, t1.Name_Customer, t1.Date_sales,t1.Total_sum,
(SELECT SUM(t2.Total_sum)
FROM #INVOICES AS t2
WHERE DATEPART(mm,(t2.Date_sales)) <= DATEPART(mm,(t1.Date_sales)))  AS 'Нарастающий итог'
FROM #INVOICES AS t1
GROUP BY t1.ID_Sales, t1.Name_Customer, t1.Date_sales,t1.Total_sum
ORDER BY t1.Date_sales

--(затронуто строк: 31440)
 --Время работы SQL Server:
 --  Время ЦП = 4390 мс, затраченное время = 1520 мс.
--табличная переменная--

DECLARE @INVOICES1 TABLE
(ID_Sales int,
Name_Customer nvarchar(50),
Date_sales date,
Total_sum decimal
);


INSERT INTO @INVOICES1  (ID_Sales, Name_Customer, Date_sales,Total_sum)
SELECT I.InvoiceID,
       C.CustomerName,
	   I.InvoiceDate,
	   SUM(il.Quantity*IL.UnitPrice) as total
FROM Sales.InvoiceLines as il
	   JOIN Sales.Invoices AS I
	   ON I.InvoiceID = IL.InvoiceID
	   JOIN Sales.Customers as c
	   ON i.CustomerID = c.CustomerID
WHERE I.InvoiceDate >= '2015-01-01'
GROUP BY I.InvoiceID,C.CustomerName,I.InvoiceDate 
 
 SELECT t1.ID_Sales, t1.Name_Customer, t1.Date_sales,t1.Total_sum,
(SELECT SUM(t2.Total_sum)
FROM @INVOICES1 AS t2
WHERE DATEPART(mm,(t2.Date_sales)) <= DATEPART(mm,(t1.Date_sales)))  AS 'Нарастающий итог'
FROM @INVOICES1 AS t1
GROUP BY t1.ID_Sales, t1.Name_Customer, t1.Date_sales,t1.Total_sum
ORDER BY t1.Date_sales


--(затронуто строк: 31440)

-- Время работы SQL Server:
--   Время ЦП = 309891 мс, затраченное время = 316647 мс.


--2. Если вы брали предложенный выше запрос, то сделайте расчет суммы нарастающим итогом с помощью оконной функции.
--Сравните 2 варианта запроса - через windows function и без них. Написать какой быстрее выполняется, сравнить по set statistics time on;


;WITH INVOICES1 (ID_Sales, Name_Customer,Date_sales, imonth, Total_sum) AS (
SELECT  I.InvoiceID,
       C.CustomerName,
	   I.InvoiceDate,
	   DATEPART(mm,(I.InvoiceDate)),
	   SUM(il.Quantity*IL.UnitPrice) as total
FROM Sales.InvoiceLines as il
	   JOIN Sales.Invoices AS I
	   ON I.InvoiceID = IL.InvoiceID
	   JOIN Sales.Customers as c
	   ON i.CustomerID = c.CustomerID
WHERE I.InvoiceDate >= '2015-01-01'
GROUP BY I.InvoiceID,C.CustomerName,I.InvoiceDate) 


SELECT ID_Sales,
       Name_Customer,
       Date_sales,
       imonth,
       Total_sum,
SUM(Total_sum) OVER ( PARTITION by imonth ORDER BY Date_sales ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as total
FROM INVOICES1
ORDER BY Date_sales  
  --Стоимость  ниже и запрос выполняется быстрее чем 1.  Время ЦП = 78 мс, затраченное время = 533 мс 

	--3. Вывести список 2х самых популярных продуктов (по кол-ву проданных) в каждом месяце за 2016й год (по 2 самых популярных продукта в каждом месяце)\
SELECT *
FROM (
SELECT  I.InvoiceID,
       C.CustomerName,
	   I.InvoiceDate,
	   il.Quantity,
	   ROW_NUMBER() OVER (PARTITION BY month(I.InvoiceDate) ORDER BY  il.Quantity DESC) AS QRank
	   FROM Sales.InvoiceLines as il
	   JOIN Sales.Invoices AS I
	   ON I.InvoiceID = IL.InvoiceID
	   JOIN Sales.Customers as c
	   ON i.CustomerID = c.CustomerID
WHERE DATEPART (yy, I.InvoiceDate) = 2016 
GROUP BY I.InvoiceID,C.CustomerName,I.InvoiceDate,il.Quantity) as t
WHERE QRank <=2
ORDER BY t.Quantity, t.InvoiceDate

--4. Функции одним запросом
--Посчитайте по таблице товаров, в вывод также должен попасть ид товара, название, брэнд и цена
--пронумеруйте записи по названию товара, так чтобы при изменении буквы алфавита нумерация начиналась заново
--посчитайте общее количество товаров и выведете полем в этом же запросе
--посчитайте общее количество товаров в зависимости от первой буквы названия товара
--отобразите следующий id товара исходя из того, что порядок отображения товаров по имени
--предыдущий ид товара с тем же порядком отображения (по имени)
--названия товара 2 строки назад, в случае если предыдущей строки нет нужно вывести "No items"
--сформируйте 30 групп товаров по полю вес товара на 1 шт
--Для этой задачи НЕ нужно писать аналог без аналитических функций

SELECT StockItemID,
       StockItemName,
	   Brand,
	   UnitPrice,
	   QuantityPerOuter,
	   ROW_NUMBER () OVER ( PARTITION BY  substring(StockItemName,1,1)  ORDER BY StockItemName ) as 'по алфавиту',
	   Count(*) OVER() as 'Общее кол-во', 
	   Count(*) OVER( PARTITION BY  substring(StockItemName,1,1)) as'Кол-во по алфавиту',
	   Lag(StockItemID) OVER (ORDER BY StockItemName) as 'Предыдущий id',
	   Lead(StockItemID) OVER (ORDER BY StockItemName) as 'Cледующий id',
	   Lag(StockItemName,2,'No items') OVER (ORDER BY StockItemName) as 'Название товара',
	   NTILE(30) OVER (ORDER BY TypicalWeightPerUnit) AS 'Группы по весу'
	   FROM Warehouse.StockItems
	   Group by  StockItemID, StockItemName,Brand,UnitPrice,QuantityPerOuter, TypicalWeightPerUnit 
	   ORDER BY  StockItemID, StockItemName,Brand,UnitPrice,QuantityPerOuter, TypicalWeightPerUnit 

--	5. По каждому сотруднику выведите последнего клиента, которому сотрудник что-то продал
--В результатах должны быть ид и фамилия сотрудника, ид и название клиента, дата продажи, сумму сделки


;WITH LastOrder (SalespersonPersonID,FullName,CustomerID,CustomerName,
OrderDate,Sum_Order,t,t2)  as (
SELECT  SalespersonPersonID,
        FullName,
        i.CustomerID,
        CustomerName,
        InvoiceDate,
        Sum(Quantity*UnitPrice) as Sum_sales,
        ROW_NUMBER() OVER (PARTITION BY SalespersonPersonID ORDER BY InvoiceDate desc)  as t,
		RANK() OVER  (ORDER BY i.InvoiceDate  desc) as t2 -- если необходимо вывести несколько последних продаж --
FROM Sales.InvoiceLines  as il
JOIN Sales.Invoices as i
ON il.InvoiceID = i.InvoiceID 
join Application.People as p
on i.SalespersonPersonID = p.PersonID
Join Sales.Customers as c
on c.CustomerID = i.CustomerID
GROUP BY SalespersonPersonID,FullName,i.CustomerID,CustomerName,InvoiceDate
)
SELECT *
FROM LastOrder
WHERE t=1
order by SalespersonPersonID
--или-- 
SELECT *
FROM LastOrder
WHERE t2=1
order by SalespersonPersonID

--6. Выберите по каждому клиенту 2 самых дорогих товара, которые он покупал
--В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки

;WITH Price as(
SELECT DISTINCT s.StockItemID,
       i.CustomerID,
       CustomerName,
	   InvoiceDate,
	   s.UnitPrice,
	   s.StockItemName,
	   ROW_NUMBER() OVER (PARTITION BY i.CustomerID ORDER BY s.UnitPrice desc)  as t
FROM Sales.InvoiceLines  as il
JOIN Sales.Invoices as i
ON il.InvoiceID = i.InvoiceID 
join Application.People as p
on i.SalespersonPersonID = p.PersonID
Join Sales.Customers as c
on c.CustomerID = i.CustomerID
join Warehouse.StockItems as s
on s.StockItemID=il.StockItemID
GROUP BY i.CustomerID, CustomerName, InvoiceDate, s.UnitPrice, s.StockItemID, s.StockItemName)
SELECT*
FROM Price
WHERE t <= 2 
ORDER BY CustomerID