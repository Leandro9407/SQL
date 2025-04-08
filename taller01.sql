DROP DATABASE IF EXISTS taller01;
CREATE DATABASE taller01;
USE taller01;

CREATE TABLE empleados(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,  
    nombre_empleado VARCHAR(50),    
    total_ventas_dinero FLOAT (11,2),
    total_cant_productos INT
);

CREATE  TABLE productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,                             
    nombre_producto VARCHAR(50),   
    precio FLOAT(10,2)                                     
);

CREATE TABLE ventas(
    id_venta INT,       
    id_empleado INT,    
    fecha DATE,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_venta),
    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

INSERT INTO empleados (nombre_empleado, total_ventas_dinero, total_cant_productos) VALUE 
('Carolina', 18000, 8),  
('Federico', 34500, 15), 
('Diego', 54000, 20),    
('Edison', 25500, 10),   
('Fredy', 36400, 14),
('Felipe', 0, 0),
('Tatiana', 0, 0);    

INSERT INTO productos (nombre_producto, precio) VALUE 
('Chocolate con leche', 2500),
('Galletas rellenas', 1800),
('Caramelos surtidos', 1200),
('Chocolatina', 1500),
('Turrón de maní', 2000),
('Malvaviscos', 1700),
('Gomitas frutales', 1600),
('Brownie de chocolate', 3000),
('Pastel de vainilla', 3500),
('Dona glaseada', 2800);

INSERT INTO ventas (id_venta, id_empleado, fecha, id_producto, cantidad) VALUE
(1, 1, '2025-03-01', 2, 2),
(2, 1, '2025-03-02', 5, 1),
(3, 2, '2025-03-01', 4, 3),
(4, 2, '2025-03-03', 7, 2),
(5, 3, '2025-03-02', 1, 4),
(6, 3, '2025-03-04', 3, 2),
(7, 4, '2025-03-01', 6, 3),
(8, 4, '2025-03-05', 10, 1),
(9, 5, '2025-03-03', 8, 2),
(10, 5, '2025-03-04', 9, 2),
(11, 1, '2025-03-06', 1, 1),
(12, 2, '2025-03-06', 5, 2),
(13, 3, '2025-03-07', 6, 2),
(14, 4, '2025-03-07', 3, 3),
(15, 5, '2025-03-08', 7, 1),
(16, 1, '2025-03-08', 10, 2),
(17, 2, '2025-03-09', 2, 1),
(18, 3, '2025-03-10', 8, 2),
(19, 4, '2025-03-10', 4, 2),
(20, 5, '2025-03-11', 9, 3),
(21, 6, '2025-03-15', 3, 0),
(22, 7, '2025-03-18', 6, 0);

/* UPDATE */
UPDATE productos SET nombre_producto = 'Chocolate negro', precio = 2700 WHERE id_producto = 1;
UPDATE productos SET nombre_producto = 'Galletas de avena', precio = 1900 WHERE id_producto = 2;
UPDATE productos SET nombre_producto = 'Caramelos de miel', precio = 1300 WHERE id_producto = 3;
UPDATE productos SET nombre_producto = 'Chocolatina rellena', precio = 1600 WHERE id_producto = 4;
UPDATE productos SET nombre_producto = 'Turrón blando', precio = 2200 WHERE id_producto = 5;

/* DELETE */
DELETE FROM ventas WHERE id_venta = 20;
DELETE FROM ventas WHERE id_venta = 19;
DELETE FROM ventas WHERE id_venta = 18;

/* SELECT SIMPLE | MOSTRAR TODO LOS REGISTROS */
SELECT * FROM empleados;
SELECT * FROM productos;
SELECT * FROM ventas;

/* WHERE | DONDE TAL REGISTRO SEA MAYOR O MENOR... */
SELECT nombre_empleado, total_ventas_dinero FROM empleados WHERE total_cant_productos > 11;
SELECT nombre_empleado, total_ventas_dinero FROM empleados WHERE total_cant_productos < 11;

