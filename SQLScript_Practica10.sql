USE [master]
GO
/****** Object:  Database [LBD]    Script Date: 05/06/2020 09:13:58 a. m. ******/
CREATE DATABASE [LBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LBD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LBD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LBD] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [LBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LBD] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LBD] SET RECOVERY FULL 
GO
ALTER DATABASE [LBD] SET  MULTI_USER 
GO
ALTER DATABASE [LBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LBD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LBD] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LBD', N'ON'
GO
ALTER DATABASE [LBD] SET QUERY_STORE = OFF
GO
USE [LBD]
GO

/****** Object:  StoredProcedure [dbo].[BsucarPedidosPorFecha]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BsucarPedidosPorFecha] @datePedido date
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
GO
/****** Object:  StoredProcedure [dbo].[BuscarTotalProveedoresPorEstado]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarTotalProveedoresPorEstado] @Estado varchar(50)
AS
SELECT COUNT(ID_Proveedor) AS TotaProveedores, Estado
FROM Proveedores
GROUP BY Estado
HAVING Estado = @Estado
GO
/****** Object:  StoredProcedure [dbo].[ReporteAlmacenes]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReporteAlmacenes] @numPedidos int 
AS
SELECT Almacenes.Nombre, COUNT(Pedidos.ID_Pedido) AS NumberOfOrders
FROM (Pedidos
INNER JOIN Almacenes ON Pedidos.ID_Almacen = Almacenes.ID_Almacen)
GROUP BY Nombre
HAVING COUNT(Pedidos.ID_Pedido) > @numPedidos
GO
/****** Object:  StoredProcedure [dbo].[TotalAlamcenesPorPais]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TotalAlamcenesPorPais] @pais varchar(50)
AS
SELECT Pais, COUNT(ID_Almacen)AS ID_Alamacen
FROM Almacenes
GROUP BY Pais  
HAVING Pais = @pais
GO
USE [master]
GO
ALTER DATABASE [LBD] SET  READ_WRITE 
GO
/****** Object:  Table [dbo].[log_historial]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_historial](
	[nombre] [varchar](50) NULL,
	[Fecha] [date] NULL,
	[descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO
-- instead of trigger
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

