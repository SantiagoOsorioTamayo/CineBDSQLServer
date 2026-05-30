/* DISEÑO E IMPLEMENTACIÓN */

-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE [CineBD]
GO

USE [CineBD]
GO

-- CREACIÓN DE LAS TABLAS PARA LA INFORMACIÓN DEL CINE

CREATE TABLE [Tipo_Documento]
(
	Tipo_Id INT PRIMARY KEY,
	Documento VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Tipo_Producto]
(
	Id_Tipo_Producto INT PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Clasificacion]
(
	Id_Clasificacion INT PRIMARY KEY,
	Nombre NVARCHAR(10) NOT NULL
)
GO

CREATE TABLE [Categoria]
(
	Id_Categoria INT PRIMARY KEY,
	Nombre NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Sala]
(
	Id_Sala INT PRIMARY KEY,
	Numero INT NOT NULL,
	Capacidad INT NOT NULL
)
GO

CREATE TABLE [Cliente]
(
	Tipo_Id INT NOT NULL,
	Num_Id INT NOT NULL,
	Nombre NVARCHAR(50) NOT NULL,
	Fecha_Nacimiento DATE NOT NULL,
	Correo NVARCHAR(50) NULL,
	CONSTRAINT FK_Tipo_Documento FOREIGN KEY(Tipo_Id) REFERENCES Tipo_Documento(Tipo_Id),
	CONSTRAINT PK_Cliente PRIMARY KEY(Tipo_Id, Num_Id)
)
GO

CREATE TABLE [Asiento]
(
	Id_Asiento INT PRIMARY KEY,
	Id_Sala INT NOT NULL,
	Fila VARCHAR(2) NOT NULL, -- filas A, B, AB, entre otros.
	Numero INT NOT NULL,
	CONSTRAINT FK_Sala FOREIGN KEY(Id_Sala) REFERENCES Sala(Id_Sala),
)
GO

CREATE TABLE [Producto]
(
	Id_Producto INT PRIMARY KEY,
	Id_Tipo_Producto INT NOT NULL,
	Nombre NVARCHAR(50) NOT NULL,
	Precio MONEY NOT NULL,
	CONSTRAINT FK_Tipo_Producto FOREIGN KEY(Id_Tipo_Producto) REFERENCES Tipo_Producto(Id_Tipo_Producto)
)
GO

CREATE TABLE [Pelicula]
(
	Id_Pelicula INT PRIMARY KEY,
	Id_Clasificacion INT NOT NULL,
	Id_Categoria INT NOT NULL,
	Titulo NVARCHAR(70) NOT NULL,
	Duracion INT NOT NULL, --Duracion por minutos
	CONSTRAINT FK_Clasificacion FOREIGN KEY(Id_Clasificacion) REFERENCES Clasificacion(Id_Clasificacion),
	CONSTRAINT FK_Categoria FOREIGN KEY(Id_Categoria) REFERENCES Categoria(Id_Categoria)
)
GO

CREATE TABLE [Funcion]
(
	Id_Funcion INT PRIMARY KEY,
	Id_Sala INT NOT NULL,
	Id_Pelicula INT NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,
	CONSTRAINT FK_Sala_Funcion FOREIGN KEY(Id_Sala) REFERENCES Sala(Id_Sala),
	CONSTRAINT FK_Pelicula FOREIGN KEY(Id_Pelicula) REFERENCES Pelicula(Id_Pelicula)
)
GO

CREATE TABLE [Ticket]
(
	Id_Ticket INT PRIMARY KEY,
	Id_Funcion INT NOT NULL,
	Id_Asiento INT NOT NULL,
	Tipo_Id_Cliente INT NOT NULL,
	Num_Id_Cliente INT NOT NULL,
	Precio MONEY NOT NULL,
	CONSTRAINT FK_Funcion FOREIGN KEY(Id_Funcion) REFERENCES Funcion(Id_Funcion),
	CONSTRAINT FK_Asiento FOREIGN KEY(Id_Asiento) REFERENCES Asiento(Id_Asiento),
	CONSTRAINT FK_Cliente FOREIGN KEY(Tipo_Id_Cliente, Num_Id_Cliente) REFERENCES Cliente(Tipo_Id, Num_Id),
)
GO