/* SELECT INNER JOIN ON | PARA UNIR Y MOSTRARLOS REGISTROS ASIGNANDOLOS */
SELECT empleados.nombre_empleado, empleados.total_ventas_dinero, productos.nombre_producto, productos.precio
FROM ventas INNER JOIN empleados ON ventas.id_empleado = empleados.id_empleado INNER JOIN productos ON 
ventas.id_producto = productos.id_producto;

/* SELECT WHERE AND OR | CONSULTAR POR CONDICIONAL */
SELECT id_empleado, id_producto, cantidad FROM ventas WHERE fecha < '2025-03-06' AND cantidad > 2; 
SELECT nombre_empleado, total_ventas_dinero, total_cant_productos FROM empleados WHERE total_ventas_dinero > 30000 OR total_cant_productos > 10;
SELECT nombre_empleado, total_ventas_dinero, total_cant_productos FROM empleados WHERE total_ventas_dinero < 40000 AND (total_cant_productos = 15 OR total_cant_productos = 10);
SELECT nombre_empleado, total_ventas_dinero FROM empleados WHERE nombre_empleado = 'Diego' OR nombre_empleado = 'Fredy';

/* BETWEEN AND */
SELECT nombre_producto, precio FROM productos WHERE precio BETWEEN 1400 AND 2300 ORDER BY nombre_producto ASC;

/* SELECT ORDER BY ASC, DESC | ORDENAR POR O DESORDENAR POR */
SELECT * FROM empleados ORDER BY nombre_empleado ASC;
SELECT * FROM productos ORDER BY nombre_producto DESC;

/* IN, NOT IN('FDB', 'DGBD') | CONSULTAR SOLO ESOS REGISTROS (IN) O QUE NO ESTEN ESOS REGISTROS (NOT IN) */
SELECT nombre_producto, precio FROM productos WHERE nombre_producto IN ('Caramelos Surtidos', 'Malvaviscos', 'Pastel de vainilla');
SELECT nombre_producto, precio FROM productos WHERE nombre_producto NOT IN ('Chocolatina', 'Brownie de chocolate', 'Turrón de maní');

/* LIKE 'NOM%', '%NOM', '%NOM%' | QUE EMPIECE, QUE TERMINE, TODAS LA ANTERIORES  */
SELECT nombre_producto FROM productos WHERE nombre_producto LIKE 'c%';
SELECT nombre_producto FROM productos WHERE nombre_producto LIKE '%e';
SELECT nombre_producto FROM productos WHERE nombre_producto LIKE '%g%';

/* FECHAS | SE PUEDE ESCRIBIR DE VARIAS MANERAS */
/* '2022-02-06'
   '2022:03:05'
   '2022@04@06'
   '2022.07.06'
   '2022/05/07' */

/* NOW(), CURDATE(), CURTIME() | FECHA Y HORA, FECHA, HORA | AS = ALIAS*/
SELECT NOW() AS Ahora, CURDATE() AS fecha, CURTIME() AS hora;

/* DATE_FORMAT | PARA EL FORMATO DE LA FECHA */
SELECT id_empleado, DATE_FORMAT(fecha, '%d/%m/%Y') AS Fecha FROM ventas;
SELECT id_empleado, DATE_FORMAT(fecha, '%m/%d/%Y') AS Fecha FROM ventas;

/* DAY(), MONTH(), YEAR() | CON AS PARA ALIAS */
SELECT DAY(fecha) AS Dia, MONTH(fecha) AS Mes, YEAR(fecha) AS Año FROM ventas WHERE YEAR(fecha) = 2025;

/* DAYNAME(), DAYOFWEEK, MONTHNAME() | NOMBRE DIA DE LA SEMANA, NUMERO DIA, NOMBRE MES*/
SELECT DAYNAME(fecha) AS dia, DAYOFWEEK(fecha) AS NumDia, MONTHNAME(fecha) AS Mes FROM ventas; 

/* OPERACIONES */
/* ROUND | REDONDEAR */
SELECT nombre_empleado, ROUND(total_ventas_dinero/total_cant_productos) AS Division FROM empleados;

/* COUNT() | CONTAR */
SELECT COUNT(nombre_producto) AS Producto FROM productos;
SELECT COUNT(cantidad) AS Cantidad FROM ventas WHERE cantidad > 2;

