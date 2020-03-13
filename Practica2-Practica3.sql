CREATE DATABASE LBD;

USE LBD;

/* ---- Practica 2 ----*/

CREATE TABLE Clientes(
ID_Cliente uniqueidentifier not null primary key,
Nombre VARCHAR(50) not null,
PrimerApellido VARCHAR(50) not null,
SegundoApellido VARCHAR(50) not null,
NombreCompleto as Nombre + ' ' + PrimerApellido + ' ' + SegundoApellido,
FechaDeNacimiento datetime not null,
Edad as DATEDIFF(year, FechaDeNacimiento, GETDATE()),
CorreoElectronico VARCHAR(50) not null
)

CREATE TABLE Proveedores(
RFC uniqueidentifier not null primary key,
RazonSocial VARCHAR(50) not null,
Calle VARCHAR(50) not null,
NumeroExt int not null,
NumeroInt VARCHAR(50) not null,
Colonia VARCHAR(50) not null,
CodigoPostal VARCHAR(50) not null,
Estado VARCHAR(50) not null,
Pais VARCHAR(50) not null,
DireccionProveedor as Calle + ' ' + NumeroInt + ' ' + NumeroExt +' ' + Colonia + ' ' + CodigoPostal + ' ' + Estado + ' ' + Pais + ' ',
)

CREATE TABLE Producto(
ID_Producto uniqueidentifier not null primary key,
Nombre VARCHAR(50) not null,
Categoria VARCHAR(50) not null,
Proveedor uniqueidentifier not null,
Costo float not null
)

CREATE TABLE Almacenes(
ID_Almacen uniqueidentifier not null primary key,
Nombre VARCHAR(50) not null,
Calle VARCHAR(50) not null,
NumeroExt int not null,
NumeroInt VARCHAR(50) not null,
Colonia VARCHAR(50) not null,
CodigoPostal VARCHAR(50) not null,
Estado VARCHAR(50) not null,
Pais VARCHAR(50) not null,
DireccionAlmacen as Calle + ' ' + NumeroInt + ' ' + NumeroExt +' ' + Colonia + ' ' + CodigoPostal + ' ' + Estado + ' ' + Pais + ' ',
)

CREATE TABLE Pedidos(
ID_Pedido uniqueidentifier not null primary key,
Cliente uniqueidentifier not null,
Producto uniqueidentifier not null, 
Proveedor uniqueidentifier not null,
Almacen uniqueidentifier not null,
FechaPedido datetime not null
)

CREATE INDEX index_ProveedorPais ON Proveedores (Pais);
CREATE INDEX index_FechaEmisionPedidos ON Pedidos (FechaPedido desc);

/* ------ Practica 3 -----*/

ALTER TABLE Proveedores
ADD CONSTRAINT UC_Proveedores UNIQUE (RFC,RazonSocial);

ALTER TABLE Almacenes
ADD CONSTRAINT UC_Almacenes UNIQUE (ID_Almacen,Nombre);

--ALTER TABLE Clientes
--ADD CONSTRAINT CHK_Edad CHECK (Edad>=21);

ALTER TABLE Producto
ADD CONSTRAINT CHK_ProductCost CHECK (Costo>0);

ALTER TABLE Producto ADD CONSTRAINT FK_ProvedorOrder 
FOREIGN KEY (Proveedor) REFERENCES Proveedores(RFC);

ALTER TABLE Pedidos ADD CONSTRAINT FK_ClienteOrder 
FOREIGN KEY (Cliente) REFERENCES Clientes(ID_CLiente);

ALTER TABLE Pedidos ADD CONSTRAINT FK_AlmacenOrder 
FOREIGN KEY (Almacen) REFERENCES Almacenes(ID_Almacen);

ALTER TABLE Pedidos ADD CONSTRAINT FK_ProductOrder 
FOREIGN KEY (Producto) REFERENCES Producto(ID_Producto);