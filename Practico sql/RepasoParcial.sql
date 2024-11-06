
-- Subconsultas

--¿Cuál es el año de lanzamiento más antiguo de un show en la plataforma?
select titulo, año_lanzamiento from show where año_lanzamiento = (select MIN(año_lanzamiento) from show) 
-- resultado = 1925

--¿Cuántos shows hay de cada tipo (tipo_show) en la plataforma?

select t.descripcion, (select COUNT (*) from show s where s.id_tipo = t.id_tipo) as cantidad_shows from tipo_show t 

-- Resultado: movie 6131 y tv show 2676


--¿Cuáles shows tienen la misma clasificación de rating que otro show específico (por ejemplo, "Stranger Things")?


SELECT titulo
FROM show
WHERE id_rating = (SELECT id_rating
                   FROM show
                   WHERE titulo = 'Stranger Things');
-- Resultado: 2160 registros 


-- Inner join

/*-
¿Cuáles son los nombres de los directores y los títulos de los shows que dirigieron?*/
select d.nombre_apellido, s.titulo  from director d
inner join show_director sd on d.id_director = sd.id_director
inner join show s on sd.id_show = s.id_show

-- Resultado: 6927 registros

/*
¿Cuáles son los shows y sus respectivos tipos de show?*/
select s.titulo, t.descripcion  from show s inner join tipo_show t on s.id_tipo = t.id_tipo
select s.titulo, t.descripcion  from show s inner join tipo_show t on s.id_tipo = t.id_tipo group by s.titulo, t.descripcion

-- Resultado:  8807 registros

-- left join

/*  ¿Cuáles son los títulos de los shows y sus respectivos ratings, incluyendo los shows que no tienen un rating asignado?*/

select s.titulo, r.descripcion  from show s left join rating r on s.id_rating = r.id_rating
-- Resultado:  8807 registros
/*
¿Cuáles son los shows y las categorías asociadas, incluyendo los shows que no están asociados con ninguna categoría?
*/

select s.titulo, c.descripcion  from show s 
left join show_categoria sc on s.id_show = sc.id_show
left join categoria c on sc.id_categoria = c.id_categoria

-- Resultado:  19323 registros

/*
¿Cuáles son los actores y los shows en los que han participado, incluyendo los actores que no están asociados con ningún show?
*/
select a.nombre_apellido from actor a
left join elenco e on a.id_actor = e.id_actor

-- Resultado:  64124 registros


/*
¿Cuántos shows están disponibles en más de un país?
es decir la cantidad show que esta disponible en mas de un pasi
*/

SELECT COUNT(*) as shows_en_multiples_paises
FROM (
    SELECT id_show
    FROM show_pais
    GROUP BY id_show
    HAVING COUNT( distinct id_pais) > 1
) as subquery;

-- Resultado:  1315

/*
¿Cuál es el tipo de show con el mayor número de shows?
*/

-- Es decir que categoria tiene la mayor cantidad de show movie o tv show

select t.descripcion, COUNT(s.id_show) from show s inner join tipo_show t on s.id_tipo = t.id_tipo group by t.descripcion order by COUNT(s.id_show) desc

SELECT t.descripcion AS tipo_show, COUNT(s.id_show) AS cantidad_shows
FROM show s
INNER JOIN tipo_show t ON s.id_tipo = t.id_tipo
GROUP BY t.descripcion
ORDER BY cantidad_shows DESc

SELECT ts.descripcion as tipo_show, COUNT(s.id_show) as cantidad_shows
FROM tipo_show ts
LEFT JOIN show s ON ts.id_tipo = s.id_tipo
GROUP BY ts.descripcion
ORDER BY COUNT(s.id_show) DESC;

-- Resultado:  movies 6131 tv show 2676 


/*


/*
¿Qué director tiene el mayor número de shows dirigidos?
*/
*/

select top 1 d.nombre_apellido, COUNT(sd.id_show) as numeros_shows  from director d inner join show_director sd on d.id_director = sd.id_director group by d.nombre_apellido order by numeros_shows desc

-- Resultado:  Rajiv Chilaka - 22

/*
¿Cuáles son los actores que no han participado en ningún show?
*/
select a.nombre_apellido  from actor a left join elenco e on a.id_actor = e.id_actor where e.id_show is null

SELECT a.nombre_apellido
FROM actor a
LEFT JOIN elenco e ON a.id_actor = e.id_actor
WHERE e.id_show IS NULL;

-- resultado vacio: vacio


/*
-Cantidad de directores con mas de 10 películas o series dirigidas
-El actor con mayor participación en películas o series
-Cantidad de series añadidas en los últimos cinco años
*/
--Cantidad de directores con mas de 10 películas o series dirigidas

select count (*) as cantidad_directores from (
select d.id_director from director d inner join show_director sd on d.id_director = sd.id_director group by d.id_director having COUNT(sd.id_show) > 10  ) as directores_con_mas_10shows

-- resultado: 11

