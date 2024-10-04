-- 1) Encuentre a todos los miembros del personal cuyo nombre empiece con “H”.
SELECT *
FROM Plantilla
WHERE nombre LIKE 'H%';

-- 2) Listar todos los médicos cuya especialidad sea “clínico”.
SELECT *
FROM Medico
WHERE espec = 'clínico';

-- 3) Listar los datos de las salas cuya cantidad de camas sea superior a 20 y la descripción de la
-- sala contenga la subcadena “int”.
SELECT *
FROM Sala
WHERE nro_camas > 20 AND nombre LIKE '%int%';

-- 4) Incrementar el salario de los empleados de la plantilla en un 10%.
SELECT *, salario * 1.10  AS salario_incrementado
FROM Plantilla;

-- 5) Escribir una consulta que muestre quiénes son las enfermeras y enfermeros que trabajan en
-- turnos tarde y mañana indicando el sueldo mensual de cada uno.
SELECT nombre, apellido, funcion, turno, salario
FROM Plantilla
WHERE funcion LIKE 'enfermer[ao]' AND turno LIKE '[MT]';

-- 6) Realice un listado de las enfermeras que ganen entre $ 700.000 y $ 800.000
SELECT *
FROM Plantilla
WHERE funcion = 'enfermera' AND salario BETWEEN 700000 AND 800000;

-- 7) Encontrar el salario medio de los empleados del hospital (no de los médicos).
SELECT AVG(salario) AS salario_medio
FROM Plantilla;

-- 8) Encontrar el salario más alto y el salario más bajo de la tabla de personal, así como la
-- diferencia entre los dos.
SELECT MAX(salario) AS salario_maximo, MIN(salario) AS salario_minimo, MAX(salario) - MIN(salario) AS diferencia
FROM Plantilla;

-- 9) Calcular la cantidad de camas con las que cuenta el hospital.
SELECT H.cod_hosp, H.nombre, SUM(S.nro_camas) AS nro_camas
FROM Hospital AS H JOIN Sala AS S ON H.cod_hosp = S.cod_hosp
GROUP BY H.cod_hosp, H.nombre;

-- 10) Calcular el número de personas que trabaja en cada turno.
SELECT turno, COUNT(*) AS nro_personas
FROM Plantilla
GROUP BY turno;

-- 11) Listar el nombre, apellido, la función, el turno y el salario de todos los empleados que tienen un
-- salario superior a $ 800.000 y trabajan en el turno noche. Ordenar el listado en forma
-- descendente según salario.
SELECT nombre, apellido, funcion, turno, salario
FROM Plantilla
WHERE salario > 800000 AND turno = 'N'
ORDER BY salario DESC;

-- 12) Listar el nombre, apellido, la función, el turno y el salario de todos los empleados que tienen un
-- salario superior al salario más bajo del turno noche. Ordenar el listado en forma descendente
-- según salario.
SELECT nombre, apellido, funcion, turno, salario
FROM Plantilla
WHERE salario > (
SELECT MIN(salario)
FROM Plantilla
WHERE turno = 'N'
)
ORDER BY salario DESC;

-- 13) Encontrar las personas que ganen 500 pesos más que el miembro del personal de sueldo
-- más alto en el turno mañana y que también tenga el mismo trabajo que Núñez. Indicar el
-- nombre de la persona, la función, el turno y el salario
SELECT nombre, funcion, turno, salario
FROM Plantilla
WHERE salario = (SELECT MAX(salario) + 500
  FROM Plantilla
  WHERE turno = 'M') AND funcion = (SELECT funcion
  FROM Plantilla
  WHERE apellido = 'Nuñez');

-- 14) Descubrir el personal que gane lo mismo o más que la media de su turno. Facilitar el nombre,
-- el número de empleado, la función, el salario y el turno.
SELECT nro_empleado, nombre, funcion, salario, turno
FROM Plantilla AS P
WHERE salario >= (SELECT AVG(salario)
FROM Plantilla
WHERE turno = P.turno);

-- 15) Recuperar todos los médicos cuya especialidad coincida con la del médico de apellido Porta.
SELECT *
FROM Medico
WHERE espec = (SELECT espec
FROM Medico
WHERE apellido = 'Porta');