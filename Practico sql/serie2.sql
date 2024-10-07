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
Ejercicio Nº 1
Escribir una consulta que muestre todos los datos de todos los conserjes.
Registros devueltos: 220
*/
SELECT * FROM conserje

/*
Ejercicio Nº 2
Mostrar solamente el nro. de conserje (idconserje) y el nombre (apeynom).
Registros devueltos: 220
*/

select idconserje, apeynom from conserje

/*
Ejercicio Nº 3
Precedencias de operadores aritméticos. Verificar los siguientes cálculos con la sentencias
Select:
4+5*3/2-1
(4 + 5)*3/2-1
Salida Esperada: 10 y 12 
*/

SELECT 4+5*3/2-1
SELECT (4 + 5)*3/2-1

/*
Ejercicio Nº 4
Escribir una consulta que muestre el gasto de los edificios, y un incremento del 20% en 3
formatos diferentes, con las siguientes cabeceras “Sin formato”, “Redondeado a 1 digito
decimal”, “Truncado a 1 digito”. Usar función ROUND.
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
Ejercicio Nº 5
Listar el nombre (descripcion) y la población (poblacion) de cada Provincia.
Salida Esperada:
Registros devueltos: 24
*/
select descripcion, poblacion from provincia

/*
Ejercicio Nº 6
Listar sin repetir, todos los códigos de provincia de la tabla “consorcio”. Usar Clausula DISTINCT
*/
SELECT * FROM consorcio
SELECT DISTINCT idprovincia FROM consorcio

/*
Ejercicio Nº 7
Listar los 15 primeros conserjes de la respectiva tabla. Usar cláusula TOP
*/
SELECT TOP 15 idconserje FROM consorcio ORDER BY idconserje ASC

/*

Ejercicio Nº 8
Crear una consulta que muestre el Nombre y la dirección de los consorcios de la provincia de
“Buenos Aires”. Tabla a utilizar: consorcio y idprovincia = 2
*/

SELECT nombre, direccion FROM consorcio WHERE idprovincia = 2 
