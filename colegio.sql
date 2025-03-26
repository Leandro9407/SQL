
CREATE DATABASE institucion CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE institucion;

CREATE TABLE asignatura(
    cod_asignatura CHAR (4) PRIMARY KEY,
    nombre VARCHAR (20)

);

CREATE TABLE estudiante(
    id_estudiante INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (20),
    apellido VARCHAR (20),
    identificacion INT,
    correo VARCHAR (50) UNIQUE
);

CREATE TABLE matricula(
    id_matricula INT UNSIGNED AUTO_INCREMENT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado BOOLEAN,
    resultado FLOAT,
    cod_asignatura CHAR (4),
    id_estudiante INT UNSIGNED,
    PRIMARY KEY (cod_asignatura, id_estudiante),
    FOREIGN KEY (cod_asignatura) REFERENCES asignatura(cod_asignatura),
    FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante)
);

INSERT INTO asignatura (cod_asignatura, nombre) VALUE
('CAS1', 'Castellano'),
('MAT1', 'Matemática'),
('ING1', 'Inglés'),
('SOC1', 'Sociales'),
('FIL1', 'Filosofía');

INSERT INTO estudiante (nombre, apellido, identificacion, correo) VALUE
('Federico', 'Duque', 10886724893, 'fico@gmail.com');

INSERT INTO estudiante (nombre, apellido, identificacion, correo) VALUE
('Edison', 'Betancur', 10886742849, 'edibetan@gmail.com');

INSERT INTO estudiante (nombre, apellido, identificacion, correo) VALUE
('Tatiana', 'Miranda', 10886741573 , 'tatis@gmail.com'),
('Santiago', 'Gontier', 10887469281, 'sango@gmail.com'),
('Esteban', 'Henao', 1088571126, 'estehen@gmail.com');


INSERT INTO matricula (fecha_inicio, fecha_fin, estado, resultado, cod_asignatura, id_estudiante) VALUE
('2023-04-20', '2025-10-26', TRUE, 4.5, 'ING1', 3),
('2021-07-02', '2023-06-21', TRUE, 4.1, 'FIL1', 1),
('2014-11-13', '2016-07-30', FALSE, 4.7, 'MAT1', 5),
('2022-03-30', '2024-09-02', TRUE, 4.0, 'CAS1', 2),
('2025-04-25', '2027-08-15', FALSE, 4.4, 'SOC1', 4);

UPDATE estudiante SET nombre = 'Brayan' WHERE id_estudiante = 1;
UPDATE estudiante SET nombre = 'Fredy' WHERE id_estudiante = 2;
UPDATE estudiante SET nombre = 'María' WHERE id_estudiante = 3;


DELETE FROM matricula WHERE id_matricula = 5;
DELETE FROM matricula WHERE id_matricula = 4;
DELETE FROM matricula WHERE id_matricula = 3;