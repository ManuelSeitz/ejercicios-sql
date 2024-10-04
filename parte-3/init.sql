-- Crear las siguientes tablas:
-- PLANTILLA (CODHOSP, CODSALA, N°EMP, APELLIDO, NOMBRE, FUNCION, TURNO,
-- SALARIO)
-- HOSPITAL (CODHOSP, NOMBRE, DIREC, TE)
-- MÉDICO (CODHOSP, N°MÉDICO, APELLIDO, NOMBRE, ESPEC)
-- PACIENTE (N°PACIENTE, APELLIDO, NOMBRE, DIR, TE, FNACIM)
-- SALA (CODHOSP, CODSALA, NOMBRE, NRO_CAMAS)

-- Eliminar tablas si existen
DROP TABLE IF EXISTS Plantilla;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS Paciente;
DROP TABLE IF EXISTS Medico;
DROP TABLE IF EXISTS Hospital;


CREATE TABLE Hospital
(
  cod_hosp INT IDENTITY PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  telefono VARCHAR(255) NOT NULL,
);

CREATE TABLE Medico
(
  num_medico INT IDENTITY PRIMARY KEY,
  cod_hosp INT FOREIGN KEY (cod_hosp) REFERENCES Hospital(cod_hosp),
  apellido VARCHAR(100) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  espec VARCHAR(100) NOT NULL
);

CREATE TABLE Paciente
(
  num_paciente INT IDENTITY PRIMARY KEY,
  apellido VARCHAR(100) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(255),
  telefono VARCHAR(255),
  fecha_nacimiento DATE NOT NULL
);

CREATE TABLE Sala
(
  cod_sala INT IDENTITY PRIMARY KEY,
  cod_hosp INT,
  nombre VARCHAR(100) NOT NULL,
  nro_camas INT NOT NULL,
  CONSTRAINT cod_hosp FOREIGN KEY (cod_hosp) REFERENCES Hospital(cod_hosp)
);

CREATE TABLE Plantilla
(
  nro_empleado INT IDENTITY PRIMARY KEY,
  cod_hosp INT FOREIGN KEY REFERENCES Hospital(cod_hosp),
  cod_sala INT FOREIGN KEY REFERENCES Sala(cod_sala),
  apellido VARCHAR(100) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  funcion VARCHAR(255),
  turno CHAR NOT NULL CHECK (turno IN ('M', 'T', 'N')),
  salario FLOAT(2) NOT NULL,
);

INSERT INTO Hospital
  (nombre, direccion, telefono)
VALUES
  ('Hospital General', 'Calle Falsa 123', '123-456-7890'),
  ('Clínica Saludable', 'Avenida Siempre Viva 456', '987-654-3210'),
  ('Hospital Municipal', 'Calle Real 789', '555-1234');

INSERT INTO Medico
  (cod_hosp, apellido, nombre, espec)
VALUES
  (1, 'Gómez', 'Juan', 'Cardiología'),
  (1, 'López', 'Ana', 'Pediatría'),
  (2, 'Martínez', 'Carlos', 'Traumatología'),
  (3, 'Rodríguez', 'Laura', 'Clínico');

INSERT INTO Paciente
  (apellido, nombre, direccion, telefono, fecha_nacimiento)
VALUES
  ('Fernández', 'Pedro', 'Calle Verde 12', '321-654-9870', '1985-05-15'),
  ('Sánchez', 'María', 'Calle Azul 34', '654-321-0987', '1990-08-25'),
  ('Pérez', 'Luis', 'Calle Amarilla 56', '789-123-4567', '2000-01-01');

INSERT INTO Sala
  (cod_hosp, nombre, nro_camas)
VALUES
  (1, 'Sala de Emergencias', 20),
  (1, 'Sala de Maternidad', 15),
  (2, 'Sala de Intervenciones', 22),
  (3, 'Sala de Cirugía', 25);

INSERT INTO Plantilla
  (cod_hosp, cod_sala, apellido, nombre, funcion, turno, salario)
VALUES
  (1, 1, 'Díaz', 'Hector', 'Enfermero', 'N', 6000500),
  (1, 3, 'Nuñez', 'Jorge', 'Enfermero', 'N', 800000),
  (1, 2, 'Castro', 'Marta', 'Auxiliar', 'T', 500000),
  (2, 3, 'Navarro', 'Sofía', 'Auxiliar', 'M', 450000),
  (3, 4, 'Torres', 'José', 'Cirujano', 'M', 6000000);
