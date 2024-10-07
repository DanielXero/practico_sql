/*
Create table administrador	(idadmin int identity primary key, 
					     apeynom varchar(50),
					     viveahi varchar(1)  NULL default ('N') 
						 CONSTRAINT CK_habitante_viveahi CHECK (viveahi IN ('S', 'N')),
					     tel varchar(20),
					     sexo varchar(1)  NOT NULL 
						 CONSTRAINT CK_sexo CHECK (sexo IN ('F', 'M')),
                         fechnac datetime)

go

Tabla: Administrador
Modificaciones
Columna: fechnac. Tipo de datos alfanumérico de 50 caracteres.
Restricciones
Columna: fechnac. Valores menores a 01 de enero del 1998.
Columna: viveahi. Solo valores “S” o “N”.
Columna: sexo Solo valores “M” o “F”

*/

ALTER TABLE administrador
ALTER COLUMN fechnac VARCHAR(50) NOT NULL


ALTER TABLE administrador
	WITH NOCHECK ADD CONSTRAINT CK_Administrador_fechnac CHECK (fechnac < '19980101')



-- Lote de prueba "Valores menores a 01 de enero del 1998."
-- 



/*
Create table conserje	(idconserje int identity primary key, 
					     apeynom varchar(50),
					     tel varchar(20),
						 fechnac datetime,
					     estciv varchar(1)  NULL default ('S') 
						 CONSTRAINT CK_estadocivil CHECK (estciv IN ('S', 'C','D','O')),
							 	)
go

Tabla: Conserje
Restricciones
Columna: fechnac. Valores menores a 01 de enero del 1998.
Columna: estciv. Solo valores “C”, “S”, “D”, “V”, “O”
*/

ALTER TABLE conserje
	ADD CONSTRAINT CK_Conserje_fechnac CHECK (fechnac < '19980101')



/*

Create table gasto	(
						idgasto int identity,
						idprovincia int,
                         idlocalidad int,
                         idconsorcio int, 
					     periodo int,
					     fechapago datetime,					     
						 idtipogasto int,
						 importe decimal (8,2),	
					     Constraint PK_gasto PRIMARY KEY (idgasto),
						 Constraint FK_gasto_consorcio FOREIGN KEY (idprovincia,idlocalidad,idconsorcio)  REFERENCES consorcio(idprovincia,idlocalidad,idconsorcio),
						 Constraint FK_gasto_tipo FOREIGN KEY (idtipogasto)  REFERENCES tipogasto(idtipogasto)					     					     						 					     					     
							)
go


Tabla: Gasto
Restricciones
Columna: fechapago. Superior o igual a la fecha del día.
Columna: periodo. Menor o igual al mes actual. No puede pagar un periodo que aun no haya llegado.

*/

ALTER TABLE gasto
	WITH NOCHECK ADD CONSTRAINT CK_Gasto_fechapago CHECK (fechapago >= CONVERT(datetime, GETDATE()))

--INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,6,'20140616',5,608.97)  -> Salta la retricción

ALTER TABLE gasto
	WITH NOCHECK ADD CONSTRAINT CK_Gasto_periodo CHECK (periodo <= MONTH(GETDATE()))

-- INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,11,'20261116',5,608.97) -> salta la retriccion


/*
EJERCICIO Nº 3. Escriba las sentencias necesarias para generar un lote de datos
representativos para cada tabla del modelo, a los efectos de poder evaluar el diseño
de modelo, y las restricciones aplicadas. Ingrese por lo menos, 5(cinco) registros por
cada tabla. Diseñe las sentencias para modificar datos, y borrar registros específicos.
*/

-- ************** Tabla Administrador ********************

-- Lote de prueba valido
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Perez Juan Manuel', 'N', '3794112233', 'M', '19850218')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('BASUALDO DELMIRA', 'N', '3624231689', 'F', '19801009')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('SEGOVIA ALEJANDRO H.', 'S', '3624232689', 'M', '19740602')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('ROMERO ELEUTERIO', 'N', '3624233689', 'M', '19720819')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('NAHMIAS DE K. NIDIA', 'S', '3624234689', 'F', '19711128')

-- Lote de prueba para verificar retriccion
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Perez Juan Daniel', 'N', '3794112234', 'M', '19990218')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Perez Juan Daniel', 'P', '3794112234', 'M', '19950218')
Insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Perez Juan Daniel', 'N', '3794112234', 'O', '19940218')

-- Modificar registro especificos
UPDATE administrador SET viveahi = 'S' WHERE idadmin = 1;

UPDATE administrador SET fechnac = '19880218' WHERE tel = '3794112233';

-- Eliminar registro especificos
DELETE FROM administrador WHERE idadmin = 174;

SELECT * FROM administrador


-- ************** Tabla Conserje ********************

