--�������� �������� ��������� ������������ ������� � ��������� ������� ������ �������.
--1) �������� ������� ������������ ������� � ���������� ������ �������.
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


--2) �������� �������� ��������� � �������� ���������� �ustomerID, ��������� ����� ������� �� ����� �������.
--������������ ������� :
--Sales.Customers
--Sales.Invoices
--Sales.InvoiceLines
GO
CREATE PROCEDURE  Sum_�ustomer 
@�ustomerID int out
AS   
SET NOCOUNT ON; 
SELECT Sum(i.UnitPrice*i.Quantity) As '����� �������'
FROM Sales.InvoiceLines as i
JOIN Sales.Invoices as il
on i.InvoiceID = il.InvoiceID
join Sales.Customers as c 
on c.CustomerID = il.CustomerID
WHERE c.CustomerID=@�ustomerID
GO
 
EXECUTE Sum_�ustomer  @�ustomerID=2


--3) ������� ���������� ������� � �������� ���������, ���������� � ��� ������� � ������������������ � ������.
SET STATISTICS IO ON;

DROP FUNCTION maxsum  ---- ����� ������� �� ������� �������
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
CREATE PROCEDURE  max_sum  --c������ ����������� ��. ���������
AS   
SET NOCOUNT ON;
SELECT TOP 1 CustomerID, (Quantity*UnitPrice)as Sum
FROM Sales.Invoices as i
JOIN Sales.InvoiceLines as l
ON i.InvoiceID = l.InvoiceID
ORDER BY Sum Desc;
GO

EXECUTE max_sum

--���� ���������� �������� ���������� �� ���������, �� ��� ���������� ������� ����� ���������� ������ ���� ������,  � ������� InvoiceLines ���������� ������ 341 ������ 161  ���������� ������,  � �������  Invoices   ���������� ������ 1111 ������ ����� 4 ���������� ������.

--4) �������� ��������� ������� �������� ��� �� ����� ������� ��� ������ ������ result set'� ��� ������������� �����.

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