CREATE TABLE [Venta_Producto]
(
	Id_Venta INT PRIMARY KEY,
	Id_Ticket INT NOT NULL,
	Id_Producto INT NOT NULL,
	Cantidad INT NOT NULL,
	CONSTRAINT FK_Ticket FOREIGN KEY(Id_Ticket) REFERENCES Ticket(Id_Ticket),
	CONSTRAINT FK_Producto FOREIGN KEY(Id_Producto) REFERENCES Producto(Id_Producto)
)
GO

-- REGISTROS INICIALES DE LA BASE DE DATOS

INSERT INTO Tipo_Documento VALUES
(1,'Cédula de ciudadanía'),
(2,'Tarjeta de identidad'),
(3,'Cédula extranjera'),
(4,'Pasaporte'),
(5,'Registro civil'),
(6,'Documento militar'),
(7,'Licencia conducción'),
(8,'Documento nacional'),
(9,'Permiso temporal'),
(10,'Carnet estudiante'),
(11,'Carnet empresa'),
(12,'Documento diplomático'),
(13,'Documento migración'),
(14,'Identificación escolar'),
(15,'Permiso residencia'),
(16,'ID universitario'),
(17,'Documento regional'),
(18,'Documento laboral'),
(19,'ID nacional'),
(20,'Documento digital')
GO

INSERT INTO Tipo_Producto VALUES
(1,'Bebidas'),
(2,'Palomitas'),
(3,'Dulces'),
(4,'Snacks'),
(5,'Combos'),
(6,'Helados'),
(7,'Nachos'),
(8,'Perros calientes'),
(9,'Hamburguesas'),
(10,'Chocolates'),
(11,'Galletas'),
(12,'Café'),
(13,'Jugos'),
(14,'Agua'),
(15,'Batidos'),
(16,'Pizza'),
(17,'Sandwich'),
(18,'Gomitas'),
(19,'Caramelos'),
(20,'Especial')
GO

INSERT INTO Clasificacion VALUES
(1,'G'),
(2,'PG'),
(3,'PG-13'),
(4,'R'),
(5,'NC-17'),
(6,'ATP'),
(7,'13+'),
(8,'15+'),
(9,'16+'),
(10,'18+'),
(11,'A'),
(12,'B'),
(13,'C'),
(14,'D'),
(15,'E'),
(16,'F'),
(17,'AA'),
(18,'BB'),
(19,'CC'),
(20,'DD')
GO

INSERT INTO Categoria VALUES
(1,'Acción'),
(2,'Comedia'),
(3,'Drama'),
(4,'Terror'),
(5,'Ciencia ficción'),
(6,'Romance'),
(7,'Animación'),
(8,'Aventura'),
(9,'Fantasia'),
(10,'Suspenso'),
(11,'Documental'),
(12,'Musical'),
(13,'Histórica'),
(14,'Misterio'),
(15,'Crimen'),
(16,'Familiar'),
(17,'Deporte'),
(18,'Biográfica'),
(19,'Guerra'),
(20,'Western')
GO

INSERT INTO Sala VALUES
(1,1,120),
(2,2,100),
(3,3,90),
(4,4,80),
(5,5,150),
(6,6,110),
(7,7,95),
(8,8,85),
(9,9,140),
(10,10,130),
(11,11,120),
(12,12,100),
(13,13,90),
(14,14,80),
(15,15,150),
(16,16,110),
(17,17,95),
(18,18,85),
(19,19,140),
(20,20,130)
GO

