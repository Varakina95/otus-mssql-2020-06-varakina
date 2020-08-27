
--1. Загрузить данные из файла StockItems.xml в таблицу Warehouse.StockItems.
--Существующие записи в таблице обновить, отсутствующие добавить (сопоставлять записи по полю StockItemName).
--Файл StockItems.xml в личном кабинете.

--DECLARE @x XML
--SET @x = ( 
--  SELECT * FROM OPENROWSET
--  (BULK '‪C:\temp\StockItems-188-f89807.xml',
--   SINGLE_BLOB)
--   as d)
--SELECT @X xIMPORTXML

DECLARE @XML_Stock varchar(max);
DECLARE @X int;

SET @XML_Stock=N'<StockItems>
<Item Name="&quot;The Gu&quot; red shirt XML tag t-shirt (Black) 3XXL">
<SupplierID>4</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>6</OuterPackageID>
<QuantityPerOuter>12</QuantityPerOuter>
<TypicalWeightPerUnit>0.400</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>7</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>18.000000</UnitPrice>
</Item>
<Item Name="Developer joke mug (Yellow)">
<SupplierID>5</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>10</QuantityPerOuter>
<TypicalWeightPerUnit>0.600</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>12</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>1.500000</UnitPrice>
</Item>
<Item Name="Dinosaur battery-powered slippers (Green) L">
<SupplierID>4</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>1</QuantityPerOuter>
<TypicalWeightPerUnit>0.350</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>12</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>16.000000</UnitPrice>
</Item>
<Item Name="Dinosaur battery-powered slippers (Green) M">
<SupplierID>4</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>1</QuantityPerOuter>
<TypicalWeightPerUnit>0.350</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>12</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>48.000000</UnitPrice>
</Item>
<Item Name="Dinosaur battery-powered slippers (Green) S">
<SupplierID>4</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>1</QuantityPerOuter>
<TypicalWeightPerUnit>0.350</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>12</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>32.000000</UnitPrice>
</Item>
<Item Name="Furry gorilla with big eyes slippers (Black) XL">
<SupplierID>4</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>1</QuantityPerOuter>
<TypicalWeightPerUnit>0.400</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>12</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>32.000000</UnitPrice>
</Item>
<Item Name="Large replacement blades 18mm">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>10</QuantityPerOuter>
<TypicalWeightPerUnit>0.800</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>21</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>2.450000</UnitPrice>
</Item>
<Item Name="Large sized bubblewrap roll 50m">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>10</QuantityPerOuter>
<TypicalWeightPerUnit>10.000</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>36.000000</UnitPrice>
</Item>
<Item Name="Medium sized bubblewrap roll 20m">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>10</QuantityPerOuter>
<TypicalWeightPerUnit>6.000</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>20.000000</UnitPrice>
</Item>
<Item Name="Shipping carton (Brown) 356x229x229mm">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>25</QuantityPerOuter>
<TypicalWeightPerUnit>0.400</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>1.140000</UnitPrice>
</Item>
<Item Name="Shipping carton (Brown) 356x356x279mm">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>25</QuantityPerOuter>
<TypicalWeightPerUnit>0.300</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>3.060000</UnitPrice>
</Item>
<Item Name="Shipping carton (Brown) 413x285x187mm">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>25</QuantityPerOuter>
<TypicalWeightPerUnit>0.350</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>0.335000</UnitPrice>
</Item>
<Item Name="Shipping carton (Brown) 457x279x279mm">
<SupplierID>7</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>25</QuantityPerOuter>
<TypicalWeightPerUnit>0.400</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>1.920000</UnitPrice>
</Item>
<Item Name="USB food flash drive - sushi roll">
<SupplierID>12</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>1</QuantityPerOuter>
<TypicalWeightPerUnit>0.050</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>32.000000</UnitPrice>
</Item>
<Item Name="USB missile launcher (Green)">
<SupplierID>12</SupplierID>
<Package>
<UnitPackageID>7</UnitPackageID>
<OuterPackageID>7</OuterPackageID>
<QuantityPerOuter>1</QuantityPerOuter>
<TypicalWeightPerUnit>0.300</TypicalWeightPerUnit>
</Package>
<LeadTimeDays>14</LeadTimeDays>
<IsChillerStock>0</IsChillerStock>
<TaxRate>20.000</TaxRate>
<UnitPrice>25.000000</UnitPrice>
</Item>
</StockItems>';

EXEC sp_xml_preparedocument @x OUTPUT, @XML_Stock

