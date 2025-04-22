
/* T03.001- Código y nombre de los artículos con un precio entre 400 y 500 euros. */
SELECT articulo.cod, articulo.nombre, linped.precio FROM linped
INNER JOIN articulo ON linped.articulo = articulo.cod
WHERE linped.precio BETWEEN 400 AND 500;

/* T03.002- Código y nombre de los artículos con precio 415, 129, 1259 o 3995. */
SELECT articulo.cod, articulo.nombre, linped.precio FROM linped
INNER JOIN articulo ON linped.articulo = articulo.cod
WHERE linped.precio = 415 OR linped.precio = 129 OR linped.precio = 1259 OR linped.precio = 3995;

/* T03.003- Código y nombre de las provincias que no son Huelva, Sevilla, Asturias ni Barcelona. */
SELECT codp, nombre FROM provincia
WHERE nombre
NOT IN ('Huela', 'Sevilla', 'Asturias', 'Barcelona');

/* T03.004- Código de la provincia Alicante. */
SELECT codp, nombre FROM provincia 
WHERE nombre 
LIKE '%alicante%';

/* T03.005- Obtener el código, nombre y pvp de los artículos cuya marca comience por S. */
SELECT cod, nombre, pvp, marca FROM articulo 
WHERE marca 
LIKE 's%';

/* T03.006- Información sobre los usuarios cuyo email es de la eps. */
SELECT email, nombre, apellidos, telefono FROM usuario 
WHERE email 
LIKE '%eps%';

/* T03.007- Código, nombre y resolución de los televisores cuya pantalla no esté entre 22 y 42. */
SELECT tv.cod, articulo.nombre, tv.resolucion, tv.pantalla FROM tv 
INNER JOIN articulo ON tv.cod = articulo.cod 
WHERE tv.pantalla < 22 OR tv.pantalla > 42;

/* T03.008- Código y nombre de los televisores cuyo panel sea tipo LED y su precio no supere los 1000 euros. */
SELECT tv.cod, articulo.nombre, tv.panel, articulo.pvp FROM tv 
INNER JOIN articulo ON tv.cod = articulo.cod
WHERE tv.panel = 'televisor LED' AND articulo.pvp <= 1000; 

/* T03.009- Email de los usuarios cuyo código postal no sea 02012, 02018 o 02032. */
SELECT nombre, apellidos, email, codpos FROM usuario
WHERE codpos NOT IN ('02012', '02018', '02032');

/* T03.010- Código y nombre de los packs de los que se conoce qué artículos los componen. */
SELECT pack.cod, articulo.nombre FROM pack 
INNER JOIN articulo ON pack.cod = articulo.cod;

/* T03.011- ¿Hay algún artículo en cesta que esté descatalogado? */
SELECT articulo, entrega FROM stock 
WHERE entrega = 'descatalogado';

/* T03.012- Código, nombre y pvp de las cámaras de tipo compacta. */
SELECT camara.cod, articulo.nombre, articulo.pvp AS precio, camara.tipo FROM camara 
INNER JOIN articulo ON camara.cod = articulo.cod 
WHERE camara.tipo LIKE '%compacta%';

/* T03.013- Código, nombre y diferencia entre pvp y precio de los artículos que hayan sido solicitados en algún pedido
 a un precio distinto de su precio de venta. */   /* ABS() PARA QUITAR LOS RESULTADOS NEGATIVOS */
 SELECT articulo.cod, articulo.nombre, articulo.pvp, linped.precio, ABS(articulo.pvp - linped.precio) FROM linped
 INNER JOIN articulo ON linped.articulo = articulo.cod
 WHERE articulo.pvp != linped.precio;
 
/* T03.014- Número de pedido, fecha y nombre y apellidos del usuario que solicita el pedido,
para aquellos pedidos solicitados por algún usuario de apellido MARTINEZ. */
SELECT pedido.numPedido, pedido.fecha, usuario.nombre, usuario.apellidos FROM pedido
INNER JOIN usuario ON pedido.usuario = usuario.email
WHERE usuario.apellidos LIKE '%martinez%';

