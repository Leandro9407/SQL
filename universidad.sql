
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

INSERT INTO asignatura (cod_asignatura, nombre, numero_horas) VALUES
('MAT1', 'Álgebra', 40),
('HIS1', 'Historia Universal', 35),
('FIS1', 'Física Clásica', 45),
('BIO1', 'Biología General', 38),
('ING1', 'Inglés Avanzado', 30);

INSERT INTO imparte (id_profe, cod_asignatura) VALUES
(1, 'MAT1'),
(2, 'HIS1'),
(3, 'FIS1'),
(4, 'BIO1'),
(5, 'ING1');


INSERT INTO profesores (nombre, apellido, especialidad, correo, fecha_ingreso, estado) 
VALUES
('Jhon', 'Osorio', 'Biologia', 'jhon.osorio@gmail.com', '2025-03-19', TRUE);

INSERT INTO imparte (id_profe, cod_asignatura) VALUES (6, 'BIO1');

INSERT INTO imparte (id_profe, cod_asignatura) VALUES (3, 'MAT1');



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


/* update simples */
UPDATE profesores SET nombre = 'Juan Carlos' WHERE profesores.id_profe = 1;
UPDATE profesores SET nombre = 'María Eugenia' WHERE id_profe = 2;
UPDATE profesores SET nombre = 'Ana María' WHERE correo = 'ana.lopez@gmail.com';

UPDATE profesores SET nombre = 'Pedro José', apellido = 'Fernández Castro' WHERE id_profe = 5;

/* delete */
DELETE FROM profesores WHERE id_profe = 2;




/* Crear una base de datos: los estudiantes pueden matricular asignaturas, para matricular asignaturas se necesita fecha de inicio, fecha de fin, estudiante y asignatura,
estado y resultado(0.0 a 5.0). De los estudiantes se necesitan solo el nombre, apellido, identificacion y el correo. Crear las dos tablas
en SQL, insertar 5 estudiantes: 2 de forma individual y 3 en una sola sentencia; matricular a 3 estudiantes en 3 asignaturas cada uno.
Actualizar 3 datos de estudiantes distintos, actualizar datos de la matricula en 3 registros diferentes. Borrar tres registros distintos 
de cualquier tabla, sacar copia de seguridad completa, almacenar sentencia en en el archivo SQL que venimos trabajando. */  