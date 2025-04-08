
/* dos formas de asignar la PK:

id_profe INT UNSIGNED AUTO_INCREMENT
PRIMARY KEY (id_profe)

id_profe INT UNSIGNED AUTO_INCREMENT PRIMARY KEY */

DROP DATABASE universidad;
CREATE DATABASE universidad CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE universidad;

CREATE TABLE profesores(
    id_profe INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    especialidad VARCHAR(30),
    correo VARCHAR(80) UNIQUE,
    fecha_ingreso DATE,
    estado BOOLEAN,
    PRIMARY KEY (id_profe)
);

CREATE TABLE facultades(
    id_facultad TINYINT UNSIGNED AUTO_INCREMENT,
    nombre_facultad VARCHAR(40),
    PRIMARY KEY (id_facultad)
);

CREATE TABLE asignatura(
    cod_asignatura CHAR(4) PRIMARY KEY, 
    nombre VARCHAR(30),
    numero_horas SMALLINT(4) UNSIGNED   
);

CREATE TABLE imparte(
    id_profe INT UNSIGNED,
    cod_asignatura CHAR(4),
    PRIMARY KEY (id_profe, cod_asignatura),
    FOREIGN KEY (id_profe) REFERENCES profesores(id_profe),
    FOREIGN KEY (cod_asignatura) REFERENCES asignatura(cod_asignatura)
);

INSERT INTO profesores (nombre, apellido, especialidad, correo, fecha_ingreso, estado) 
VALUES
('Juan', 'Pérez', 'Matemáticas', 'juan.perez@gmail.com', '2020-03-15', TRUE),
('María', 'Gómez', 'Historia', 'maria.gomez@gmail.com', '2019-07-20', TRUE),
('Carlos', 'Ramírez', 'Física', 'carlos.ramirez@gmail.com', '2021-01-10', FALSE),
('Ana', 'López', 'Biología', 'ana.lopez@gmail.com', '2018-05-30', TRUE),
('Pedro', 'Fernández', 'Inglés', 'pedro.fernandez@gmail.com', '2022-09-12', TRUE);

INSERT INTO facultades(nombre_facultad) VALUES ('Ingenierias TIC');
INSERT INTO facultades(nombre_facultad) VALUES ('Ingenierias Arquitectonicas');
INSERT INTO facultades(nombre_facultad) VALUES ('Ingenierias de la salud');
INSERT INTO facultades(nombre_facultad) VALUES ('Ingenierias biólogicas');
INSERT INTO facultades(nombre_facultad) VALUES ('Artes');
INSERT INTO facultades(nombre_facultad) VALUES ('Musica');

INSERT INTO profesores (nombre, apellido, especialidad, correo, fecha_ingreso, estado) 
VALUES
('Jhon', 'Osorio', 'Biologia', 'jhon.osorio@gmail.com', '2025-03-19', TRUE),
('Jaime', 'Duran', 'Castellano', 'jaime@gmail.com', '2024-08-23', TRUE);

INSERT INTO asignatura (cod_asignatura, nombre, numero_horas) VALUES
('MAT1', 'Álgebra', 40),
('HIS1', 'Historia Universal', 35),
('FIS1', 'Física Clásica', 45),
('BIO1', 'Biología General', 38),
('ING1', 'Inglés Avanzado', 30),
('CAS1', 'Castellano', 41);

INSERT INTO imparte (id_profe, cod_asignatura) VALUES
(1, 'MAT1'),
(2, 'HIS1'),
(3, 'FIS1'),
(4, 'BIO1'),
(5, 'ING1');

INSERT INTO imparte (id_profe, cod_asignatura) VALUES (6, 'BIO1');
INSERT INTO imparte (id_profe, cod_asignatura) VALUES (7, 'CAS1');


/* INSERT INTO imparte (id_profe, cod_asignatura) VALUES (3, 'MAT1'); */


/* Consultas simples */
SELECT * FROM profesores;

SELECT nombre, correo FROM profesores;

SELECT nombre, apellido, fecha_ingreso FROM profesores WHERE fecha_ingreso > '2021-01-01';


SELECT nombre, apellido, correo FROM profesores WHERE estado = 1;
SELECT * FROM profesores WHERE fecha_ingreso < '2020-01-01';


SELECT asignatura.nombre, numero_horas, profesores.nombre, profesores.apellido 
FROM profesores INNER JOIN imparte ON imparte.id_profe = profesores.id_profe
INNER JOIN asignatura ON imparte.cod_asignatura = asignatura.cod_asignatura;

