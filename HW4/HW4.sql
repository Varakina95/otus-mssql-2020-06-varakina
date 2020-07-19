CREATE DATABASE project
use  project


create table Partners (
id_partner int IDENTITY (1, 1) Primary key,
name_partner varchar(100),
email VARCHAR (100) NOT NULL ,
password_partner VARCHAR (100) NOT NULL,
City  VARCHAR (50),
phone_partner  VARCHAR (25),
);
create table Drivers
( id_driver int  IDENTITY (1, 1) Primary key ,
Last_name varchar(100) NOT NULL,
First_name varchar(100) NOT NULL,
DOB date ,
phone VARCHAR (25) NOT NULL ,
passport VARCHAR (50) NOT NULL,
drivers_license VARCHAR (25),
dateIssue_drivingLicense date,
id_partner int,
FOREIGN KEY (id_partner) REFERENCES Partners (id_partner)
) ;
create table driver_card (
id_card int IDENTITY (1, 1) Primary key,
phone_driver VARCHAR (25) NOT NULL,
number_card VARCHAR (50),
id_driver int,
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver),

);
create table  Driver_device (
id_device int  IDENTITY (1, 1) Primary key,
id_driver int,
phone_driver VARCHAR (25) NOT NULL,
Last_name varchar(100) NOT NULL,
First_name varchar(100) NOT NULL,
Os_device VARCHAR (25),
deviceName VARCHAR (25),
imei VARCHAR (50),
Bloock_type VARCHAR (25),
FOREIGN KEY (id_driver) REFERENCES Drivers (id_driver),
);

Alter table  Drivers
add CONSTRAINT Ck_DBO 
CHECK  (datediff(yy,Dob, getdate()) >=18);   
alter table Drivers
add constraint CK_DL 
CHECK (datediff(yy,dateIssue_drivingLicense, getdate()) >=5);

Alter table Drivers
Add constraint UQ_phone UNIQUE(phone);

Alter table Partners
add constraint UQ_email UNIQUE(Email);

alter table Driver_device
add constraint d_n default ('No') for deviceName;

create index indx_phone on Drivers (phone);
create index index_card on driver_card ( number_card);
create index indx_email on Partners (email);

                            


