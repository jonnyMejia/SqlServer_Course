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

