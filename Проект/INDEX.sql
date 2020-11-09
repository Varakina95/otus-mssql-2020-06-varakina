
CREATE NONCLUSTERED INDEX indx_phone ON Drivers (phone);
CREATE NONCLUSTERED INDEX index_card ON driver_card ( number_card);
CREATE NONCLUSTERED INDEX indx_email ON Partners (email);
CREATE NONCLUSTERED INDEX indx_Block ON Driver_device (Bloock_type);

SELECT Last_name,First_name,number_card
FROM Drivers as d
JOIN  driver_card as c
ON d.id_driver = c.id_driver
WHERE phone ='79066080055'

SELECT number_card, phone, d.id_driver
FROM driver_card as c
JOIN Drivers as d 
ON   d.id_driver = c.id_driver
JOIN  Driver_device as d1
ON d1.id_driver =d.id_driver
JOIN Partners as p
ON  p.id_partner = d.id_partner
WHERE p.email = 'OOO.VIS.Moskva.m@yandex.ru'

SELECT Last_name,First_name,phone,number_card, name_partner
FROM Drivers as d
JOIN  Driver_device as d1  
ON d.id_driver = d1.id_driver 
JOIN  driver_card as c
ON c.id_driver =d.id_driver
JOIN Partners as p
ON  p.id_partner = d.id_partner
WHERE Bloock_type ='block' 

SELECT Last_name,First_name,phone,number_card, name_partner
FROM Drivers as d
JOIN  Driver_device as d1  
ON d.id_driver = d1.id_driver
JOIN Partners as p
ON  p.id_partner = d.id_partner
LEFT JOIN  driver_card as c
ON c.id_driver =d.id_driver
WHERE number_card in ( SELECT number_card FROM  driver_card GROUP BY  number_card  HAVING COUNT(*) > 1)