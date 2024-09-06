-- Crear las siguientes tablas:
-- FACTURA (NºFACT, FECHA, CODCLI, TOTAL)
-- DETALLE (NºFACT, CODPROD, PUNIT, CANT)
-- CLIENTE (CODCLI, APELLIDO, NOMBRE, DOMICILIO, LOCALIDAD, SALDOCLI)
-- PRODUCTO (CODPROD, DESCRIPCIÓN, CODRUBRO, STOCK, PTO_REPOSICIÓN, PRECIO)
-- RUBRO (CODRUBRO, DESCRIPCIÓN)

-- Eliminar tablas si existen
DROP TABLE IF EXISTS Detalle;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Factura;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Rubro;

CREATE TABLE Cliente
(
  id INT IDENTITY PRIMARY KEY,
  apellido VARCHAR(255) NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  domicilio VARCHAR(150),
  localidad VARCHAR(100),
  saldo FLOAT(2)
);

CREATE TABLE Factura
(
  numero INT IDENTITY PRIMARY KEY,
  fecha DATE DEFAULT GETDATE(),
  id_cliente INT FOREIGN KEY REFERENCES Cliente(id),
  total FLOAT(2) NOT NULL
);

CREATE TABLE Rubro
(
  id INT IDENTITY PRIMARY KEY,
  descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE Producto
(
  id INT IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255) NOT NULL,
  id_rubro INT FOREIGN KEY REFERENCES Rubro(id),
  stock INT NOT NULL,
  pto_reposicion VARCHAR(100),
  precio FLOAT(2) NOT NULL
);

CREATE TABLE Detalle
(
  num_factura INT NOT NULL,
  id_producto INT NOT NULL,
  p_unit FLOAT(2) NOT NULL,
  cant INT NOT NULL,
  CONSTRAINT id_detalle PRIMARY KEY (num_factura, id_producto),
  FOREIGN KEY (num_factura) REFERENCES Factura(numero),
  FOREIGN KEY (id_producto) REFERENCES Producto(id)
);

-- Llenar las tablas
INSERT INTO Cliente
VALUES
  ('Seitz', 'Manuel', 'Casa', 'Olavarría', 1500),
  ('Gonzalez', 'Juan', 'Depto', 'Capital', -2700),
  ('Martínez', 'Ana', 'Casa', 'Loma Negra', 2500.50),
  ('Rodríguez', 'Luis', 'Casa', 'Tandil', 1800.75);

INSERT INTO Rubro
VALUES
  ('Electrónica'),
  ('Ropa'),
  ('Alimentos'),
  ('Hogar');

INSERT INTO Producto
VALUES
  ('Televisor LED', 'Televisor LED 40 pulgadas', 1, 150, '50 unidades', 600000),
  ('Camiseta', 'Camiseta de algodón tamaño M', 2, 500, '100 unidades', 3000),
  ('Laptop', 'Laptop portátil con 16GB RAM', 1, 80, '20 unidades', 1500000),
  ('Galletitas OREO', 'Paquete de galletitas OREO', 3, 1000, '200 unidades', 2500.50),
  ('Sillón', 'Maravilloso sillón de 3 plazas', 4, 20, '5 unidades', 29999.99),
  ('Pelota', 'Una pelota de fútbol', NULL, 1000, '200 unidades', 5500);

INSERT INTO Factura
VALUES
  (GETDATE(), 1, 700.00),
  (GETDATE(), 2, 320.00),
  (GETDATE(), 1, 500.00);

INSERT INTO Detalle
  (num_factura, id_producto, p_unit, cant)
VALUES
  (1, 1, 600000, 2),
  (1, 4, 2500.50, 1500),
  (2, 2, 3000, 10),
  (3, 3, 1500000, 1),
  (2, 5, 29999.99, 1),
  (3, 4, 2500.50, 2000);