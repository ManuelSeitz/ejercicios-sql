-- 1) Obtener el total de ventas en pesos (es decir, monto total en pesos $).
SELECT SUM(total) AS monto_total
FROM Factura;

-- 2) Obtener la cantidad de ventas realizadas (cantidad de facturas emitidas).
SELECT COUNT(numero) AS facturas_emitidas
FROM Factura;

-- 3) Obtener el promedio de ventas general 
-- (monto total facturado dividido la cantidad de facturas)
SELECT AVG(total) AS monto_promedio
FROM Factura;

-- 4) Obtener el total vendido por fecha (es decir, monto total diario)
SELECT fecha, SUM(total) AS monto_total
FROM Factura
GROUP BY fecha;

-- 5) Obtener el total vendido por mes (monto total vendido por mes)
SELECT MONTH(fecha) AS mes, SUM(total) AS monto_total
FROM Factura
GROUP BY MONTH(fecha);

-- 6) Obtener el monto total vendido por año.
SELECT YEAR(fecha) AS año, SUM(total) AS monto_total
FROM Factura
GROUP BY YEAR(fecha);

-- 7) Obtener un listado con el monto total de las ventas realizadas en el mes de Mayo, 
-- ordenado por importe descendente.
SELECT fecha, SUM(total) AS monto_total
FROM Factura
WHERE MONTH(fecha) = 5
GROUP BY fecha
ORDER BY monto_total DESC;

-- 8) Listar el monto total de ventas de aquellos meses que superen 
-- $ 10.000.000 (diez millones de pesos).
SELECT MONTH(fecha) AS mes, SUM(total) AS monto_total
FROM Factura
GROUP BY MONTH(fecha)
HAVING SUM(total) > 10000000;

-- 9) Obtener un listado con los tres productos que más se vendieron (en pesos) cuyo monto
-- supere los $ 800.000, ordenar el listado por importe en forma descendente.
SELECT TOP 3
  P.nombre, SUM(D.p_unit * D.cant) AS importe
FROM Producto AS P
  JOIN Detalle AS D ON P.id = D.id_producto
GROUP BY P.nombre
HAVING SUM(D.p_unit * D.cant) > 800000
ORDER BY importe DESC;

-- 10) Mostrar el mejor precio de cada rubro, la cantidad de artículos del rubro, 
-- el código del rubro y la descripción del mismo.
SELECT R.id, R.descripcion, MIN(P.precio) AS mejor_precio, COUNT(P.id) AS cantidad
FROM Rubro AS R
  JOIN Producto AS P ON R.id = P.id_rubro
GROUP BY R.id, R.descripcion;

-- 11) Mostrar los datos de los rubros cuyo precio promedio de productos sea $ 8.000 y el rubro
-- tenga más de dos artículos.
SELECT R.id, R.descripcion, AVG(P.precio) AS precio_promedio, COUNT(P.id) AS cantidad_productos
FROM Rubro AS R
  JOIN Producto AS P ON R.id = P.id_rubro
GROUP BY R.id, R.descripcion
HAVING AVG(P.precio) > 8000 AND COUNT(P.id) > 2;

-- 12) Obtener un listado con los clientes que compraron más de $ 900.000 en el año 2023,
-- ordenado por importe descendente.
SELECT C.nombre, C.apellido, SUM(F.total) AS importe, YEAR(F.fecha) AS año
FROM Cliente AS C
  JOIN Factura AS F ON F.id_cliente = C.id
WHERE YEAR(F.fecha) = 2023
GROUP BY C.nombre, C.apellido, YEAR(F.fecha)
HAVING SUM(F.total) > 900000;

-- 13) Obtener un listado con los 5 clientes que menos compraron en el año 2023 ordenado por
-- importe ascendente.
SELECT TOP 5
  C.nombre, C.apellido, SUM(F.total) AS importe, YEAR(F.fecha) AS año
FROM Cliente AS C
  JOIN Factura AS F ON F.id_cliente = C.id
WHERE YEAR(F.fecha) = 2023
GROUP BY C.nombre, C.apellido, YEAR(F.fecha)
ORDER BY importe ASC;

-- 14) Obtener un listado con las facturas de más de $ 1.000.000 de los clientes cuyo nombre
-- comience con “C”, ordenado por importe descendente.
SELECT C.nombre, C.apellido, F.*
FROM Factura AS F
  JOIN Cliente AS C ON F.id_cliente = C.id
WHERE F.total > 1000000 AND C.nombre LIKE 'C%'
ORDER BY F.total DESC;