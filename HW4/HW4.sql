CREATE DATABASE project
use  project


CREATE TABLE Partners (
   id_partner int IDENTITY (1, 1) PRIMARY KEY,
   name_partner varchar(50),
   email varchar (100) NOT NULL ,
   password_partner varchar (100) NOT NULL,
   City  varchar (50),
   phone_partner  varchar (25),
);

CREATE TABLE Drivers( 
   id_driver int  IDENTITY (1, 1) PRIMARY KEY ,
   Last_name varchar(50) NOT NULL,
   First_name varchar(50) NOT NULL,
   DOB date ,
   phone varchar (25) NOT NULL ,
   passport varchar (50) NOT NULL,
   drivers_license varchar (25),
   dateIssue_drivingLicense date,
   id_partner int,
FOREIGN KEY (id_partner) REFERENCES Partners (id_partner)
) ;

CREATE TABLE driver_card (
   id_card int IDENTITY (1, 1) PRIMARY KEY,
   phone_driver varchar (25) NOT NULL,
   number_card varchar (50),
   id_driver int,
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver),

);
CREATE TABLE  Driver_device (
  id_device int  IDENTITY (1, 1) PRIMARY KEY,
  id_driver int,
  phone_driver varchar(25) NOT NULL,
  Last_name varchar(50) NOT NULL,
  First_name varchar(50) NOT NULL,
  Os_device varchar (25),
  deviceName varchar (25),
  imei varchar(50),
  Bloock_type varchar (25),
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver),
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

CREATE INDEX indx_phone on Drivers (phone);
CREATE INDEX index_card on driver_card ( number_card);
CREATE INDEX indx_email on Partners (email);

                            


