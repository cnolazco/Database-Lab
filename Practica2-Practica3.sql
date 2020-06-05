CREATE DATABASE LBD;

USE LBD;

/* ---- Practica 2 ----*/


CREATE TABLE Clientes(
ID_Cliente int PRIMARY KEY not null identity(1,1),
Nombre VARCHAR(50) not null,
PrimerApellido VARCHAR(50) not null,
SegundoApellido VARCHAR(50) not null,
NombreCompleto as Nombre + ' ' + PrimerApellido + ' ' + SegundoApellido,
FechaDeNacimiento date not null,
Edad int not null,
CorreoElectronico VARCHAR(50) not null
)

CREATE TABLE Proveedores(
ID_Proveedor int PRIMARY KEY not null identity(1,1),
RFC VARCHAR(13) not null,
RazonSocial VARCHAR(50) not null,
Calle VARCHAR(50) not null,
NumeroExt varchar(10) not null,
NumeroInt VARCHAR(50) not null,
Colonia VARCHAR(50) not null,
CodigoPostal VARCHAR(50) not null,
Estado VARCHAR(50) not null,
Pais VARCHAR(50) not null,
DireccionProveedor as Calle + ' ' + NumeroInt + ' ' + NumeroExt +' ' + Colonia + ' ' + CodigoPostal + ' ' + Estado + ' ' + Pais + ' ',
)

CREATE TABLE Producto(
ID_Producto int PRIMARY KEY not null identity(1,1),
Nombre VARCHAR(50) not null,
Categoria VARCHAR(50) not null,
Proveedor int not null,
Costo float not null
)

CREATE TABLE Almacenes(
ID_Almacen int PRIMARY KEY not null identity(1,1),
Nombre VARCHAR(50) not null,
Calle VARCHAR(50) not null,
NumeroExt VARCHAR(20) not null,
NumeroInt VARCHAR(50) not null,
Colonia VARCHAR(50) not null,
CodigoPostal VARCHAR(50) not null,
Estado VARCHAR(50) not null,
Pais VARCHAR(50) not null,
DireccionAlmacen as Calle + ' ' + NumeroInt + ' ' + NumeroExt +' ' + Colonia + ' ' + CodigoPostal + ' ' + Estado + ' ' + Pais + ' ',
)

CREATE TABLE Pedidos(
ID_Pedido int PRIMARY KEY not null identity(1,1),
ID_Cliente int not null,
ID_Producto int not null,
ID_Proveedor int not null,
ID_Almacen int not null,
FechaPedido date not null
)

CREATE INDEX index_ProveedorPais ON Proveedores (Pais);
CREATE INDEX index_FechaEmisionPedidos ON Pedidos (FechaPedido desc);

/* ------ Practica 3 -----*/


ALTER TABLE Proveedores
ADD CONSTRAINT UC_Proveedores UNIQUE (RFC,RazonSocial);

ALTER TABLE Almacenes
ADD CONSTRAINT UC_Almacenes UNIQUE (ID_Almacen,Nombre);

ALTER TABLE Clientes
ADD CONSTRAINT CHK_Edad CHECK (Edad >= 18);

ALTER TABLE Producto
ADD CONSTRAINT CHK_ProductCost CHECK (Costo>0);

ALTER TABLE Producto
ADD CONSTRAINT FK_ProvedorOrder 
FOREIGN KEY (Proveedor) REFERENCES Proveedores(ID_Proveedor);

ALTER TABLE Pedidos  
ADD CONSTRAINT FK_ClienteOrder 
FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente);

ALTER TABLE Pedidos
ADD CONSTRAINT FK_AlmacenOrder 
FOREIGN KEY (ID_Almacen) REFERENCES Almacenes(ID_Almacen);

ALTER TABLE Pedidos 
ADD CONSTRAINT FK_ProductOrder 
FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto);
