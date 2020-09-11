--Написать хранимую процедуру возвращающую Клиента с набольшей разовой суммой покупки.
--1) Написать функцию возвращающую Клиента с наибольшей суммой покупки.
GO
CREATE FUNCTION  maxsum ()
RETURNS Table
AS
RETURN (SELECT TOP 1 CustomerID, (Quantity*UnitPrice)as Sum
FROM Sales.Invoices as i
JOIN Sales.InvoiceLines as l
ON i.InvoiceID = l.InvoiceID
ORDER BY Sum Desc);
GO

SELECT * FROM maxsum()


--2) Написать хранимую процедуру с входящим параметром СustomerID, выводящую сумму покупки по этому клиенту.
--Использовать таблицы :
--Sales.Customers
--Sales.Invoices
--Sales.InvoiceLines
GO
CREATE PROCEDURE  Sum_Сustomer 
@СustomerID int out
AS   
SET NOCOUNT ON; 
SELECT Sum(i.UnitPrice*i.Quantity) As 'Сумма покупок'
FROM Sales.InvoiceLines as i
JOIN Sales.Invoices as il
on i.InvoiceID = il.InvoiceID
join Sales.Customers as c 
on c.CustomerID = il.CustomerID
WHERE c.CustomerID=@СustomerID
GO
 
EXECUTE Sum_Сustomer  @СustomerID=2


--3) Создать одинаковую функцию и хранимую процедуру, посмотреть в чем разница в производительности и почему.
SET STATISTICS IO ON;

DROP FUNCTION maxsum  ---- Берем функцию из первого задания
GO
CREATE FUNCTION  maxsum ()
RETURNS Table
AS
RETURN (SELECT TOP 1 CustomerID, (Quantity*UnitPrice)as Sum
FROM Sales.Invoices as i
JOIN Sales.InvoiceLines as l
ON i.InvoiceID = l.InvoiceID
ORDER BY Sum Desc);
GO

SeLect * From maxsum()

GO
CREATE PROCEDURE  max_sum  --cоздаем аналогичную хр. процедуру
AS   
SET NOCOUNT ON;
SELECT TOP 1 CustomerID, (Quantity*UnitPrice)as Sum
FROM Sales.Invoices as i
JOIN Sales.InvoiceLines as l
ON i.InvoiceID = l.InvoiceID
ORDER BY Sum Desc;
GO

EXECUTE max_sum

--План выполнения Запросов одинаковый по стоимосте, но при выполнении функции число логических чтений было больше,  в таблице InvoiceLines логических чтений 341 против 161  логических чтений,  в таблице  Invoices   логических чтений 1111 против всего 4 логических чтений.

--4) Создайте табличную функцию покажите как ее можно вызвать для каждой строки result set'а без использования цикла.

CREATE FUNCTION  maxsum_Customer (@CustomerID int)
RETURNS Table
AS
RETURN (SELECT  (Quantity*UnitPrice)as Sum
FROM Sales.Invoices as i
JOIN Sales.InvoiceLines as l
ON i.InvoiceID = l.InvoiceID
WHERE CustomerID = @CustomerID
);

SELECT i.CustomerID, c.sum
FROM Sales.Customers as i
OUTER APPLY  maxsum_Customer (i.CustomerID) as c