/* T03.015- Código, nombre y marca del artículo más caro. */
SELECT cod, nombre, marca, pvp FROM articulo
WHERE pvp = (SELECT MAX(pvp) FROM articulo);

/* T03.016- Nombre, marca y resolución de las cámaras que nunca se han solicitado. */
SELECT articulo.nombre, articulo.marca, camara.resolucion, camara.cod FROM camara
INNER JOIN articulo ON camara.cod = articulo.cod
WHERE camara.cod NOT IN (SELECT articulo FROM linped);

/* T03.017- Código, nombre, tipo y marca de las cámaras de marca Nikon, LG o Sigma. */
SELECT camara.cod, articulo.nombre, camara.tipo, articulo.marca FROM camara
INNER JOIN articulo ON camara.cod = articulo.cod
WHERE articulo.marca IN ('Nikon', 'LG', 'Sigma');

/* T03.018- Código, nombre y pvp de la cámara más cara de entre las de tipo réflex. */
SELECT camara.cod, articulo.nombre, articulo.pvp, camara.tipo FROM camara
INNER JOIN articulo ON camara.cod = articulo.cod
WHERE camara.tipo LIKE '%reflex%' AND articulo.pvp = (SELECT MAX(articulo.pvp) FROM articulo 
INNER JOIN camara ON camara.cod = articulo.cod 
WHERE camara.tipo LIKE '%reflex%');

/* T03.019- Marcas de las que no existe ningún televisor en nuestra base de datos. */
SELECT cod, nombre, marca FROM articulo
WHERE cod NOT IN (SELECT cod FROM tv);

/* T03.020- Código, nombre y disponibilidad de los artículos con menor disponibilidad de
entre los que pueden estar disponibles en 24 horas. */
SELECT articulo.cod, articulo.nombre, stock.disponible, stock.entrega FROM stock
INNER JOIN articulo ON stock.articulo = articulo.cod
WHERE stock.entrega = '24 horas' AND stock.disponible = (SELECT MIN(stock.disponible) FROM stock
WHERE stock.entrega = '24 horas');

/* T03.021- Nombre de los artículos cuyo nombre contenga la palabra EOS. */
SELECT cod, nombre FROM articulo
WHERE nombre LIKE 'EOS%';

/* T03.022- Tipo y focal de los objetivos que se monten en una cámara Canon sea cual sea el modelo. */
SELECT objetivo.tipo, objetivo.focal, articulo.nombre FROM objetivo
INNER JOIN articulo ON objetivo.cod = articulo.cod
WHERE articulo.nombre LIKE '%canon%';

/* T03.023- Nombre de los artículos cuyo precio sea mayor de 100 pero menor o igual que 200. */
SELECT nombre, pvp FROM articulo
WHERE pvp > 100 AND pvp <= 200;

/* T03.024- Nombre de los artículos cuyo precio sea mayor o igual que 100 pero menor o igual que 300. */
SELECT nombre, pvp FROM articulo
WHERE pvp >= 100 AND pvp <= 300;

/* T03.025- Nombre de las cámaras cuya marca no comience por la letra S. */
SELECT nombre, marca FROM articulo
INNER JOIN camara ON camara.cod = articulo.cod
WHERE marca NOT LIKE 's%';

/* T04.001- Toda la información de los pedidos anteriores a octubre de 2010. */
SELECT * FROM pedido 
WHERE fecha <  '2010-08-01';

/* T04.002- Toda la información de los pedidos posteriores a agosto de 2010. */
SELECT * FROM pedido
WHERE fecha > '2010.08.31';

/* T04.003- Toda la información de los pedidos realizados entre agosto y octubre de 2010. */
SELECT * FROM pedido
WHERE fecha BETWEEN '2010-07-31' AND '2010-11-1';

/* T04.004- Toda la información de los pedidos realizados el 3 de marzo o el 27 de octubre de 2010. */
SELECT * FROM pedido
WHERE fecha = '2010-03-3' OR fecha = '2010-10-27';

SELECT * FROM pedido
WHERE fecha IN ('2010-03-3', '2010-10-27');

