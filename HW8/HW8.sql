--1. Требуется написать запрос, который в результате своего выполнения формирует таблицу следующего вида:
--Название клиента
--МесяцГод Количество покупок

--Клиентов взять с ID 2-6, это все подразделение Tailspin Toys
--имя клиента нужно поменять так чтобы осталось только уточнение
--например исходное Tailspin Toys (Gasport, NY) - вы выводите в имени только Gasport,NY
--дата должна иметь формат dd.mm.yyyy например 25.12.2019
SELECT * FROM
(SELECT REPLACE(SUBSTRING(CustomerName,16,Len(CustomerName)), ')', '') as Name,
       CONVERT(varchar, InvoiceDate, 104) as Date,
	   Quantity
FROM Sales.Customers as c
JOIN Sales.Invoices as i
ON c.CustomerID = i.CustomerID
JOIN Sales.InvoiceLines as il
ON i.InvoiceID = il.InvoiceID
Where c.CustomerID BETWEEN 2 and 6
GROUP BY  CONVERT(varchar, InvoiceDate, 104),  REPLACE(SUBSTRING(CustomerName,16,Len(CustomerName)), ')', ''),Quantity
) as s
PIVOT (SUM(Quantity)
FOR  Name IN ([Jessie, ND],[Sylvanite, MT],[Medicine Lodge, KS],[Peeples Valley, AZ],[Gasport, NY])) as p


--2. Для всех клиентов с именем, в котором есть Tailspin Toys
--вывести все адреса, которые есть в таблице, в одной колонке

--Пример результатов
--CustomerName AddressLine
--Tailspin Toys (Head Office) Shop 38
--Tailspin Toys (Head Office) 1877 Mittal Road
--Tailspin Toys (Head Office) PO Box 8975
--Tailspin Toys (Head Office) Ribeiroville
SELECT CustomerName,
       AddressLine
FROM (
SELECT CustomerName,
       DeliveryAddressLine1,
       DeliveryAddressLine2,
       PostalAddressLine1,
       PostalAddressLine2
FROM Sales.Customers
WHERE CustomerName like '%Tailspin%'
) as t
UNPIVOT (AddressLine FOR Address IN ( DeliveryAddressLine1, DeliveryAddressLine2, PostalAddressLine1, PostalAddressLine2)) as p

--3. В таблице стран есть поля с кодом страны цифровым и буквенным
--сделайте выборку ИД страны, название, код - чтобы в поле был либо цифровой либо буквенный код
--Пример выдачи

--CountryId CountryName Code
--1 Afghanistan AFG
--1 Afghanistan 4
--3 Albania ALB
--3 Albania 8

SELECT CountryId, CountryName, Code
FROM
(SELECT CountryID,
        CountryName,
		IsoAlpha3Code,
		CONVERT(Nvarchar(3), IsoNumericCode) as IsoNumericCode
FROM Application.Countries
) as t
UNPIVOT( Code For CodeType in (IsoAlpha3Code,IsoNumericCode)) as p

--4. Перепишите ДЗ из оконных функций через CROSS APPLY
--Выберите по каждому клиенту 2 самых дорогих товара, которые он покупал
--В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки


SELECT c.CustomerName,
       t.StockItemID,
       t.CustomerID,
	   t.InvoiceDate,
	   t.UnitPrice,
	   t.StockItemName
FROM Sales.Customers as c
CROSS APPLY ( SELECT TOP 2 s.StockItemID,
                         i.CustomerID,
						 InvoiceDate,
						 s.UnitPrice,
	                     s.StockItemName
FROM Warehouse.StockItems as s
JOIN  Sales.InvoiceLines  as il
ON s.StockItemID = il.StockItemID
JOIN Sales.Invoices as i
ON il.InvoiceID = i.InvoiceID 
WHERE c.CustomerID = i.CustomerID
ORDER BY s.UnitPrice DESC) as t




