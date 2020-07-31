USE WideWorldImporters;

SELECT [CustomerID]
      ,[CustomerName]
      ,[BillToCustomerID]
      ,[CustomerCategoryID]
      ,[BuyingGroupID]
      ,[PrimaryContactPersonID]
      ,[AlternateContactPersonID]
      ,[DeliveryMethodID]
      ,[DeliveryCityID]
      ,[PostalCityID]
      ,[CreditLimit]
      ,[AccountOpenedDate]
      ,[StandardDiscountPercentage]
      ,[IsStatementSent]
      ,[IsOnCreditHold]
      ,[PaymentDays]
      ,[PhoneNumber]
      ,[FaxNumber]
      ,[DeliveryRun]
      ,[RunPosition]
      ,[WebsiteURL]
      ,[DeliveryAddressLine1]
      ,[DeliveryAddressLine2]
      ,[DeliveryPostalCode]
      ,[DeliveryLocation]
      ,[PostalAddressLine1]
      ,[PostalAddressLine2]
      ,[PostalPostalCode]
      ,[LastEditedBy]
INTO Sales.Customers_Copy2
FROM  Sales.Customers
WHERE 1 = 2;
 
 --1. Довставлять в базу 5 записей используя insert в таблицу Customers или Suppliers

 INSERT INTO Sales.Customers
	  ([CustomerID]
      ,[CustomerName]
      ,[BillToCustomerID]
      ,[CustomerCategoryID]
      ,[BuyingGroupID]
      ,[PrimaryContactPersonID]
      ,[AlternateContactPersonID]
      ,[DeliveryMethodID]
      ,[DeliveryCityID]
      ,[PostalCityID]
      ,[CreditLimit]
      ,[AccountOpenedDate]
      ,[StandardDiscountPercentage]
      ,[IsStatementSent]
      ,[IsOnCreditHold]
      ,[PaymentDays]
      ,[PhoneNumber]
      ,[FaxNumber]
      ,[DeliveryRun]
      ,[RunPosition]
      ,[WebsiteURL]
      ,[DeliveryAddressLine1]
      ,[DeliveryAddressLine2]
      ,[DeliveryPostalCode]
      ,[PostalAddressLine1]
      ,[PostalAddressLine2]
      ,[PostalPostalCode]
      ,[LastEditedBy]
      )
      OUTPUT   inserted.*
     VALUES (NEXT VALUE FOR Sequences.CustomerID,'Maria White', 1119,5,NULL,1,NULL,3,19881,19881,1500.00,'2016-05-07','0.000',0,0,7,'(325)8901-5555','(325)8901-5555',NULL,NULL,'http://www.microsoft.com/','shop 89','109 green steet',90243,'shop 89','109 green steet',90243,1),
	 (NEXT VALUE FOR Sequences.CustomerID,'Mason Adrian Rogers St.',1119,5,NULL,1,NULL,3,25608,25608,1500.00,'2020-01-09',0.000,0,0,7,'(217)7005-0101','(217)7005-0101',NULL,NULL,'http://www.microsoft.com/','Shop 89','162 Stern Crescent',90760,'Shop 89','162 Stern Crescent',90760,1),
	 (NEXT VALUE FOR Sequences.CustomerID, 'Jack Keruak',1119,5,NULL,1,NULL,3,1326,1326,2000.00,'2020-07-30',0.000,0,0,7,'(388)6003-1000','(388)6003-1000',NULL,NULL,'http://www.microsoft.com/','Shop 21', '199 Kings Road',90069,'Shop 21', '199 Kings Road',90069,1),
	 (NEXT VALUE FOR Sequences.CustomerID,'Diana Black',1119,5,NULL,1,NULL,3,22090,22090,2000.00, '2020-07-30',0.000,0,0,7, '(123)2050-4555','(123)2050-4555',NULL,NULL,'http://www.microsoft.com/', 'Shop OOO', '78 Baker Street', 90669,'Shop OOO', '78 Baker Street', 90669,1),
	 (NEXT VALUE FOR Sequences.CustomerID,'James Kemeron',1119,5,NULL,1,NULL,3,10483,10483,2000.00, '2020-07-30',0.000,0,0,7,'(173)2090-4555','(173)2090-4555',NULL,NULL,'http://www.microsoft.com/', 'Shop 001', '13 Oxford Street', 90243, 'Shop 001', '13 Oxford Street', 90243,1);


	 	 	  
