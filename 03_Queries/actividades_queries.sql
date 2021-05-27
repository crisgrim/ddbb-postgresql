-- 1.1 Obtener los nombres de los productos de la tienda
SELECT NOMBRE FROM articulos ORDER BY NOMBRE

-- 1.2 Obtener los nombres y los precios de los productos de la tienda
SELECT NOMBRE, PRECIO FROM articulos ORDER BY PRECIO

-- 1.3 Obtener el nombre de los productos cuyos precio sea menor o igual a 200
SELECT NOMBRE FROM articulos WHERE PRECIO <= 200 ORDER BY NOMBRE

-- 1.4 Obtener todos los datos de los artículos cuyo precio esté entre 60 y 120
SELECT * FROM articulos WHERE (PRECIO BETWEEN 60 AND 120) ORDER BY NOMBRE

-- 1.5 Obtener el nombre y precio en pesetas
SELECT NOMBRE, round(PRECIO * (166.386), 2) as PRECIO_PESETAS FROM articulos ORDER BY PRECIO

-- 1.6 Seleccionar el precio medio de todos los productos
SELECT AVG(PRECIO)::numeric(10,2) FROM articulos

-- 1.7 Obtener el precio medio de los articulos cuyo fabricante sea 2
SELECT AVG(PRECIO)::numeric(10,2) FROM articulos WHERE FABRICANTE=2

-- 1.8 Obtener el numero de articulos cuyo precio sea mayor o igual a 180
SELECT COUNT(CODIGO) FROM articulos WHERE PRECIO >= 180

-- 1.9 Obtener nombre y precio de los articulos cuyo precio sea mayor o igual 180
-- ordenar descendentemente por precio y luego ascendentemente por nombre
SELECT NOMBRE, PRECIO FROM articulos WHERE PRECIO >=180 ORDER BY PRECIO DESC, NOMBRE ASC

-- 1.10 Obtener un listado completo de articulos incluyendo por cada articulo
-- los datos del articulo y de su fabricante
SELECT * FROM articulos INNER JOIN fabricantes ON articulos.FABRICANTE=fabricantes.CODIGO

-- 1.11 Obtener un listado de articulos incluyendo su nombre, su precio
-- y el nombre del fabricante
SELECT
    articulos.NOMBRE as NOMBRE_ARTICULO,
    articulos.PRECIO, fabricantes.NOMBRE as NOMBRE_FABRICANTE
FROM articulos
LEFT JOIN fabricantes
    ON articulos.FABRICANTE=fabricantes.CODIGO

-- 1.12 Obtener el precio medio de los productos de cada fabricante,
-- mostrando solo los códigos del fabricante
SELECT
	fabricantes.CODIGO as FABRICANTE_CODIGO,
	AVG(articulos.PRECIO)::numeric(10,2) as PRECIO_MEDIO
FROM fabricantes
LEFT JOIN articulos
	ON fabricantes.CODIGO=articulos.FABRICANTE
GROUP BY fabricantes.CODIGO

-- 1.13 Obtener el precio medio de los productos de cada fabricante,
-- mostrando el nombre del fabricante
SELECT
	fabricantes.NOMBRE as FABRICANTE_NOMBRE,
	AVG(articulos.PRECIO)::numeric(10,2) as PRECIO_MEDIO
FROM fabricantes
LEFT JOIN articulos
	ON fabricantes.CODIGO=articulos.FABRICANTE
GROUP BY fabricantes.NOMBRE

-- 1.14 Obtener los nombres de los fabricantes que ofrezcan productos
-- cuyo precio medio sea mayor o igual a 150
SELECT fabricantes.NOMBRE
FROM fabricantes
WHERE fabricantes.CODIGO IN
(
	SELECT articulos.FABRICANTE
	FROM articulos 
	GROUP BY articulos.FABRICANTE
	HAVING AVG(articulos.PRECIO) >= 150
)

-- 1.15 Obtener el nombre y el precio del articulo más barato
SELECT
    NOMBRE
FROM articulos
WHERE PRECIO = (SELECT MIN(PRECIO) FROM articulos)

-- 1.16 Obtener nombre y precio de articulos más caros de cada fabricante
-- incluyendo su nombre
SELECT
	articulos.NOMBRE,
	articulos.PRECIO,
	fabricantes.NOMBRE as FABRICANTE_NOMBRE
FROM articulos
LEFT JOIN fabricantes
	ON articulos.FABRICANTE = fabricantes.CODIGO
WHERE PRECIO IN (
	SELECT MAX(articulos.PRECIO)
	FROM articulos
	GROUP BY articulos.FABRICANTE
)

-- 1.17 Añadir nuevo producto: Altavoces, 70€, Fabricante 2
INSERT INTO articulos VALUES (11,'Altavoces',70,2);

-- 1.18 Cambiar el nombre del producto 8 a Impresora Láser
UPDATE articulos
SET NOMBRE = 'Impresora Láser' 
WHERE CODIGO = 8;

-- 1.19 Aplicar 10% dto a todos los productos
UPDATE articulos
SET PRECIO = PRECIO * 0.9

-- 1.20 Aplicar descuento de 10€ a los productos mayor o igual que 120
UPDATE articulos
SET PRECIO = PRECIO - 10
WHERE PRECIO >= 120
