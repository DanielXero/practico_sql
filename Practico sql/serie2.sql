-- Consideraciones previas

--Eliminando retriciones
ALTER TABLE administrador
	DROP CONSTRAINT CK_Administrador_fechnac

ALTER TABLE administrador
	DROP CONSTRAINT CK_habitante_viveahi

ALTER TABLE administrador
	DROP CONSTRAINT CK_sexo



ALTER TABLE conserje
	DROP CONSTRAINT CK_Conserje_fechnac

ALTER TABLE conserje
	DROP CONSTRAINT CK_estadocivil

ALTER TABLE gasto
	DROP CONSTRAINT CK_Gasto_fechapago

ALTER TABLE gasto
	DROP CONSTRAINT CK_Gasto_periodo


/*
Ejercicio N� 1
Escribir una consulta que muestre todos los datos de todos los conserjes.
Registros devueltos: 220
*/
SELECT * FROM conserje

/*
Ejercicio N� 2
Mostrar solamente el nro. de conserje (idconserje) y el nombre (apeynom).
Registros devueltos: 220
*/

select idconserje, apeynom from conserje

/*
Ejercicio N� 3
Precedencias de operadores aritm�ticos. Verificar los siguientes c�lculos con la sentencias
Select:
4+5*3/2-1
(4 + 5)*3/2-1
Salida Esperada: 10 y 12 
*/

SELECT 4+5*3/2-1
SELECT (4 + 5)*3/2-1

/*
Ejercicio N� 4
Escribir una consulta que muestre el gasto de los edificios, y un incremento del 20% en 3
formatos diferentes, con las siguientes cabeceras �Sin formato�, �Redondeado a 1 digito
decimal�, �Truncado a 1 digito�. Usar funci�n ROUND.
*/

select * from gasto

SELECT
    idgasto,
    importe * 1.2 AS gasto_original,
    ROUND(importe * 1.2, 1) AS gasto_redondeado,
    FLOOR(importe * 1.2 * 10) / 10.0 AS gasto_truncado
FROM
    gasto;

/*
Ejercicio N� 5
Listar el nombre (descripcion) y la poblaci�n (poblacion) de cada Provincia.
Salida Esperada:
Registros devueltos: 24
*/
select descripcion, poblacion from provincia

/*
Ejercicio N� 6
Listar sin repetir, todos los c�digos de provincia de la tabla �consorcio�. Usar Clausula DISTINCT
*/
SELECT * FROM consorcio
SELECT DISTINCT idprovincia FROM consorcio

/*
Ejercicio N� 7
Listar los 15 primeros conserjes de la respectiva tabla. Usar cl�usula TOP
*/
SELECT TOP 15 idconserje FROM consorcio ORDER BY idconserje ASC

/*

Ejercicio N� 8
Crear una consulta que muestre el Nombre y la direcci�n de los consorcios de la provincia de
�Buenos Aires�. Tabla a utilizar: consorcio y idprovincia = 2
*/

SELECT nombre, direccion FROM consorcio WHERE idprovincia = 2 
