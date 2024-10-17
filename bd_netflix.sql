select country from netflix_titles 

CREATE TABLE actor
(
  id_actor INT NOT NULL IDENTITY,
  nombre VARCHAR(50) NULL,
  apellido VARCHAR(50) NULL,
  CONSTRAINT PK_actor PRIMARY KEY (id_actor)
);

CREATE TABLE tipo
(
  id_tipo INT NOT NULL IDENTITY,
  nombre_tipo VARCHAR(50) NOT NULL,
  CONSTRAINT PK_tipo PRIMARY KEY (id_tipo)
);

select * from tipo


INSERT INTO tipo (nombre_tipo)
SELECT type
FROM netflix_titles;

INSERT INTO tipo (nombre_tipo)
SELECT nt.type
FROM netflix_titles nt
WHERE NOT EXISTS (
    SELECT 1
    FROM tipo td
    WHERE td.nombre_tipo = nt.type
);

CREATE TABLE director
(
  id_director INT NOT NULL IDENTITY,
  nombre_completo VARCHAR(50) NULL,
  CONSTRAINT PK_director PRIMARY KEY (id_director)
);

CREATE TABLE pais
(
  id_pais INT NOT NULL IDENTITY,
  nombre_pais VARCHAR(50) NULL,
  CONSTRAINT PK_pais PRIMARY KEY (id_pais)
);

CREATE TABLE clasificacion
(
  id_clasificacion INT NOT NULL IDENTITY,
  descripcion VARCHAR(200) NOT NULL,
  CONSTRAINT PK_clasificacion PRIMARY KEY (id_clasificacion)
);

CREATE TABLE genero
(
  id_genero INT NOT NULL IDENTITY,
  nombre_genero VARCHAR(550) NOT NULL,
  CONSTRAINT PK_genero PRIMARY KEY (id_genero)
);

CREATE TABLE pelicula_serie
(
  show_id INT NOT NULL IDENTITY,
  title VARCHAR(250) NOT NULL,
  fecha_registro DATE NOT NULL,
  anio_lanzamiento INT NOT NULL,
  duracion VARCHAR(100) NOT NULL,
  descripcion VARCHAR(550) NOT NULL,
  id_tipo INT NOT NULL,
  id_clasificacion INT NOT NULL,
  CONSTRAINT PK_pelicula_serie PRIMARY KEY (show_id),
  CONSTRAINT FK_tipo FOREIGN KEY (id_tipo) REFERENCES tipo(id_tipo),
  CONSTRAINT FK_clasificacion FOREIGN KEY (id_clasificacion) REFERENCES clasificacion(id_clasificacion)
);

CREATE TABLE director_pelicula
(
  id_director INT NOT NULL,
  show_id INT NOT NULL,
  CONSTRAINT PK_director_pelicula PRIMARY KEY (id_director, show_id),
  CONSTRAINT FK_director FOREIGN KEY (id_director) REFERENCES director(id_director),
  CONSTRAINT FK_show_pelicula FOREIGN KEY (show_id) REFERENCES pelicula_serie(show_id)
);

CREATE TABLE pelicula_actor
(
  show_id INT NOT NULL,
  id_actor INT NOT NULL,
  CONSTRAINT PK_pelicula_actor PRIMARY KEY (show_id, id_actor),
  CONSTRAINT FK_show_actor FOREIGN KEY (show_id) REFERENCES pelicula_serie(show_id),
  CONSTRAINT FK_actor FOREIGN KEY (id_actor) REFERENCES actor(id_actor)
);

CREATE TABLE pais_pelicula
(
  id_pais INT NOT NULL,
  show_id INT NOT NULL,
  CONSTRAINT PK__pelicula_pais PRIMARY KEY (id_pais, show_id),
  CONSTRAINT FK_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
  CONSTRAINT FK_show_pais FOREIGN KEY (show_id) REFERENCES pelicula_serie(show_id)
);

CREATE TABLE genero_pelicula
(
  show_id INT NOT NULL,
  id_genero INT NOT NULL,
  CONSTRAINT PK_genero_pelicula PRIMARY KEY (show_id, id_genero),
  CONSTRAINT FK_show_genero FOREIGN KEY (show_id) REFERENCES pelicula_serie(show_id),
  CONSTRAINT FK_genero FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);