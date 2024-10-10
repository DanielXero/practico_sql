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



/*Ejercicio N� 9
Escribir y ejecutar una sentencia SELECT que devuelva los consorcios cuyo nombre comience
con EDIFICIO-3. Tabla a utilizar: consorcio, columna: nombre
*/

SELECT nombre, direccion FROM consorcio WHERE nombre LIKE '%EDIFICIO-3%'







/*
Ejercicio N� 10
Crear una consulta que muestre el nombre y apellido, tel�fono y fecha de nacimiento en una
sola columna, separados por un gui�n para todos los administradores mujeres (Sexo =F). Poner
alias �Datos personales� en la primera columna:
*/

SELECT apeynom + ' - ' + tel + ' - ' + fechnac as 'Datos Pewrsonales' FROM administrador WHERE sexo = 'F' 


/*
Ejercicio N� 11
Crear una consulta que muestre los gastos cuyos importes est�n entre 10,00 y 100,00
*/

SELECT * FROM gasto WHERE importe BETWEEN 10.00 AND 100.00







/*
Ejercicio N� 12
Crear una consulta que muestre los administradores que hayan nacido en la d�cada del 60,
ordenar el resultado por dicha fecha en forma descendente:
*/

SELECT * FROM administrador WHERE YEAR(fechnac) BETWEEN 1960 AND 1970 ORDER BY fechnac DESC



/*
Ejercicio N� 13
Crear una consulta que muestre las localidades de las provincias de capital federal y buenos
aires (1 y 2), ordenado alfab�ticamente dentro de cada provincia. 
*/

SELECT * FROM localidad WHERE idprovincia = 1 or idprovincia = 2  ORDER BY idprovincia ASC, descripcion ASC

/*
Ejercicio N� 14
Crear una consulta que muestre los datos de los consorcios cuya direcci�n contenga la letra �N�
en la Posici�n 5



*/

SELECT * FROM consorcio WHERE SUBSTRING(direccion, 5, 1) = 'N'




/*
Ejercicio N� 15
Crear una consulta para mostrar los 697 gastos m�s costosos.
*/

SELECT  TOP 697 * FROM gasto  ORDER BY importe DESC

/*
Ejercicio N� 16 (???????????????????????????????????)
Sobre la consulta anterior mostrar los importes repetidos ?????
*/

SELECT TOP 698 WITH TIES IMPORTE FROM gasto  ORDER BY importe DESC -- ???????????????????????????????????????????


/*
Ejercicio N� 17 (??????????????????????????????????)
Crear una consulta que permita calcular un incremento de 15% para los gastos menores a
10000, 10% para los que est�n entre 10000 y 20000 y un 5 % para el resto. Muestre la salida
ordenada en forma decreciente por el importe.
*/


SELECT 
    periodo, 
    fechapago, 
    importe,
    CASE 
        WHEN importe < 10000 THEN importe * 1.15  -- Incremento del 15% para gastos menores a 10000
        WHEN importe BETWEEN 10000 AND 20000 THEN importe * 1.10  -- Incremento del 10% para gastos entre 10000 y 20000
        ELSE importe * 1.05  -- Incremento del 5% para gastos mayores a 20000
    END AS 'Importe actualizado'
FROM 
    gasto
ORDER BY 
    'Importe actualizado' DESC;

/*
Ejercicio N� 18
Informar la cantidad de administradores masculinos y femeninos (sexo = �M� y sexo = �F�) 
*/
SELECT COUNT(CASE WHEN sexo = 'M' THEN 1 END) AS Masculino, COUNT(CASE WHEN sexo = 'f' THEN 1 END) AS Femenino  from administrador 

/*
Ejercicio N� 19
Informar la suma total de gastos, la cantidad de gastos y el promedio del mismo. Utilizar Sum,
Count y Avg
*/

SELECT SUM(importe) AS sumatoria, COUNT(idgasto) AS cantidad, AVG(importe) AS promedio from gasto

-- Ejercicio N� 20
/*
a) Mostrar el importe total acumulado de gasto por tipo de gasto.*/
SELECT idtipogasto, SUM(importe) as 'Importe Acumulado' FROM gasto Group By idtipogasto

/*
b) Sobre la consulta anterior, listar solo aquellos gastos cuyos importes sean superior a
2.000.000.
*/

SELECT idtipogasto, SUM(importe) as 'Importe Acumulado' FROM gasto Group By idtipogasto HAVING SUM(importe) > 2000000

/*
c) Listar solamente los dos (2) tipos de gastos con menor importe acumulado.
*/
SELECT TOP 2 idtipogasto, SUM(importe) as 'Importe Acumulado' FROM gasto Group By idtipogasto Order By 'Importe Acumulado' ASC


/*
Ejercicio N� 21
Mostrar por cada tipo de gasto, el importe del mayor gasto realizado
*/

