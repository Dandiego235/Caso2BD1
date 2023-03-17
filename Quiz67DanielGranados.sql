/*
Quiz 6 y 7, Bases de Datos I
Daniel Granados Retana, carné 2022104692

Ejercicios de la instrucción select

2.1 seleccione la receta es decir los ingredientes y su cantidad para un producto específico
output: nombre del producto, nombre del ingrediente, cantidad necesaria;*/

SELECT copoProductos.nombre, ingredientes.descripcion, ingredientesPorProductos.cantidad FROM copoProductos
INNER JOIN ingredientesPorProductos ON copoProductos.productoId = ingredientesPorProductos.productoId
INNER JOIN ingredientes ON ingredientes.ingredienteId = ingredientesPorProductos.ingredienteId;

/*2.2 muestre todos los productos con su precio actual ordenados de precio mayor a precio menor.
Tome en cuenta que el producto podría tener o no precio especial por playa.
output: nombre del producto, precio, un flag que diga si este es precio especial de playa, beachname;*/

SELECT copoProductos.nombre,
COALESCE(preciosPorProducto.precio, preciosDefault.precio) precio,
CASE WHEN isnull(preciosPorProducto.precio) THEN 'No' ELSE 'Si' END flagEspecial,
IFNULL(playas.nombre, 'No asociado a playa') playa
FROM copoProductos
INNER JOIN preciosDefault ON copoProductos.productoId = preciosDefault.productoId
LEFT JOIN preciosPorProducto ON preciosPorProducto.productoId = copoProductos.productoId
LEFT JOIN playas ON playas.playaId = preciosPorProducto.playaId
WHERE preciosDefault.enabled = 1 OR preciosPorProducto.enabled = 1 ORDER BY precio DESC;

/*2.3 averigue que ingredientes son usados en únicamente un solo producto
output: nombre del producto, nombre del ingrediente*/

SELECT copoProductos.nombre AS nombreProducto, ingredientes.descripcion  AS nombreIngrediente FROM ingredientesPorProductos ipp
INNER JOIN ingredientes ON ipp.ingredienteId = ingredientes.ingredienteId
INNER JOIN copoProductos ON ipp.productoId = copoProductos.productoId
WHERE ipp.ingredienteId NOT IN (SELECT ingredienteId FROM ingredientesPorProductos WHERE ingredientesPorProductos.productoId != ipp.productoId);
-- agarra los ingredientes que no son usados en los otros productos. El segundo select retorna los ingredientes que son usados en los otros productos,
-- por lo que nos quedamos con ese ingrediente solo si no aparece con los otros productos.

/*2.4 liste cuanto se ha vendido en una playa específica durante una fecha inicial y una fecha final
output: nombre de la playa, monto vendido, fecha inicial, fechafinal*/

SET @fechaInicial4 = CONVERT("2022-01-01", DATETIME);
SET @fechaFinal4 = CONVERT ("2022-02-01", DATETIME);

SELECT playas.nombre AS nombrePlaya, SUM(copoVentas.monto) AS montoVendido, @fechaInicial4 AS fechaInicial, @fechaFinal4 AS fechaFin
FROM copoVentas INNER JOIN turnos ON copoVentas.turnoId = turnos.turnoId
INNER JOIN playas ON playas.playaId = turnos.playaId
WHERE copoVentas.postDate BETWEEN @fechaInicial4 AND @fechaFinal4 AND turnos.playaId = 2 GROUP BY turnos.playaId;
