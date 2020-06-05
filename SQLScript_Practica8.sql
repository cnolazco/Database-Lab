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

-- – 1 Select With * 1 Select into
CREATE SCHEMA AlmacenesGuanajuato
SELECT * INTO AlmacenesGuanajuato
FROM Almacenes
WHERE Estado = 'Guanajuato';

/****** Object:  Table [dbo].[AlmacenesGuanajuato]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlmacenesGuanajuato](
	[ID_Almacen] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Calle] [varchar](50) NOT NULL,
	[NumeroExt] [varchar](20) NOT NULL,
	[NumeroInt] [varchar](50) NOT NULL,
	[Colonia] [varchar](50) NOT NULL,
	[CodigoPostal] [varchar](50) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[Pais] [varchar](50) NOT NULL,
	[DireccionAlmacen] [varchar](327) NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Schema [AlmacenesGuanajuato]    Script Date: 05/06/2020 09:13:58 a. m. ******/
CREATE SCHEMA [AlmacenesGuanajuato]
GO