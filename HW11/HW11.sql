exec sp_configure 'show advanced options', 1;
go
reconfigure;
go

exec sp_configure 'clr enabled', 1;
exec sp_configure 'clr strict security', 0 
go

reconfigure;
go

ALTER DATABASE WideWorldImporters SET TRUSTWORTHY ON; 

CREATE ASSEMBLY HWCLR
FROM 'C:\Users\User\source\repos\HW\HW\bin\Debug\HW.dll'
WITH PERMISSION_SET = SAFE;
GO

CREATE FUNCTION SplitString (@text nvarchar(max), @delimiter nchar(1))
RETURNS TABLE (
part nvarchar(max),
ID_ODER int
) WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [HWCLR].[HW.UserDefinedFunctions].[SplitString];
GO

SELECT part Into #HWCLR FROM SplitString('1,3,5,7,9', ',')
SELECT * FROM #HWCLR