/* T04.005- Toda la información de los pedidos realizados el 3 de marzo o el 27 de octubre
de 2010, y que han sido realizados por usuarios del dominio "cazurren" */
SELECT * FROM pedido
INNER JOIN usuario ON pedido.usuario = usuario.email
WHERE pedido.fecha BETWEEN '2010-03-03' AND '2010-10-27' AND usuario.email LIKE '%cazurren%';

/* T04.006- ¿En qué día y hora vivimos? */
SELECT NOW()
/* T04.007- 21 de febrero de 2011 en formato dd/mm/aaaa */
SELECT DATE_FORMAT(STR_TO_DATE('2011/02/21', '%Y/%m/%d'), '%d/%m/%Y') AS fecha;

/* T04.008- 31 de febrero de 2011 en formato dd/mm/aaaa */
SELECT DATE_FORMAT(STR_TO_DATE('2011/02/31', '%Y/%m/%d'), '%d/%m/%Y') AS fecha;

/* T04.009- Pedidos realizados el 13.9.2010 (este formato, obligatorio en la comparación). */
/* CON CERO DE MES INICIAL */
SELECT *, DATE_FORMAT(fecha, '%d.%m.%Y') AS fecha_formateada
FROM pedido
WHERE DATE_FORMAT(fecha, '%d.%m.%Y') = '13.09.2010'; 

/* SIN CERO DE MES INICIAL */
SELECT *, DATE_FORMAT(fecha, '%d.%c.%Y') AS fecha_formateada
FROM pedido
WHERE DATE_FORMAT(fecha, '%d.%c.%Y') = '13.9.2010'; 

/* T04.010- Numero y fecha de los pedidos realizados el 13.9.2010 (este formato, obligatorio
tanto en la comparación como en la salida). */
SELECT numPedido, fecha, DATE_FORMAT(fecha, '%d.%c.%Y') AS fecha_formateada
FROM pedido
WHERE DATE_FORMAT(fecha, '%d.%c.%Y') = '13.9.2010'

/* T04.011- Numero, fecha, y email de cliente de los pedidos (formato dd.mm.aa) ordenado
Descendente por fecha y ascendentemente por cliente. */
SELECT pedido.numPedido, DATE_FORMAT(pedido.fecha, '%d.%m.%y') AS fecha_formateada, usuario.email
FROM pedido 
INNER JOIN usuario ON pedido.usuario = usuario.email
ORDER BY pedido.fecha DESC, usuario.email ASC;

/* T04.012- Códigos de artículos solicitados en 2010, eliminando duplicados y ordenado ascendentemente. */
SELECT DISTINCT linped.articulo FROM pedido
INNER JOIN linped ON pedido.numPedido = linped.numPedido
WHERE YEAR(pedido.fecha) = '2010' ORDER BY linped.articulo ASC;

/* T04.013- Códigos de artículos solicitados en pedidos de marzo de 2010, eliminando duplicados y ordenado ascendentemente. */
SELECT DISTINCT linped.articulo FROM pedido
INNER JOIN linped ON pedido.numPedido = linped.numPedido
WHERE YEAR(pedido.fecha) = '2010' AND MONTH(pedido.fecha) = '03' ORDER BY linped.articulo DESC;

/* T04.014- Códigos de artículos solicitados en pedidos de septiembre de 2010, y semana del
año (la semana comienza en lunes) y año del pedido, ordenado por semana. */
SELECT linped.articulo, WEEK(pedido.fecha, 1) AS semana, YEAR(pedido.fecha) AS anio
FROM pedido
INNER JOIN linped ON pedido.numPedido = linped.numPedido
WHERE YEAR(pedido.fecha) = 2010 AND MONTH(pedido.fecha) = 9 ORDER BY semana;

/* T04.015- Nombre, apellidos y edad (aproximada) de los usuarios del dominio "dlsi.ua.es",
ordenado descendentemente por edad. */
SELECT nombre, apellidos, fecha, (2025 - YEAR(nacido)) AS edad, email FROM usuario
WHERE email LIKE '%dlsi.ua.es%' ORDER BY edad DESC;

