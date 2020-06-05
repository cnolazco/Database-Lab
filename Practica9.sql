
-- PRACTICA 9 --

-- 1
CREATE VIEW [Reporte de Pedidos - 2020] 
AS
SELECT 
	Pedidos.ID_Pedido,
	Clientes.NombreCompleto AS Cliente, 
	Proveedores.RFC AS Proveedor_RFC,
	Almacenes.Nombre AS Almacen, 
	Producto.Nombre AS Producto 
FROM Pedidos
	INNER JOIN Clientes ON Pedidos.ID_Cliente = Clientes.ID_Cliente
	INNER JOIN Proveedores ON Pedidos.ID_Proveedor = Proveedores.ID_Proveedor
	INNER JOIN Almacenes ON Pedidos.ID_Almacen = Almacenes.ID_Almacen
	INNER JOIN Producto ON Pedidos.ID_Producto = Producto.ID_Producto
WHERE FechaPedido > '2020-01-01'
SELECT * FROM [Reporte de Pedidos - 2020] 
-- 2
CREATE VIEW [AlamcenesPor_Pais] AS
SELECT Pais, COUNT(ID_Almacen)AS ID_Alamacen
FROM Almacenes
GROUP BY Pais
SELECT * FROM [AlamcenesPor_Pais]
-- 3
CREATE VIEW [Alamcenes_NuevoLeon] AS
SELECT COUNT(ID_Proveedor) AS TotaProveedores_NuevoLeon, Estado
FROM Proveedores
GROUP BY Estado
HAVING Estado = 'Nuevo Leon'
SELECT * FROM [Alamcenes_NuevoLeon]
-- 4
CREATE VIEW [Reporte de Clientes con Compras] 
AS
SELECT 
	Clientes.ID_Cliente,
	Clientes.NombreCompleto AS Nombre,
	Clientes.FechaDeNacimiento AS FechaNacimiento,
	Clientes.CorreoElectronico AS Email
FROM Clientes
	INNER JOIN Pedidos ON Pedidos.ID_Cliente = Clientes.ID_Cliente
SELECT * FROM [Reporte de Clientes con Compras] 
-- 5
CREATE VIEW [Listado de Almacenes con mas de 1 Pedido] 
AS
SELECT Almacenes.Nombre, COUNT(Pedidos.ID_Pedido) AS NumberOfOrders
FROM (Pedidos
INNER JOIN Almacenes ON Pedidos.ID_Almacen = Almacenes.ID_Almacen)
GROUP BY Nombre
HAVING COUNT(Pedidos.ID_Pedido) > 1;
SELECT * FROM [Listado de Almacenes con mas de 1 Pedido] 
