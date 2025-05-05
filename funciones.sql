/* Una función es un bloque de codigo reutilizable que:
        - Se crea una vez y se usa muchas veces.
        - Devuelve un solo valor usando RETURN.
        - Se puede usar en un SELECT, WHERE, ORDER BY, etc.
        - No puede modificar datos (no hace INSERT, UPDATE ni DELETE).
        - Se usa para cálculos o transformaciones simples. */

CREATE DATABASE rutinas1;
USE rutinas1;

CREATE TABLE puntos (
id_participante INT NOT NULL,
genero CHAR(1) NOT NULL,
competencia_1 INT NOT NULL,
competencia_2 INT NOT NULL,
PRIMARY KEY (id_participante)
);

INSERT INTO puntos VALUES(1,'M', 9, 7);
INSERT INTO puntos VALUES(2,'F', 6, 8);
INSERT INTO puntos VALUES(3,'M', 9, 9);
INSERT INTO puntos VALUES(4,'F', 10, 7);
INSERT INTO puntos VALUES(5,'M', 9, 10);


#####################################

DELIMITER //
CREATE FUNCTION holaMundo() RETURNS VARCHAR(20)
RETURN 'HolaMundo';
//
DELIMITER ;

SELECT holamundo();
SELECT holamundo() as Retorno;


######################################

/* FUNCION CON VARIABLE */
/* DECLARE ES PARA CREAR UNA VARIABLE */
DELIMITER //
CREATE FUNCTION holaMundo_var() RETURNS VARCHAR(40)
BEGIN
DECLARE var_salida VARCHAR(40);
SET var_salida = 'Hola Mundo desde una Variable';
RETURN var_salida;
END;
//
DELIMITER ;

SELECT holaMundo_var();


#####################################

/* FUNCIONES CON PARAMETROS */
DELIMITER //
CREATE FUNCTION saludo (texto CHAR(20))
RETURNS CHAR(50)
RETURN CONCAT('Hola, ',texto,'!');
//
DELIMITER ;

SELECT saludo('Mundo');
SELECT saludo('Pepito Perez');

#######################################

/* DROP FUNTION NOMBREFUNCION PARA ELIMINAR UNA FUNCION */
DROP FUNCTION holaMundo;

#######################################

/* SHOW CREATE FUNCTION NOMBREFUNCION PARA OBSERVAR LA DESCRIPCION DE UNA FUNCION */
SHOW CREATE FUNCTION saludo;

#######################################

/* SHOW FUNCTION STATUS PARA MOSTRAR LOS DETALLES DE LA FUNCIONES ALMACENADAS */
SHOW FUNCTION STATUS;

#######################################


/* FUNCIONES CON MAS DE UN PARAMETRO */
DELIMITER //
CREATE FUNCTION elmayor (num1 INT, num2 INT) RETURNS INT
BEGIN
DECLARE var_retorno INT;
IF num1 > num2 THEN
SET var_retorno = num1;
ELSE
SET var_retorno = num2;
END IF;
RETURN var_retorno;
END;
//
DELIMITER ;

SELECT elmayor(33,25);
SELECT elmayor(12,28);

##########################################

/* SE PUEDE APLICAR ESTA FUNCION DENTRO DE UNA CONSULTA */
/* SELECT un_campo, otro_campo, lafuncion(un_campo, otro_campo)
as NombreCampo FROM tabla; */
SELECT competencia_1, competencia_2, elmayor(competencia_1, competencia_2)
as Mayor_Puntaje FROM puntos;

##########################################

/* FUNCIONES CASE */
DELIMITER //
CREATE FUNCTION prioridad (cliente_prioridad VARCHAR(1)) RETURNS VARCHAR(20)
BEGIN
CASE cliente_prioridad
WHEN 'A' THEN
RETURN 'Alto';
WHEN 'M' THEN
RETURN 'Medio';
WHEN 'B' THEN
RETURN 'Bajo';
ELSE
RETURN 'Dato no Valido';
END CASE;
END
//
DELIMITER ;

SELECT prioridad('M');
SELECT prioridad('B');
SELECT prioridad('S');

#########################################

/* FUNCION CON ACCESO A DATOS */
DELIMITER //
CREATE FUNCTION sumas (p_genero CHAR(1)) RETURNS INT
BEGIN
DECLARE var_suma INT;
SELECT SUM(competencia_1)
INTO var_suma
FROM puntos
WHERE genero = p_genero OR p_genero is NULL;
RETURN var_suma;
END;
//
DELIMITER ;