/* T04.016- Email y cantidad de días que han pasado desde los pedidos realizados por cada
usuario hasta la fecha de cada cesta que también sea suya. Eliminad duplicados. */
SELECT DISTINCT pedido.usuario, DATEDIFF(cesta.fecha, pedido.fecha) AS cantidad_dias FROM pedido
INNER JOIN cesta ON pedido.usuario = cesta.usuario;

/* T04.017- Información sobre los usuarios menores de 25 años. */
SELECT *, (2010 - YEAR(nacido)) AS edad  FROM usuario
WHERE (2010 - YEAR(nacido)) < 25;

/* T04.018- Número de pedido, usuario y fecha (dd/mm/aaaa) al que se le solicitó para los
pedidos que se realizaron durante la semana del 7 de noviembre de 2010. */
SELECT numPedido, usuario, DATE_FORMAT(fecha, '%d/%m/%Y') AS fecha FROM pedido
WHERE fecha BETWEEN '2010-11-01' AND '2010-11-07';

/* T04.019- Código, nombre, panel y pantalla de los televisores que no se hayan solicitado ni
en lo que va de año, ni en los últimos seis meses del año pasado. */
SELECT tv.cod, articulo.nombre, tv.panel, tv.pantalla FROM tv 
INNER JOIN articulo ON tv.cod = articulo.cod
WHERE tv.cod NOT IN (SELECT linped.articulo FROM linped 
INNER JOIN pedido ON linped.numPedido = pedido.numPedido 
WHERE (pedido.fecha BETWEEN '2025-01-01' AND CURDATE()
OR
pedido.fecha BETWEEN '2024-07-01' AND '2024-12-31'));

/* T04.020- Email y cantidad de días que han pasado desde los pedidos realizados por cada
usuario hasta la fecha de cada artículo que ahora mismo hay en su cesta. Eliminad
duplicados. */
SELECT DISTINCT pedido.usuario, DATEDIFF(cesta.fecha, pedido.fecha) AS dias_diferencia
FROM pedido
INNER JOIN cesta ON pedido.usuario = cesta.usuario;

/* T05.001- Número de pedido e identificador, apellidos y nombre del usuario que realiza el
pedido (usando join). */
SELECT pedido.numPedido, pedido.usuario, usuario.apellidos, usuario.nombre FROM pedido
INNER JOIN usuario ON pedido.usuario = usuario.email;

/* T05.002- Número de pedido e identificador, apellidos y nombre del usuario que realiza el
pedido, y nombre de la localidad del usuario (usando join). */
SELECT pedido.numPedido, pedido.usuario AS email, usuario.apellidos, usuario.nombre, localidad.pueblo AS nombre_localidad
FROM pedido
INNER JOIN usuario ON pedido.usuario = usuario.email 
INNER JOIN localidad ON usuario.pueblo = localidad.codm;

/* T05.003- Número de pedido e identificador, apellidos y nombre del usuario que realiza el
pedido, nombre de la localidad y nombre de la provincia del usuario (usando join). */
SELECT pedido.numPedido, pedido.usuario AS email, usuario.apellidos, usuario.nombre, localidad.pueblo, provincia.nombre
FROM pedido
INNER JOIN usuario ON pedido.usuario = usuario.email
INNER JOIN localidad ON usuario.pueblo = localidad.codm
INNER JOIN provincia ON provincia.codp = usuario.provincia;

/* T05.004- Nombre de provincia y nombre de localidad ordenados por provincia y localidad
(usando join) de las provincias de Aragón y de localidades cuyo nombre comience por "B". */
SELECT provincia.nombre, localidad.pueblo 
FROM provincia
INNER JOIN localidad ON localidad.provincia = provincia.codp
WHERE provincia.nombre = 'Aragón' OR localidad.pueblo LIKE 'b%';

/* T05.005- Apellidos y nombre de los usuarios y, si tienen, pedido que han realizado. */
SELECT usuario.apellidos, usuario.nombre, pedido.numPedido
FROM pedido
INNER JOIN usuario ON pedido.usuario = usuario.email;