--El actor con mayor participación en películas o series
SELECT TOP 1 
    a.nombre_apellido,
    COUNT(e.id_show) as cantidad_shows
FROM actor a
INNER JOIN elenco e ON a.id_actor = e.id_actor
GROUP BY a.id_actor, a.nombre_apellido
ORDER BY cantidad_shows DESC

-- resultado: Anupam Kher 43

--El actor con mayor participación en películas o series

select top 1 a.nombre_apellido, COUNT(e.id_show) as cantidad_shows from actor a inner join elenco e on a.id_actor = e.id_actor group by a.nombre_apellido order by cantidad_shows desc

--Cantidad de series añadidas en los últimos cinco años
select COUNT (*) as cantidad_series from show s inner join tipo_show ts on s.id_tipo = ts.id_tipo where ts.descripcion = 'Tv Show' and año_lanzamiento > YEAR(GETDATE()) - 5

-- resultado: 751

select * from director


/*
Ejercicio 1
Mostrar todos los géneros (categorias, solo sus descripciones) y todos los shows (solo sus IDs), organizando primero las categorías sin shows asignados, luego los shows sin categorías y después el resto.

*/
SELECT 
    COALESCE(c.descripcion, 'SIN CATEGORIA') AS categoria,
    COALESCE(s.id_show, 'SIN SHOW') AS id_show
FROM categoria c
FULL OUTER JOIN show_categoria sc ON c.id_categoria = sc.id_categoria
FULL OUTER JOIN show s ON sc.id_show = s.id_show
ORDER BY 
    CASE 
        WHEN c.descripcion IS NOT NULL AND s.id_show IS NULL THEN 1
        WHEN c.descripcion IS NULL AND s.id_show IS NOT NULL THEN 2
        ELSE 3
    END,
    c.descripcion,
    s.id_show

-- resultado 19323 registros
/*

Ejercicio 2
Usando una subconsulta, mostrar todas las categorías que no tienen shows asignados.
*/
SELECT descripcion
FROM categoria 
WHERE id_categoria NOT IN (
    SELECT DISTINCT id_categoria 
    FROM show_categoria
);

SELECT descripcion
FROM categoria c
WHERE NOT EXISTS (
    SELECT 1 
    FROM show_categoria sc 
    WHERE sc.id_categoria = c.id_categoria
);

SELECT c.descripcion
FROM categoria c
LEFT JOIN show_categoria sc ON c.id_categoria = sc.id_categoria
WHERE sc.id_categoria IS NULL;


-- resultado:  vacio

/*
Ejercicio 3
Mostrar en una sola línea la cantidad de shows con 1, 2, 3, y 4 o más temporadas, respetando el siguiente formato:
Cantidad Temporada1 Temporada2 Temporada3 MasdetresTemporadas
*/

SELECT 
    COUNT(CASE WHEN duracion = '1 Season' THEN 1 END) AS Temporada1,
    COUNT(CASE WHEN duracion = '2 Seasons' THEN 1 END) AS Temporada2,
    COUNT(CASE WHEN duracion = '3 Seasons' THEN 1 END) AS Temporada3,
    COUNT(CASE WHEN duracion NOT IN ('1 Season', '2 Seasons', '3 Seasons') THEN 1 END) AS MasdetresTemporadas
FROM show;

/*
Resultados
Temporada1	Temporada2	Temporada3	MasdetresTemporadas
1793		425			199			6387
*/
select * from show

/*

Ejercicio 4
Generar un informe que muestre la cantidad de shows por año de lanzamiento y categoría.
*/
SELECT 
    s.año_lanzamiento,
    c.descripcion AS categoria,
    COUNT(*) AS cantidad_shows
FROM 
    show s
JOIN 
    show_categoria sc ON s.id_show = sc.id_show
JOIN 
    categoria c ON sc.id_categoria = c.id_categoria
GROUP BY 
    s.año_lanzamiento, c.descripcion
ORDER BY 
    s.año_lanzamiento DESC, c.descripcion ASC;

-- resultados 1192 registros
/*
Ejercicio 5
Mostrar los datos de los shows (título, año de lanzamiento, duración), el nombre del director, y el país al que pertenecen, excepto aquellos que están en el país con menor cantidad de shows.
*/
SELECT DISTINCT
    s.titulo,
    s.año_lanzamiento,
    s.duracion,
    d.nombre_apellido AS director,
    p.descripcion AS pais
FROM 
    show s
JOIN 
    show_director sd ON s.id_show = sd.id_show
JOIN 
    director d ON sd.id_director = d.id_director
JOIN 
    show_pais sp ON s.id_show = sp.id_show
JOIN 
    pais p ON sp.id_pais = p.id_pais
WHERE 
    p.id_pais NOT IN (
        SELECT TOP 1 sp2.id_pais
        FROM show_pais sp2
        GROUP BY sp2.id_pais
        ORDER BY COUNT(*) ASC
    )
ORDER BY 
    s.año_lanzamiento DESC, s.titulo ASC;


-- resultado 8408 registros