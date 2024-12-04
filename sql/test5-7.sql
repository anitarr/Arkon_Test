/*
Preguntas obligatorias en SQL

5 Generar una query de SQL que muestre la siguiente información, los nombres que tengan un
height arriba de 180 pero menor a 190, que cumplan la condición de ser male y el hair_color
sea cualquiera menos “none”
*/
/*mysql*/
SELECT name FROM testdata.data_union
WHERE height BETWEEN 180 AND 190 AND sex = 'male' AND hair_color!='none';

/*postgres*/
SELECT name FROM arkon_data.data_union
WHERE height BETWEEN 180 AND 190 AND sex = 'male' AND hair_color!='none';

/*
6 Por medio de una sentencia SQL generar la siguiente bandera:
1 <-> el mass está arriba del promedio
0 <-> el mass es menor igual al promedi

SQL
*/
SELECT 
    name, 
    mass,
    CASE 
        WHEN mass > (SELECT AVG(mass) FROM data_union) THEN 1 
        ELSE 0 
    END AS bandera
FROM 
    data_union;

/*postgres*/
SELECT 
    name, 
    mass,
    CASE 
        WHEN mass > (SELECT AVG(mass) FROM arkon_data.data_union) THEN 1 
        ELSE 0 
    END AS bandera
FROM 
    arkon_data.data_union;

/*Pregunta 6 también puedo crear una VIEW*/
/*SQL*/
CREATE VIEW mass_flat AS
SELECT 
    name, 
    mass,
    CASE 
        WHEN mass > (SELECT AVG(mass) FROM data_union) THEN 1 
        ELSE 0 
    END AS bandera
FROM 
    data_union;
    
SELECT * FROM mass_flat;

/*postgres*/
CREATE VIEW mass_flat AS
SELECT 
    name, 
    mass,
    CASE 
        WHEN mass > (SELECT AVG(mass) FROM arkon_data.data_union) THEN 1 
        ELSE 0 
    END AS bandera
FROM 
    arkon_data.data_union;
    
SELECT * FROM mass_flat;
/* Otra manera de hacerlo es creando una nueva columna en el esquema,
una tabla temporal donde guardo el valor del avg de mass y luego hago un update
con la consulta para actualizar el valor de la bandera según el promedio*/
ALTER TABLE data_union ADD COLUMN flat INT;

CREATE TEMPORARY TABLE temp_avg_mass AS
SELECT AVG(mass) AS avg_mass FROM data_union;

-- Desactivar el modo de actualización segura
SET SQL_SAFE_UPDATES = 0;

-- Ejecutar la actualización
UPDATE data_union
SET flat = CASE 
    WHEN mass > (SELECT avg_mass FROM temp_avg_mass) THEN 1 
    ELSE 0 
END;

-- Volver a activar el modo de actualización segura
SET SQL_SAFE_UPDATES = 1;

-- postgres
ALTER TABLE arkon_data.data_union ADD COLUMN flat INT;

CREATE TEMPORARY TABLE temp_avg_mass AS
SELECT AVG(mass) AS avg_mass FROM arkon_data.data_union;

-- Ejecutar la actualización
UPDATE arkon_data.data_union
SET flat = CASE 
    WHEN mass > (SELECT avg_mass FROM temp_avg_mass) THEN 1 
    ELSE 0 
END;


/*7 Calcular la altura promedio, la altura máxima y mínima por especie, mediante una sentencia SQL*/
SELECT 
    species,
    AVG(height) AS altura_promedio,
    MAX(height) AS altura_maxima,
    MIN(height) AS altura_minima
FROM 
    data_union
GROUP BY 
    species;

-- postgres
SELECT 
    species,
    AVG(height) AS altura_promedio,
    MAX(height) AS altura_maxima,
    MIN(height) AS altura_minima
FROM 
    arkon_data.data_union
GROUP BY 
    species;


/*Pregunta 2 mysql*/
SELECT DISTINCT starships FROM data_union;
/*Pregunta 2 postgres*/
SELECT DISTINCT starships FROM arkon_data.data_union;

/*Pregunta 3*/
SELECT COUNT(*), skin_color,eye_color FROM data_union group by skin_color, eye_color;
/*Pregunta 3 postgres*/
SELECT COUNT(*), skin_color,eye_color FROM arkon_data.data_union group by skin_color, eye_color;

/*Pregunta 4*/
SELECT name, COUNT(*) AS cantidad_duplicados
FROM data_union
GROUP BY name
HAVING COUNT(*) > 1;
/*Pregunta 4 postgres*/
SELECT name, COUNT(*) AS cantidad_duplicados
FROM arkon_data.data_union
GROUP BY name
HAVING COUNT(*) > 1;