/* T05.006- Código y nombre de los artículos, si además es una cámara, mostrar también la
resolución y el sensor. */
SELECT articulo.cod, articulo.nombre, camara.resolucion AS relosucion_camara, camara.sensor AS sensor_camara FROM articulo
LEFT JOIN camara ON camara.cod = articulo.cod;

/* T05.007- Código, nombre y precio de venta al público de los artículos, si además se trata
de un objetivo mostrar todos sus datos. */
SELECT articulo.cod, articulo.nombre, linped.precio, objetivo.tipo, objetivo.montura, objetivo.focal, objetivo.apertura, objetivo.especiales  
FROM articulo
LEFT JOIN linped ON linped.articulo = articulo.cod
LEFT JOIN objetivo ON objetivo.cod = articulo.cod;

/* T05.008- Muestra las cestas del año 2010 junto con el nombre del artículo al que
referencia y su precio de venta al público. */
SELECT cesta.fecha, articulo.nombre, linped.precio 
FROM cesta
INNER JOIN articulo ON cesta.articulo = articulo.cod 
LEFT JOIN linped ON  linped.articulo = articulo.cod
WHERE YEAR(cesta.fecha) = '2010';

/* T05.009- Muestra toda la información de los artículos. Si alguno aparece en una cesta del
año 2010 muestra esta información. */
SELECT *, cesta.fecha AS fecha_cesta
FROM articulo
LEFT JOIN cesta ON cesta.articulo = articulo.cod
AND YEAR(cesta.fecha) = '2010'; 


/* T05.010- Disponibilidad en el stock de cada cámara junto con la resolución de todas las
cámaras. */
SELECT stock.disponible, camara.resolucion 
FROM camara
LEFT JOIN articulo ON camara.cod = articulo.cod
LEFT JOIN stock ON stock.articulo = articulo.cod;

/* T05.011- Código y nombre de los artículos que no tienen marca. */
SELECT cod, nombre, marca 
FROM articulo
WHERE marca IS NULL;

/* T05.012- Código, nombre y marca de todos los artículos, tengan o no marca. */
SELECT cod, nombre, marca 
FROM articulo;

/* T05.013- Código, nombre, marca y empresa responsable de la misma de todos los artículos. 
Si algún artículo no tiene marca debe aparecer en el listado con esta información vacía. */
SELECT articulo.cod, articulo.nombre, marca.marca, marca.empresa
FROM articulo
LEFT JOIN marca ON articulo.marca = marca.marca;

/* T05.014- Información de todos los usuarios de la comunidad valenciana cuyo nombre
empiece por 'P' incluyendo la dirección de envío en caso de que la tenga. */
SELECT *, localidad.pueblo, direnvio.calle 
FROM usuario
INNER JOIN localidad ON localidad.codm = usuario.pueblo
LEFT JOIN direnvio ON direnvio.email = usuario.email
AND localidad.pueblo LIKE '%valencia%' AND usuario.nombre LIKE 'p%'; 

/* T05.015- Código y nombre de los artículos, y código de pack en el caso de que pertenezca
a alguno. */
SELECT articulo.cod, articulo.nombre, pack.cod AS cod_pack
FROM articulo
LEFT JOIN pack ON pack.cod = articulo.cod;

/* T05.016- Usuarios y pedidos que han realizado. */
SELECT usuario.email, pedido.numPedido 
FROM usuario
INNER JOIN pedido ON usuario.email = pedido.usuario;

/* T05.017- Información de aquellos usuarios de la comunidad valenciana (códigos 03, 12 y 46) 
cuyo nombre empiece por 'P' que tienen dirección de envío pero mostrando, a la
derecha, todas las direcciones de envío de la base de datos. */
SELECT usuario.nombre, usuario.apellidos, provincia.nombre, direnvio.calle AS direc_envio
FROM usuario
LEFT JOIN provincia ON provincia.codp = usuario.provincia
LEFT JOIN direnvio ON direnvio.email = usuario.email
WHERE usuario.nombre LIKE 'p%' AND (provincia.nombre LIKE '%valencia%' OR provincia.nombre IS NULL);