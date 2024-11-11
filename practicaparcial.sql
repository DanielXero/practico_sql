--¿Cuántos actores participaron en mas de 5 shows que se lanzaron en el año 2020?

select a.nombre_apellido, COUNT(s.id_show) as cantidadshows from actor a inner join elenco e on a.id_actor = e.id_actor
inner join show s on e.id_show = s.id_show where s.año_lanzamiento = 2020 group by a.nombre_apellido having  COUNT(s.id_show) > 5 order by cantidadshows desc

select count(*) as cantidad_actores from (select a.nombre_apellido, COUNT(s.id_show) as cantidadshows from actor a inner join elenco e on a.id_actor = e.id_actor
inner join show s on e.id_show = s.id_show where s.año_lanzamiento = 2020 group by a.nombre_apellido having  COUNT(s.id_show) > 5) as subconsulta

-- Resultado = 2


--- ¿Cuántos actores participaron en mas de 10 shows que se lanzaron en el año 2016?
select a.nombre_apellido, COUNT(s.id_show) as cantidad_shows from actor a inner join elenco e on a.id_actor = e.id_actor inner join show s on e.id_show = s.id_show 
where s.año_lanzamiento = 2016 group by a.nombre_apellido having  COUNT(s.id_show) > 10 order by cantidad_shows desc

select COUNT(*) as cantidad_actores from (select a.nombre_apellido, COUNT(s.id_show) as cantidad_shows from actor a inner join elenco e on a.id_actor = e.id_actor inner join show s on e.id_show = s.id_show 
where s.año_lanzamiento = 2016 group by a.nombre_apellido having  COUNT(s.id_show) > 10) as subconsulta

-- Resultado = 0 

-- ¿Cuántos actores participaron en más de 3 shows que se lanzaron en el año 2017?

select a.nombre_apellido, count(s.id_show) as cantidad_shows from actor a inner join elenco e on a.id_actor = e.id_actor inner join show s on e.id_show = s.id_show 
where s.año_lanzamiento = 2017 group by a.nombre_apellido having count(s.id_show) > 3 order by cantidad_shows desc

select COUNT(*) from (select a.nombre_apellido, count(s.id_show) as cantidad_shows from actor a inner join elenco e on a.id_actor = e.id_actor inner join show s on e.id_show = s.id_show 
where s.año_lanzamiento = 2017 group by a.nombre_apellido having count(s.id_show) > 3) as subconsulta


-- resultado = 29

--Cuántos actores participaron en mas de 6 shows que se lanzaron en el año 2021
select a.nombre_apellido, COUNT(e.id_show) as cantidad_show from actor a inner join elenco e on a.id_actor = e.id_actor where e.id_show in (select id_show from show where año_lanzamiento = 2021)
group by a.nombre_apellido having COUNT(e.id_show) > 6

select COUNT(cantidad_show) from (select a.nombre_apellido, COUNT(e.id_show) as cantidad_show from actor a inner join elenco e on a.id_actor = e.id_actor where e.id_show in (select id_show from show where año_lanzamiento = 2021)
group by a.nombre_apellido having COUNT(e.id_show) > 6) as subconsulta

-- resultado = 3


--Indicar el promedio de show por categoría.
select c.descripcion, count(sw.id_show) as cantidad_shows from categoria c inner join show_categoria sw on c.id_categoria = sw.id_categoria group by c.descripcion


select avg(cantidad_show) as sumatoria from (select c.descripcion, count(sw.id_show) as cantidad_show from categoria c inner join show_categoria sw on c.id_categoria = sw.id_categoria group by c.descripcion) as subconsulta




-- Resultado: 460



--Indicar el promedio de show por año de lanzamiento para el rating “TV-PG”.
select s.año_lanzamiento, count(s.id_show) as catidad_shows  from show s inner join rating r on s.id_rating = r.id_rating where r.descripcion = 'TV-PG' group by s.año_lanzamiento

select AVG(catidad_shows) as promedio from(select s.año_lanzamiento, count(s.id_show) as catidad_shows  from show s inner join rating r on s.id_rating = r.id_rating where r.descripcion = 'TV-PG' group by s.año_lanzamiento
) as subconsulta

-- resultado = 15



-- ¿Qué cantidad de actores no trabajaron en el año 2017 y que cantidad trabajaron?

