CREATE DATABASE ejer_trigger;
USE ejer_trigger;

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    precio INT,
    rectangular CHAR(1)
);

CREATE TABLE registros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productos_id INT,
    precio_antiguo INT,
    precio_nuevo INT,
    rectangular CHAR(1),
    FOREIGN KEY(productos_id) REFERENCES productos(id)
);

INSERT INTO productos (nombre, precio, rectangular) VALUE 
('Teclado', 30000, "S" ),
('Monitor', 350000, "S" ),
('Mouse', 22000, "S" ),
('RAM', 270000, "S" ),
('BOARD', 410000, "S" );


DELIMITER //
    CREATE TRIGGER actualizar_precio AFTER UPDATE ON productos
    FOR EACH ROW
    BEGIN
        IF NEW.precio <> OLD.precio THEN
            INSERT INTO registros (productos_id, precio_antiguo, precio_nuevo, rectangular)
            VALUE (NEW.id, OLD.precio, NEW.precio, "N");
        END IF;    
    END;
//    
DELIMITER ;


UPDATE productos SET precio = 28000 WHERE id = 1;
UPDATE productos SET precio = 17000 WHERE id = 3;
UPDATE productos SET precio = 390000 WHERE id = 5;