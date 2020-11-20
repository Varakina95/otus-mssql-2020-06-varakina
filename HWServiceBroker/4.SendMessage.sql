--Реализуйте очередь для БД WideWorldImporters:
--1. Создайте очередь для формирования отчетов для клиентов по таблице Invoices. При вызове процедуры для создания отчета в очередь должна отправляться заявка.
--2. При обработке очереди создавайте отчет по количеству заказов (Orders) по клиенту за заданный период времени и складывайте готовый отчет в новую таблицу.
--3. Проверьте, что вы корректно открываете и закрываете диалоги и у нас они не копятся.


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Drop procedure if exists Sales.SendNewInvoice--
CREATE PROCEDURE Sales.SendNewInvoice 
	@CustomerID INT,
	@Firstdate date,
	@Lastdate date
AS
BEGIN
	SET NOCOUNT ON;
DECLARE @InitDlgHandle UNIQUEIDENTIFIER; 
DECLARE @RequestMessage NVARCHAR(4000);

BEGIN TRAN

SELECT @RequestMessage = (SELECT CustomerID,  @Firstdate AS Firstdate , @Lastdate AS Lastdate
							  FROM Sales.Invoices AS Inv
							  WHERE CustomerID = @CustomerID 
							  GROUP BY  CustomerID
							  FOR XML AUTO, root('RequestMessage')); 

							  BEGIN DIALOG @InitDlgHandle
	FROM SERVICE
	[//WWI/SB/InitiatorService]
	TO SERVICE
	'//WWI/SB/TargetService'
	ON CONTRACT
	[//WWI/SB/Contract]
	WITH ENCRYPTION=OFF; 


	SEND ON CONVERSATION @InitDlgHandle 
	MESSAGE TYPE
	[//WWI/SB/RequestMessage]
	(@RequestMessage);
	COMMIT TRAN 
END
GO