-- primero calculamos la cantidad de actores que trabajaron en 2017
-- se utiliza DISTINCT en las consultas es para asegurarse de que cada actor se cuente solo una vez, incluso si ha trabajado en múltiples shows en el año 2017.
select COUNT(distinct a.id_actor) as cantidad_trabajadores from  actor a
inner join elenco e on a.id_actor = e.id_actor
inner join show s on e.id_show = s.id_show where s.año_lanzamiento = 2017

-- Segundo calculamos la cantidad de veces que no han trabajado en el año 2017

select COUNT(*) as cantiodad_no_trabajadores from actor where id_actor not in (select distinct a.id_actor as cantidad_trabajadores from  actor a
inner join elenco e on a.id_actor = e.id_actor
inner join show s on e.id_show = s.id_show where s.año_lanzamiento = 2017) 

--resultado: cantidad de actores que trabajaron en el año 2017: 5897
--			 cantida de actores que notrabajaron en el año 2017: 30522

--¿Qué cantidad de actores no trabajaron en el año 2014 y que cantidad trabajaron?

-- primero calculamos la cantidad de actores
select COUNT(a.id_actor) as cantidad_trabajadores from actor a inner join elenco e on a.id_actor = e.id_actor
inner join show s on e.id_show = s.id_show where s.año_lanzamiento = 2014




-- Segundo calculamos la cantidad de que no trabajaron

select COUNT(*) as cantiada_no_trabajadores from actor where id_actor not in (select a.id_actor as cantidad_trabajadores from actor a inner join elenco e on a.id_actor = e.id_actor
inner join show s on e.id_show = s.id_show where s.año_lanzamiento = 2014)

--resultado: cantidad de actores que trabajaron en el año 2014: 2505
--			 cantida de actores que notrabajaron en el año 2014: 34145

--Identificar el id de la película realizada en Chile con mayor duración, y con menor demora en subirse a la plataforma

select * from tipo_show

SELECT top 1 s.id_show
FROM show s
INNER JOIN show_pais sp ON s.id_show = sp.id_show
WHERE sp.id_pais = (SELECT id_pais FROM pais WHERE descripcion = 'Chile') 
  AND s.id_tipo = (SELECT id_tipo FROM tipo_show WHERE descripcion = 'Movie')
ORDER BY s.duracion DESC, s.fecha_salida ASC

-- Resultado: s7219

--identificar el id de la pelicula sin pais asociado, con menor durtación, y con mayor demora en subirse a la plataforma
select top 1 s.id_show from show s left join show_pais sp on s.id_show = sp.id_show 
where sp.id_pais is null and s.id_tipo = (select id_tipo from tipo_show where descripcion = 'Movie')
order by s.duracion asc, s.fecha_salida desc

SELECT top 1 s.id_show
FROM show s
LEFT JOIN show_pais sp ON s.id_show = sp.id_show
WHERE sp.id_pais IS NULL 
  AND s.id_tipo = (SELECT id_tipo FROM tipo_show WHERE descripcion = 'Movie')
ORDER BY s.duracion ASC, s.fecha_salida DESC


-- resultado = s462

/*
Si tienes una película que no tiene un país asociado, el LEFT JOIN devolverá esa película con NULL en las columnas de show_pais, permitiéndonos filtrar correctamente por sp.id_pais IS NULL.
Con INNER JOIN:

Si usas un INNER JOIN, esa película no aparecería en los resultados porque no hay una coincidencia en la tabla show_pais, lo que haría imposible identificarla.

INNER JOIN: Si hubiéramos utilizado un INNER JOIN, solo se habrían devuelto las películas que tienen al menos un país asociado. Esto significa que las películas sin país no aparecerían en los resultados, lo cual no es lo que queremos en este caso.
*/


--Identificar el id de la película con al menos un país asociado realizada con menor duración, y más reciente
select top 1 s.id_show from show s inner join show_pais sp on s.id_show = sp.id_show where s.id_tipo = (select id_tipo from tipo_show where descripcion = 'Movie') group by s.id_show , s.duracion, s.año_lanzamiento having  COUNT(sp.id_pais) > 0  order by s.duracion asc, s.año_lanzamiento desc


SELECT TOP 1 s.id_show
FROM show s
right JOIN show_pais sp ON s.id_show = sp.id_show
WHERE s.id_tipo = (SELECT id_tipo FROM tipo_show WHERE descripcion = 'Movie')
GROUP BY s.id_show, s.duracion, s.año_lanzamiento
HAVING COUNT(sp.id_pais) >= 1 
ORDER BY s.duracion ASC, s.año_lanzamiento DESC;

