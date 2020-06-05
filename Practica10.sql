
--Practica 10

-- SP 1
CREATE PROCEDURE ReporteAlmacenes @numPedidos int 
AS
SELECT Almacenes.Nombre, COUNT(Pedidos.ID_Pedido) AS NumberOfOrders
FROM (Pedidos
INNER JOIN Almacenes ON Pedidos.ID_Almacen = Almacenes.ID_Almacen)
GROUP BY Nombre
HAVING COUNT(Pedidos.ID_Pedido) > @numPedidos
EXEC ReporteAlmacenes @numPedidos = 0;

-- SP2
CREATE PROCEDURE BuscarTotalProveedoresPorEstado @Estado varchar(50)
AS
SELECT COUNT(ID_Proveedor) AS TotaProveedores, Estado
FROM Proveedores
GROUP BY Estado
HAVING Estado = @Estado
EXEC BuscarTotalProveedoresPorEstado @Estado = 'Jalisco';

-- SP3
CREATE PROCEDURE BsucarPedidosPorFecha @datePedido date
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
WHERE FechaPedido = @datePedido
EXEC BsucarPedidosPorFecha @datePedido = '2020-01-25'

-- SP4
CREATE PROCEDURE TotalAlamcenesPorPais @pais varchar(50)
AS
SELECT Pais, COUNT(ID_Almacen)AS ID_Alamacen
FROM Almacenes
GROUP BY Pais  
HAVING Pais = @pais
EXEC TotalAlamcenesPorPais @pais = 'Estados Unidos'

-- SP5 

-- instead of trigger

CREATE TABLE log_historial(
nombre varchar(50),
Fecha date,
descripcion varchar (50)
)

CREATE TRIGGER TR_log_Cliente ON Clientes
INSTEAD OF INSERT
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO log_historial(nombre, fecha, descripcion) SELECT nombre, GETDATE(), 'Registro nuevo'
FROM inserted
END

INSERT INTO Clientes VALUES ('Aria Daniela', 'Benavides', 'Reyna', '1999-02-13', 21, 'aria@gmail.com') 
SELECT * FROM Clientes
SELECT * FROM log_historial

-- AFTER TRIGGER
CREATE TRIGGER TR_Cliente_Estatico ON Clientes
AFTER INSERT 
AS
BEGIN
	SELECT * FROM inserted
	SELECT * FROM deleted
END
GO
INSERT INTO Clientes VALUES ('Ramiro Andre', 'Villasana', 'Treviño', '1999-02-13', 21, 'ramtrev@gmail.com') 
