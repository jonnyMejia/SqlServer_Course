---------CREAR OBJETO SEQUENCE--------

CREATE SEQUENCE PrimerObjeto

--DEFAULT
--BIGINT
--INCREMENTO EN 1
--VALORES MAXIMOS Y MINIMOS EN FUNCION AL BIGINT:

--VALOR MINIMO: -9.223.372.036.854.775.808
--VALOR MAXIMO: 9.223.372.036.854.775.807

--BUSQUEDA DE LA SECUENCIA

SELECT * FROM sys.sequences WHERE name='PrimerObjeto'

--USO DEL OBJETO SECUENCIA

SELECT NEXT VALUE FOR PrimerObjeto

--SINTAXIS DE INCREMENTO EN SECUENCIA


IF EXISTS (SELECT * FROM sys.sequences WHERE name = 'PrimerObjeto')

     DROP SEQUENCE PrimerObjeto

GO

CREATE SEQUENCE PrimerObjeto AS tinyint

     START WITH 0

     INCREMENT BY 100

GO

-- Cuanod pasa el numero 256(valor maximo del tinyInt) entonces genera un error 
SELECT NEXT VALUE FOR PrimerObjeto


--OBJETO SECUENCIA CON CICLO


IF EXISTS (SELECT * FROM sys.sequences WHERE name = 'PrimerObjeto')

     DROP SEQUENCE PrimerObjeto


CREATE SEQUENCE PrimerObjeto AS tinyint

     START WITH 0

     INCREMENT BY 1

     MINVALUE 0

     MAXVALUE 3

     CYCLE
     -- Cycle significa que cuando llega al maximo valor el siguiente termino es el inicio de la secuencia


SELECT NEXT VALUE FOR PrimerObjeto


--EJERCICIOS CON EL OBJETO SECUENCIA

IF EXISTS (SELECT * FROM sys.sequences WHERE name = 'PrimerObjeto')

     DROP SEQUENCE PrimerObjeto


CREATE SEQUENCE PrimerObjeto AS tinyint

     START WITH 0

     INCREMENT BY 1

     MINVALUE 0

     MAXVALUE 3

     CYCLE
     

CREATE TABLE MCP_DATA1

(COL1 int not null)

INSERT MCP_DATA1 VALUES (NEXT VALUE FOR PrimerObjeto)

SELECT COL1 from MCP_DATA1

UPDATE MCP_DATA1
SET COL1 = NEXT VALUE FOR PrimerObjeto


---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
--------------INDICES CLUSTERIZADOS----------------
---------------------------------------------------


CREATE TABLE MCP_ESTUDIANTES
(
    ID INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    GENDER VARCHAR(50) NOT NULL,
    SCORE INT NOT NULL,
    CITY VARCHAR(50) NOT NULL
 )

