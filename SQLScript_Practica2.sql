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
/****** Object:  Table [dbo].[Clientes]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ID_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[PrimerApellido] [varchar](50) NOT NULL,
	[SegundoApellido] [varchar](50) NOT NULL,
	[NombreCompleto]  AS (((([Nombre]+' ')+[PrimerApellido])+' ')+[SegundoApellido]),
	[FechaDeNacimiento] [datetime] NOT NULL,
	[Edad] [int] NOT NULL,
	[CorreoElectronico] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[ID_Pedido] [int] IDENTITY(1,1) NOT NULL,
	[ID_Cliente] [int] NOT NULL,
	[ID_Producto] [int] NOT NULL,
	[ID_Proveedor] [int] NOT NULL,
	[ID_Almacen] [int] NOT NULL,
	[FechaPedido] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[ID_Producto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Categoria] [varchar](50) NOT NULL,
	[Proveedor] [int] NOT NULL,
	[Costo] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[ID_Proveedor] [int] IDENTITY(1,1) NOT NULL,
	[RFC] [varchar](13) NOT NULL,
	[RazonSocial] [varchar](50) NOT NULL,
	[Calle] [varchar](50) NOT NULL,
	[NumeroExt] [varchar](10) NOT NULL,
	[NumeroInt] [varchar](50) NOT NULL,
	[Colonia] [varchar](50) NOT NULL,
	[CodigoPostal] [varchar](50) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[Pais] [varchar](50) NOT NULL,
	[DireccionProveedor]  AS ((((((((((((([Calle]+' ')+[NumeroInt])+' ')+[NumeroExt])+' ')+[Colonia])+' ')+[CodigoPostal])+' ')+[Estado])+' ')+[Pais])+' '),
PRIMARY KEY CLUSTERED 
(
}	[ID_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Almacenes]    Script Date: 05/06/2020 09:13:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Almacenes](
	[ID_Almacen] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Calle] [varchar](50) NOT NULL,
	[NumeroExt] [varchar](20) NOT NULL,
	[NumeroInt] [varchar](50) NOT NULL,
	[Colonia] [varchar](50) NOT NULL,
	[CodigoPostal] [varchar](50) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[Pais] [varchar](50) NOT NULL,
	[DireccionAlmacen]  AS ((((((((((((([Calle]+' ')+[NumeroInt])+' ')+[NumeroExt])+' ')+[Colonia])+' ')+[CodigoPostal])+' ')+[Estado])+' ')+[Pais])+' '),
PRIMARY KEY CLUSTERED 
(
	[ID_Almacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [index_FechaEmisionPedidos]    Script Date: 05/06/2020 09:13:58 a. m. ******/
CREATE NONCLUSTERED INDEX [index_FechaEmisionPedidos] ON [dbo].[Pedidos]
(
	[FechaPedido] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
