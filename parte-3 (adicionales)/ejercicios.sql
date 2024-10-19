-- 1) Calcular la cantidad de camas de cada hospital
SELECT H.nombre, SUM(S.nro_camas) AS cantidad_camas
FROM Hospital AS H JOIN Sala AS S ON H.cod_hosp = S.cod_hosp
GROUP BY H.nombre;

-- 2) Realizar un listado con los empleados cuya función sea “camillero” y ganen un salario entre
-- $850.000 y $950.000.
SELECT *
FROM Plantilla
WHERE funcion = 'camillero' AND salario BETWEEN 850000 AND 950000;

-- 3) Realice un listado de los pacientes nacidos en el mes de Octubre.
SELECT *
FROM Paciente
WHERE MONTH(fecha_nacimiento) = 10;

-- 4) Listar todos los pacientes cuyo nombre termine con “ez” y cumplan años en el mes de
-- Noviembre.
SELECT *
FROM Paciente
WHERE nombre LIKE '%ez' AND MONTH(fecha_nacimiento) = 11;

-- 5) Encontrar el salario mínimo y el salario máximo de cada turno.
SELECT turno, MIN(salario) AS [salario minimo], MAX(salario) AS [salario maximo]
FROM Plantilla
GROUP BY turno;

-- 6) Calcular el promedio de salario de cada turno.
SELECT turno, AVG(salario) AS salario_promedio
FROM Plantilla
GROUP BY turno;

-- 7) Calcular la cantidad de médicos con los que cuenta cada hospital.
SELECT H.nombre, COUNT(M.num_medico) AS cantidad_medicos
FROM Hospital AS H JOIN Medico AS M ON H.cod_hosp = M.cod_hosp
GROUP BY H.cod_hosp, H.nombre;

-- 8) Listar aquellos turnos cuya cantidad de empleados sea superior a 20 personas.
SELECT turno, COUNT(nro_empleado) AS cantidad_empleados
FROM Plantilla
GROUP BY turno
HAVING COUNT(nro_empleado) > 20;

-- 9) Encontrar todos los pacientes que hayan nacido en el mismo año que el paciente “Fernandez”.
SELECT *
FROM Paciente
WHERE YEAR(fecha_nacimiento) = (
  SELECT TOP 1
  YEAR(fecha_nacimiento)
  FROM Paciente
  WHERE apellido = 'Fernández'
);

-- 10) Listar el nombre, la función, el turno y el salario de todos los empleados que tienen un salario
-- más bajo que el salario más alto del turno Noche (“N”). Ordenar el listado en forma
-- descendente según salario.
SELECT nombre, apellido, funcion, turno, salario
FROM Plantilla
WHERE salario < (SELECT MAX(salario) FROM Plantilla WHERE turno = 'N')
ORDER BY salario DESC;