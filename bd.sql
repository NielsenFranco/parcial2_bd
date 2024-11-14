CREATE DATABASE parcial_dos;

USE parcial_dos;

/* CREACIÓN DE LAS TABLAS */

/* Productos: almacena información sobre los productos */
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio_actual DECIMAL(5, 2) NOT NULL,
    marca VARCHAR(20),
    modelo VARCHAR(30),
    descripcion TEXT,
    foto_url VARCHAR(100)
);

/* Historial_Precios: registra el historial de precios de los productos */
CREATE TABLE historial_precios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(5, 2),
    nuevo_precio DECIMAL(5, 2),
    fecha_cambio DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

/* Clientes: almacena los datos de los clientes */
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    correo VARCHAR(50),
    telefono VARCHAR(12),
    direccion VARCHAR(80)
);

/* Cuentas_Corrientes: administra el saldo actual de cada cliente */
CREATE TABLE cuentas_corrientes (
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    saldo_actual DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

/* Movimientos_Cuenta: registra los débitos y créditos en cuentas */
CREATE TABLE movimientos_cuenta (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT,
    tipo ENUM('Débito', 'Crédito') NOT NULL,
    monto DECIMAL(5, 2) NOT NULL,
    fecha DATE,
    FOREIGN KEY (id_cuenta) REFERENCES cuentas_corrientes(id_cuenta)
);

/* Catalogo: productos dentro del catálogo */
CREATE TABLE catalogo (
    id_catalogo INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

/* Presupuestos: almacena los presupuestos generados para los clientes */
CREATE TABLE presupuestos (
    id_presupuesto INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_emision DATE,
    fecha_vencimiento DATE,
    total DECIMAL(5, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

/* Presupuesto_Productos: relación de los productos en los presupuestos */
CREATE TABLE presupuesto_productos (
    id_presupuesto_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_presupuesto INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (id_presupuesto) REFERENCES presupuestos(id_presupuesto),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

/* Pedidos: pedidos en línea de los clientes */
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_pedido DATE,
    estado ENUM('Pendiente', 'Confirmado', 'Cancelado') DEFAULT 'Pendiente',
    total DECIMAL(5, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

/* Pedido_Productos: relación de productos dentro de los pedidos */
CREATE TABLE pedido_productos (
    id_pedido_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

/* CARGA DE DATOS PARA BASE DE DATOS */

INSERT INTO productos (nombre, precio_actual, marca, modelo, descripcion, foto_url) VALUES
('Samsung Galaxy S21', 699.99, 'Samsung', 'S21', 'Smartphone con pantalla de 6.2 pulgadas y 128GB de almacenamiento', 'url_imagen1'),
('Laptop Inspiron 15', 799.99, 'Dell', 'Inspiron 15 5000', 'Laptop de 15 pulgadas con procesador Intel Core i5 y 8GB de RAM', 'url_imagen2'),
('Auriculares Bluetooth', 59.99, 'Sony', 'WH-1000XM4', 'Auriculares inalámbricos con cancelación de ruido', 'url_imagen3'),
('Smart TV 4K', 499.99, 'LG', 'LG 55UP8000', 'Televisor 4K de 55 pulgadas con inteligencia artificial', 'url_imagen4');

INSERT INTO historial_precios (id_producto, precio_anterior, nuevo_precio, fecha_cambio) VALUES
(1, 650.00, 699.99, '2023-08-01'),
(2, 750.00, 799.99, '2023-09-15'),
(3, 50.00, 59.99, '2023-07-10'),
(4, 450.00, 499.99, '2023-10-05');

INSERT INTO clientes (nombre, correo, telefono, direccion) VALUES
('Franco Nielsen', 'franconielsen@gmail.com', '123456789', 'Av. Principal 123'),
('Mariano Villalba', 'Villalba.m@gmail.com', '987654321', 'Calle Secundaria 456'),
('Ivan Mierez', 'mierezivan1@gmail.com', '456789123', 'Carrera 10 #20-30'),
('Danzel Burki', 'burki.danzel@gmail.com', '321654987', 'Barrio Alto 789');

INSERT INTO cuentas_corrientes (id_cliente, saldo_actual) VALUES
(1, 1000.00),
(2, -200.00),
(3, 500.00),
(4, 300.00);

INSERT INTO movimientos_cuenta (id_cuenta, tipo, monto, fecha) VALUES
(1, 'Crédito', 200.00, '2023-08-15'),
(2, 'Débito', 150.00, '2023-09-01'),
(3, 'Crédito', 300.00, '2023-09-20'),
(4, 'Débito', 100.00, '2023-10-05');

INSERT INTO catalogo (id_producto) VALUES
(1),
(2),
(3),
(4);

INSERT INTO presupuestos (id_cliente, fecha_emision, fecha_vencimiento, total) VALUES
(1, '2023-08-20', '2023-09-20', 899.99),
(2, '2023-09-05', '2023-10-05', 999.99),
(3, '2023-10-10', '2023-11-10', 749.99),
(4, '2023-10-15', '2023-11-15', 1599.99);

INSERT INTO presupuesto_productos (id_presupuesto, id_producto, cantidad, precio) VALUES
(1, 1, 1, 699.99),
(1, 3, 2, 59.99),
(2, 2, 1, 799.99),
(3, 4, 1, 499.99),
(4, 1, 2, 699.99);

INSERT INTO pedidos (id_cliente, fecha_pedido, estado, total) VALUES
(1, '2023-08-25', 'Confirmado', 599.99),
(2, '2023-09-10', 'Pendiente', 499.99),
(3, '2023-10-12', 'Confirmado', 1199.99),
(4, '2023-10-18', 'Cancelado', 750.00);

INSERT INTO pedido_productos (id_pedido, id_producto, cantidad, precio) VALUES
(1, 3, 1, 59.99),
(1, 4, 1, 499.99),
(2, 2, 1, 499.99),
(3, 1, 2, 699.99),
(4, 3, 1, 59.99);