INSERT INTO Cliente VALUES
(1,1001,'Carlos Gomez','1995-05-10','carlos@gmail.com'),
(1,1002,'Laura Martinez','1992-02-20','laura@gmail.com'),
(1,1003,'Pedro Sanchez','1988-09-12','pedro@gmail.com'),
(1,1004,'Ana Rodriguez','1999-03-15','ana@gmail.com'),
(1,1005,'Luis Ramirez','1990-07-07','luis@gmail.com'),
(1,1006,'Maria Lopez','1996-04-30','maria@gmail.com'),
(1,1007,'Daniel Torres','1994-08-18','daniel@gmail.com'),
(1,1008,'Sofia Herrera','2000-12-05','sofia@gmail.com'),
(1,1009,'Miguel Castro','1985-01-22','miguel@gmail.com'),
(1,1010,'Paula Vargas','1993-10-10','paula@gmail.com'),
(1,1011,'Juan Perez','1997-11-01','juan@gmail.com'),
(1,1012,'Camila Rojas','1998-06-14','camila@gmail.com'),
(1,1013,'Andres Diaz','1991-04-04','andres@gmail.com'),
(1,1014,'Juliana Ortiz','1995-02-17','juliana@gmail.com'),
(1,1015,'Felipe Medina','1989-05-19','felipe@gmail.com'),
(1,1016,'Natalia Mora','1994-09-21','natalia@gmail.com'),
(1,1017,'Jorge Castillo','1990-12-11','jorge@gmail.com'),
(1,1018,'Angela Vega','1996-03-03','angela@gmail.com'),
(1,1019,'Ricardo Ruiz','1992-08-25','ricardo@gmail.com'),
(1,1020,'Valentina Cruz','2001-07-09','valentina@gmail.com')
GO

INSERT INTO Asiento VALUES
(1,1,'A',1),
(2,1,'A',2),
(3,1,'A',3),
(4,2,'B',1),
(5,2,'B',2),
(6,2,'B',3),
(7,3,'C',1),
(8,3,'C',2),
(9,3,'C',3),
(10,4,'D',1),
(11,4,'D',2),
(12,5,'E',1),
(13,5,'E',2),
(14,6,'F',1),
(15,6,'F',2),
(16,7,'G',1),
(17,8,'H',1),
(18,9,'I',1),
(19,10,'J',1),
(20,10,'J',2)
GO

INSERT INTO Producto VALUES
(1,1,'Coca Cola',7000),
(2,1,'Pepsi',6500),
(3,2,'Palomitas pequeñas',8000),
(4,2,'Palomitas medianas',12000),
(5,2,'Palomitas grandes',15000),
(6,3,'M&M',6000),
(7,3,'Skittles',6000),
(8,4,'Papas fritas',7000),
(9,5,'Combo pareja',25000),
(10,6,'Helado vainilla',5000),
(11,7,'Nachos queso',9000),
(12,8,'Perro caliente',10000),
(13,9,'Hamburguesa',15000),
(14,10,'Chocolate',4000),
(15,11,'Galletas',3500),
(16,12,'Café',3000),
(17,13,'Jugo natural',4500),
(18,14,'Agua',3000),
(19,18,'Gomitas',4000),
(20,19,'Caramelos',3500)
GO

INSERT INTO Pelicula VALUES
(1,3,1,'Misión Final',120),
(2,2,2,'Risas sin fin',95),
(3,4,4,'La noche oscura',110),
(4,3,5,'Viaje a Marte',130),
(5,2,6,'Amor eterno',105),
(6,1,7,'Aventura animada',90),
(7,3,8,'Exploradores',115),
(8,4,10,'Sombras',108),
(9,2,1,'Acción total',125),
(10,3,9,'Reinos mágicos',140),
(11,2,2,'Comedia loca',100),
(12,3,3,'Drama profundo',112),
(13,4,4,'Pesadilla',102),
(14,3,5,'Planeta rojo',118),
(15,2,6,'Historias de amor',97),
(16,1,7,'Animales felices',88),
(17,3,8,'Aventura perdida',121),
(18,4,10,'Misterio mortal',109),
(19,2,1,'Explosión final',132),
(20,3,9,'Dragones',136)
GO

INSERT INTO Funcion VALUES
(1,1,1,'2026-06-01','18:00'),
(2,2,2,'2026-06-01','19:00'),
(3,3,3,'2026-06-01','20:00'),
(4,4,4,'2026-06-01','21:00'),
(5,5,5,'2026-06-02','18:30'),
(6,6,6,'2026-06-02','19:30'),
(7,7,7,'2026-06-02','20:30'),
(8,8,8,'2026-06-02','21:30'),
(9,9,9,'2026-06-03','18:00'),
(10,10,10,'2026-06-03','19:00'),
(11,11,11,'2026-06-03','20:00'),
(12,12,12,'2026-06-03','21:00'),
(13,13,13,'2026-06-04','18:30'),
(14,14,14,'2026-06-04','19:30'),
(15,15,15,'2026-06-04','20:30'),
(16,16,16,'2026-06-04','21:30'),
(17,17,17,'2026-06-05','18:00'),
(18,18,18,'2026-06-05','19:00'),
(19,19,19,'2026-06-05','20:00'),
(20,20,20,'2026-06-05','21:00')
GO