DESCRIBE profesores;


/* Select WHERE AND OR */
SELECT * FROM profesores WHERE apellido = 'Pérez' OR apellido = 'López';
SELECT * FROM profesores WHERE apellido = 'Osorio' AND especialidad = 'Biología';

SELECT cod_asignatura, nombre, numero_horas FROM asignatura WHERE cod_asignatura = 'FIS1' AND numero_horas >= 45;

SELECT cod_asignatura, nombre, numero_horas FROM asignatura WHERE cod_asignatura = 'FIS1' OR cod_asignatura = 'ING1';
SELECT cod_asignatura, nombre, numero_horas FROM asignatura WHERE numero_horas > 30 AND (cod_asignatura = 'BIO1' OR cod_asignatura = 'FIS1');


/* ORDER BY */
SELECT nombre, apellido FROM profesores ORDER BY nombre ASC; /* DESC */

SELECT  nombre, apellido, fecha_ingreso, correo, estado FROM profesores ORDER BY fecha_ingreso DESC;
SELECT  nombre, apellido, fecha_ingreso, correo, estado FROM profesores WHERE estado = true ORDER BY fecha_ingreso DESC;


/* Between */
SELECT nombre, apellido, correo, fecha_ingreso FROM profesores WHERE fecha_ingreso BETWEEN '2022-01-01' AND '2025-03-26' ORDER BY fecha_ingreso DESC;
SELECT nombre, numero_horas FROM asignatura WHERE numero_horas BETWEEN '40' AND '45';


/* update simples */
UPDATE profesores SET nombre = 'Juan Carlos' WHERE profesores.id_profe = 1;
UPDATE profesores SET nombre = 'María Eugenia' WHERE id_profe = 2;
UPDATE profesores SET nombre = 'Ana María' WHERE correo = 'ana.lopez@gmail.com';


/* ALTER TABLE | PARA MODIFICAR UNA TABLA | ADD COLUMN PARA AGREGAR UNA NUEVA COLUMNA | ADD CONSTRAINT PARA AGREGAR RESTRICCIONES */
ALTER TABLE profesores
ADD COLUMN facultad TINYINT UNSIGNED,
ADD CONSTRAINT fk_profesor_facultad
FOREIGN KEY (facultad) REFERENCES facultades(id_facultad);

UPDATE profesores SET facultad= 2 WHERE id_profe =1;
UPDATE profesores SET facultad= 1 WHERE id_profe =2;
UPDATE profesores SET facultad= 2 WHERE id_profe =3;
UPDATE profesores SET facultad= 4 WHERE id_profe =4;
UPDATE profesores SET facultad= 3 WHERE id_profe =5;
UPDATE profesores SET facultad= 4 WHERE id_profe =6;
UPDATE profesores SET facultad= 1 WHERE id_profe =7;


/* IN ('FDB', 'DGBD') */
SELECT cod_asignatura, nombre FROM asignatura WHERE cod_asignatura IN ('HIS1', 'FIS1', 'ING1');
SELECT nombre, apellido, especialidad FROM profesores WHERE especialidad IN ('Física', 'Biología', 'Inglés');
SELECT nombre, apellido, especialidad FROM profesores WHERE especialidad NOT IN ('Física', 'Biología', 'Inglés');

UPDATE profesores SET nombre = 'Pedro José', apellido = 'Fernández Castro' WHERE id_profe = 5;


/* LIKE 'NOM%' */
SELECT nombre, apellido, correo FROM estudiante WHERE nombre LIKE '@a@';


/* Fechas */
SELECT nombre, apellido, fecha_ingreso FROM profesores WHERE fecha_ingreso < '2022:01:01';
/*  '2022:01:01
    '2022@01@01 
    '2022/01/01 
    '2022.01.01  */


/* NOW(); CURDATE(); CURTIME(); */
SELECT NOW(); /* fecha y hora */
SELECT CURDATE(); /* fecha */
SELECT CURTIME(); /* hora */

SELECT NOW() AS Ahora, CURDATE() AS Fecha, CURTIME() AS Hora; /* AS nombre tabla */

SELECT nombre, DATE_FORMAT(fecha_ingreso, '%d/%m/%Y') AS fecha FROM profesores; /* Y = año completo y = numero final */

SELECT DAY(fecha_ingreso) AS dia, MONTH(fecha_ingreso) AS mes, YEAR(fecha_ingreso) AS año FROM profesores WHERE nombre = 'Carlos';