SELECT idtipogasto, MAX(importe) as 'Gasto mayor importe' FROM gasto Group By idtipogasto

/*
Ejercicio N� 22
Mostrar el promedio de gasto por tipo de gasto, solo para aquellos pertenecientes al 1er
semestre (per�od del 1 al 6).
*/
SELECT idtipogasto, AVG(importe) as 'Promedio de gasto -1er Semestre-' FROM gasto Where periodo BETWEEN 1 AND 6  Group By idtipogasto

/*
Ejercicio N� 23
Mostrar la cantidad de consorcios concentrados por zonas. Solo para las zonas 2 (NORTE), 3
(SUR) y 4 (ESTE).
*/
SELECT idzona, COUNT(idconsorcio) as 'Cantidad consorcio por zona' FROM consorcio where idzona in(2, 3, 4) Group By idzona
SELECT idzona, COUNT(idconsorcio) as 'Cantidad consorcio por zona' FROM consorcio Group By idzona
/*
Ejercicio N� 24
Mostrar la cantidad de consorcios existentes por localidad. Visualizar la lista en forma
descendente por cantidad.
*/
SELECT idprovincia, idlocalidad, COUNT(idconsorcio) as 'Cantidad consorcio por localidad' FROM consorcio Group By idprovincia, idlocalidad Order By 'Cantidad consorcio por localidad' desc

/*
Ejercicio N� 25
Mostrar la cantidad de conserjes agrupados por estado civil y edad. Mostrar un listado
ordenado.
*/

SELECT estciv, DATEDIFF(YEAR, fechnac, GETDATE()) AS 'EDAD', COUNT(idconserje) as Cantidad from conserje Group by estciv, DATEDIFF(YEAR, fechnac, GETDATE()) Order by DATEDIFF(YEAR, fechnac, GETDATE()), Cantidad desc

/*
Ejercicio N� 26
Mostrar el importe total acumulado de gasto por tipo de gasto. Mostrar las descripciones de
cada tipo de gasto de la tabla tipogasto.
*/
SELECT tg.descripcion, SUM(g.importe) AS 'Importe Acumulado' from gasto g INNER JOIN tipogasto tg on g.idtipogasto = tg.idtipogasto GROUP BY tg.descripcion

/*
La cl�usula INNER JOIN une las tablas gasto y tipogasto seg�n la columna idtipogasto.
La funci�n SUM calcula la suma del importe de cada tipo de gasto.
La cl�usula GROUP BY agrupa las filas de la tabla seg�n la descripci�n de cada tipo de gasto (tg.descripcion).
La cl�usula ORDER BY ordena los resultados en forma descendente seg�n el importe total (importe_total DESC).
*/

/*
Ejercicio N� 27
Mostrar los nombres de todos los consorcios y en que provincia y localidad esta cada uno.
Ordenados por Provincia, localidad y consorcio*/SELECT p.descripcion AS Provincia, l.descripcion AS Localidad, c.nombre AS Consorcio from consorcio c INNER JOIN localidad l on c.idprovincia = l.idprovincia and c.idlocalidad = l.idlocalidad INNER JOIN provincia p on l.idprovincia = p.idprovincia Order By p.descripcion, l.descripcion, c.nombre  /*En este caso, eleg� poner la tabla consorcio en la cl�usula FROM porque es la tabla principal que contiene la informaci�n que queremos mostrar: los nombres de los consorcios. La consulta se centra en mostrar la informaci�n de los consorcios, por lo que es l�gico que la tabla consorcio sea la base de la consu*//*Ejercicio N� 28
Mostrar los 10 (diez) consorcios donde se registraron mayores gastos y a qu� provincia
pertenecen.*/SELECT TOP 10
    c.nombre AS Consorcio,
    p.descripcion Provincia,
    SUM(g.importe) AS 'Total Gasto'
FROM 
    gasto g
INNER JOIN 
    consorcio c ON g.idprovincia = c.idprovincia AND g.idlocalidad = c.idlocalidad AND g.idconsorcio = c.idconsorcio
INNER JOIN 
    localidad l ON c.idprovincia = l.idprovincia AND c.idlocalidad = l.idlocalidad
INNER JOIN 
    provincia p ON l.idprovincia = p.idprovincia
GROUP BY 
    c.nombre, p.descripcion
ORDER BY 
    'Total Gasto' DESC;


/*
Ejercicio N� 29
Mostrar todas las provincias registradas. Para las que tengan consorcios mostrar a qu�
localidad pertenecen. Todos con sus nombres respectivos. Ordene los resultados por Provincia,
localidad y consorcio.
*/
SELECT p.descripcion AS Provincia,
       l.descripcion AS Localidad,
       c.nombre AS Consorcio
FROM provincia p
LEFT JOIN localidad l ON p.idprovincia = l.idprovincia
LEFT JOIN consorcio c ON l.idprovincia = c.idprovincia AND l.idlocalidad = c.idlocalidad

