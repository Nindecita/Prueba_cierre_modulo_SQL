--creamos la base de datos
CREATE DATABASE consultas_las_peliculas;

--nos conectamos con la base de datos
\c consultas_las_peliculas;

--creamos la primera tabla llamada peliculas
CREATE TABLE peliculas(
id INTEGER PRIMARY KEY,
nombre VARCHAR(255),
anno INTEGER
);

--creamos la segunda tabla llamada tags
CREATE TABLE tags(
id INTEGER PRIMARY KEY,
tags VARCHAR(32)
);

--ahora crearé una tabla intermedia llamada peliculas_tags 
CREATE TABLE peliculas_tags(
id INTEGER PRIMARY KEY,
pelicula_id INTEGER,
tag_id INTEGER,
FOREIGN KEY (pelicula_id) REFERENCES peliculas(id),
FOREIGN KEY (tag_id) REFERENCES tags(id)
);


-- inserto registros en la tabla peliculas
INSERT INTO peliculas (id, nombre, anno)
VALUES (1, 'Volver_al_futuro', 1985);

INSERT INTO peliculas (id, nombre, anno) 
VALUES (2, 'Beetlejuice', 1988);

INSERT INTO peliculas (id, nombre, anno) 
VALUES (3, 'It', 1990);

INSERT INTO peliculas (id, nombre, anno) 
VALUES (4, 'Yo_antes_de_ti', 2016);

INSERT INTO peliculas (id, nombre, anno) 
VALUES (5, 'No_te_metas_con_Zohan', 1985);

--verifico que los datos de la tabla películas estén ingresados
 SELECT * FROM peliculas;

 --respuesta
id |        nombre         | anno
----+-----------------------+------
  1 | Volver_al_futuro      | 1985
  2 | Beetlejuice           | 1988
  3 | It                    | 1990
  4 | Yo_antes_de_ti        | 2016
  5 | No_te_metas_con_Zohan | 1985
(5 filas)


--inserto registros en la tabla tags
INSERT INTO tags (id, tags)
VALUES (1, 'Terror');

INSERT INTO tags (id, tags)
VALUES (2, 'Ficcion');

INSERT INTO tags (id, tags)
VALUES (3, 'Fantasia');

INSERT INTO tags (id, tags)
VALUES (4, 'Romance');

INSERT INTO tags (id, tags)
VALUES (5, 'Comedia');

--verifico que los datos en la tabla tags estén ingresados 
SELECT * FROM tags;

--resultado
 id |   tags
----+----------
  1 | Terror
  2 | Ficción
  3 | Fantasia
  4 | Romance
  5 | Comedia
(5 filas)

--Requerimiento 2.- inserto los 3 tags asosiados, la primera película tiene que tener 3 tags asociados

INSERT INTO peliculas_tags (id, pelicula_id, tag_id)
VALUES (1, 1, 2);

INSERT INTO peliculas_tags (id, pelicula_id, tag_id)
VALUES (2, 1 ,3 );

INSERT INTO peliculas_tags (id, pelicula_id, tag_id)
VALUES (3, 1 ,5 );

--inserto los 2 tags asosiados, la segunda película debe tener dos tags asociados
INSERT INTO peliculas_tags (id, pelicula_id, tag_id)
VALUES (4, 2, 3 );

INSERT INTO peliculas_tags (id, pelicula_id, tag_id)
VALUES (5, 2, 5 );

--verifico que estén insertados los registros en la tabla peliculas_tags
SELECT * FROM peliculas_tags;

--respuesta
 id | pelicula_id | tag_id
----+-------------+--------
  1 |           1 |      2
  2 |           1 |      3
  3 |           1 |      5
  4 |           2 |      3
  5 |           2 |      5
(5 filas)


--3.- cuento la cantidad de tags que tiene cada pelicula y si una pelicula no tiene tags debe mostrar 0

--se leeria asi: selecciona el campo nombre de la tabla peliculas, cuenta los tag_id de la tabla peliculas_tags
--ahora AS cantidad_de_tags_por_pelicula este será el alias que tendrá la columna donde quedará ese conteo 
--ahora desde la tabla peliculas
--hacemos un LEFT JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id
--para que obtenga todos los registros de la tabla peliculas_tags y los registros coincidentes entre tabla peliculas y el campo id sean igual
-- y que las agrupe por el campo nombre de la tabla peliculas
SELECT peliculas.nombre, COUNT(peliculas_tags.tag_id) AS cantidad_de_tags_por_pelicula
FROM peliculas
LEFT JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id
GROUP BY peliculas.nombre; 

--respuesta 
        nombre         | cantidad_de_tags_por_pelicula
-----------------------+-------------------------------
 Yo_antes_de_ti        |                             0
 It                    |                             0
 Beetlejuice           |                             2
 Volver_al_futuro      |                             3
 No_te_metas_con_Zohan |                             0
(5 filas)
--esta es la tabla peliculas, está agrupada por el nombre de las peliculas, 
--tiene la columna llamada "cantidad de tags por peliculas"
--(hay que recordar que le pusimos el AS(alias) que es para que la lectura sea mas fácil)
--en ella tiene el conteo de los tags que tiene cada pelicula