/* COUNT( DISTINCT) | SI SE REPITE EL NUMERO SE CUENTA UNA SOLA VEZ */
SELECT COUNT(DISTINCT cantidad) AS cantidad FROM ventas;

/* SUMA() */
SELECT SUM(cantidad) AS Total FROM ventas;
SELECT SUM(total_ventas_dinero) AS Total FROM empleados;

/* AVG | PROMEDIO */
SELECT AVG(total_ventas_dinero) AS promedio FROM empleados;

/* MIN(), MAX() | MINIMO VALOR, MAXIMO VALOR */
SELECT MIN(precio) FROM productos;
SELECT MAX(precio) FROM productos;

/* SUBCONSULTA SOLUCIONA EL MIN Y MAX | SOLO DEBE USARSE EN EL WHERE*/
SELECT nombre_producto, precio FROM productos WHERE precio = (SELECT MIN(precio) FROM productos);
SELECT nombre_producto, precio FROM productos WHERE precio = (SELECT MAX(precio) FROM productos);

-- Insertar 5 empleados
-- Insertar 10 productos 
-- Insertar 20 ventas

-- Modificar 5 registros
-- Eliminar 3 registros

-- Realizar 3 ejemplos de cada una de las consultar aprendidas.

/* JOIN */

SELECT empleados.nombre_empleado, productos.nombre_producto, ventas.cantidad, productos.precio, SUM(ventas.cantidad * productos.precio) AS Total
FROM ventas INNER JOIN empleados ON ventas.id_empleado = empleados.id_empleado INNER JOIN productos ON ventas.id_producto = productos.id_producto
GROUP BY empleados.nombre_empleado, productos.nombre_producto, ventas.cantidad, productos.precio;

SELECT empleados.id_empleado, empleados.nombre_empleado, SUM(ventas.cantidad * productos.precio) AS Total
FROM ventas INNER JOIN empleados ON ventas.id_empleado = empleados.id_empleado INNER JOIN productos ON ventas.id_producto = productos.id_producto
GROUP BY empleados.id_empleado, empleados.nombre_empleado;

SELECT empleados.nombre_empleado, ventas.cantidad AS Ventas
FROM ventas INNER JOIN empleados ON ventas.id_empleado = empleados.id_empleado WHERE ventas.cantidad = 0;

SELECT productos.nombre_producto, productos.precio, ventas.cantidad 
FROM ventas INNER JOIN productos ON ventas.id_producto = productos.id_producto WHERE ventas.cantidad = 0;

-- nombre de los empleados, nombre de los productos, cantidad, precio y precio total de todas las ventas.
-- nombre de los empleados que no han vendido nada.
-- nombre de los productos que no se han vendido.

-- El nombre del producto que mas se ha vendido en cantidad.
-- El nombre del producto que mas se ha vendido en precio.

-- nombre de los empleados y cuantas ventas tiene registradas en la tabla ventas. 
SELECT empleados.id_empleado, empleados.nombre_empleado, COUNT(ventas.cantidad) AS Cantidas_ventas FROM empleados INNER JOIN ventas ON empleados.id_empleado = ventas.id_empleado
GROUP BY empleados.id_empleado, empleados.nombre_empleado;

--nombre de los empleados y cantidad de productos que tien registradas en la tabla ventas.
SELECT empleados.id_empleado, empleados.nombre_empleado, SUM(ventas.cantidad) AS Cantidad_productos FROM empleados INNER JOIN ventas ON empleados.id_empleado = ventas.id_empleado
GROUP BY empleados.id_empleado, empleados.nombre_empleado;

-- nombre de los empleados y cuanto ha vendido en dinero registrado en ventas (cantidad*precio) filtrado por una fecha determinada.

--todos los empleatos que no han vendido y todos los productos que no se han vendido.


----
SELECT empleados.id_empleado, ventas.fecha, empleados.nombre_empleado, ventas.cantidad
FROM empleados
INNER JOIN ventas ON empleados.id_empleado = ventas.id_empleado;

/* NUNCA HACER | GENERA PRODUCTO CARTESIONA Y TRAE TODOS LOS REGISTROS                                                                    */
FROM empleados, ventas