-- Lote de prueba valido

Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('RAMIREZ JORGE ESTEBAN', '374449272', '19830910', 'S')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('ALCARAZ SONIA', '374449272', '19700710', 'C')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('ALMADA DE R. EMERENCIANA', '374449372', '19840401', 'S')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('RAMIREZ JORGE ESTEBAN', '373449472', '19690212', 'C')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('MARIN DE P. ANTOLINA', '373449572', '19950627', 'S')

-- Lote de prueba para verificar retriccion
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('SAUCEDO RAFAEL', '375449872', '19991116', 'S')
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('SAUCEDO RAFAEL', '375449872', '19921116', 'Z')

-- Modificar registro especifico
UPDATE conserje SET estciv = 'C' WHERE idconserje = 1

-- Eliminar registro especifico
DELETE FROM conserje WHERE idconserje = 220

SELECT * FROM conserje


-- ************** Tabla Consorcio ********************
-- Lote de prueba valido

INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 1, 1, 'EDIFICIO-111', 'PARAGUAY N� 630', 5, 100, 1)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (1, 2, 2, 'EDIFICIO-122', 'B� 250 VIV SEC 2 MZ 4 CSA N� 2', 5, 99, 2)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (2, 48, 1, 'EDIFICIO-2481', 'SAN LUIS N� 1035, 4� piso, Dpto c', 4, 98, 3)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (2, 55, 2, 'EDIFICIO-2552', 'REMEDIOS DE ESCALADA N� 5353', 3, 97, 4)
INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio, Nombre,direccion,idzona,idconserje,idadmin) VALUES (3, 16, 1, 'EDIFICIO-3161', 'B� VENEZUELA, GR.4, MZ.21,C.2', 2, 96, 5)

-- Modificar registro especifico
UPDATE consorcio SET direccion = 'PARAGUAY N� 640' WHERE idconsorcio = 1

-- Eliminar registro especifico
DELETE FROM consorcio WHERE idconsorcio = 10

SELECT * FROM consorcio

-- ************** Tabla Gasto ********************

-- Lote de prueba valido

INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,6,'20130616',5,608.97)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,3,'20130311',3,48026.65)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,7,'20130709',3,62573.61)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,7,'20130708',3,91137.20)
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,8,'20130814',2,3033.99)

-- Lote de prueba para verificar retriccion
INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,6,'20140616',5,608.97)

INSERT INTO gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) VALUES (1,1,1,11,'20261116',5,608.97)

-- Modificar registro especifico
UPDATE gasto SET importe = 700.00 WHERE idgasto = 1

-- Eliminar registro especifico
DELETE FROM gasto WHERE idgasto = 8003


SELECT * FROM gasto


-- ************** Tabla Inmueble ********************

-- Lote de prueba valido

INSERT INTO inmueble(idinmueble, nro_piso, dpto, sup_Cubierta, frente, balcon, idprovincia, idlocalidad, idconsorcio)VALUES(1,0,'A',85,0,0,1,1,1);
INSERT INTO inmueble(idinmueble, nro_piso, dpto, sup_Cubierta, frente, balcon, idprovincia, idlocalidad, idconsorcio)VALUES(2,0,'B',85,1,0,1,1,1);
INSERT INTO inmueble(idinmueble, nro_piso, dpto, sup_Cubierta, frente, balcon, idprovincia, idlocalidad, idconsorcio)VALUES(3,0,'C',85,1,0,1,1,1);
INSERT INTO inmueble(idinmueble, nro_piso, dpto, sup_Cubierta, frente, balcon, idprovincia, idlocalidad, idconsorcio)VALUES(4,1,'A',85,0,0,1,1,1);
INSERT INTO inmueble(idinmueble, nro_piso, dpto, sup_Cubierta, frente, balcon, idprovincia, idlocalidad, idconsorcio)VALUES(5,1,'B',85,0,0,1,1,1);

-- Modificar registro especifico
UPDATE inmueble set sup_Cubierta = 90.00 WHERE idinmueble = 1

-- Eliminar registro especifico
DELETE FROM inmueble WHERE idinmueble = 582


SELECT * FROM inmueble

-- ************** Tabla Localidad ********************

-- Lote de prueba valido

INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (2, 2, 'Alberti')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (2, 3, 'Arrecifes')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (2, 4, 'Avellaneda')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (2, 5, 'Ayacucho')
INSERT INTO localidad (idprovincia, idlocalidad, descripcion) VALUES (2, 6, 'Azul')

-- Modificar registro especifico
UPDATE localidad set descripcion = 'Avellaneda Bs. As.' WHERE idprovincia = 2 AND idlocalidad = 4

-- Eliminar registro especifico
DELETE FROM localidad WHERE idprovincia = 24 AND idlocalidad = 17 --no se puede

SELECT * FROM localidad

-- ************** Tabla provincia ********************

-- Lote de prueba valido

Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (1, 'Capital Federal',203,1,2891082,'Capital Federal')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (2, 'Buenos Aires',307571,127,15594428,'La Plata')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (3, 'Catamarca',102602,16,367820,'San Fernando del Valle de Catamarca')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (4, 'Chaco',99633,24,1053466,'Resistencia')
Insert into provincia (idprovincia, descripcion,km2,cantdptos,poblacion,nomcabe) values (5, 'Chubut',224686,15,506668,'Rawson')