SELECT nombre, fecha_ingreso FROM profesores WHERE YEAR(fecha_ingreso) = '2020';

SELECT DAYNAME(fecha_ingreso) AS dia, DAYOFWEEK(fecha_ingreso) AS numdia, MONTHNAME (fecha_ingreso) AS mes FROM profesores WHERE nombre = 'Jhon';


/* Operaciones */
Cuantos creditos tiene una asignatura?

SELECT nombre, numero_horas, numero_horas/48 AS creditos FROM asignatura;


/* ROUND */
SELECT nombre, numero_horas, ROUND(numero_horas/48, 2) AS creditos FROM asignatura; /* para redondear ROUND */


/* COUNT (*) contar numero de filas */
SELECT COUNT(cod_asignatura) AS numero_asignaturas FROM asignatura;
SELECT COUNT(numero_horas) AS horas FROM asignatura WHERE numero_horas>=38;


/* SUM () suma*/
SELECT SUM(numero_horas) AS total, SUM(numero_horas/48) AS creditos FROM asignatura;


/* DELETE */
DELETE FROM profesores WHERE id_profe = 2;



/* INNER JOIN ON | RECUPERA SOLO LOS REGISTROS QUE TIENEN VALORES COINCIDENTES EN AMBAS TABLAS*/
SELECT nombre, correo, nombre_facultad FROM profesores INNER JOIN facultades ON facultad = id_facultad;

/* INNER JOIN ALIAS */
SELECT nombre, correo, nombre_facultad FROM profesores p INNER JOIN facultades f ON p.facultad = f.id_facultad;

/* INNER JOIN NOMENCLATURA DEL PUNTO */
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores INNER JOIN facultades ON profesores.facultad = facultades.id_facultad;


/* RIGHT JOIN | RECUPERA TODOS LOS REGISTROS DE LA TABLA DERECHA Y SOLO LOS REGISTROS COINCIDENTES DE LA TABLA IZQUIERDA | UTIL PARA VER CAMPOS NO RELACIONADOS*/
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores RIGHT JOIN facultades ON profesores.facultad = facultades.id_facultad;

 /* RIGHT JOIN IS NULL | FILTRA SOLO LOS REGISTROS DE LA TABLA DERECHA QUE NO TIENEN COINCIDENCIA EN LA TABLA IZQUIERDA */
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores RIGHT JOIN facultades ON profesores.facultad = facultades.id_facultad WHERE profesores.nombre IS NULL;


/* LEFT JOIN | RECUPERA TODOS LOS REGISTROS DE LA TABLA IZQUIERDA Y SOLO LOS REGISTROS COINCIDENTES DE LA TABLA DERECHA */
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores LEFT JOIN facultades ON profesores.facultad = facultades.id_facultad;

/* LEFT JOIN IS NULL | FILTRA SOLO LOS REGISTROS DE LA TABLA DERECHA QUE NO TIENEN COINCIDENCIA EN LA TABLA DERECHA */
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores LEFT JOIN facultades ON profesores.facultad = facultades.id_facultad WHERE profesores.nombre IS NULL;


/* RIGHT Y LEFT */
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores LEFT JOIN facultades ON profesores.facultad = facultades.id_facultad
UNION SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores RIGHT JOIN facultades ON profesores.facultad = facultades.id_facultad;

/* RIGHT Y LEFT IS NULL */
SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores LEFT JOIN facultades ON profesores.facultad = facultades.id_facultad WHERE facultades.id_facultad IS NULL
UNION SELECT profesores.nombre, profesores.correo, facultades.nombre_facultad FROM profesores RIGHT JOIN facultades ON profesores.facultad = facultades.id_facultad WHERE profesores.facultad IS NULL;



/* Crear una base de datos: los estudiantes pueden matricular asignaturas, para matricular asignaturas se necesita fecha de inicio, fecha de fin, estudiante y asignatura,
estado y resultado(0.0 a 5.0). De los estudiantes se necesitan solo el nombre, apellido, identificacion y el correo. Crear las dos tablas
en SQL, insertar 5 estudiantes: 2 de forma individual y 3 en una sola sentencia; matricular a 3 estudiantes en 3 asignaturas cada uno.
Actualizar 3 datos de estudiantes distintos, actualizar datos de la matricula en 3 registros diferentes. Borrar tres registros distintos 
de cualquier tabla, sacar copia de seguridad completa, almacenar sentencia en en el archivo SQL que venimos trabajando. */  