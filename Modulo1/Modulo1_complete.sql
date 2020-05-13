-- TIPOS DE DATOS 
CHAR(n) --> Conozco el tamaño de la cadena 
VARCHAR(n) --> No conozco el tamaño de la cadena pero pongo un maximo
MONEY
DATETIME --> Año,Mes,Dia,Hora
SMALLDATETIME 
NUMERIC(n,s) --> n:tamaño parte entera ; s:tamaño parte decimal
FLOAT(n) --> Cuando no conozco sus decimales
INT --> -2^31 a 2^31
SMALLINT --> -2^15 a 2^15
TINYINT --> 0 a 256

-- Creacion de una base de datos
create database prueba;
use prueba
-- Creacion de una tabla 
CREATE TABLE DIRECTORIO(
    ID_ALUMNO INT IDENTITY(100,5),
    -- Empezara por el 100 y aumentara en 5 por cada alumno insertado
    TELEFONO CHAR(8) NULL
)

-- Insertar el registro telefono
-- no marca error porque identity permite tener como default un cierto valor
insert into DIRECTORIO values('telefono')

-- Ver la tabla y todas sus columnas
select * from Directorio 

--Eliminar una tabla 
DROP TABLE DIRECTORIO

--Agregar un registro 
INSERT INTO DIRECTORIO VALUES ('Telefono')
INSERT INTO DIRECTORIO(TELEFONO) VALUES ('telefono')

--Eliminar un registro
delete from DIRECTORIO 
where ID_ALUMNO=100

--Modificar registros 

--Modificara a todos los registros porque no tiene un control
update Diretorio
set ID_ALUMNO=120

-- Modificara a solo los registros que cumplam la condicion 
update Directorio
set id_alumno=23
where telefono='telefono'

--WHERE MAS SELECT

--Creando la tabla 
create table news(
    nombre varchar(30),
    apellido varchar(30),
    promedio numeric(2,2)
)
--Agregando algunos registros
insert into Alumnos values('Pepe','Perez',12.3)
insert into Alumnos values('Juan','Juarez',10.3)
insert into Alumnos values('Rodrigo','Meneces',13.3)

--mostrar todos los registros y campos
select * from Alumnos

--mostrar todos los registros pero algunos campos(nombre,promedio)
select nombre,promedio as NotaFinal 
from news

--mostrar algunos registros(cumplan la condicion) con todos los campos
select * from news
where promedio>10.5

--Update con where
update Alumnos 
set nombre='Nuevo'
where nombre is null

--Top 'n' mostrar los primeros n registros
select top 2 * from news

--Order by, permite ordenar mediante una columna en orden ascendente o descendente
select * from news
--como manera prederteminada es ascendente
order by 1 

select * from news 
order by nombre DESC

--Primero ordena la columna 1 de manera ascedente  luego de manera descendente
--solo si la primera columna por si solas no pueden ordenarse por igualdad de valores
select * from news 
order by 1 , 2 desc

--Top y order by para mostrar los n ULTIMOS registros(No es exacto) 
--Se deberia usar cursores(Modulo 2)
select top 10 * from news
order by 1 desc 

--DISTINCT y group by 
--Si los registros se repiten solo mostrara una vez
select distinct nombre from news 

--Asegurar que muestre los registros sin duplicados 
select distinct * from news

--Group by permite agrupar los datos cuando se puedan repetir 
 
create table OFICINAS 
( OFICINA integer not null,
CIUDAD varchar(30) not null,
REGION varchar (30) not null,
DIR integer  not null,
OBJETIVO money not null,
VENTAS money not null);

insert into oficinas
(OFICINA, CIUDAD, REGION, DIR, OBJETIVO, VENTAS) values
(22,'Denver','Oeste',108,300000,186042)

insert into oficinas
(OFICINA, CIUDAD, REGION, DIR, OBJETIVO, VENTAS) values
(11,'New York','Este',106,575000,692637)

insert into oficinas
(OFICINA, CIUDAD, REGION, DIR, OBJETIVO, VENTAS) values
(12,'Chicago','Este',104,800000,735042)

insert into oficinas
(OFICINA, CIUDAD, REGION, DIR, OBJETIVO, VENTAS) values
(13,'Atlanta','Este',105,350000,367911)

insert into oficinas
(OFICINA, CIUDAD, REGION, DIR, OBJETIVO, VENTAS) values
(21,'Los Angeles','Oeste',108,725000,835915)

select COUNT(OFICINA) "Cantidad de regiones",REGION from OFICINAS
GROUP by REGION

3	Este
2	Oeste

-- FUNCIONES DE AGREGADO

/* 
Funcion MAX y MIN
Funcion SUM
Funcion AVG
Funcion COUNT
Funcion HAVING
 */

select COUNT(*)'Cantidad de regiones',SUM(DIR) 'Direcciones Sumadas',Region from OFICINAS
group by REGION

-- Cuando usamos group by debemos tener en cuenta que debemos agrupar 
-- columnas cuantas veces se menciona en el select
/* 
select columna1,columna2,funcionMax,funcionAvg FROM EXAMPLE
group by columna1,columna2 
 */

-- FUNCION HAVING 

-- Having es un where que tambien aplica a las funciones agregadas y/o resultados obtenidos a partir de ellas

select Region,AVG(DIR) 'AVG(DIRECCIONES)' from OFICINAS
group by REGION
having AVG(DIR) > 100 and REGION='Este'
 
-- LIKE
-- Es una sentencia muy parecida a match en java 

-- Creando la tabla alumnos
create table Alumnos(
    nombre varchar(30),
    nota int
)

insert into Alumnos values('Jose',11)
insert into Alumnos values('23nef dfef',18)
insert into Alumnos values('342 sdsf sdf',12)
insert into Alumnos values('Judas Meneces 1241234',12)
insert into Alumnos values('Esto no se si ',04)

-- Esta sentencia mostrara nombres que no empiezen con un numero y despues valida cualquier palabra .
Select nombre from Alumnos
where nombre like '[^0-9]%'
/* 
Jose
Judas Meneces 1241234
Esto no se si 
 */

-- AND, OR, NOT , IS
AND -> 'Y logico'
OR  -> 'O logico'
is  -> 'Con expresiones verdaderas o falsas (is null)'
not -> 'Con expresiones verdaderas o falsas (not like, is not null)'

-- =, (!=, <>)
=       -> 'Asignar valores y comparar'
(!=,<>) -> 'Diferente a'

-- BETWEEN, IN

select * from alumnos
where nota BETWEEN 12 and 19
-- Incluye el numero 12 y 19 en la busqueda

select * from alumnos
where nota in (12,14,16,18)
-- Solo aceptara los valores que esten dentro del parentesis ()
-- Funciona mejor con subconsultas

select * from alumnos
where nota in (select nota from Aprobados )

