USE GD1C2025
GO
--- DROP DE TABLAS ---

-- DIMENSIONES
IF OBJECT_ID('JOIN_FORCES.BI_DIM_TIEMPO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_TIEMPO;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_SUCURSAL', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_SUCURSAL;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_UBICACION', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_UBICACION;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_TURNO_VENTA', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_TURNO_VENTA;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_ESTADO_PEDIDO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_ESTADO_PEDIDO;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_TIPO_MATERIAL', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_TIPO_MATERIAL;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_MODELO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_MODELO;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_RANGO_ETARIO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_RANGO_ETARIO;

-- HECHOS
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_FACTURACION', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_FACTURACION;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_VENTAS_MODELO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_VENTAS_MODELO;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_PEDIDOS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_PEDIDOS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_COMPRAS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_COMPRAS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_ENVIOS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_ENVIOS;

--- DROP DE PROCEDURES ---
IF OBJECT_ID('JOIN_FORCES.migrar_dim_tiempo', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_tiempo;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_sucursal', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_sucursal;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_ubicacion', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_ubicacion;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_turno_venta', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_turno_venta;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_estado_pedido', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_estado_pedido;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_tipo_material', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_tipo_material;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_modelo', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_modelo;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_rango_etario', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_rango_etario;


----- TABLAS DIMENSIONES -----
CREATE TABLE JOIN_FORCES.BI_DIM_TIEMPO (
    tiempo_id INT PRIMARY KEY IDENTITY(1,1),
    tiempo_anio INT,
    tiempo_mes INT,
    tiempo_cuatrimestre INT
);

CREATE TABLE JOIN_FORCES.BI_DIM_SUCURSAL (
    sucursal_id INT PRIMARY KEY,
    sucursal_email NVARCHAR(255)
);

CREATE TABLE JOIN_FORCES.BI_DIM_UBICACION (
    ubicacion_id INT PRIMARY KEY IDENTITY(1,1),
    ubicacion_provincia NVARCHAR(255),
    ubicacion_localidad NVARCHAR(255)
);

CREATE TABLE JOIN_FORCES.BI_DIM_TURNO_VENTA (
    turno_venta_id INT PRIMARY KEY IDENTITY(1,1),
    turno_ventas_horario_minimo TINYINT,
    turno_ventas_horario_maximo TINYINT,
    turno_descripcion NVARCHAR(50)
);

CREATE TABLE JOIN_FORCES.BI_DIM_ESTADO_PEDIDO (
    estado_pedido_id INT PRIMARY KEY,
    estado_pedido_nombre NVARCHAR(255)
);


CREATE TABLE JOIN_FORCES.BI_DIM_TIPO_MATERIAL (
    tipo_mat_id INT PRIMARY KEY,
    tipo_material NVARCHAR(255)
);

CREATE TABLE JOIN_FORCES.BI_DIM_MODELO (
    modelo_codigo BIGINT PRIMARY KEY,
    modelo_nombre NVARCHAR(255)
);

CREATE TABLE JOIN_FORCES.BI_DIM_RANGO_ETARIO (
    rango_id INT PRIMARY KEY IDENTITY(1,1),
    rango_edad_minima TINYINT,
    rango_edad_maxima TINYINT,
    rango_descripcion NVARCHAR(50)
);
GO

--- TABLAS DE HECHOS ---
CREATE TABLE JOIN_FORCES.BI_HECHO_FACTURACION(
    subtotal DECIMAL(18,2),
    cantidad DECIMAL(18,2),
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_SUCURSAL(sucursal_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_UBICACION(ubicacion_id),
    PRIMARY KEY (tiempo_id, sucursal_id, ubicacion_id)
)

CREATE TABLE JOIN_FORCES.BI_HECHO_VENTAS_MODELO(
    modelo NVARCHAR(255),
    valor_ventas decimal(18,2),
    cantidad_ventas DECIMAL(18,2),
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_SUCURSAL(sucursal_id),
    rango_etario_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_RANGO_ETARIO(rango_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_UBICACION(ubicacion_id),
    PRIMARY KEY (modelo, tiempo_id, sucursal_id, rango_etario_id, ubicacion_id)
)

CREATE TABLE JOIN_FORCES.BI_HECHO_PEDIDOS(
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_SUCURSAL(sucursal_id),
    tipo_mat_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIPO_MATERIAL(tipo_mat_id),
    cantidad DECIMAL(18,2),
    cantidad_entregados DECIMAL(18,2),
    cantidad_pendiente DECIMAL(18,2),
    cantidad_cancelados DECIMAL(18,2),
    tiempo_registro_factura DECIMAL(18,2),
    PRIMARY KEY (tiempo_id, sucursal_id, tipo_mat_id)
)
CREATE TABLE JOIN_FORCES.BI_HECHO_COMPRAS(
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_SUCURSAL(sucursal_id),
    tipo_mat_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIPO_MATERIAL(tipo_mat_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_UBICACION(ubicacion_id),
    subtotal DECIMAL(18,2),
    cantidad DECIMAL(18,2),
    PRIMARY KEY (tiempo_id, sucursal_id, tipo_mat_id, ubicacion_id)
)

CREATE TABLE JOIN_FORCES.BI_HECHO_ENVIOS(
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_TIEMPO(tiempo_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES_BI.BI_DIM_UBICACION(ubicacion_id),
    costo_total DECIMAL(18,2),
    cantidad DECIMAL(18,2),
    cantidad_tiempo DECIMAL(18,2),
    PRIMARY KEY (tiempo_id, ubicacion_id)
)
GO


--- POBLAR TABLAS DE DIMENSIONES -----
CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_tiempo
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_TIEMPO (tiempo_anio, tiempo_mes, tiempo_cuatrimestre)
    SELECT DISTINCT YEAR(f.fecha), MONTH(f.fecha), ((MONTH(f.fecha)-1)/4)+1
    FROM (
        SELECT fecha_nacimiento AS fecha FROM JOIN_FORCES.cliente
        UNION ALL SELECT fecha    AS fecha FROM JOIN_FORCES.compra
        UNION ALL SELECT pedido_fecha AS fecha FROM JOIN_FORCES.pedido
        UNION ALL SELECT fecha    AS fecha FROM JOIN_FORCES.factura
        UNION ALL SELECT fecha    AS fecha FROM JOIN_FORCES.envio
        UNION ALL SELECT fecha_programada AS fecha FROM JOIN_FORCES.envio
    ) f
    WHERE NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.BI_DIM_TIEMPO t
         WHERE t.tiempo_anio = YEAR(f.fecha)
           AND t.tiempo_mes  = MONTH(f.fecha)
           AND t.tiempo_cuatrimestre = ((MONTH(f.fecha)-1)/4)+1
    );
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_sucursal
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_SUCURSAL (sucursal_id, sucursal_email)
    SELECT id, sucursal_email FROM JOIN_FORCES.sucursal s
    WHERE NOT EXISTS (SELECT 1 FROM JOIN_FORCES.BI_DIM_SUCURSAL b WHERE b.sucursal_id = s.id);
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_ubicacion
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_UBICACION (ubicacion_provincia, ubicacion_localidad)
    SELECT p.nombre, l.nombre
    FROM JOIN_FORCES.localidad l
    JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
    WHERE NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.BI_DIM_UBICACION b
         WHERE b.ubicacion_provincia = p.nombre AND b.ubicacion_localidad = l.nombre
    );
END;
GO


CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_turno_venta
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_TURNO_VENTA (turno_ventas_horario_minimo, turno_ventas_horario_maximo, turno_descripcion)
    VALUES (8,13,'08:00 - 14:00'),(14,19,'14:00 - 20:00');
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_estado_pedido
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_ESTADO_PEDIDO (estado_pedido_id, estado_pedido_nombre)
    SELECT id, nombre FROM JOIN_FORCES.estado e
    WHERE NOT EXISTS (SELECT 1 FROM JOIN_FORCES.BI_DIM_ESTADO_PEDIDO b WHERE b.estado_pedido_id = e.id);
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_tipo_material
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_TIPO_MATERIAL (tipo_mat_id, tipo_material)
    SELECT id, nombre FROM JOIN_FORCES.tipo_material tm
    WHERE NOT EXISTS (SELECT 1 FROM JOIN_FORCES.BI_DIM_TIPO_MATERIAL b WHERE b.tipo_mat_id = tm.id);
END;
GO


CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_modelo
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_MODELO (modelo_codigo, modelo_nombre)
    SELECT modelo_codigo, nombre FROM JOIN_FORCES.modelo m
    WHERE NOT EXISTS (SELECT 1 FROM JOIN_FORCES.BI_DIM_MODELO b WHERE b.modelo_codigo = m.modelo_codigo);
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_rango_etario
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_RANGO_ETARIO (rango_edad_minima, rango_edad_maxima, rango_descripcion)
    VALUES (0,24,'< 25'),(25,34,'25 - 35'),(35,49,'35 - 50'),(50,200,'> 50');
END;
GO




