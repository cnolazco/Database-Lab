
-- PRACTICA 8

-- LEFT JOIN
SELECT Clientes.NombreCompleto, Pedidos.ID_Pedido
FROM Clientes
LEFT JOIN Pedidos ON Clientes.ID_Cliente = Pedidos.ID_Cliente
ORDER BY Clientes.NombreCompleto;

SELECT Almacenes.Nombre, Pedidos.ID_Pedido
FROM Almacenes
LEFT JOIN Pedidos ON Almacenes.ID_Almacen = Pedidos.ID_Almacen
ORDER BY Almacenes.Nombre;

-- RIGHT JOIN
SELECT Pedidos.ID_Pedido, Proveedores.RFC, Proveedores.RazonSocial
FROM Pedidos
RIGHT JOIN Proveedores ON Pedidos.ID_Proveedor = Proveedores.ID_Proveedor
ORDER BY Pedidos.ID_Pedido;

SELECT Pedidos.ID_Pedido, ProductO.ID_Producto, Producto.Nombre, Producto.Costo
FROM Pedidos
RIGHT JOIN Producto ON Pedidos.ID_Producto = Producto.ID_Producto
ORDER BY Pedidos.ID_Pedido;

-- INNER JOIN
SELECT Pedidos.ID_Pedido, Clientes.NombreCompleto AS Cliente, Proveedores.RFC AS Proveedor_RFC, Almacenes.Nombre AS Almacen, 
Producto.Nombre AS Producto FROM Pedidos
INNER JOIN Clientes ON Pedidos.ID_Cliente = Clientes.ID_Cliente
INNER JOIN Proveedores ON Pedidos.ID_Proveedor = Proveedores.ID_Proveedor
INNER JOIN Almacenes ON Pedidos.ID_Almacen = Almacenes.ID_Almacen
INNER JOIN Producto ON Pedidos.ID_Producto = Producto.ID_Producto

SELECT Producto.ID_Producto, Producto.Nombre AS Producto, Producto.Costo, Proveedores.RFC AS Proveedor FROM Producto
INNER JOIN Proveedores ON Producto.Proveedor = Proveedores.ID_Proveedor

-- 1 subquery
SELECT Clientes.Nombre, Clientes.PrimerApellido, 
TotalPedidos = (SELECT COUNT(Pedidos.ID_Cliente) FROM Pedidos WHERE Pedidos.ID_Cliente = Clientes.ID_Cliente)
FROM Clientes

--- – 1 Select With * 1 Select into
CREATE SCHEMA AlmacenesGuanajuato
SELECT * INTO AlmacenesGuanajuato
FROM Almacenes
WHERE Estado = 'Guanajuato';