INSERT INTO MCP_ESTUDIANTES VALUES  (6, 'Kate', 'Female', 500, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(2, 'Jon', 'Male',  545, 'Manchester')
INSERT INTO MCP_ESTUDIANTES VALUES(9, 'Wise', 'Male',  499, 'Manchester')
INSERT INTO MCP_ESTUDIANTES VALUES(3, 'Sara', 'Female',  600, 'Leeds')
INSERT INTO MCP_ESTUDIANTES VALUES(1, 'Jolly', 'Female',  500, 'London')
INSERT INTO MCP_ESTUDIANTES VALUES(4, 'Laura', 'Female',  400, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(7, 'Joseph', 'Male',  643, 'London')
INSERT INTO MCP_ESTUDIANTES VALUES(5, 'Alan', 'Male',  500, 'London') 
INSERT INTO MCP_ESTUDIANTES VALUES(8, 'Mice', 'Male',  543, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(10, 'Elis', 'Female',  400, 'Leeds')

SELECT * FROM MCP_ESTUDIANTES

execute sp_helpindex MCP_ESTUDIANTES

----PERSONALIZACION DEL INDICE------

DROP TABLE MCP_ESTUDIANTES

CREATE TABLE MCP_ESTUDIANTES
(
    ID INT ,
    NAME VARCHAR(50) NOT NULL,
    GENDER VARCHAR(50) NOT NULL,
    SCORE INT NOT NULL,
    CITY VARCHAR(50) NOT NULL
 )
 
INSERT INTO MCP_ESTUDIANTES VALUES  (6, 'Kate', 'Female', 500, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(2, 'Jon', 'Male',  545, 'Manchester')
INSERT INTO MCP_ESTUDIANTES VALUES(9, 'Wise', 'Male',  499, 'Manchester')
INSERT INTO MCP_ESTUDIANTES VALUES(3, 'Sara', 'Female',  600, 'Leeds')
INSERT INTO MCP_ESTUDIANTES VALUES(1, 'Jolly', 'Female',  500, 'London')
INSERT INTO MCP_ESTUDIANTES VALUES(4, 'Laura', 'Female',  400, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(7, 'Joseph', 'Male',  643, 'London')
INSERT INTO MCP_ESTUDIANTES VALUES(5, 'Alan', 'Male',  500, 'London') 
INSERT INTO MCP_ESTUDIANTES VALUES(8, 'Mice', 'Male',  543, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(10, 'Elis', 'Female',  400, 'Leeds')

EXECUTE SP_HELPINDEX MCP_ESTUDIANTES
-- The object 'MCP_ESTUDIANTES' does not have any indexes, or you do not have permissions.
-- nO TIENEN PRIMARY KEY

CREATE CLUSTERED INDEX IC_GENDER_SCORE ON MCP_ESTUDIANTES(GENDER ASC,SCORE DESC)


-- La tabla estara ordenada por GENDER(Asc) Y SCORE(Desc)
SELECT * FROM MCP_ESTUDIANTES

--Eliminar el indice de la tabla
DROP INDEX IC_GENDER_SCORE ON MCP_ESTUDIANTES

EXECUTE SP_HELPINDEX MCP_ESTUDIANTES
---------------------------------------------------------------
-------------INDICES NO CLUSTERIZADOS--------------------------
---------------------------------------------------------------

-- NONCLUSTERED

DROP TABLE MCP_ESTUDIANTES

CREATE TABLE MCP_ESTUDIANTES
(
    ID INT,
    NAME VARCHAR(50) NOT NULL,
    GENDER VARCHAR(50) NOT NULL,
    SCORE INT NOT NULL,
    CITY VARCHAR(50) NOT NULL
 )
 
INSERT INTO MCP_ESTUDIANTES VALUES  (6, 'Kate', 'Female', 500, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(2, 'Jon', 'Male',  545, 'Manchester')
INSERT INTO MCP_ESTUDIANTES VALUES(9, 'Wise', 'Male',  499, 'Manchester')
INSERT INTO MCP_ESTUDIANTES VALUES(3, 'Sara', 'Female',  600, 'Leeds')
INSERT INTO MCP_ESTUDIANTES VALUES(1, 'Jolly', 'Female',  500, 'London')
INSERT INTO MCP_ESTUDIANTES VALUES(4, 'Laura', 'Female',  400, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(7, 'Joseph', 'Male',  643, 'London')
INSERT INTO MCP_ESTUDIANTES VALUES(5, 'Alan', 'Male',  500, 'London') 
INSERT INTO MCP_ESTUDIANTES VALUES(8, 'Mice', 'Male',  543, 'Liverpool')
INSERT INTO MCP_ESTUDIANTES VALUES(10, 'Elis', 'Female',  400, 'Leeds')


CREATE INDEX IC_DOS ON MCP_ESTUDIANTES (ID,NAME)

--MEJOR SEPARAR LOS INDICES

CREATE INDEX IC_ID_NC ON MCP_ESTUDIANTES (ID)

CREATE INDEX IC_ID ON MCP_ESTUDIANTES (NAME)

SELECT * FROM MCP_ESTUDIANTES

execute sp_helpindex MCP_ESTUDIANTES


---------------------------------------------------
----------------SINTAXIS DE CTE--------------------
---------------------------------------------------

-- Mantiene en memoria el resultado de una consulta, para que lo podamos llamar dentro de otra consulta
WITH PRIMER_CTE 
AS
(
SELECT 
PRODUCTO,
COUNT(*) AS NRO_PEDIDOS,
SUM(IMPORTE) AS IMPORTE_TOTAL
FROM PEDIDOS
GROUP BY PRODUCTO
)

----------VARIANTES DEL CTE------------

SELECT 
A.DESCRIPCION,
ISNULL(B.NRO_PEDIDOS,0) AS CANTIDAD_PEDIDOS,
ISNULL(B.IMPORTE_TOTAL,0) AS IMPORTE_TOTAL
FROM PRODUCTOS A LEFT JOIN 
(
SELECT 
PRODUCTO,
COUNT(*) AS NRO_PEDIDOS,
SUM(IMPORTE) AS IMPORTE_TOTAL
FROM PEDIDOS
GROUP BY PRODUCTO
) B
ON (A.ID_PRODUCTO=B.PRODUCTO)

-----------------------------------------------------
--------------------TRIGGER--------------------------
-----------------------------------------------------

-------CREACION DE TABLA PRODUCTOS-------
CREATE DATABASE bd_trigger
USE BD_TRIGGER

CREATE TABLE PRODUCTOS
(
ID_FAB char(3) not null,
ID_PRODUCTO varchar (5) not null,
DESCRIPCION varchar (30) not null,
PRECIO money not null,
EXISTENCIAS integer not null);

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('REI','2A45C','V Stago Trinquete',79,210)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','4100Y','Extractor',2750,25)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('QSA','XK47','Reductor',355,38)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('BIC','41672','Plate',180,0)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('IMM','779C','Riostra2-Tm',1875,9)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','41003','Articulo Tipo 3',107,207)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','41004','Articulo Tipo 4',117,139)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('BIC','41003','Manivela',652,3)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('IMM','877P','Perno Riostra',250,24)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('QSA','XK48','Reductor',134,203)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('REI','2A44L','Bisagra Izqda',4500,12)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('FEA','112','Cubierta',148,115)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('IMM','887H','Soporte Riostra',54,223)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('BIC','41089','Retn',225,78)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','41001','Articulo Tipo 1',55,277)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('IMM','775C','Riostra 1-Tm',1425,5)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','4100Z','Montador',2500,28)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('QSA','XK48A','Reductor',117,37)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','41002','Articulo Tipo 2',76,167)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('REI','2A44R','Bisagra Dcha.',4500,12)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('IMM','773C','Riostra 1/2-Tm',975,28)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('ACI','4100X','Ajustador',25,37)

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('FEA','114','Bancada Motor',243,15)


SELECT * FROM PRODUCTOS


------------------CREACION DE TABLA AUDITORA----------------------
-- La tabla Audita_producto tambien tiene las columnas updated_At(subido a las) y operation(insert,delete,update)

CREATE TABLE AUDITA_PRODUCTO
(
ID_FAB CHAR(3),
ID_PRODUCTO VARCHAR(5),
DESCRIPCION VARCHAR(30),
PRECIO MONEY,
EXISTENCIAS INT,
UPDATED_AT DATETIME NOT NULL,
USUARIO VARCHAR(50),
OPERATION CHAR(3) NOT NULL,
CHECK(OPERATION='INS' OR OPERATION='DEL' or OPERATION='UPD')
)

-- Esto me permite tener la estructura de una tabla en otra pero sin elementos

SELECT TOP 0 * 
INTO ESTRUCTURA_PRODUCTO
FROM PRODUCTOS

SELECT * FROM ESTRUCTURA_PRODUCTO

---------------CREACION DEL TRIGGER-------------------------
------------------------------------------------------------
------TRIGGER CON INSERCION, ELIMINACION, Y ACTUALIZACION---

CREATE TRIGGER TRG_AUDITA_PRODUCTO
ON PRODUCTOS
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AUDITA_PRODUCTO(
      ID_FAB ,
      ID_PRODUCTO,
      DESCRIPCION,
      PRECIO,
      EXISTENCIAS,
      UPDATED_AT, 
	  USUARIO,
      OPERATION
    )
    SELECT
      i.ID_FAB ,
      i.ID_PRODUCTO,
      i.DESCRIPCION,
      i.PRECIO,
      i.EXISTENCIAS,
        GETDATE(),
		USER_NAME(USER_ID()),
        'INS'
    FROM
        inserted i
     WHERE NOT EXISTS(SELECT * FROM deleted)
    UNION ALL
    SELECT
      d.ID_FAB ,
      d.ID_PRODUCTO,
      d.DESCRIPCION,
      d.PRECIO,
      d.EXISTENCIAS,
        GETDATE(),
		USER_NAME(USER_ID()),
        'DEL'
    FROM
        deleted d
     WHERE NOT EXISTS(SELECT * FROM INSERTED)
     UNION ALL
    SELECT
      i.ID_FAB ,
      i.ID_PRODUCTO,
      i.DESCRIPCION,
      i.PRECIO,
      i.EXISTENCIAS,
      GETDATE(),
	  USER_NAME(USER_ID()),
      'UPD'
    FROM INSERTED i 
     WHERE EXISTS (SELECT * FROM DELETED)
END

-------------TEST DEL TRIGGER - INSERCION----------------

insert into PRODUCTOS
(ID_FAB, ID_PRODUCTO, DESCRIPCION, PRECIO, EXISTENCIAS)
values
('IMM','887X','Retenedor Riostra',475,32)

---------  TEST DEL TRIGGER - ELIMINACION-----------------

DELETE FROM PRODUCTOS
WHERE ID_PRODUCTO='887X'

-----------TEST DEL TRIGGER - ACTUALIZACION --------------

UPDATE PRODUCTOS
SET PRECIO=84
WHERE ID_PRODUCTO='2A45C'

------------VERIFICAMOS EN LA TABLA AUDITORA--------------

SELECT * FROM AUDITA_PRODUCTO

----------ELIMINAMOS EL TRIGGER MAS NO LA TABLA------------

DROP TRIGGER TRG_AUDITA_PRODUCTO


-----------------------------------------------------
--------------------CURSORES--------------------------
-----------------------------------------------------

CREATE DATABASE CURSORES

create table categoria (
idCategoria int primary key not null, 
nombreCategoria varchar(50) not null, 
)

insert into categoria values (1, 'Computadoras')
insert into categoria values (2, 'Accesorios')

SELECT * FROM CATEGORIA

create table productos (
codigo int primary key not null,
producto varchar(50) not null,
precio Money not null,
idCategoria int not null
)

insert into productos values (1, 'Laptop', 2500.00, 1)
insert into productos values (2, 'Mouse', 50.00, 2)
insert into productos values (3, 'Parlantes', 80.00, 2)
insert into productos values (4, 'Audifonos', 20.00, 2)


--Crear cursor que permita listar productos

declare cursorP cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
fetch next from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP

--------------------------------------------------------
---------------------CURSOR SCROLL----------------------
--------------------------------------------------------

--PRIMER REGISTRO 

declare cursorP scroll cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch First from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP

--ULTIMO REGISTRO

declare cursorP scroll cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch Last from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP


---ADVERTENCIA----

declare cursorP cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch Last from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP

-- -----------SCROLL-------------
-- Indica que sera bidireccional y no unidireccional el recorrido

--REGISTRO RELATIVO

-- Con registro relativo puedes asegurarte de poder moverte en cierta cantidades
-- Por ejemplo relative -2 significa que retrocederas 2 veces en el cursor

declare cursorP scroll cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch last from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
Fetch relative -2 from cursorP into @cod, @pro, @pre
end
close cursorP
deallocate cursorP

--REGISTRO ABSOLUTO
-- Te iras al cursor que te indica 
-- Por ejemplo absolute 2 te iras al segundo dato de la tabla
-- Absolute -1 funciona como un fetch last 

declare cursorP scroll cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch Absolute 1 from cursorP into @cod,@pro,@pre 
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP

--¿Funcionará sin el scroll?

declare cursorP  cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch Absolute 3 from cursorP into @cod,@pro,@pre 
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP

--REGISTRO ANTERIOR Y MOSTRAR LOS ULTIMOS 2 REGISTROS


DECLARE @CONT NUMERIC(5,0)
SET @CONT=0
declare cursorP scroll cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch LAST from cursorP into @cod,@pro,@pre 
while @@fetch_status=0 AND @CONT<2
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
SELECT @CONT=@CONT+1
Fetch prior from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP


------------------------------------------------------------
--------------------CURSOR ANIDADO--------------------------
------------------------------------------------------------

--Crear un cursor que permita mostrar los productos de cada categoría.
--Primera Opción

select * from categoria
select * from productos

declare cursorCP cursor
for select idCategoria,nombreCategoria from categoria
open cursorCP
declare @cat int, @nom varchar(50)
fetch next from cursorCP into @cat,@nom
while @@fetch_status=0
begin
print 'Categoria : ' + @nom
print '=================================='
	declare cursorCP1 cursor
	for select codigo, producto, precio from productos where idCategoria=@cat
	open cursorCP1
	declare @codpro int,@prod varchar(50) ,@prec money
	fetch next from cursorCP1 into @codpro, @prod, @prec
	while @@fetch_status=0
	begin
	print 'Codigo : ' + cast(@codpro as varchar(10))
	print 'Producto : ' + @prod
	print 'Precio : ' + cast(@prec as varchar(10))
	fetch next from cursorCP1 into @codpro, @prod, @prec
	end
	close cursorCP1
	deallocate cursorCP1

fetch next from cursorCP into @cat,@nom
end
close cursorCP
deallocate cursorCP

--Segunda Opción

declare cursorCate cursor for select nombreCategoria, idCategoria from categoria
declare cursorProd cursor for select codigo, producto, precio, idCategoria from productos
declare @codcat int, @categoria varchar(50)
declare @codprod int, @producto varchar(50), @precio decimal, @cate int
open cursorCate
fetch next from cursorCate into @categoria, @codcat
while @@FETCH_STATUS = 0
begin
print '=================================='
print 'Categoria=' + upper(@categoria)
print '=================================='
	open cursorProd
	fetch next from cursorProd into @codprod, @producto, @precio, @cate
	while @@FETCH_STATUS = 0
	begin
	if @cate = @codcat
	begin
	print 'Codigo=' + cast(@codprod as varchar(5))
	print 'Producto=' + @producto
	print 'Precio=' + cast(@precio as varchar(10))
	end
	fetch next from cursorProd into @codprod, @producto, @precio, @cate
	end
close cursorProd
fetch next from cursorCate into @categoria, @codcat
end

close cursorCate
deallocate cursorCate
deallocate cursorProd

------------------APLICACION PARTICULAR---------------------------
sp_configure 'show advanced options', '1'
RECONFIGURE
-- this enables xp_cmdshell
sp_configure 'xp_cmdshell', '1' 
RECONFIGURE

DECLARE @COM VARCHAR(5000)
DECLARE @RUTA VARCHAR(1000) = 'C:\Users\TEMP\Desktop\Example\'
create TABLE COPIA(ARCHIVO VARCHAR(1000))
DECLARE @ARCHIVO VARCHAR(1000)
 
SET @COM = 'DIR '+@RUTA
INSERT INTO COPIA
EXEC XP_CMDSHELL @COM

DELETE FROM COPIA
WHERE ARCHIVO IS NULL OR ARCHIVO NOT LIKE '%.TXT%'

UPDATE COPIA
SET ARCHIVO = SUBSTRING(ARCHIVO,42,1000)

DECLARE CURSOR_ARCHIVO CURSOR FOR
SELECT ARCHIVO FROM COPIA

OPEN CURSOR_ARCHIVO
FETCH NEXT FROM CURSOR_ARCHIVO INTO @ARCHIVO

WHILE(@@FETCH_STATUS = 0) BEGIN
       PRINT @ARCHIVO
       EXEC('
       BULK INSERT TABLA 
       FROM '''+@RUTA+@ARCHIVO+'''
       WITH (
             FIELDTERMINATOR =''|'',ROWTERMINATOR=''\n'',FIRSTROW = 1
       )
       ')
       FETCH NEXT FROM CURSOR_ARCHIVO INTO @ARCHIVO
END
CLOSE CURSOR_ARCHIVO
DEALLOCATE CURSOR_ARCHIVO

------USO CON PROCEDURES--------

CREATE PROCEDURE SP_USO_CURSOR
AS
BEGIN
declare cursorP scroll cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
Fetch First from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP
END

EXEC SP_USO_CURSOR

--Crear un store procedure que incremente el precio de venta de uno en uno tantas veces como
--lo indique el parámetro numérico que reciba.

Create Table Libros(
id_Libro numeric(10,0) Not NULL,
Titulo varchar(30) Not NULL,
PreciodeVenta numeric(10,2) Not NULL,
Paginas int Not NULL
)

INSERT INTO LIBROS VALUES (345,' Cien años de soledad ',70,200)
INSERT INTO LIBROS VALUES (346,' Metamorfo5i5 ',50,100)

SELECT * FROM LIBROS

CREATE PROCEDURE SP_LIBROS
@PARAMETRO NUMERIC(10,0)
AS
BEGIN 

declare CursosLibros cursor
for select id_Libro from Libros
open CursosLibros
declare @codlibro numeric(10,0)
fetch next from CursosLibros into @codlibro
while @@fetch_status=0 
begin
Update Libros
set PreciodeVenta=PreciodeVenta+@PARAMETRO
fetch next from CursosLibros into @codlibro
end
close CursosLibros
deallocate CursosLibros

END

--110+40=150
--90+40=130

EXEC SP_LIBROS 40

SELECT * FROM LIBROS

--70
--50
-------------¿QUE SUCEDIÓ?---------------

DROP TABLE LIBROS
DROP PROCEDURE SP_LIBROS

CREATE PROCEDURE SP_LIBROS
@PARAMETRO NUMERIC(10,0)
AS
BEGIN 

declare CursosLibros cursor
for select id_Libro from Libros
open CursosLibros
declare @codlibro numeric(10,0)
fetch next from CursosLibros into @codlibro
while @@fetch_status=0 
begin
Update Libros
set PreciodeVenta=PreciodeVenta+@PARAMETRO
where id_Libro=@codlibro
fetch next from CursosLibros into @codlibro
end
close CursosLibros
deallocate CursosLibros

END

EXEC SP_LIBROS 40

SELECT * FROM LIBROS

------------------VEAMOS LAS VENTAJAS Y DESVENTAJAS----------------------------

---------MEJOREMOS LA APLICACION CON PRODUCTOS Y PEDIDOS-----------------

declare cursorP cursor
for select Producto,SUM(Importe) AS Venta_Total from Pedidos group by Producto
open cursorP
declare @codprod varchar(10), @importe numeric(20,2)
fetch next from cursorP into @codprod,@importe
while @@fetch_status=0
begin
print 'Codigo Producto :' + @codprod
print 'Venta Total :' + cast(@importe as varchar(10))
print '=================='
fetch next from cursorP into @codprod,@importe
end
close cursorP
deallocate cursorP

----Crear Tablas Mensuales de las ventas realizadas

Declare @mesformat varchar(2)
declare cursorMensual cursor
for Select Year(Fecha_pedido) as Año_Pedido,Month(Fecha_Pedido) AS Mes_Pedido from Pedidos group by Year(Fecha_pedido),Month(Fecha_Pedido)
open cursorMensual
declare @año varchar(4), @mes varchar(2)
fetch next from cursorMensual into @año,@mes
while @@fetch_status=0
begin
Set @mesformat=RIGHT('0'+@mes,2)  
EXEC('Select * into Ventas_'+@año+@mesformat+' from Pedidos Where Year(Fecha_Pedido)='+@año+' and Month(Fecha_Pedido)='+@mes)
fetch next from cursorMensual into @año,@mes
end
close cursorMensual
deallocate cursorMensual

--Truncamos masivamente

Declare @mesformat varchar(2)
declare cursorMensual cursor
for Select Year(Fecha_pedido) as Año_Pedido,Month(Fecha_Pedido) AS Mes_Pedido from Pedidos group by Year(Fecha_pedido),Month(Fecha_Pedido)
open cursorMensual
declare @año varchar(4), @mes varchar(2)
fetch next from cursorMensual into @año,@mes
while @@fetch_status=0
begin
Set @mesformat=RIGHT('0'+@mes,2)  
EXEC('Truncate table Ventas_'+@año+@mesformat)
fetch next from cursorMensual into @año,@mes
end
close cursorMensual
deallocate cursorMensual

EXEC('select * from pedidos')

SELECT * FROM [dbo].[Ventas_199003]
SELECT * FROM [dbo].[Ventas_199002]

--Insertamos masivamente

Declare @mesformat varchar(2)
declare cursorMensual cursor
for Select Year(Fecha_pedido) as Año_Pedido,Month(Fecha_Pedido) AS Mes_Pedido from Pedidos group by Year(Fecha_pedido),Month(Fecha_Pedido)
open cursorMensual
declare @año varchar(4), @mes varchar(2)
fetch next from cursorMensual into @año,@mes
while @@fetch_status=0
begin
Set @mesformat=RIGHT('0'+@mes,2)  
EXEC('Insert into Ventas_'+@año+@mesformat+' Select * from Pedidos where Year(Fecha_Pedido)='+@año+' and Month(Fecha_Pedido)='+@mes)
fetch next from cursorMensual into @año,@mes
end
close cursorMensual
deallocate cursorMensual


---Crear tablas de Producto 

select * from pedidos

Declare cursorProducto cursor
for Select distinct Producto from Pedidos
open cursorProducto
declare @codprod varchar(10)
fetch next from cursorProducto into @codprod
while @@fetch_status=0
begin
EXEC('Select * into Ventas_'+@codprod+' from Pedidos Where producto='''+@codprod+'''')
--SELECT * INTO VENTAS_112 FROM PEDIDOS WHERE PRODUCTO='112'
fetch next from cursorProducto into @codprod
end
close cursorProducto
deallocate cursorProducto

--Borrar tablas

Declare cursorProducto cursor
for Select distinct Producto from Pedidos
open cursorProducto
declare @codprod varchar(10)
fetch next from cursorProducto into @codprod
while @@fetch_status=0
begin
EXEC('Drop table Ventas_'+@codprod)
fetch next from cursorProducto into @codprod
end
close cursorProducto
deallocate cursorProducto