INSERT INTO Ticket VALUES
(1,1,1,1,1001,12000),
(2,2,4,1,1002,12000),
(3,3,7,1,1003,12000),
(4,4,10,1,1004,12000),
(5,5,12,1,1005,12000),
(6,6,14,1,1006,12000),
(7,7,16,1,1007,12000),
(8,8,17,1,1008,12000),
(9,9,18,1,1009,12000),
(10,10,19,1,1010,12000),
(11,11,2,1,1011,12000),
(12,12,3,1,1012,12000),
(13,13,5,1,1013,12000),
(14,14,6,1,1014,12000),
(15,15,8,1,1015,12000),
(16,16,9,1,1016,12000),
(17,17,11,1,1017,12000),
(18,18,13,1,1018,12000),
(19,19,15,1,1019,12000),
(20,20,20,1,1020,12000)
GO

INSERT INTO Venta_Producto VALUES
(1,1,1,2),
(2,2,3,1),
(3,3,4,1),
(4,4,6,2),
(5,5,8,1),
(6,6,9,1),
(7,7,10,2),
(8,8,11,1),
(9,9,12,1),
(10,10,13,1),
(11,11,14,3),
(12,12,15,2),
(13,13,16,1),
(14,14,17,2),
(15,15,18,1),
(16,16,19,2),
(17,17,20,1),
(18,18,2,2),
(19,19,5,1),
(20,20,7,2)
GO

/* CONSULTAS Y ANÁLISIS */

/* 5 consultas simples (SELECT, FROM, WHERE, HAVING, GROUP BY y ORDER BY) */

-- Contar los productos que se clasifican como palomitas
SELECT Id_Tipo_Producto, GETDATE() AS FechaHoraSistema, COUNT(Id_Producto) AS NumeroProductos FROM Producto GROUP BY Id_Tipo_Producto HAVING Id_Tipo_Producto = 2

-- Mostrar por clasificación el promedio de la duración de las peliculas donde el promedio sea mayor a 100
SELECT Id_Clasificacion, GETDATE() AS FechaHoraSistema, AVG(Duracion) AS PromedioDuracion FROM Pelicula GROUP BY Id_Clasificacion HAVING AVG(Duracion) > 100

-- Contar las peliculas que comienzan despues de la 1 pm el 4 de junio de 2026
SELECT Fecha, GETDATE() AS FechaHoraSistema, COUNT(Id_Pelicula) AS NumeroPeliculas FROM Funcion WHERE Hora > '13:00' GROUP BY Fecha HAVING Fecha = '2026-06-04'

-- Mostrar el nombre de los clientes mayores de edad y ordenarlos de menor a mayor
SELECT GETDATE() AS FechaHoraSistema, Nombre, Fecha_Nacimiento  FROM Cliente WHERE Fecha_Nacimiento <= DATEADD(YEAR, -18, GETDATE()) ORDER BY Fecha_Nacimiento DESC

-- Mostrar los productos que sean jugos o batidos desde el más barato al más caro
SELECT Nombre, precio, GETDATE() AS FechaHoraSistema FROM Producto WHERE Id_Tipo_Producto IN (13, 15) ORDER BY Precio ASC

/* Consultas usando los JOIN */

-- Mostrar los productos junto con su tipo de producto (INNER JOIN)
SELECT P.Id_Producto, P.Nombre AS Producto, T.Nombre AS Tipo FROM Producto P INNER JOIN Tipo_Producto T ON P.Id_Tipo_Producto = T.Id_Tipo_Producto

-- Mostrar los productos que se vendieron en 2 o más unidades (LEFT JOIN)
SELECT P.Id_Producto, P.Nombre AS Producto FROM Producto P LEFT JOIN Venta_Producto V ON P.Id_Producto = V.Id_Producto WHERE V.Cantidad >= 2