INSERT INTO Sales.Customers_Copy2
	  ([CustomerID]
      ,[CustomerName]
      ,[BillToCustomerID]
      ,[CustomerCategoryID]
      ,[BuyingGroupID]
      ,[PrimaryContactPersonID]
      ,[AlternateContactPersonID]
      ,[DeliveryMethodID]
      ,[DeliveryCityID]
      ,[PostalCityID]
      ,[CreditLimit]
      ,[AccountOpenedDate]
      ,[StandardDiscountPercentage]
      ,[IsStatementSent]
      ,[IsOnCreditHold]
      ,[PaymentDays]
      ,[PhoneNumber]
      ,[FaxNumber]
      ,[DeliveryRun]
      ,[RunPosition]
      ,[WebsiteURL]
      ,[DeliveryAddressLine1]
      ,[DeliveryAddressLine2]
      ,[DeliveryPostalCode]
      ,[PostalAddressLine1]
      ,[PostalAddressLine2]
      ,[PostalPostalCode]
      ,[LastEditedBy]
      )
      OUTPUT   inserted.*
     VALUES 
     (NEXT VALUE FOR Sequences.CustomerID,'Allan Butler', 1061,5,NULL,3261,NULL,3,19881,19881,1600.00,'2016-05-07','0.000',0,0,7,'(325)8900-5555','(325)8900-5555',NULL,NULL,'http://www.microsoft.com/','shop 89','109 green steet',90243,'shop 89','109 green steet',90243,1),
	 (NEXT VALUE FOR Sequences.CustomerID,'Mason Adrian Rogers',1119,5,NULL,3257,NULL,3,25608,25608,1600.00,'2020-01-09',0.000,0,0,7,'(217)7005-0101','(217)7005-0101',NULL,NULL,'http://www.microsoft.com/','Shop 89','162 Stern Crescent',90760,'Shop 89','162 Stern Crescent',90760,1),
	 (NEXT VALUE FOR Sequences.CustomerID, 'Thomas Jaden Ward',1120,5,NULL,3260,NULL,3,1326,1326,4000.00,'2020-07-30',0.000,0,0,7,'(388)6000-1000','(388)6000-1000',NULL,NULL,'http://www.microsoft.com/','Shop 21', '199 Kings Road',90069,'Shop 21', '199 Kings Road',90069,1),
	 (NEXT VALUE FOR Sequences.CustomerID,'Molly Diana Hill',1121,5,NULL,3289,NULL,3,22090,22090,4000.00, '2020-07-30',0.000,0,0,7, '(123)2000-4555','(123)2000-4555',NULL,NULL,'http://www.microsoft.com/', 'Shop OOO', '78 Baker Street', 90669,'Shop OOO', '78 Baker Street', 90669,1),
	 (NEXT VALUE FOR Sequences.CustomerID,'Sarah Melanie Washington',1122,5,NULL,3256,NULL,3,10483,10483,4000.00, '2020-07-30',0.000,0,0,7,'(173)2080-4555','(173)2080-4555',NULL,NULL,'http://www.microsoft.com/', 'Shop 001', '13 Oxford Street', 90243, 'Shop 001', '13 Oxford Street', 90243,1);
	 
	 --2. удалите 1 запись из Customers, которая была вами добавлена
	 DELETE  FROM Sales.Customers_Copy2 
	 WHERE CustomerName like '%Allan Butler'

	 

	 --3. изменить одну запись, из добавленных через UPDATE
	 UPDATE Sales.Customers_Copy2
	 SET
	 DeliveryAddressLine1 = 'Shop market 22',
	 DeliveryAddressLine2 = '22 Lime Street' 
	 OUTPUT inserted.*
	 WHERE CustomerID = 1120

	UPDATE Sales.Customers_Copy2
	SET CreditLimit = 1800
	OUTPUT inserted.*
	WHERE CustomerID = 1119

	
	 --4. Написать MERGE, который вставит вставит запись в клиенты, если ее там нет, и изменит если она уже есть
	 	 
	MERGE Sales.Customers AS target
	USING Sales.Customers_Copy2 AS source 
	 ON (target.BillToCustomerID = source.BillToCustomerID) 
	WHEN MATCHED  
	  THEN UPDATE SET CreditLimit=source.CreditLimit
    WHEN NOT MATCHED 
	  THEN INSERT (
	   [CustomerID]
      ,[CustomerName]
      ,[BillToCustomerID]
      ,[CustomerCategoryID]
      ,[BuyingGroupID]
      ,[PrimaryContactPersonID]
      ,[AlternateContactPersonID]
      ,[DeliveryMethodID]
      ,[DeliveryCityID]
      ,[PostalCityID]
      ,[CreditLimit]
      ,[AccountOpenedDate]
      ,[StandardDiscountPercentage]
      ,[IsStatementSent]
      ,[IsOnCreditHold]
      ,[PaymentDays]
      ,[PhoneNumber]
      ,[FaxNumber]
      ,[DeliveryRun]
      ,[RunPosition]
      ,[WebsiteURL]
      ,[DeliveryAddressLine1]
      ,[DeliveryAddressLine2]
      ,[DeliveryPostalCode]
      ,[PostalAddressLine1]
      ,[PostalAddressLine2]
      ,[PostalPostalCode]
      ,[LastEditedBy])
	   VALUES  (source.CustomerID
      ,source.CustomerName
      ,source.BillToCustomerID
      ,source.CustomerCategoryID
      ,source.BuyingGroupID
      ,source.PrimaryContactPersonID
      ,source.AlternateContactPersonID
      ,source.DeliveryMethodID
      ,source.DeliveryCityID
      ,source.PostalCityID
      ,source.CreditLimit
      ,source.AccountOpenedDate
      ,source.StandardDiscountPercentage
      ,source.IsStatementSent
      ,source.IsOnCreditHold
      ,source.PaymentDays
      ,source.PhoneNumber
      ,source.FaxNumber
      ,source.DeliveryRun
      ,source.RunPosition
      ,source.WebsiteURL
      ,source.DeliveryAddressLine1
      ,source.DeliveryAddressLine2
      ,source.DeliveryPostalCode
      ,source.PostalAddressLine1
      ,source.PostalAddressLine2
      ,source.PostalPostalCode
      ,source.LastEditedBy)
	  OUTPUT  deleted.*,$action, inserted.*;

 --5. Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert

 