SELECT sumas('M');
SELECT 'Hombres' as Genero, sumas('M') as Total_Compe1;
SELECT 'Mujeres' as Genero, sumas('F') as Total_Compe1;
SELECT 'Todos' as Genero, sumas(NULL) as Total_Compe1;

/* UNION PARA UNIR LAS CONSULTAS */
SELECT 'Hombres' as Genero, sumas('M') as Total_Compe1
UNION
SELECT 'Mujeres' as Genero, sumas('F') as Total_Compe1
UNION
SELECT 'Todos' as Genero, sumas(NULL) as Total_Compe1;

#############################################

/* EJERCICIOS, realizar una función que calcule el total 
de puntos de las dos competencias para cada uno de los registros y mostrarlos en una nueva consulta. */
DELIMITER //
CREATE FUNCTION calculo_competencias () RETURNS INT
BEGIN 
DECLARE var_total INT;
SELECT SUM(competencia_1 + competencia_2)
INTO var_total
FROM puntos;
RETURN var_total;
END;
//
DELIMITER ;

SELECT id_participante, competencia_1 + competencia_2 AS total_puntos
FROM puntos;

##########################################

/* FUNCIONES CON CICLOS */
/* Realizar una función que acepte un número y una potencia, ejecute 
la operación usando un ciclo y devuelva el resultado. */
DELIMITER //
CREATE FUNCTION res_potencia(numero INT, potencia INT) RETURNS INT
BEGIN
DECLARE contador INT DEFAULT 1;
DECLARE resultado INT DEFAULT 1;
WHILE contador <= potencia DO
SET resultado = resultado * numero ;
SET contador = contador + 1;
END WHILE;
RETURN resultado;
END;
//
DELIMITER ;

SELECT res_potencia(2,3);
SELECT res_potencia(3,3);
SELECT res_potencia(2,4);

############################################

/* Ejercicio, realizar una función que enviado un número, devuelva el resultado de 
sumar sus 5 primeros múltiplos, usando ciclos. Ejemplo si envió por parámetros el 7
Resultado=(7*1)+7*2)+(7*3)+(7*4)+(7*5) */

DELIMITER //
CREATE FUNCTION multiplos(numero INT) RETURNS VARCHAR (255)
BEGIN
    DECLARE resultado VARCHAR (255) DEFAULT " ";
    DECLARE contador INT DEFAULT 1;
    WHILE contador <=5 DO
    SET resultado = CONCAT(resultado, numero * contador, '\n');
    SET contador = contador + 1;
    END WHILE;
    RETURN resultado;
END;    
//    
DELIMITER ;

SELECT multiplos(7) AS resultado;

###########################################
/* Ejercicio, realizar una función que enviado tres notas de 0.0 a 5.0 por parámetros, devuelva 
el resultado de la nota final, teniendo en cuenta que la nota1 vale el 20% la nota2 vale el 30% 
la nota3 vale 50]%.
Ejemplo si envió por parámetros notas(4.5,3.0,4.7)
La NotaFinal= 4.2
Luego de Realizar la Función, utilizarla con un INSERT para completar la siguiente Tabla. */

CREATE TABLE nota (
id INT(4) PRIMARY KEY AUTO_INCREMENT,
nota1 FLOAT(2,1) DEFAULT 0,
nota2 FLOAT(2,1) DEFAULT 0,
nota3 FLOAT(2,1) DEFAULT 0,
final FLOAT(2,1) DEFAULT NULL
);

INSERT INTO nota (nota1, nota2, nota3) VALUES(2.5,3.5,4.0);
INSERT INTO nota (nota1, nota2, nota3) VALUES(4.5,5.0,4.0);
INSERT INTO nota (nota1, nota2, nota3) VALUES(1.5,4.5,3.0);
INSERT INTO nota (nota1, nota2, nota3) VALUES(3.5,3.8,4.4);
INSERT INTO nota (nota1, nota2, nota3) VALUES(3.9,3.7,4.9);

SELECT * FROM nota;


DELIMITER //
CREATE FUNCTION calculo_notas (n1 FLOAT, n2 FLOAT, n3 FLOAT) RETURNS FLOAT
DETERMINISTIC
BEGIN
 RETURN (n1 * 0.2 + n2 * 0.3 + n3 * 0.5);
END;
//
DELIMITER ;

SELECT 
  id,
  nota1,
  nota2,
  nota3,
  calculo_notas(nota1, nota2, nota3) AS final
FROM nota;

