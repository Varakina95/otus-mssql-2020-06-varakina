DECLARE @X XML,  @XML_Stock int;
SET @X = (SELECT * FROM OPENROWSET (BULK 'C:\temp\StockItems-188-f89807.xml', SINGLE_BLOB) as data)
SELECT @X xIMPORTXML 


EXEC sp_xml_preparedocument @XML_Stock OUTPUT, @X

MERGE Warehouse.StockItems as target
USING (
SELECT *
FROM OPENXML(@XML_Stock, N'/StockItems/Item')
WITH ( 
	[StockItemName] nvarchar(50) '@Name',
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
VALUES ( source.StockItemName, source.SupplierId,source.UnitPackageID, source.OuterPackageID,source.QuantityPerOuter, source.TypicalWeightPerUnit,source.LeadTimeDays,source.IsChillerStock, source.TaxRate,source.UnitPrice,1)
OUTPUT  deleted.*,$action, inserted.*;