--4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos
CREATE TABLE preguntas(
id INTEGER PRIMARY KEY,
pregunta VARCHAR(255),
respuesta_correcta VARCHAR 
);

CREATE TABLE usuarios(
id INTEGER PRIMARY KEY,
nombre VARCHAR(255),
edad INTEGER
);

CREATE TABLE respuestas(
id INTEGER PRIMARY KEY,
respuesta VARCHAR(255),
usuario_id INTEGER,
pregunta_id INTEGER, 
FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
FOREIGN KEY (pregunta_id) REFERENCES preguntas(id)
);

--5.- Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada
--dos veces correctamente por distintos usuarios, la pregunta 2 debe estar contestada
--correctamente sólo por un usuario, y las otras 2 respuestas deben estar incorrectas.
INSERT INTO preguntas (id, pregunta, respuesta_correcta)
VALUES (1,'¿Quién es personaje verde en la saga "Star Wars"?', 'Yoda');

INSERT INTO preguntas (id, pregunta, respuesta_correcta) 
VALUES (2,'¿Quién es el protagonista de la película "Volver al futuro"?', 'Marty McFly');

INSERT INTO preguntas (id, pregunta, respuesta_correcta)
VALUES (3, '¿Cuál es la estación del año con mas calor?', 'Verano');

INSERT INTO preguntas (id, pregunta, respuesta_correcta)
VALUES (4,'¿Quién es el autor del libro "El resplandor"?', 'Stephen King');

INSERT INTO preguntas (id, pregunta, respuesta_correcta)
VALUES (5,'¿Quién es el vocalista de la banda de rock "Iron Maiden', 'Bruce Dickinson');

SELECT * FROM preguntas;
--respuesta
 id |                           pregunta                           | respuesta_correcta
----+--------------------------------------------------------------+--------------------
  1 | ¿Quién es personaje verde en la saga "Star Wars"?            | Yoda
  2 | ¿Quién es el protagonista de la película "Volver al futuro"? | Marty McFly
  3 | ¿Cuál es la estación del año con mas calor?                  | Verano
  4 | ¿Quién es el autor del libro "El resplandor"?                | Stephen King
  5 | ¿Quién es el vocalista de la banda de rock "Iron Maiden"     | Bruce Dickinson
(5 filas)

-- inserto registros tabla usuarios
INSERT INTO usuarios (id, nombre, edad)
VALUES (1, 'Fabian Pino', 36);

INSERT INTO usuarios (id, nombre, edad) 
VALUES (2, 'Paz Arancibia', 40);

INSERT INTO usuarios (id, nombre, edad)
VALUES (3, 'Fernanda Pino', 19);

INSERT INTO usuarios (id, nombre, edad)
VALUES (4, 'Bastian Pino', 22);

INSERT INTO usuarios (id, nombre, edad) 
VALUES (5, 'Florencia Pino', 48);

SELECT * FROM usuarios;
--respuesta
 id |     nombre     | edad
----+----------------+------
  1 | Fabian Pino    |   36
  2 | Paz Arancibia  |   40
  3 | Fernanda Pino  |   19
  4 | Bastian Pino   |   22
  5 | Florencia Pino |   48
(5 filas)

-- inserto registros tabla intermedia llamada respuestas
INSERT INTO respuestas (id, respuesta, usuario_id, pregunta_id) 
VALUES (1, 'Yoda', 1, 1);

INSERT INTO respuestas (id, respuesta, usuario_id, pregunta_id) 
VALUES (2, 'Yoda', 2, 1);

INSERT INTO respuestas (id, respuesta, usuario_id, pregunta_id) 
VALUES (3, 'Marty McFly', 3, 2);

INSERT INTO respuestas (id, respuesta, usuario_id, pregunta_id) 
VALUES (4, 'lovecraft', 5, 4);

INSERT INTO respuestas (id, respuesta, usuario_id, pregunta_id) 
VALUES (5, 'James Hetfield', 4, 5);

-- reviso
SELECT * FROM respuestas;
--resultado
 id |   respuesta    | usuario_id | pregunta_id
----+----------------+------------+-------------
  1 | Yoda           |          1 |           1
  2 | Yoda           |          2 |           1
  3 | Marty McFly    |          3 |           2
  4 | lovecraft      |          5 |           4
  5 | James Hetfield |          4 |           5
(5 filas)


--6.-Cuento la cantidad de respuestas correctas totales por usuario
SELECT respuestas.usuario_id, COUNT(respuesta_correcta) AS respuestas_correctas_por_usuario FROM preguntas
RIGHT JOIN respuestas ON respuestas.respuesta = preguntas.respuesta_correcta 
GROUP BY respuestas.usuario_id; 

--respuesta
 usuario_id | respuestas_correctas_por_usuario
------------+----------------------------------
          3 |                                1
          5 |                                0
          4 |                                0
          2 |                                1
          1 |                                1
(5 filas)

--7.- ahora, por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta.
SELECT preguntas.pregunta, COUNT(respuestas.respuesta) AS usuarios_con_respuesta_correcta FROM respuestas 
RIGHT JOIN preguntas ON preguntas.respuesta_correcta = respuestas.respuesta 
GROUP BY preguntas.id ORDER BY preguntas.id;