MERGE Warehouse.StockItems as target
USING (
SELECT *
FROM OPENXML(@x, N'/StockItems/Item')
WITH ( 
	[StockItemName] nvarchar(20) '@Name',
	[SupplierID] int 'SupplierID',
	[UnitPackageID] int 'Package/UnitPackageID',
	[OuterPackageID]   int  'Package/OuterPackageID',
	[QuantityPerOuter] int 'Package/QuantityPerOuter',
	[TypicalWeightPerUnit] decimal(18,3) 'Package/TypicalWeightPerUnit',
	[LeadTimeDays] int 'LeadTimeDays',
	[IsChillerStock] bit 'IsChillerStock',
	[TaxRate] decimal(18,3) 'TaxRate',
	[UnitPrice] decimal(18,2) 'UnitPrice'
))  as source ON target.StockItemName=source.StockItemName
WHEN MATCHED 
THEN UPDATE SET 
	target.SupplierID=source.SupplierId,
	target.UnitPackageID=source.UnitPackageID,
	target.OuterPackageID=source.OuterPackageID,
	target.QuantityPerOuter=source.QuantityPerOuter,
	target.TypicalWeightPerUnit=source.TypicalWeightPerUnit,
	target.LeadTimeDays=source.LeadTimeDays,
	target.IsChillerStock=source.IsChillerStock,
	target.TaxRate=source.TaxRate,
	target.UnitPrice=source.UnitPrice
WHEN NOT MATCHED 
THEN INSERT([StockItemName],[SupplierID],[UnitPackageID],[OuterPackageID],[QuantityPerOuter],[TypicalWeightPerUnit],[LeadTimeDays],[IsChillerStock],[TaxRate],[UnitPrice],[LastEditedBy]) 
VALUES (source.StockItemName, source.SupplierId,source.UnitPackageID, source.OuterPackageID,source.QuantityPerOuter, source.TypicalWeightPerUnit,source.LeadTimeDays,source.IsChillerStock, source.TaxRate,source.UnitPrice,1)
OUTPUT  deleted.*,$action, inserted.*;


--2. Выгрузить данные из таблицы StockItems в такой же xml-файл, как StockItems.xml

--Примечания к заданиям 1, 2:
--* Если с выгрузкой в файл будут проблемы, то можно сделать просто SELECT c результатом в виде XML.
--* Если у вас в проекте предусмотрен экспорт/импорт в XML, то можете взять свой XML и свои таблицы.
--* Если с этим XML вам будет скучно, то можете взять любые открытые данные и импортировать их в таблицы (например, с https://data.gov.ru).

SELECT top 10
StockItemName as [@Name] ,
SupplierID as  [SupplierID],
UnitPackageID as [Package/UnitPackageID],
OuterPackageID as [Package/OuterPackageID] ,
QuantityPerOuter as [Package/QuantityPerOuter],
IsChillerStock as [Package/IsChillerStock] ,
UnitPrice as [UnitPrice] ,
TaxRate as [TaxRate]
FROM Warehouse.StockItems
FOR XML PATH('Item'), ROOT('StockItems')




--3. В таблице Warehouse.StockItems в колонке CustomFields есть данные в JSON.
--Написать SELECT для вывода:
--- StockItemID
--- StockItemName
--- CountryOfManufacture (из CustomFields)
--- FirstTag (из поля CustomFields, первое значение из массива Tags)

SELECT StockItemID,
       StockItemName,
       JSON_VALUE (CustomFields, '$.CountryOfManufacture') as CountryOfManufacture,
	   JSON_VALUE (CustomFields, '$.Tags[0]') as FirstTag
	   FROM Warehouse.StockItems
	  

--4. Найти в StockItems строки, где есть тэг "Vintage".
--Вывести:
--- StockItemID
--- StockItemName
--- (опционально) все теги (из CustomFields) через запятую в одном поле

--Тэги искать в поле CustomFields, а не в Tags.
--Запрос написать через функции работы с JSON.
--Для поиска использовать равенство, использовать LIKE запрещено.


SELECT
    StockItemID,
	StockItemName,
    JSON_QUERY(CustomFields, '$.Tags') AS Tags,
	t.[key],
	t.value 
FROM Warehouse.StockItems
CROSS APPLY OPENJSON(CustomFields, '$.Tags') as t
WHERE t.value = 'Vintage'


--5. Пишем динамический PIVOT.
--По заданию из занятия “Операторы CROSS APPLY, PIVOT, CUBE”.
--Требуется написать запрос, который в результате своего выполнения формирует таблицу следующего вида:
--Название клиента
--МесяцГод Количество покупок

--Нужно написать запрос, который будет генерировать результаты для всех клиентов.
--Имя клиента указывать полностью из CustomerName.
--Дата должна иметь формат dd.mm.yyyy например 01.12.2019

DECLARE @query nVARCHAR(max)
DECLARE @Name nVARCHAR(max)

SELECT @Name =  STUFF(( SELECT DISTINCT '],[' + CustomerName FROM Sales.Customers 
    FOR XML PATH('') ),1,2,'') + ']';

SET @query = 'SELECT  Date, ' + @Name + ' FROM 
(SELECT c.CustomerName,
        CONVERT(varchar, InvoiceDate, 104) as Date,
	    i.InvoiceID
FROM Sales.Customers as c
JOIN Sales.Invoices as i
ON c.CustomerID = i.CustomerID) as t
PIVOT (count (InvoiceID) 
FOR  CustomerName IN (' + @Name + ')) as pvt
ORDER BY Date'


EXEC (@query);