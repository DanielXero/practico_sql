---------------------
--EJERCICIO 1 ------
--------------------
/*
1) Se requiere acceder a un informe que muestre la cantidad de departamentos por piso y consorcio. 

Formato de la salida:
provincia|localidad|consorcio|piso|cantidad de departamentos|
---------+---------+---------+----+-------------------------+
*/

SELECT 
    p.descripcion AS provincia,  -- Cambié 'l' a 'p' para referenciar la provincia
    l.descripcion AS localidad,
    co.nombre AS consorcio,
    i.nro_piso AS piso,
    COUNT(i.dpto) AS cantidad_departamentos
FROM 
    inmueble i
JOIN 
    consorcio co ON i.idprovincia = co.idprovincia 
                  AND i.idlocalidad = co.idlocalidad 
                  AND i.idconsorcio = co.idconsorcio
JOIN 
    provincia p ON co.idprovincia = p.idprovincia
JOIN 
    localidad l ON co.idprovincia = l.idprovincia 
                  AND co.idlocalidad = l.idlocalidad
GROUP BY 
    p.descripcion, l.descripcion, co.nombre, i.nro_piso  -- Cambié 'c.descripcion' a 'l.descripcion'
ORDER BY 
    provincia, localidad, consorcio, piso;

--------------------
--EJERCICIO 2 ------
--------------------
/*
2) Mostrar los datos de los departamentos (Nro_piso, Dpto, Sup_cubierta, Frente, balcon), el nombre del consorcio,  y la zona a la que pertenecen. Exceptos los que estan en la zona con menor cantidad de inmuebles.

Formato de salida:
nombre   |nro_piso |dpto |sup_Cubierta |frente |balcon |idprovincia |idlocalidad |idconsorcio |idzona|
*/
WITH ZonaMenorInmuebles AS (
    SELECT 
        z.idzona
    FROM 
        inmueble i
    JOIN 
        consorcio co ON i.idprovincia = co.idprovincia 
                      AND i.idlocalidad = co.idlocalidad 
                      AND i.idconsorcio = co.idconsorcio
    JOIN 
        zona z ON co.idzona = z.idzona
    GROUP BY 
        z.idzona
    ORDER BY 
        COUNT(i.idinmueble) ASC
    OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY
)
SELECT 
    co.nombre AS nombre,
    i.nro_piso,
    i.dpto,
    i.sup_Cubierta,
    i.frente,
    i.balcon,
    i.idprovincia,
    i.idlocalidad,
    i.idconsorcio,
    z.idzona
FROM 
    inmueble i
JOIN 
    consorcio co ON i.idprovincia = co.idprovincia 
                  AND i.idlocalidad = co.idlocalidad 
                  AND i.idconsorcio = co.idconsorcio
JOIN 
    zona z ON co.idzona = z.idzona
WHERE 
    z.idzona NOT IN (SELECT idzona FROM ZonaMenorInmuebles)
ORDER BY 
    co.nombre, i.nro_piso, i.dpto;


	--------------------
--EJERCICIO 3 ------
--------------------
/*
3) Se solicita un informe, 
para conocer por cada conserje que trabaja en un consorcio, la cantidad de departamentos asignados que tiene, y la cantidad de pisos correspondientes.

Formato de salida:
apeynom     |nombre        |cantidad de pisos|Cantidad de departamentos|
------------+--------------+-----------------+-------------------------+
*/
SELECT 
c.apeynom AS apeynom,
co.nombre AS nombre,
COUNT(DISTINCT i.nro_piso) AS cantidad_de_pisos,
COUNT(i.idinmueble) AS cantidad_de_departamentos
FROM 
conserje c
JOIN 
consorcio co ON c.idconserje = co.idconserje
JOIN 
inmueble i ON co.idprovincia = i.idprovincia 
            AND co.idlocalidad = i.idlocalidad 
            AND co.idconsorcio = i.idconsorcio
GROUP BY 
c.apeynom, co.nombre
ORDER BY 
c.apeynom;




-- Consulta para consorcios sin departamentos asignados
SELECT 
    co.nombre AS nombre,
    'sin dptos' AS id_inmueble
FROM 
    consorcio co
LEFT JOIN 
    inmueble i ON co.idprovincia = i.idprovincia 
                AND co.idlocalidad = i.idlocalidad 
                AND co.idconsorcio = i.idconsorcio
WHERE 
    i.idinmueble IS NULL

UNION ALL

-- Consulta para inmuebles sin consorcio asignado
SELECT 
    'sin consorcios' AS nombre,
    CAST(i.idinmueble AS VARCHAR(10)) AS id_inmueble  -- Convertir idinmueble a VARCHAR
