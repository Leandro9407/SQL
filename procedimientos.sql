/* Un procedimiento (PROCEDURE) es un bloque de código reutilizable que:
     - Se crea una vez y se puede ejecutar cuantas veces se necesite usando CALL.
     - Puede recibir parámetros de entrada (IN), salida (OUT) o ambos (INOUT).
     - No devuelve un valor con RETURN, pero puede entregar resultados con variables OUT.
     - Puede ejecutar varias instrucciones SQL (INSERT, UPDATE, DELETE, SELECT...).
     - No se puede usar dentro de un SELECT, WHERE u ORDER BY.
     - Es útil para automatizar tareas, modificar datos o realizar operaciones complejas. */


/* Volviendo a la tabla creada anteriormente */ 
DELIMITER //
CREATE PROCEDURE listar_tabla ()
SELECT * FROM puntos;
//
DELIMITER ; 

CALL listar_tabla;

########################################

/* PROCEDIMIENTOS CON PARAMETROS */
DELIMITER //
CREATE PROCEDURE consultar_puntos2 (p_id INT)
SELECT * FROM puntos
WHERE id_participante = p_id OR p_id is NULL;
//
DELIMITER ;

CALL consultar_puntos2(NULL);
CALL consultar_puntos2(3);

#######################################

/* PODEMOS USAR CUALQUIER TIPO DE CONSULTA */

DELIMITER //
CREATE PROCEDURE buscar_puntos(num INT)
SELECT * FROM puntos
WHERE competencia_2 > num;
//
DELIMITER ;

CALL buscar_puntos(8);

#######################################

/* PROCEDIMIENTOS PARA INSERTAR DATOS */
DELIMITER //
CREATE PROCEDURE insertar_puntos(
nuevo_id INT,
nuevo_genero CHAR(1),
nuevo_puntos_1 INT,
nuevo_puntos_2 INT
)

INSERT INTO puntos (id_participante, genero, competencia_1, competencia_2) VALUES
(nuevo_id, nuevo_genero, nuevo_puntos_1, nuevo_puntos_2);
//
DELIMITER ;

CALL insertar_puntos(6,'F', 10, 10);
SELECT * FROM puntos;

########################################

/* USO DE PARAMETROS IN, OUT */
DELIMITER //
CREATE PROCEDURE genero_cantidad(IN letra CHAR(1), OUT cantidad INT)
BEGIN
SELECT * FROM puntos
WHERE genero = letra;
SELECT COUNT(*) INTO cantidad
FROM puntos
WHERE genero = letra;
END
//
DELIMITER ;

CALL genero_cantidad('M', @cantidad);
SELECT @cantidad;

########################################

/* EJERCICIOS, Programe un procedimiento que actualice el precio de
los productos de la tabla artículos en función de los precios que indica la tabla novedades. */
CREATE TABLE articulos (
id_articulo INT NOT NULL,
descripcion VARCHAR(30) NOT NULL,
precio FLOAT NULL,
auditoria DATETIME NOT NULL,
PRIMARY KEY (id_articulo)
);

INSERT INTO articulos VALUES(1, 'Leche 1L.', 2000, '2013-09-23 12:23:14');
INSERT INTO articulos VALUES(2, 'Café 250 gr.', 2400, '2013-10-22 18:33:51');
INSERT INTO articulos VALUES(3, 'Agua 5L.', 3900, '2013-10-01 20:16:36');
INSERT INTO articulos VALUES(4, 'Galletas 200 gr.', 1000, '2013-08-11 10:03:54');


CREATE TABLE novedades (
id_articulo INT NOT NULL,
descripcion VARCHAR(30) NOT NULL,
precio FLOAT DEFAULT NULL
);

INSERT INTO novedades VALUES(2, 'Café 250 gr.', 2500);
INSERT INTO novedades VALUES(3, 'Agua 5L.', 4000);

DELIMITER //
CREATE PROCEDURE actualizar_precio ()
BEGIN 
UPDATE articulos
JOIN novedades ON articulos.id_articulo = novedades.id_articulo
SET articulos.precio = novedades.precio,
    articulos.auditoria = NOW();
END;
//    
DELIMITER ;

CALL actualizar_precio();