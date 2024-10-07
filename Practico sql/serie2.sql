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
Registros devueltos: 220*/
SELECT * FROM conserje

/*
Ejercicio Nº 2
Mostrar solamente el nro. de conserje (idconserje) y el nombre (apeynom).
Registros devueltos: 220*/

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




