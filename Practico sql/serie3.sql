/*Ejercicio 1*/

SELECT provincia, localidad, nombres, direccion, zona
FROM consorcios
WHERE zona IN (
    SELECT TOP 2 zona
    FROM consorcios
    GROUP BY zona
    ORDER BY COUNT(*) DESC
);

/*Ejercicio 2*/

WITH ProvinciaMayorHabitantes AS (
    SELECT TOP 1 provincia
    FROM provincias
    ORDER BY numero_habitantes DESC
)
SELECT c.nombre, c.edad
FROM conserjes c
WHERE c.edad > 50
AND c.consorcio_id NOT IN (
    SELECT consorcio_id
    FROM consorcios
    WHERE provincia IN (SELECT provincia FROM ProvinciaMayorHabitantes)
)
ORDER BY c.edad DESC;

/*Ejercicio 3*/

SELECT t.tipo_gasto, t.descripcion
FROM tipos_gastos t
WHERE t.tipo_gasto NOT IN (
    SELECT DISTINCT g.tipo_gasto
    FROM gastos g
    JOIN consorcios c ON g.consorcio_id = c.consorcio_id
    WHERE c.provincia = 'Buenos Aires'
    AND MONTH(g.fecha) = 2
    AND YEAR(g.fecha) = 2015
);

/*Ejercicio 5*/

SELECT p.nombre
FROM provincias p
LEFT JOIN localidades l ON p.provincia_id = l.provincia_id
WHERE l.localidad_id IS NULL;

/*Ejercicio 6*/
INSERT INTO tipos_gastos (tipo_gasto, descripcion)
VALUES ('Nuevo Gasto', 'Descripción del nuevo gasto');


/*Ejercicio 7*/

SELECT COUNT(DISTINCT c.consorcio_id) AS consorcios_con_gastos
FROM consorcios c
JOIN gastos g ON c.consorcio_id = g.consorcio_id;

/*Ejercicio 8*/

SELECT a.nombre
FROM administradores a
LEFT JOIN consorcios c ON a.admin_id = c.admin_id
WHERE c.consorcio_id IS NULL;

/*Ejercicio 9*/

WITH PromedioEdad AS (
    SELECT AVG(a.edad) AS promedio_edad
    FROM administradores a
    JOIN consorcios c ON a.admin_id = c.admin_id
)
SELECT a.nombre, a.edad
FROM administradores a
JOIN consorcios c ON a.admin_id = c.admin_id
WHERE a.edad < (SELECT promedio_edad FROM PromedioEdad);

/*Ejercicio 10*/

WITH GastoConsorcio AS (
    SELECT c.consorcio_id, SUM(g.monto) AS total_gasto
    FROM gastos g
    JOIN consorcios c ON g.consorcio_id = c.consorcio_id
    WHERE g.concepto = 'servicios'
    AND YEAR(g.fecha) = 2015
    GROUP BY c.consorcio_id
)
SELECT a.nombre, a.edad, a.direccion
FROM administradores a
JOIN consorcios c ON a.admin_id = c.admin_id
WHERE c.consorcio_id = (
    SELECT TOP 1 consorcio_id
    FROM GastoConsorcio
    ORDER BY total_gasto ASC
);

/*Ejercicio 11*/


WITH PromedioGastoSueldos AS (
    SELECT AVG(g.monto) AS promedio_gasto
    FROM gastos g
    WHERE g.concepto = 'sueldos'
    AND YEAR(g.fecha) = 2015
)
SELECT c.consorcio_id, c.nombre, SUM(g.monto) AS total_gasto_sueldos
FROM consorcios c
JOIN gastos g ON c.consorcio_id = g.consorcio_id
WHERE g.concepto = 'sueldos'
AND YEAR(g.fecha) = 2015
GROUP BY c.consorcio_id, c.nombre
HAVING SUM(g.monto) > (SELECT promedio_gasto FROM PromedioGastoSueldos);