-- Mostrar el título y la duración de las peliculas que comienzan entre las 8 y 10 pm (RIGHT JOIN)
SELECT P.Titulo, P.Duracion FROM Funcion F RIGHT JOIN Pelicula P ON F.Id_Pelicula = P.Id_Pelicula WHERE F.Hora BETWEEN '20:00' AND '22:00'

-- Mostrar todos los registros de los clientes y los tipos de documento en una tabla (FULL JOIN)
SELECT * FROM Cliente C FULL JOIN Tipo_Documento T ON C.Tipo_Id = T.Tipo_Id

-- Mostrar la información de los clientes y su tipo de documento (JOIN)
SELECT T.Documento AS Tipo_Documento, C.Num_Id AS Numero_Documento, C.Fecha_Nacimiento, C.Correo FROM Cliente C JOIN Tipo_Documento T ON C.Tipo_Id = T.Tipo_Id

-- Producto cartesiano entre dos o mas tablas, en este caso, entre pelicula y cliente (CROSS JOIN)
SELECT * FROM Pelicula CROSS JOIN Cliente

/* MANIPULACIÓN DE DATOS Y ESTRUCTURA */

-- Eliminar un registro de una tabla
SELECT * FROM Tipo_Documento

DELETE FROM Tipo_Documento WHERE Tipo_Id = 16

-- Modificar un registro de una tabla
SELECT Num_Id, Nombre FROM Cliente

UPDATE Cliente SET Nombre = 'María Rodriguéz' WHERE Num_Id = 1011

-- Agregar nueva columna a una tabla
SELECT * FROM Tipo_Documento

ALTER TABLE Tipo_Documento
	ADD Columna_Prueba VARCHAR(40) NULL

-- Alterar tipo de dato de una columna existente
ALTER TABLE Tipo_Documento
	ALTER COLUMN Columna_Prueba INT NULL

-- Eliminar columna de una tabla
ALTER TABLE Tipo_Documento
	DROP COLUMN Columna_Prueba

SELECT * FROM Tipo_Documento
GO

---------------------------------------------------------------------------------------------

-- Tabla auxiliar para el INSERT siguiente
CREATE TABLE Cliente_Auxiliar (
    Tipo_Id INT NOT NULL,
    Num_Id INT NOT NULL,
    Nombre NVARCHAR(50) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Correo NVARCHAR(50) NULL,
    Fecha_Backup DATETIME DEFAULT GETDATE()
)
GO

-- INSERT con datos de otra tabla
INSERT INTO Cliente_Auxiliar (Tipo_Id, Num_Id, Nombre, Fecha_Nacimiento, Correo)
SELECT Tipo_Id, Num_Id, Nombre, Fecha_Nacimiento, Correo FROM Cliente WHERE YEAR(Fecha_Nacimiento) < 2000;

SELECT * FROM Cliente_Auxiliar;

-- TRUNCATE
TRUNCATE TABLE Cliente_Auxiliar;
GO

SELECT * FROM Cliente_Auxiliar;
GO

-- Se borrará la tabla auxiliar para el caso anterior
DROP TABLE Cliente_Auxiliar;
GO

-- DATEDIFF
SELECT Nombre, DATEDIFF(YEAR, Fecha_Nacimiento, GETDATE()) AS Edad FROM Cliente;

-- SUBSTRING, CONCAT, LEN
SELECT CONCAT(Nombre, ' - ', SUBSTRING(Correo, 1, 5)) AS Nombre_y_5_Primeras_Letras FROM Cliente;

-- CAST / CONVERT
SELECT CAST(Precio AS INT) AS Cambio_Precio_INT FROM Producto;

-- DISTINCT
SELECT DISTINCT Id_Sala FROM Funcion;

-- CASE
SELECT Nombre, Precio,
    CASE WHEN Precio < 5000 THEN 'Económico' ELSE 'Normal' END AS Tipo_Precio
FROM Producto;
GO

