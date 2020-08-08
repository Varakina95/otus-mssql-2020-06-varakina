--1. �������� ������ � ��������� �������� � ���������� ��� � ��������� ����������. �������� �����.
--� �������� ������� � ��������� �������� � ��������� ���������� ����� ����� ���� ������ ��� ��������� ������:
--������� ������ ����� ������ ����������� ������ �� ������� � 2015 ���� (� ������ ������ ������ �� ����� ����������, ��������� ����� � ������� ������� �������)
--�������� id �������, �������� �������, ���� �������, ����� �������, ����� ����������� ������. ����������� ���� ������ ���� ��� ������� �������.

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
WHERE DATEPART(mm,(t2.Date_sales)) <= DATEPART(mm,(t1.Date_sales)))  AS '����������� ����'
FROM #INVOICES AS t1
GROUP BY t1.ID_Sales, t1.Name_Customer, t1.Date_sales,t1.Total_sum
ORDER BY t1.Date_sales

--(��������� �����: 31440)
 --����� ������ SQL Server:
 --  ����� �� = 4390 ��, ����������� ����� = 1520 ��.
--��������� ����������--

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
WHERE DATEPART(mm,(t2.Date_sales)) <= DATEPART(mm,(t1.Date_sales)))  AS '����������� ����'
FROM @INVOICES1 AS t1
GROUP BY t1.ID_Sales, t1.Name_Customer, t1.Date_sales,t1.Total_sum
ORDER BY t1.Date_sales


--(��������� �����: 31440)

-- ����� ������ SQL Server:
--   ����� �� = 309891 ��, ����������� ����� = 316647 ��.


--2. ���� �� ����� ������������ ���� ������, �� �������� ������ ����� ����������� ������ � ������� ������� �������.
--�������� 2 �������� ������� - ����� windows function � ��� ���. �������� ����� ������� �����������, �������� �� set statistics time on;


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
  --���������  ���� � ������ ����������� ������� ��� 1.  ����� �� = 78 ��, ����������� ����� = 533 �� 

	--3. ������� ������ 2� ����� ���������� ��������� (�� ���-�� ���������) � ������ ������ �� 2016� ��� (�� 2 ����� ���������� �������� � ������ ������)\
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

--4. ������� ����� ��������
--���������� �� ������� �������, � ����� ����� ������ ������� �� ������, ��������, ����� � ����
--������������ ������ �� �������� ������, ��� ����� ��� ��������� ����� �������� ��������� ���������� ������
--���������� ����� ���������� ������� � �������� ����� � ���� �� �������
--���������� ����� ���������� ������� � ����������� �� ������ ����� �������� ������
--���������� ��������� id ������ ������ �� ����, ��� ������� ����������� ������� �� �����
--���������� �� ������ � ��� �� �������� ����������� (�� �����)
--�������� ������ 2 ������ �����, � ������ ���� ���������� ������ ��� ����� ������� "No items"
--����������� 30 ����� ������� �� ���� ��� ������ �� 1 ��
--��� ���� ������ �� ����� ������ ������ ��� ������������� �������

SELECT StockItemID,
       StockItemName,
	   Brand,
	   UnitPrice,
	   QuantityPerOuter,
	   ROW_NUMBER () OVER ( PARTITION BY  substring(StockItemName,1,1)  ORDER BY StockItemName ) as '�� ��������',
	   Count(*) OVER() as '����� ���-��', 
	   Count(*) OVER( PARTITION BY  substring(StockItemName,1,1)) as'���-�� �� ��������',
	   Lag(StockItemID) OVER (ORDER BY StockItemName) as '���������� id',
	   Lead(StockItemID) OVER (ORDER BY StockItemName) as 'C�������� id',
	   Lag(StockItemName,2,'No items') OVER (ORDER BY StockItemName) as '�������� ������',
	   NTILE(30) OVER (ORDER BY TypicalWeightPerUnit) AS '������ �� ����'
	   FROM Warehouse.StockItems
	   Group by  StockItemID, StockItemName,Brand,UnitPrice,QuantityPerOuter, TypicalWeightPerUnit 
	   ORDER BY  StockItemID, StockItemName,Brand,UnitPrice,QuantityPerOuter, TypicalWeightPerUnit 

--	5. �� ������� ���������� �������� ���������� �������, �������� ��������� ���-�� ������
--� ����������� ������ ���� �� � ������� ����������, �� � �������� �������, ���� �������, ����� ������


;WITH LastOrder (SalespersonPersonID,FullName,CustomerID,CustomerName,
OrderDate,Sum_Order,t,t2)  as (
SELECT  SalespersonPersonID,
        FullName,
        i.CustomerID,
        CustomerName,
        InvoiceDate,
        Sum(Quantity*UnitPrice) as Sum_sales,
        ROW_NUMBER() OVER (PARTITION BY SalespersonPersonID ORDER BY InvoiceDate desc)  as t,
		RANK() OVER  (ORDER BY i.InvoiceDate  desc) as t2 -- ���� ���������� ������� ��������� ��������� ������ --
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
--���-- 
SELECT *
FROM LastOrder
WHERE t2=1
order by SalespersonPersonID

--6. �������� �� ������� ������� 2 ����� ������� ������, ������� �� �������
--� ����������� ������ ���� �� ������, ��� ��������, �� ������, ����, ���� �������

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