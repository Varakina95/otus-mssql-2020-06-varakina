--Создание правил проверки платежей водителя, по которому формируется таблица с проверками.
 --Таблица проверок, которая содержит данные о водителе, партнере и сумме платежа
CREATE TABLE #CHECK
(DriverID int,
NameDriver nvarchar(50),
NamePartner  nvarchar(50),
email  nvarchar(50),
PhoneDriver varchar(20),
Payment money)

GO

--Тригер срабатывающий на добавление платежа, где сумма парковки превышает 1000р.

CREATE TRIGGER CHECK_TIPS 
ON Payments
 AFTER INSERT
AS
 INSERT INTO #CHECK
 SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, py.Amount_payment
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Payments as Py
 ON Py.id_driver=d.id_driver
 WHERE Py.Tips_payment >=1000

 END

 INSERT INTO Payments 
 VALUES('2', '2020-11-05 19:34' , '8', '5800', ' ', ' ', '1580', 'Transfer')
 
 SELECT*  FROM #CHECK

 ---Платеж с парковкой на сумму более 1000
GO
 CREATE TRIGGER CHECK_PARKING
 ON Payments
  AFTER INSERT
 AS
 INSERT INTO #CHECK
 SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, py.Amount_payment
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Payments as Py
 ON Py.id_driver=d.id_driver
 WHERE Py.Parking_payment >= 1000

 END 
 
 INSERT INTO Payments 
 VALUES('2', '2020-12-05 19:34' , '8', '6000', ' ', '2000 ', '500', 'Transfer')

 SELECT*  FROM #CHECK

 ---Платеж бонусов на сумму более 1000 
 GO
 CREATE TRIGGER CHECK_BONUS
 ON Payments
  AFTER INSERT
 AS
 INSERT INTO #CHECK
 SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, py.Amount_payment
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Payments as Py
 ON Py.id_driver=d.id_driver
 WHERE Py.Bonus_payment >=1000 

 END

 ---Платеж на сумму более 1800 

 GO
 CREATE TRIGGER CHECK_PAY
 ON Payments
  AFTER INSERT
 AS
 INSERT INTO #CHECK
 SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, py.Amount_payment
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Payments as Py
 ON Py.id_driver=d.id_driver
 WHERE Py.Amount_payment > 1800

 END
  --Создаем таблицу, куда будут заноситься данные о заблокированых водителях
 GO
 CREATE TABLE  TableBlock(
 DriverID int,
 NameDriver nvarchar(50),
 NamePartner  nvarchar(50),
 email  nvarchar(50),
 PhoneDriver varchar(20),
 imei varchar(50));

 --Если при проверке аккаунт водителя блокируется, то в отдельную таблицу заносится информация о  данном водителе, 
 --а так же о тех водителях, которые имеют с ним одинаковый imei мобильного телефона.

 GO
 CREATE TRIGGER BLOCK_DRIVER
 ON Driver_device
 AFTER UPDATE
 AS
 INSERT INTO  TableBlock
 SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, dd.imei
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Driver_device as dd
 ON dd.id_driver =  d.id_driver
 WHERE  Bloock_type = 'block' 
END

UPDATE Driver_device 
SET Bloock_type='Block'
WHERE id_driver = 1007

INSERT INTO Driver_device
VALUES (1009, 'Android', 'Redmi 7', 'c99b63f1fb305008', ' ')

SELECT * FROM TableBlock

GO
 CREATE TRIGGER BLOCK_DRIVERIMEI
 ON Driver_device
 AFTER INSERT
 AS
 INSERT INTO  TableBlock
 SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, dd.imei
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Driver_device as dd
 ON dd.id_driver =  d.id_driver
 WHERE  EXISTS (select d1.imei, d2.imei FROM Driver_device as d1 JOIN Driver_device as d2 ON d1.id_device > d2.id_device WHERE d1.imei=d2.imei) and  Bloock_type = 'block' 
;
-- ХП для поиска водителей, которые заблокированы.
GO
CREATE PROCEDURE BlockDriver
 @BLOCKTYPE  varchar(10) 
WITH EXECUTE AS CALLER  
AS   
SET NOCOUNT ON
SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, dd.Bloock_type
FROM Drivers as D
JOIN Partner_drivers as Pd
ON d.id_driver=Pd.id_driver
JOIN Partners as Pt
ON Pt.id_partner=Pd.id_partner
JOIN Driver_device as dd
ON dd.id_driver =  d.id_driver
WHERE dd.Bloock_type = @BLOCKTYPE
GO
EXEC BlockDriver @BLOCKTYPE= block

--Если водитель совершает перевод на карту, которая привязана к аккаунту водителя, который ранее был заблокирован,
--то данные по водителю заносятся в отдельню таблицу и водитель блокируется.
GO
CREATE TRIGGER TransferBLock
ON Driver_transfer
AFTER INSERT
AS 
INSERT INTO  TableBlock
SELECT d.id_driver, (d.Last_name+d.First_name), pt.name_partner,  pt.email, d.phone, dd.imei
 FROM Drivers as D
 JOIN Partner_drivers as Pd
 ON d.id_driver=Pd.id_driver
 JOIN Partners as Pt
 ON Pt.id_partner=Pd.id_partner
 JOIN Driver_device as dd
 ON dd.id_driver =  d.id_driver
 JOIN Driver_transfer as dt
 ON dt.id_driver = d.id_driver
 JOIN driver_card as dc
 ON dc.id_card = dt.id_card
 WHERE dd.Bloock_type= 'BLOCK'
 END

 INSERT INTO Driver_transfer
 VALUES ('2020-11-05', 1002, '1000', 4, 'int', 3)

 SELECT * FROM TableBlock