FROM 
    inmueble i
LEFT JOIN 
    consorcio co ON i.idprovincia = co.idprovincia 
                  AND i.idlocalidad = co.idlocalidad 
                  AND i.idconsorcio = co.idconsorcio
WHERE 
    co.idconsorcio IS NULL;



--------------------
--EJERCICIO 5 ------
--------------------

/*
5) Generar un informe donde se muestre por cada consorcio, el total de gasto generado, el promedio de gasto, y la cantidad de gastos realizados. 
Visualizar solamente los consorcios con más de 42 gastos realizados.

nombre    |total de gasto generado|promedio de gasto|Cantidad de Gastos|
----------+-----------------------+-----------------+------------------+
*/

SELECT 
    consorcio.nombre AS nombre,
    SUM(gasto.importe) AS total_de_gasto_generado,
    AVG(gasto.importe) AS promedio_de_gasto,
    COUNT(gasto.idgasto) AS cantidad_de_gastos
FROM 
    consorcio
JOIN 
    gasto ON consorcio.idprovincia = gasto.idprovincia 
           AND consorcio.idlocalidad = gasto.idlocalidad 
           AND consorcio.idconsorcio = gasto.idconsorcio
GROUP BY 
    consorcio.nombre
HAVING 
    COUNT(gasto.idgasto) > 42
ORDER BY 
    cantidad_de_gastos DESC;


--------------------
--EJERCICIO 6 ------
--------------------
--Mostrar todos los consorcios (solo sus nombres) y todos los inmuebles (solo su ID).
--Organizando primero los consorcios sin inmuebles asignados, luego los inmuebles sin 
--consorcios y después el resto.
-- Consorcios sin inmuebles asignados
SELECT 
    consorcio.nombre AS nombre,
    NULL AS id_inmueble
FROM 
    consorcio
LEFT JOIN 
    inmueble ON consorcio.idprovincia = inmueble.idprovincia 
              AND consorcio.idlocalidad = inmueble.idlocalidad 
              AND consorcio.idconsorcio = inmueble.idconsorcio
WHERE 
    inmueble.idinmueble IS NULL

UNION ALL

-- Inmuebles sin consorcios asignados
SELECT 
    'sin consorcio' AS nombre,
    inmueble.idinmueble AS id_inmueble
FROM 
    inmueble
LEFT JOIN 
    consorcio ON inmueble.idprovincia = consorcio.idprovincia 
               AND inmueble.idlocalidad = consorcio.idlocalidad 
               AND inmueble.idconsorcio = consorcio.idconsorcio
WHERE 
    consorcio.idconsorcio IS NULL

UNION ALL

-- Consorcios con inmuebles asignados
SELECT 
    consorcio.nombre AS nombre,
    inmueble.idinmueble AS id_inmueble
FROM 
    consorcio
JOIN 
    inmueble ON consorcio.idprovincia = inmueble.idprovincia 
              AND consorcio.idlocalidad = inmueble.idlocalidad 
              AND consorcio.idconsorcio = inmueble.idconsorcio
ORDER BY 
    nombre, id_inmueble;


--------------------
--EJERCICIO 7 ------
--------------------
--Usando subconsulta, mostrar todos los consorcios que no tienen inmuebles asignados.
SELECT 
    consorcio.nombre 
FROM 
    consorcio
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM inmueble 
        WHERE consorcio.idprovincia = inmueble.idprovincia 
              AND consorcio.idlocalidad = inmueble.idlocalidad 
              AND consorcio.idconsorcio = inmueble.idconsorcio
    );


--------------------
--EJERCICIO 8 ------
--------------------
--Mostrar en una sola línea la cantidad de Departamentos/inmuebles con 1, 2, 3 y 4 o más
--pisos que estén asignados a algún consorcio. 
-- Respetando  el siguiente formato:
--Cantidad						UnPiso	DosPisos	TresPisos	Masdetrespisos
--Cantidad inmuebles por piso  	0			0			0			0

SELECT 
    'Cantidad inmuebles por piso' AS Cantidad,
    SUM(CASE WHEN nro_piso = 1 THEN 1 ELSE 0 END) AS UnPiso,
    SUM(CASE WHEN nro_piso = 2 THEN 1 ELSE 0 END) AS DosPisos,
    SUM(CASE WHEN nro_piso = 3 THEN 1 ELSE 0 END) AS TresPisos,
    SUM(CASE WHEN nro_piso >= 4 THEN 1 ELSE 0 END) AS MasDeTresPisos
FROM 
    inmueble
WHERE 
    idprovincia IS NOT NULL 
    AND idlocalidad IS NOT NULL 
    AND idconsorcio IS NOT NULL;