-- Procedimiento almacenado
CREATE PROCEDURE sp_RegistrarVentaSimple
    @Id_Ticket INT,
    @Id_Producto INT,
    @Cantidad INT,
    @Resultado NVARCHAR(200) = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    
    BEGIN TRY
        -- Validar que la cantidad sea positiva
        IF @Cantidad <= 0
        BEGIN
            SET @Resultado = 'Error: La cantidad debe ser mayor a 0'
            RAISERROR(@Resultado, 16, 1)
        END
        
        -- Validar que la cantidad no sea excesiva
        IF @Cantidad > 20
        BEGIN
            SET @Resultado = 'Error: No se pueden vender más de 20 unidades'
            RAISERROR(@Resultado, 16, 1)
        END
        
        -- Validar que el ticket exista
        IF NOT EXISTS (SELECT 1 FROM Ticket WHERE Id_Ticket = @Id_Ticket)
        BEGIN
            SET @Resultado = CONCAT('Error: El ticket ', @Id_Ticket, ' no existe')
            RAISERROR(@Resultado, 16, 1)
        END
        
        -- Validar que el producto exista
        IF NOT EXISTS (SELECT 1 FROM Producto WHERE Id_Producto = @Id_Producto)
        BEGIN
            SET @Resultado = CONCAT('Error: El producto ', @Id_Producto, ' no existe')
            RAISERROR(@Resultado, 16, 1)
        END       
      
        -- Obtener el siguiente ID disponible
        DECLARE @NuevoId INT
        SELECT @NuevoId = ISNULL(MAX(Id_Venta), 0) + 1 FROM Venta_Producto
        
        -- Insertar el registro
        INSERT INTO Venta_Producto (Id_Venta, Id_Ticket, Id_Producto, Cantidad)
        VALUES (@NuevoId, @Id_Ticket, @Id_Producto, @Cantidad)
        
        SET @Resultado = CONCAT('*** Venta registrada exitosamente. ID: ', @NuevoId, ' ***')
        PRINT @Resultado
        
    END TRY
    
    BEGIN CATCH
        IF @Resultado IS NULL
        BEGIN
            SET @Resultado = CONCAT('*** Error: ', ERROR_MESSAGE(), ' ***')
        END
        
        PRINT @Resultado
    END CATCH
END
GO

-- Variable auxiliar para guardar el OUTPUT del procedimiento almacenado ****DECLARE @Mensaje NVARCHAR(200)****

-- Verificación del procedimiento almacenado de forma correcta
DECLARE @Mensaje NVARCHAR(200)

EXEC sp_RegistrarVentaSimple
    @Id_Ticket = 1,
    @Id_Producto = 1,
    @Cantidad = 2,
    @Resultado = @Mensaje OUTPUT


SELECT @Mensaje AS Mensaje
GO

-- Verificación del procedimiento almacenado con cantidad inválida
DECLARE @Mensaje NVARCHAR(200)

EXEC sp_RegistrarVentaSimple
    @Id_Ticket = 1,
    @Id_Producto = 1,
    @Cantidad = 0,
    @Resultado = @Mensaje OUTPUT


SELECT @Mensaje AS Mensaje
GO

-- Verificación del procedimiento almacenado con cantidad excedida (>20)
DECLARE @Mensaje NVARCHAR(200)

EXEC sp_RegistrarVentaSimple
    @Id_Ticket = 1,
    @Id_Producto = 1,
    @Cantidad = 25,
    @Resultado = @Mensaje OUTPUT

SELECT @Mensaje AS Mensaje
GO

-- Verificación del procedimiento almacenado con ticket inexistente
DECLARE @Mensaje NVARCHAR(200)

EXEC sp_RegistrarVentaSimple
    @Id_Ticket = 999,
    @Id_Producto = 1,
    @Cantidad = 1,
    @Resultado = @Mensaje OUTPUT

SELECT @Mensaje AS Mensaje
GO

-- Verificación del procedimiento almacenado con producto inexistente
DECLARE @Mensaje NVARCHAR(200)

EXEC sp_RegistrarVentaSimple
    @Id_Ticket = 1,
    @Id_Producto = 999,
    @Cantidad = 1,
    @Resultado = @Mensaje OUTPUT

SELECT @Mensaje AS Mensaje
GO

