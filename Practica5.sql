-- PRACTICA 5 --

-- 5 simple selects with where clause:

-- 1
SELECT ID_Cliente, NombreCompleto FROM Clientes WHERE Edad BETWEEN 24 AND 30
-- 2
SELECT RFC, RazonSocial FROM Proveedores WHERE Colonia IN ('GUADALUPE', 'CALETA')
-- 3
SELECT Nombre, DireccionAlmacen FROM Almacenes WHERE Estado <> 'Jalisco'
-- 4
SELECT Nombre, Costo FROM Producto WHERE Costo >= 550
-- 5
SELECT ID_Pedido, ID_Cliente FROM Pedidos WHERE FechaPedido = '2020-01-25'

-- 5 selects with Group by clause:

--1
SELECT Categoria, COUNT(ID_Producto) AS TotalProductos
FROM Producto
GROUP BY Categoria;
-- 2
SELECT Estado, COUNT(ID_Almacen) AS TotalAlamcenes
FROM Almacenes
GROUP BY Estado;
-- 3
SELECT ID_Proveedor, COUNT(ID_Producto) AS TotalVentas
FROM Pedidos
GROUP BY ID_Proveedor;
 -- 4
SELECT Edad, COUNT(ID_Cliente) AS TotalEdad
FROM Clientes
GROUP BY Edad;
-- 5
SELECT Colonia,  COUNT(ID_Proveedor) AS TotalProveedores
FROM Proveedores
GROUP BY Colonia;

-- 5 selects using *aggregate funtions:

-- 1
SELECT COUNT(*) AS NumeroClientes 
FROM Clientes;  
-- 2
SELECT AVG(Edad) AS PromedioEdad 
FROM Clientes;  
-- 2
SELECT MAX(Costo) AS CostoMaximo 
FROM Producto;
-- 4
SELECT SUM(ID_Pedido) AS TotalPedidos 
FROM Pedidos;
-- 5
SELECT SUM(ID_Pedido) AS TotalPedidos 
FROM Pedidos;

-- 5 select with Having clause:

-- 1
SELECT COUNT(ID_Cliente) AS ClientesTotales_Mayores23, Edad
FROM Clientes
GROUP BY Edad
HAVING Edad > 23
-- 2
SELECT COUNT(ID_Proveedor) AS TotaProveedores_NuevoLeon, Estado
FROM Proveedores
GROUP BY Estado
HAVING Estado = 'Nuevo Leon'
-- 3
SELECT COUNT(ID_Pedido) AS PedidosTotalesDia_2020, FechaPedido
FROM Pedidos
GROUP BY FechaPedido
HAVING FechaPedido BETWEEN '2020-01-01' AND '2020-12-31'
-- 4
SELECT COUNT(ID_Producto) AS Total_ProductosNutricion, Categoria
FROM Producto
GROUP BY Categoria
HAVING Categoria = 'Nutricion'
-- 5
SELECT Colonia, COUNT(ID_Almacen) AS TotalAlmacenes
FROM Almacenes
GROUP BY Colonia
HAVING Colonia = 'San Patricio'

-- 5 Select with Top:

-- 1
SELECT TOP 5 * FROM Clientes;
-- 2
SELECT TOP 50 PERCENT * FROM Proveedores 
WHERE CodigoPostal BETWEEN 66000 AND 99000
-- 3
SELECT TOP 3 * FROM Producto
WHERE Costo < 300
-- 4
SELECT TOP 3 * FROM Almacenes
WHERE Estado = 'Ciudad de Mexico';
-- 5
SELECT TOP 20 PERCENT * FROM Pedidos 
WHERE ID_Proveedor = 4
