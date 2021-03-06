CREATE DATABASE project
use  project


CREATE TABLE Partners (
   id_partner int IDENTITY (1, 1) PRIMARY KEY,
   name_partner nvarchar(50),
   email varchar (100) NOT NULL ,
   password_partner nvarchar (100) NOT NULL,
   City  nvarchar (50),
   phone_partner  varchar (25),
);


CREATE TABLE Drivers( 
   id_driver int  IDENTITY (1, 1) PRIMARY KEY ,
   Last_name nvarchar(50) NOT NULL,
   First_name nvarchar(50) NOT NULL,
   DOB date ,
   phone varchar (25) NOT NULL ,
   passport nvarchar (50) NOT NULL,
   drivers_license nvarchar (25),
   dateIssue_drivingLicense date,
   id_partner int,
FOREIGN KEY (id_partner) REFERENCES Partners (id_partner)
) ;

CREATE TABLE Partner_drivers (
id_PartnerDrivers int  IDENTITY (1, 1) PRIMARY KEY ,
id_driver int,
id_partner int,
connection_date date,
FOREIGN KEY (id_partner) REFERENCES Partners (id_partner),
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver)
);

CREATE TABLE driver_card (
   id_card int IDENTITY (1, 1) PRIMARY KEY,
   phone_driver varchar (25) NOT NULL,
   number_card varchar (50),
   id_driver int,
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver)
);


CREATE TABLE  Driver_device (
  id_device int  IDENTITY (1, 1) PRIMARY KEY,
  id_driver int,
  Os_device varchar (25),
  deviceName varchar (25),
  imei varchar(50),
  Bloock_type varchar (25),
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver)
);


CREATE TABLE Driver_checks (
id_checks int  IDENTITY (1, 1) PRIMARY KEY,
id_driver int,
�heck_name nvarchar(50)  NOT NULL,
Check_start datetime,
Check_end datetime,
Employee_name nvarchar(50),
Result nvarchar(20),
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver)
);


CREATE TABLE  Payments (
id_Payment int  IDENTITY (1, 1) PRIMARY KEY,
id_driver int,
payment_date datetime,
Id_orders int,
Amount_payment money,
Bonus_payment  money,
Parking_payment money,
Tips_payment money,   
Status_payment  varchar(15),
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver)
);


ALTER TABLE Payments
ADD FOREIGN KEY (Id_orders) REFERENCES Orders (Id_orders);   

CREATE TABLE Driver_transfer (
id_transfer int  IDENTITY (1, 1) PRIMARY KEY,
Date_transfer date,
id_driver int,
Transfer_amount money,
id_card int,
Status_transfer  varchar(15),
id_Payment int
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver),
FOREIGN KEY (id_card) REFERENCES driver_card (id_card),
FOREIGN KEY(id_Payment) REFERENCES  Payments (id_Payment)
);



CREATE TABLE Orders
(
Id_orders int  IDENTITY (1, 1) PRIMARY KEY,
Date_Completion datetime,
Order_price money,
Aggregator varchar(20),
Order_number varchar(25),
Distance varchar(20),
Time_Orders time
);


ALTER TABLE  Drivers
ADD  CONSTRAINT Ck_DBO 
CHECK  (datediff(yy,Dob, getdate()) >=18);   

ALTER TABLE Drivers
ADD  CONSTRAINT CK_DL 
CHECK (datediff(yy,dateIssue_drivingLicense, getdate()) >=5);

ALTER TABLE Drivers
 ADD  CONSTRAINT UQ_phone UNIQUE(phone);

ALTER TABLE Partners
 ADD  CONSTRAINT UQ_email UNIQUE(Email);

ALTER TABLE Driver_device
 ADD  CONSTRAINT d_n DEFAULT ('No') for deviceName;


