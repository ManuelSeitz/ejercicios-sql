-- 1) Listar el nombre y código de todos los clientes.
SELECT nombre, id
FROM Cliente;


-- 2) Obtener un listado con el detalle de los productos que vende la empresa.
SELECT num_factura, id_producto, p_unit, cant
FROM Detalle;


-- 3) Obtener los datos de los clientes deudores (saldo negativo).
SELECT nombre, apellido, id, domicilio, localidad, saldo
FROM Cliente
WHERE saldo < 0


-- 4) Averiguar los clientes que vivan en Capital o en Tandil y no sean deudores.
SELECT *
FROM Cliente
WHERE (localidad = 'Capital' OR localidad = 'Tandil') AND saldo >= 0;


-- 5) Listar las facturas emitidas mostrando el detalle de cada una.
SELECT Factura.numero AS num_factura, Detalle.p_unit, Detalle.cant, Detalle.id_producto
FROM Factura
  JOIN Detalle ON Factura.numero = Detalle.num_factura


-- 6) En la consulta anterior agregar la descripción del producto.
SELECT F.numero AS num_factura, D.p_unit, D.cant, D.id_producto, P.descripcion
FROM Factura AS F
  RIGHT JOIN Detalle AS D ON F.numero = D.num_factura
  LEFT JOIN Producto AS P ON D.id_producto = P.id;


-- 7) Recuperar sólo aquellos productos cuyo precio unitario sea mayor a $ 15000.
SELECT P.*, D.p_unit
FROM Producto AS P
  LEFT JOIN Detalle AS D ON P.id = D.id_producto
WHERE D.p_unit > 15000;


-- 8) Obtener un listado con los nombres de los productos cuyo precio unitario se encuentre 
-- entre $ 10000 y $30000.
SELECT DISTINCT P.nombre, D.p_unit
FROM Producto AS P
  JOIN Detalle AS D ON P.id = D.id_producto
WHERE D.p_unit BETWEEN 10000 AND 30000;


-- 9) Mostrar los datos de todos los productos y agregar una columna con el precio incrementado 
-- un 25%. Llamar a la columna calculada “Incremento”.
SELECT *, (precio * 1.25) AS incremento
FROM Producto;


-- 10) Listar todos los productos cuya cantidad vendida supere las 2000 unidades.
SELECT P.id, P.nombre, P.descripcion, SUM(D.cant) AS cantidad_vendida
FROM Producto AS P
  JOIN Detalle AS D ON P.id = D.id_producto
GROUP BY P.id, P.nombre, P.descripcion
HAVING SUM(D.cant) > 2000


-- 11) Listar todos los productos cuya descripción comience con “Ma”.
SELECT *
FROM Producto
WHERE descripcion LIKE 'Ma%';


-- 12) Listar los clientes cuyo apellido sea Rodríguez o Rodriguez.
SELECT *
FROM Cliente
WHERE apellido LIKE 'Rodr[ií]guez';


-- 13)  Listar los clientes que tengan nombre que termine con “an”.
SELECT *
FROM Cliente
WHERE nombre LIKE '%an';


-- 14) Obtener todas las fechas distintas donde haya comprado el cliente cuyo código es CU138.
SELECT *
FROM Factura AS F JOIN Cliente AS C ON F.id_cliente = C.id
WHERE C.id = 1
-- Acá sería WHERE C.id = 'CU138', pero mi ID es un entero


-- 15) Listar el código de producto y la descripción de aquellos productos que no tengan 
-- asignado un rubro.
SELECT id, descripcion
FROM Producto
WHERE id_rubro IS NULL