EXEC sp_configure 'show advanced options', 1;  
GO  

RECONFIGURE;  
GO  

EXEC sp_configure 'xp_cmdshell', 1;  
GO  

RECONFIGURE;  
GO  

SELECT @@SERVERNAME


exec master..xp_cmdshell 'bcp "[WideWorldImporters].Sales.Customers" out  "D:\SQL\Customers.txt" -T -w -t"---" -S DESKTOP-R3U1S8T\SQL2017'


CREATE TABLE [Sales].[Customers_Bulk] (
    [CustomerID] [int] NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[BillToCustomerID] [int] NOT NULL,
	[CustomerCategoryID] [int] NOT NULL,
	[BuyingGroupID] [int] NULL,
	[PrimaryContactPersonID] [int] NOT NULL,
	[AlternateContactPersonID] [int] NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[DeliveryCityID] [int] NOT NULL,
	[PostalCityID] [int] NOT NULL,
	[CreditLimit] [decimal](18, 2) NULL,
	[AccountOpenedDate] [date] NOT NULL,
	[StandardDiscountPercentage] [decimal](18, 3) NOT NULL,
	[IsStatementSent] [bit] NOT NULL,
	[IsOnCreditHold] [bit] NOT NULL,
	[PaymentDays] [int] NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[FaxNumber] [nvarchar](20) NOT NULL,
	[DeliveryRun] [nvarchar](5) NULL,
	[RunPosition] [nvarchar](5) NULL,
	[WebsiteURL] [nvarchar](256) NOT NULL,
	[DeliveryAddressLine1] [nvarchar](60) NOT NULL,
	[DeliveryAddressLine2] [nvarchar](60) NULL,
	[DeliveryPostalCode] [nvarchar](10) NOT NULL,
	[DeliveryLocation] [geography] NULL,
	[PostalAddressLine1] [nvarchar](60) NOT NULL,
	[PostalAddressLine2] [nvarchar](60) NULL,
	[PostalPostalCode] [nvarchar](10) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7)  NOT NULL)


 
BULK INSERT [WideWorldImporters].[Sales].[Customers_Bulk]
				   FROM "D:\SQL\Customers.txt"
				   WITH 
					 (
						BATCHSIZE = 1000, 
						DATAFILETYPE = 'widechar',
						FIELDTERMINATOR = '---',
						ROWTERMINATOR ='\n',
						KEEPNULLS,
						TABLOCK        
					  );



select Count(*) from [Sales].[Customers_Bulk];

TRUNCATE TABLE [Sales].[InvoiceLines_BulkDemo];