-- Trigger
CREATE TRIGGER trg_ValidarVenta_Simple
ON Venta_Producto
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON
    
    BEGIN TRY
        -- Validar cantidad positiva
        IF EXISTS (SELECT 1 FROM inserted WHERE Cantidad <= 0)
        BEGIN
            RAISERROR('La cantidad debe ser mayor a 0', 16, 1)
        END
        
        -- Validar cantidad máxima
        IF EXISTS (SELECT 1 FROM inserted WHERE Cantidad > 50)
        BEGIN
            RAISERROR('La cantidad no puede superar 50 unidades', 16, 1)
        END
        
        PRINT '*** Validación exitosa ***'
    END TRY
    BEGIN CATCH
        DECLARE @Msg NVARCHAR(500) = '*** Error: ' + ERROR_MESSAGE() + ' ***'
        RAISERROR(@Msg, 16, 1)
        ROLLBACK
    END CATCH
END
GO

-- INSERT correcto después de crear el TRIGGER
INSERT INTO Venta_Producto (Id_Venta, Id_Ticket, Id_Producto, Cantidad) VALUES (21, 1, 1, 2)
GO

SELECT * FROM Venta_Producto WHERE Id_Venta = 21
GO

-- INSERT incorrecto después de crear el TRIGGER (caso <= 0)
INSERT INTO Venta_Producto (Id_Venta, Id_Ticket, Id_Producto, Cantidad) VALUES (22, 1, 2, 0)
GO

-- INSERT incorrecto después de crear el TRIGGER (caso > 50)
INSERT INTO Venta_Producto (Id_Venta, Id_Ticket, Id_Producto, Cantidad) VALUES (23, 2, 4, 51)
GO

-- UPDATE correcto después de crear el TRIGGER
UPDATE Venta_Producto SET Cantidad = 5 WHERE Id_Venta = 21
GO

SELECT * FROM Venta_Producto WHERE Id_Venta = 21
GO

--UPDATE incorrecto después de crear el TRIGGER
UPDATE Venta_Producto SET Cantidad = 0 WHERE Id_Venta = 21
GO

-- Vista estándar
CREATE VIEW Vista_ProductosVendidos AS
SELECT P.Nombre, SUM(VP.Cantidad) AS TotalVendido
FROM Producto P
INNER JOIN Venta_Producto VP ON P.Id_Producto = VP.Id_Producto
GROUP BY P.Nombre;
GO

SELECT * FROM Vista_ProductosVendidos
GO

-- Vista indexada
CREATE VIEW Vista_ConteoPorCategoria
WITH SCHEMABINDING
AS
SELECT C.Nombre, COUNT_BIG(*) AS Cantidad
FROM dbo.Categoria C
INNER JOIN dbo.Pelicula P ON C.Id_Categoria = P.Id_Categoria
GROUP BY C.Nombre;
GO

CREATE UNIQUE CLUSTERED INDEX IX_VistaConteo ON Vista_ConteoPorCategoria (Nombre);
GO

SELECT * FROM Vista_ConteoPorCategoria
GO

-- Merge
MERGE INTO Producto AS Target
USING (VALUES (21, 1, 'Nueva Bebida', 5500)) AS Source (Id_Producto, Id_Tipo_Producto, Nombre, Precio) -- VALORES PARA COMPARAR
ON Target.Id_Producto = Source.Id_Producto
WHEN MATCHED THEN UPDATE SET Nombre = Source.Nombre, Precio = Source.Precio -- SI EXISTE, ACTUALIZA NOMBRE Y PRECIO
WHEN NOT MATCHED THEN INSERT VALUES (Source.Id_Producto, Source.Id_Tipo_Producto, Source.Nombre, Source.Precio); -- SI NO EXISTE, LO INSERTA
GO

-- Encriptar
UPDATE Cliente SET Correo = ENCRYPTBYPASSPHRASE('clave_secreta', Correo);
GO

SELECT * FROM Cliente
GO

-- Desencriptar
SELECT CONVERT(NVARCHAR(50), DECRYPTBYPASSPHRASE('clave_secreta', Correo)) AS CorreoDesc FROM Cliente;

SELECT * FROM Cliente
GO

-- Backup
BACKUP DATABASE CineBD TO DISK = 'C:\Backup\CineBD_Full.bak' WITH FORMAT;