SELECT TOP 1 s.id_show
FROM show s
INNER JOIN show_pais sp ON s.id_show = sp.id_show
WHERE s.id_tipo = (SELECT id_tipo FROM tipo_show WHERE descripcion = 'Movie')
ORDER BY s.duracion ASC, s.año_lanzamiento DESC;


/*
/Identificar el id de la película realizada en argentina con mayor duración y mas antigua/
*/

select top 1 s.id_show from show s inner join show_pais sp on s.id_show = sp.id_show where sp.id_pais = (select id_pais from pais where descripcion = 'Argentina') order by duracion desc, año_lanzamiento asc

/*
Indicar la cantidad de directores cuyos nombre y apellido coinciden con actores, en series (TV Show) incorporadas a la plataforma en los últimos seis años.
*/

SELECT COUNT( distinct d.id_director) AS cantidad_directores
FROM director d
INNER JOIN show_director sd ON d.id_director = sd.id_director
INNER JOIN show s ON sd.id_show = s.id_show
inner join elenco e on s.id_show = e.id_show
INNER JOIN actor a ON a.id_actor = e.id_actor
WHERE s.id_tipo = (SELECT id_tipo FROM tipo_show WHERE descripcion = 'TV Show')
AND year (s.fecha_salida) >= YEAR(GETDATE()) - 6
AND d.nombre_apellido = a.nombre_apellido;


select d.id_director,count(distinct d.id_director) from director d
inner join show_director sd on d.id_director = sd.id_director
inner join show s on sd.id_show = s.id_show 
inner join elenco e on s.id_show = e.id_show
inner join actor a on e.id_actor = a.id_actor
where d.nombre_apellido = a.nombre_apellido and s.id_tipo = 2 and year(s.fecha_salida) >= year(getdate()) - 6
group by d.id_director;



/*
Indicar la cantidad de directores cuyos nombre y apellido coinciden con actores, en shows (Tv Show, movies) incorporadas a la plataforma en los últimos tres años
*/
select COUNT(distinct d.id_director) as cantidad_directores from director d
inner join show_director sd on d.id_director = sd.id_director
inner join show s on sd.id_show = s.id_show
inner join elenco e on s.id_show = e.id_show
inner join actor a on e.id_actor = a.id_actor
where s.id_tipo in (select id_tipo from tipo_show where descripcion in ('TV Show', 'Movie')) and  d.nombre_apellido = a.nombre_apellido and YEAR(s.fecha_salida) >= YEAR(GETDATE()) - 3

SELECT COUNT(DISTINCT d.id_director) AS cantidad_directores
FROM director d
INNER JOIN show_director sd ON d.id_director = sd.id_director
INNER JOIN show s ON sd.id_show = s.id_show
INNER JOIN elenco e ON s.id_show = e.id_show
INNER JOIN actor a ON e.id_actor = a.id_actor
WHERE s.id_tipo IN (SELECT id_tipo FROM tipo_show WHERE descripcion IN ('TV Show', 'Movie'))
AND d.nombre_apellido = a.nombre_apellido
AND YEAR(s.fecha_salida) >= YEAR(GETDATE()) - 3;

/*
Indicar la cantidad de directores cuyos nombre y apellido coinciden con actores, en series (TV Show, 'Movie') incorporadas a la plataforma en los últimos tres años.
*/

SELECT COUNT( distinct d.id_director) AS cantidad_directores
FROM director d
INNER JOIN show_director sd ON d.id_director = sd.id_director
INNER JOIN show s ON sd.id_show = s.id_show
inner join elenco e on s.id_show = e.id_show
INNER JOIN actor a ON e.id_actor = a.id_actor
WHERE s.id_tipo in (SELECT id_tipo FROM tipo_show WHERE descripcion IN ('TV Show', 'Movie'))
AND year (s.fecha_salida) >= YEAR(GETDATE()) - 3
AND d.nombre_apellido = a.nombre_apellido;


select count(distinct d.id_director) from director d
inner join show_director sd on sd.id_director = d.id_director
inner join show s on s.id_show = sd.id_show
inner join elenco e on s.id_show = e.id_show
inner join actor a on e.id_actor = a.id_actor
where DATEDIFF(YEAR,s.fecha_salida,getdate()) <= 3 AND
a.nombre_apellido = d.nombre_apellido