-- Modificar registro especifico
UPDATE provincia set nomcabe = 'La plata Bs. As.' WHERE idprovincia = 2

-- Eliminar registro especifico
DELETE FROM provincia WHERE idprovincia = 24 -- no se puede

SELECT * FROM provincia

-- ************** Tabla TipoGasto ********************

-- Lote de prueba valido
Insert into tipogasto (idtipogasto, descripcion) values (1,'Servicios')
Insert into tipogasto (idtipogasto, descripcion) values (2,'Limpieza')
Insert into tipogasto (idtipogasto, descripcion) values (3,'Sueldos')
Insert into tipogasto (idtipogasto, descripcion) values (4,'Aportes')
Insert into tipogasto (idtipogasto, descripcion) values (5,'OTROS')


-- Modificar registro especifico
UPDATE tipogasto set descripcion = 'Otros tipos' WHERE idtipogasto = 5

-- Eliminar registro especifico
DELETE FROM tipogasto WHERE idtipogasto = 5 -- no se puede

SELECT * FROM tipogasto

-- ************** Tabla Zona ********************

-- Lote de prueba valido
Insert into zona (descripcion) values ('Centro')
Insert into zona (descripcion) values ('NORTE')
Insert into zona (descripcion) values ('SUR')
Insert into zona (descripcion) values ('ESTE')
Insert into zona (descripcion) values ('OESTE')
Insert into zona (descripcion) values ('Periferica')


-- Modificar registro especifico
UPDATE zona set descripcion = 'SUR Ar' WHERE idzona = 3

-- Eliminar registro especifico
DELETE FROM zona WHERE idzona = 6 -- no se puede

SELECT * FROM zona


/*EJERCICIO Nº 4. Inicialice las estructuras del modelo, utilizando la sentencia
TRUNCATE, y procese el lote de datos proporcionado, para incorporar los nuevos datos
del modelo. 
*/


-- Consideraciones previas

TRUNCATE TABLE gasto;

--Primero, elimina las claves foráneas:
/*ALTER TABLE consorcio DROP CONSTRAINT FK_consorcio_pcia;
ALTER TABLE consorcio DROP CONSTRAINT FK_consorcio_zona;
ALTER TABLE consorcio DROP CONSTRAINT FK_consorcio_conserje;
ALTER TABLE consorcio DROP CONSTRAINT FK_consorcio_admin;

ALTER TABLE inmueble DROP CONSTRAINT FK_inmueble_consorcio;

ALTER TABLE gasto DROP CONSTRAINT FK_gasto_consorcio;
ALTER TABLE gasto DROP CONSTRAINT FK_gasto_tipo;*/
--Después de eliminar las restricciones, ya puedes usar TRUNCATE sin problemas:
TRUNCATE TABLE consorcio;
--Volver a agregar las restricciones de clave externa
/*ALTER TABLE consorcio ADD CONSTRAINT FK_consorcio_pcia FOREIGN KEY (idprovincia, idlocalidad) REFERENCES localidad(idprovincia, idlocalidad);
ALTER TABLE consorcio ADD CONSTRAINT FK_consorcio_zona FOREIGN KEY (idzona) REFERENCES zona(idzona);
ALTER TABLE consorcio ADD CONSTRAINT FK_consorcio_conserje FOREIGN KEY (idconserje) REFERENCES conserje(idconserje);
ALTER TABLE consorcio ADD CONSTRAINT FK_consorcio_admin FOREIGN KEY (idadmin) REFERENCES administrador(idadmin);

ALTER TABLE inmueble ADD CONSTRAINT FK_inmueble_consorcio FOREIGN KEY(idprovincia, idlocalidad, idconsorcio) REFERENCES consorcio(idprovincia, idlocalidad, idconsorcio);

ALTER TABLE gasto ADD CONSTRAINT FK_gasto_consorcio FOREIGN KEY (idprovincia, idlocalidad, idconsorcio) REFERENCES consorcio(idprovincia, idlocalidad, idconsorcio);
ALTER TABLE gasto ADD CONSTRAINT FK_gasto_tipo FOREIGN KEY (idtipogasto) REFERENCES tipogasto(idtipogasto);*/

TRUNCATE TABLE inmueble;
TRUNCATE TABLE administrador;
TRUNCATE TABLE conserje;
TRUNCATE TABLE tipogasto;
TRUNCATE TABLE zona;
TRUNCATE TABLE localidad;


--ALTER TABLE localidad DROP CONSTRAINT FK_localidad_pcia;


TRUNCATE TABLE provincia;

--ALTER TABLE localidad ADD CONSTRAINT FK_localidad_pcia FOREIGN KEY (idprovincia) REFERENCES provincia(idprovincia);

