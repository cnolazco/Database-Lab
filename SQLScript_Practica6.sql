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
/****** Practica 3:  Add to the sql script backup at least 5 relations ******/
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_AlmacenOrder] FOREIGN KEY([ID_Almacen])
REFERENCES [dbo].[Almacenes] ([ID_Almacen])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_AlmacenOrder]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_ClienteOrder] FOREIGN KEY([ID_Cliente])
REFERENCES [dbo].[Clientes] ([ID_Cliente])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_ClienteOrder]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_ProductOrder] FOREIGN KEY([ID_Producto])
REFERENCES [dbo].[Producto] ([ID_Producto])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_ProductOrder]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_ProvedorOrder] FOREIGN KEY([Proveedor])
REFERENCES [dbo].[Proveedores] ([ID_Proveedor])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_ProvedorOrder]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [CHK_Edad] CHECK  (([Edad]>=(18)))
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [CHK_Edad]
GO
/****** Practica 6:  Add to the sql script backup the complete data sctructure and append: ******/
SET IDENTITY_INSERT [dbo].[Almacenes] ON 

INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (1, N'Birriesca', N'Cañada', N'230', N'Bodeaga 2', N'Torres de Parra', N'660131', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (2, N'Torrada', N'Monte Azul', N'22', N'Bodega N78', N'Mirador del Sol', N'66902', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (3, N'Amanayne', N'Gonzalitos', N'321', N'Bodega KT5', N'San Patricio', N'99784', N'Guanajuato', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (4, N'Galada', N'Sierra blanca', N'901', N'Bodega KT5', N'San Patricio', N'99784', N'Guanajuato', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (5, N'Amaranto', N'Kilimanjaro', N'133', N'Bodega I5', N'Villa hermosa', N'89364', N'Ciudad de Mexico', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (6, N'Tanzania', N'Armani', N'034', N'Bodega L02', N'Nave Cerrada', N'90732', N'Ciudad de Mexico', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (7, N'Granate', N'Amarillo', N'923', N'Bodega 1', N'Azul cielo', N'23784', N'Jalisco', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (8, N'Miraste', N'Muralillo', N'084', N'Local T5', N'Jardines de Anahuac', N'23897', N'Jalisco', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (9, N'Zaote', N'Cuahutemoc', N'762', N'Bodega 02J', N'Miraventana', N'12934', N'Sinaloa', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (10, N'Yate', N'Villa Gast', N'342', N'Unidad 9', N'Villa morada', N'12073', N'Sinaloa', N'Mexico')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (11, N'Malta', N'Franklin', N'762', N'02J', N'San Diego', N'12934', N'Califronia', N'Estados Unidos')
INSERT [dbo].[Almacenes] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (12, N'Raom', N'Grand Village', N'342', N'KO21', N'Michigan', N'34123', N'Colorado', N'Estados Unidos')
SET IDENTITY_INSERT [dbo].[Almacenes] OFF
GO
SET IDENTITY_INSERT [dbo].[AlmacenesGuanajuato] ON 

INSERT [dbo].[AlmacenesGuanajuato] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais], [DireccionAlmacen]) VALUES (3, N'Amanayne', N'Gonzalitos', N'321', N'Bodega KT5', N'San Patricio', N'99784', N'Guanajuato', N'Mexico', N'Gonzalitos Bodega KT5 321 San Patricio 99784 Guanajuato Mexico ')
INSERT [dbo].[AlmacenesGuanajuato] ([ID_Almacen], [Nombre], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais], [DireccionAlmacen]) VALUES (4, N'Galada', N'Sierra blanca', N'901', N'Bodega KT5', N'San Patricio', N'99784', N'Guanajuato', N'Mexico', N'Sierra blanca Bodega KT5 901 San Patricio 99784 Guanajuato Mexico ')
SET IDENTITY_INSERT [dbo].[AlmacenesGuanajuato] OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (2, N'Miguel', N'Hernandez', N'Ibarra', CAST(N'1995-10-12T00:00:00.000' AS DateTime), 24, N'mhernandez@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (3, N'Andrea Dayane', N'Gomez', N'Palacios', CAST(N'1998-06-22T00:00:00.000' AS DateTime), 22, N'andy@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (4, N'Carlos Andre', N'Carrea', N'Faz', CAST(N'1995-10-12T00:00:00.000' AS DateTime), 24, N'andrecar@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (5, N'Mariana', N'Rodriguez', N'Castro', CAST(N'1998-06-22T00:00:00.000' AS DateTime), 22, N'mardz@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (6, N'Veronica', N'Garza', N'Robles', CAST(N'1997-06-25T00:00:00.000' AS DateTime), 22, N'gvero@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (7, N'Mariano', N'Castañeda', N'Parra', CAST(N'1995-08-04T00:00:00.000' AS DateTime), 24, N'cast@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (8, N'Daniel Emiliano', N'Saenz', N'Lozano', CAST(N'1998-06-22T00:00:00.000' AS DateTime), 22, N'demuir@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (9, N'Sofia Elizabeth', N'Garza', N'Rangel', CAST(N'2000-04-13T00:00:00.000' AS DateTime), 20, N'sofgarza@gmail.com')
INSERT [dbo].[Clientes] ([ID_Cliente], [Nombre], [PrimerApellido], [SegundoApellido], [FechaDeNacimiento], [Edad], [CorreoElectronico]) VALUES (13, N'Adrian Alejandro', N'Reyes', N'Parra', CAST(N'1999-02-13T00:00:00.000' AS DateTime), 21, N'arp@gmail.com')
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
INSERT [dbo].[log_historial] ([nombre], [Fecha], [descripcion]) VALUES (N'Debanhy', CAST(N'2020-06-05' AS Date), N'Registro nuevo')
INSERT [dbo].[log_historial] ([nombre], [Fecha], [descripcion]) VALUES (N'Aria Daniela', CAST(N'2020-06-05' AS Date), N'Registro nuevo')
INSERT [dbo].[log_historial] ([nombre], [Fecha], [descripcion]) VALUES (N'Ramiro Andre', CAST(N'2020-06-05' AS Date), N'Registro nuevo')
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([ID_Pedido], [ID_Cliente], [ID_Producto], [ID_Proveedor], [ID_Almacen], [FechaPedido]) VALUES (4, 4, 7, 3, 7, CAST(N'2020-03-05' AS Date))
INSERT [dbo].[Pedidos] ([ID_Pedido], [ID_Cliente], [ID_Producto], [ID_Proveedor], [ID_Almacen], [FechaPedido]) VALUES (5, 5, 6, 6, 6, CAST(N'2020-01-25' AS Date))
INSERT [dbo].[Pedidos] ([ID_Pedido], [ID_Cliente], [ID_Producto], [ID_Proveedor], [ID_Almacen], [FechaPedido]) VALUES (9, 9, 2, 4, 2, CAST(N'2020-02-25' AS Date))
INSERT [dbo].[Pedidos] ([ID_Pedido], [ID_Cliente], [ID_Producto], [ID_Proveedor], [ID_Almacen], [FechaPedido]) VALUES (12, 2, 1, 10, 1, CAST(N'2020-01-25' AS Date))
INSERT [dbo].[Pedidos] ([ID_Pedido], [ID_Cliente], [ID_Producto], [ID_Proveedor], [ID_Almacen], [FechaPedido]) VALUES (14, 2, 3, 1, 9, CAST(N'2020-01-25' AS Date))
INSERT [dbo].[Pedidos] ([ID_Pedido], [ID_Cliente], [ID_Producto], [ID_Proveedor], [ID_Almacen], [FechaPedido]) VALUES (15, 2, 1, 10, 1, CAST(N'2020-01-25' AS Date))
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (1, N'Suero Base Artistry', N'Belleza', 10, 850)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (2, N'Exact Fit Corrector líquido', N'Belleza', 10, 850)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (3, N'Cerocarb', N'Nutricion', 7, 250)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (4, N'Ajo Concentrado', N'Nutricion', 7, 460)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (5, N'Desodorante Ertia', N'Cuidado Personal', 10, 250)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (6, N'Shampoo Anticaída', N'Cuidado Personal', 10, 150)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (7, N' Limpiador concentrado multiusos', N'Hogar', 6, 250)
INSERT [dbo].[Producto] ([ID_Producto], [Nombre], [Categoria], [Proveedor], [Costo]) VALUES (8, N'Blanqueador para múltiples telas', N'Hogar', 6, 331)
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[Proveedores] ON 

INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (1, N'CDM150829H73', N'Civica Digital Mexico', N'Olimpo', N'408', N'Oficina 20', N'Mas Palomas', N'66463', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (2, N'PAQ591107QY3', N'PAQUIN, S.A. DE C.V', N'NETZAHUALCOYOTL', N'202', N'Local 10', N'Mirasur', N'98050', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (3, N'OPA880220626', N'OFICENTRO PAPELERÍA, S. A. DE C.V', N'MINA SIRENA', N'97', N'Bodega 3', N'Minera', N'98040', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (4, N'MNL990623QPA', N'MUEBLES NOVA LUXE, S.A. DE C.V', N'LÓPEZ PORTILLO', N'9', N'Bodega 20', N'LOMAS DEL CONSUELO', N'98608', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (5, N'COM940110JE2', N'COMPULOGIC, S.A. DE C.V.', N'AMARO', N'122', N'Oficina 3', N'BOULEVARES', N'46283', N'Nuevo Leon', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (6, N'CLO400315I71 ', N'CASA LOPEZ S.A. DE C.V.', N'BLVD. LOPEZ PORTILLO ', N'230', N'Oficina 21', N'GUADALUPE', N'98600', N'Jalisco', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (7, N'ENZ081008UG6', N'ENZAC S.A. DE C.V', N'HEROES DE CHAPULTEPEC', N'635', N'Oficina N3', N'LOMAS', N'66982', N'Jalisco', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (8, N'940209PH5SAI', N'SERVICIOS AMBIENTALES INTERNACIONALES,S.A DE R.L.D', N'PROL. PINO SUAREZ', N'12', N'2719-B', N'BELLA VISTA', N'55540', N'Jalisco', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (9, N'ACA0002161J2', N'ALTA CARGA,S.A. DE C.V', N'CARR.TAMPICO-MANTE', N'14', N'Bodega K32', N'CALETA', N'55010', N'Jalisco', N'Mexico')
INSERT [dbo].[Proveedores] ([ID_Proveedor], [RFC], [RazonSocial], [Calle], [NumeroExt], [NumeroInt], [Colonia], [CodigoPostal], [Estado], [Pais]) VALUES (10, N'TRA740921HG1', N'TRANSINERGIA, S.A. DE C.V', N'ISLA BRITANICA', N'3420', N'Oficina 3', N'Jardines del Sur', N'44950', N'Nuevo Leon', N'Mexico')
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
GO
-- UPDATE STATEMENTS WITH WHERE --
UPDATE Almacenes SET NumeroInt = 'Bodega KT5' 
WHERE Colonia IN ('San Patricio', 'Jardines de Parra')
GO
UPDATE Producto SET Costo = 250
WHERE Costo <300
GO
UPDATE Almacenes SET CodigoPostal = '99784', Colonia = 'San Patricio'
WHERE Estado = 'Guanajuato'
GO
UPDATE Producto SET Proveedor = 10, Costo = 850 
WHERE Proveedor BETWEEN 1 AND 3
GO
UPDATE Proveedores SET Estado = 'Nuevo Leon'  
WHERE Estado <> 'Nuevo Leon'
GO
-- DELETE STATEMENTS
DELETE FROM Clientes WHERE Edad <= 19
GO
DELETE FROM Pedidos WHERE ID_Proveedor = 2
GO
DELETE FROM Producto WHERE Categoria = 'Conservas'
GO
DELETE FROM Almacenes WHERE Pais <> 'Mexico'
GO
DELETE FROM Pedidos WHERE FechaPedido < '2020-01-01'
GO