--respuesta
                           pregunta                           | usuarios_con_respuesta_correcta
--------------------------------------------------------------+---------------------------------
 ¿Quién es personaje verde en la saga "Star Wars"?            |                               2
 ¿Quién es el protagonista de la película "Volver al futuro"? |                               1
 ¿Cuál es la estación del año con mas calor?                  |                               0
 ¿Quién es el autor del libro "El resplandor"?                |                               0
 ¿Quién es el vocalista de la banda de rock "Iron Maiden"?    |                               0
(5 filas)


--8.-Implemento borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación.

--para ver las constraint que tiene mi tabla
SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 'respuestas'::regclass;
--respuesta
           conname           | contype
-----------------------------+---------
 respuestas_pkey             | p
 respuestas_usuario_id_fkey  | f
 respuestas_pregunta_id_fkey | f
(3 filas)

--aqui altero la tabla respuestas eliminando la FK, para así luego poder agregar una nueva FK pero con la restriccion que nos piden
--osea que sea en cascada para que al eliminarla pueda ser en cascada 
ALTER TABLE respuestas 
DROP CONSTRAINT respuestas_usuario_id_fkey;
--respuesta 

--agregar un fk para usuario_id y modificacion delete en cascada
ALTER TABLE respuestas 
ADD CONSTRAINT respuestas_usuario_id_fkey
FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;  
--altero la tabla respuestas agregando la CONSTRAINT que habiamos eliminado
--para luego agregar nuestra FK (usuario_id) con REFERENCES usuarios(id) para indicar que la referencia es el id de la tabla usuarios
--ON DELETE CASCADE; para que tenga la condicion de que cuando hagamos un DELETE este sea en casacada

--ahora si, eliminamos el primer usuario por ende se ejecutará en cascada 
DELETE FROM usuarios WHERE id = 1;

--reviso si se implementó la eliminacion del usuario 1
SELECT * FROM usuarios;

--respuesta
 id |     nombre     | edad
----+----------------+------
  2 | Paz Arancibia  |   40
  3 | Fernanda Pino  |   19
  4 | Bastian Pino   |   22
  5 | Florencia Pino |   48

--reviso si se elimnaron las respuestas del usuario 1 
SELECT * FROM respuestas;

--respuesta,  
id |   respuesta    | usuario_id | pregunta_id
----+----------------+------------+-------------
  2 | Yoda           |          2 |           1
  3 | Marty McFly    |          3 |           2
  4 | lovecraft      |          5 |           4
  5 | James Hetfield |          4 |           5
(4 filas)
--todo ok, al eliminarse el usuario 1 por cascada elimina todos los registros de su fila.


--9.-Creo una restricción que impida insertar usuarios menores de 18 años en la base de datos.
ALTER TABLE usuarios 
ADD CONSTRAINT CK_usuarios_edadmin
CHECK (edad  > 18);

--insertaré un registro menor de 18 para corroborar que la restriccion impida que se inserten menores de 18 años
INSERT INTO usuarios (id, nombre, edad) 
VALUES (6, 'Matias Pino', 10);
--respuesta
ERROR:  el nuevo registro para la relación «usuarios» viola la restricción «check» «ck_usuarios_edadmin»
DETALLE:  La fila que falla contiene (6, Matias Pino, 10).

--10.-Altero la tabla existente de usuarios agregando el campo email con la restricción de único.
ALTER TABLE usuarios 
ADD COLUMN email VARCHAR(100) UNIQUE;

--inserto 1 registro en el nuevo campo email para corroborar que si se agregó la columna email en la tabla existente usuarios  
INSERT INTO usuarios (id, nombre, edad, email) 
VALUES (9, 'chini', 25, 'chini@chini.com');

--revisanos...
SELECT * FROM usuarios;

-- y ahora inserto otro registro pero con el mismo email para corroborar que la restriccion UNIQUE está funcionado
INSERT INTO usuarios (id, nombre, edad, email) 
VALUES (8, 'Flor', 27, 'chini@chini.com');

-- reviso que la modificacion se haya realizado
SELECT * FROM usuarios;

--resultado
 id |     nombre     | edad |      email
----+----------------+------+------------------
  2 | Paz Arancibia  |   40 |
  3 | Fernanda Pino  |   19 |
  4 | Bastian Pino   |   12 |
  5 | Florencia Pino |   10 |
  9 | chini          |   25 | chini@chini.com
  
(5 filas)


-- y ahora inserto otro registro pero con el mismo email para corroborar que la restriccion UNIQUE esté funcionado
INSERT INTO usuarios (id, nombre, edad, email) 
VALUES (8, 'chinis', 27, 'chini@chini.com');

--resultado
ERROR:  llave duplicada viola restricción de unicidad «usuarios_email_key»
DETALLE:  Ya existe la llave (email)=(chini@chini.com).
--todo ok, no nos deja agregar un mismo correo para distintos usuarios, nos indicó que el correo ya está vinculado a otro usuario

\q