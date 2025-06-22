USE GD1C2025
GO

--- DROP DE TABLAS DE HECHOS ---
IF OBJECT_ID('JOIN_FORCES.BI_HECHOS_VENTAS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHOS_VENTAS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHOS_COMPRAS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHOS_COMPRAS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHOS_PEDIDOS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHOS_PEDIDOS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHOS_ENVIOS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHOS_ENVIOS;


--- DROP DE TABLAS ---
IF OBJECT_ID('JOIN_FORCES.BI_DIM_TIEMPO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_TIEMPO;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_SUCURSAL', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_SUCURSAL;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_UBICACION', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_UBICACION;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_TURNO_VENTA', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_TURNO_VENTA;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_ESTADO_PEDIDO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_ESTADO_PEDIDO;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_TIPO_MATERIAL', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_TIPO_MATERIAL;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_MODELO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_MODELO;
IF OBJECT_ID('JOIN_FORCES.BI_DIM_RANGO_ETARIO', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_DIM_RANGO_ETARIO;


--- DROP DE PROCEDURES ---
IF OBJECT_ID('JOIN_FORCES.migrar_dim_tiempo', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_tiempo;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_sucursal', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_sucursal;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_ubicacion', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_ubicacion;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_turno_venta', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_turno_venta;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_estado_pedido', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_estado_pedido;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_tipo_material', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_tipo_material;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_modelo', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_modelo;
IF OBJECT_ID('JOIN_FORCES.migrar_dim_rango_etario', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_dim_rango_etario;

--- DROP DE PROCEDURES DE HECHOS ---
IF OBJECT_ID('JOIN_FORCES.migrar_hechos_ventas', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hechos_ventas;
IF OBJECT_ID('JOIN_FORCES.migrar_hechos_compras', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hechos_compras;
IF OBJECT_ID('JOIN_FORCES.migrar_hechos_pedidos', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hechos_pedidos;
IF OBJECT_ID('JOIN_FORCES.migrar_hechos_envios', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hechos_envios;
GO


IF OBJECT_ID('JOIN_FORCES.migrar_bi', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_bi;

IF OBJECT_ID('JOIN_FORCES.V_Ganancias_Mensuales', 'V') IS NOT NULL DROP VIEW JOIN_FORCES.V_Ganancias_Mensuales;


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

----- TABLAS DE HECHOS -----
CREATE TABLE JOIN_FORCES.BI_HECHOS_VENTAS (
    detalle_factura_id INT,
    factura_numero BIGINT,
    modelo_codigo BIGINT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_MODELO(modelo_codigo),
    rango_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_RANGO_ETARIO(rango_id),
    tiempo_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    ubicacion_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_UBICACION(ubicacion_id),
    sucursal_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    detalle_subtotal DECIMAL(18,2) NOT NULL,
    detalle_cantidad INT NOT NULL,
    detalle_tiempo_fabricacion DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (detalle_factura_id, factura_numero)
);

CREATE TABLE JOIN_FORCES.BI_HECHOS_COMPRAS (
    compra_detalle_id INT,
    compra_numero DECIMAL(18,0),
    tiempo_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    tipo_mat_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_TIPO_MATERIAL(tipo_mat_id),
    detalle_subtotal DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (compra_detalle_id, compra_numero)
);

CREATE TABLE JOIN_FORCES.BI_HECHOS_PEDIDOS (
    pedido_numero DECIMAL(18,0) PRIMARY KEY,
    tiempo_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    estado_pedido_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_ESTADO_PEDIDO(estado_pedido_id),
    turno_venta_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_TURNO_VENTA(turno_venta_id)
);

CREATE TABLE JOIN_FORCES.BI_HECHOS_ENVIOS (
    envio_numero DECIMAL(18,0) PRIMARY KEY,
    tiempo_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    ubicacion_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_UBICACION(ubicacion_id),
    sucursal_id INT NOT NULL REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    envio_fecha_programada DATETIME NOT NULL,
    envio_fecha DATETIME,
    envio_total DECIMAL(18,2) NOT NULL
);
GO

--- POBLAR TABLAS DE DIMENSIONES -----
CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_tiempo
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_TIEMPO (tiempo_anio,tiempo_mes,tiempo_cuatrimestre )
    (
        SELECT DISTINCT 
        YEAR(f.fecha) AS tiempo_anio, 
        MONTH(f.fecha) AS tiempo_mes, 
        DATEPART(QUARTER, f.fecha) AS tiempo_cuatrimestre
        FROM JOIN_FORCES.factura AS f
        UNION
        SELECT DISTINCT 
        YEAR(c.fecha) AS tiempo_anio, 
        MONTH(c.fecha) AS tiempo_mes, 
        DATEPART(QUARTER, c.fecha) AS tiempo_cuatrimestre
        FROM JOIN_FORCES.compra AS c
        UNION
        SELECT DISTINCT 
        YEAR(p.pedido_fecha) AS tiempo_anio, 
        MONTH(p.pedido_fecha) AS tiempo_mes, 
        DATEPART(QUARTER, p.pedido_fecha) AS tiempo_cuatrimestre
        FROM JOIN_FORCES.pedido AS p
        UNION
        SELECT DISTINCT 
        YEAR(e.fecha) AS tiempo_anio, 
        MONTH(e.fecha) AS tiempo_mes, 
        DATEPART(QUARTER, e.fecha) AS tiempo_cuatrimestre
        FROM JOIN_FORCES.envio AS e
        UNION
        SELECT DISTINCT
        YEAR(e.fecha_programada) AS tiempo_anio, 
        MONTH(e.fecha_programada) AS tiempo_mes, 
        DATEPART(QUARTER, e.fecha_programada) AS tiempo_cuatrimestre
        FROM JOIN_FORCES.envio AS e
        UNION
        SELECT DISTINCT
        YEAR(c.fecha_nacimiento) AS tiempo_anio, 
        MONTH(c.fecha_nacimiento) AS tiempo_mes, 
        DATEPART(QUARTER, c.fecha_nacimiento) AS tiempo_cuatrimestre
        FROM JOIN_FORCES.cliente AS c
    )
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_sucursal
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_SUCURSAL (sucursal_id, sucursal_email)
    SELECT id, sucursal_email FROM JOIN_FORCES.sucursal s
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_dim_ubicacion
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_DIM_UBICACION (ubicacion_provincia, ubicacion_localidad)
    (
        SELECT DISTINCT 
        p.nombre,
        l.nombre
        FROM JOIN_FORCES.cliente c
            JOIN JOIN_FORCES.direccion d ON c.direccion_id = d.id
            JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
            JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
        UNION
        SELECT DISTINCT 
        p.nombre,
        l.nombre
        FROM JOIN_FORCES.sucursal s
            JOIN JOIN_FORCES.direccion d ON s.direccion_id = d.id
            JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
            JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
    )
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

--- POBLAR TABLAS DE HECHOS -----
CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hechos_ventas
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHOS_VENTAS(
        detalle_factura_id, 
        factura_numero, 
        modelo_codigo, 
        rango_id, 
        tiempo_id, 
        ubicacion_id, 
        sucursal_id, 
        detalle_subtotal, 
        detalle_cantidad, 
        detalle_tiempo_fabricacion
    )
    SELECT 
        df.id,
        df.factura_numero,
        m.modelo_codigo,
        r.rango_id,
        t.tiempo_id,
        u.ubicacion_id,
        s.sucursal_id,
        ISNULL(df.subtotal, 0),
        ISNULL(df.cantidad, 0),
        DATEDIFF(DAY, p.pedido_fecha, f.fecha) AS detalle_tiempo_fabricacion
    FROM JOIN_FORCES.detalle_factura df
        JOIN JOIN_FORCES.factura f ON df.factura_numero = f.numero
        JOIN JOIN_FORCES.detalle_pedido dp ON df.detalle_pedido_id = dp.id
        JOIN JOIN_FORCES.sillon sillon ON dp.sillon_codigo = sillon.codigo
        JOIN JOIN_FORCES.modelo m ON sillon.modelo_codigo = m.modelo_codigo
        JOIN JOIN_FORCES.pedido p ON dp.pedido_numero = p.numero
        JOIN JOIN_FORCES.cliente c ON f.cliente_dni = c.dni
        JOIN JOIN_FORCES.direccion d ON c.direccion_id = d.id
        JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
        JOIN JOIN_FORCES.provincia prov ON l.provincia_id = prov.id
        
        -- Para obtener el rango etario
        JOIN JOIN_FORCES.BI_DIM_RANGO_ETARIO r ON 
            DATEDIFF(YEAR, c.fecha_nacimiento, f.fecha) BETWEEN r.rango_edad_minima AND r.rango_edad_maxima
        
        -- Para obtener el tiempo
        JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON 
            YEAR(f.fecha) = t.tiempo_anio AND 
            MONTH(f.fecha) = t.tiempo_mes AND 
            DATEPART(QUARTER, f.fecha) = t.tiempo_cuatrimestre
        
        -- Para obtener la ubicacion
        JOIN JOIN_FORCES.BI_DIM_UBICACION u ON 
            u.ubicacion_provincia = prov.nombre AND 
            u.ubicacion_localidad = l.nombre
        
        -- Para obtener la sucursal
        JOIN JOIN_FORCES.BI_DIM_SUCURSAL s ON f.sucursal_id = s.sucursal_id
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hechos_compras
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHOS_COMPRAS(
        compra_detalle_id, 
        compra_numero, 
        tiempo_id, 
        sucursal_id, 
        tipo_mat_id, 
        detalle_subtotal
    )
    SELECT 
        cd.id,
        cd.compra_numero,
        t.tiempo_id,
        s.sucursal_id,
        tm.tipo_mat_id,
        cd.subtotal
    FROM JOIN_FORCES.compra_detalle cd
        JOIN JOIN_FORCES.compra c ON cd.compra_numero = c.numero
        JOIN JOIN_FORCES.material m ON cd.material_id = m.id
        JOIN JOIN_FORCES.tipo_material tm_mat ON m.tipo_material_id = tm_mat.id
        
        -- Para obtener el tiempo
        JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON 
            YEAR(c.fecha) = t.tiempo_anio AND 
            MONTH(c.fecha) = t.tiempo_mes AND 
            DATEPART(QUARTER, c.fecha) = t.tiempo_cuatrimestre
        
        -- Para obtener la sucursal
        JOIN JOIN_FORCES.BI_DIM_SUCURSAL s ON c.sucursal_id = s.sucursal_id
        
        -- Para obtener el tipo de material
        JOIN JOIN_FORCES.BI_DIM_TIPO_MATERIAL tm ON tm_mat.id = tm.tipo_mat_id
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hechos_pedidos
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHOS_PEDIDOS(
        pedido_numero, 
        tiempo_id, 
        sucursal_id, 
        estado_pedido_id, 
        turno_venta_id
    )
    SELECT 
        p.numero,
        t.tiempo_id,
        s.sucursal_id,
        e.estado_pedido_id,
        tv.turno_venta_id
    FROM JOIN_FORCES.pedido p
        JOIN JOIN_FORCES.estado est ON p.estado_id = est.id
        
        -- Para obtener el tiempo
        JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON 
            YEAR(p.pedido_fecha) = t.tiempo_anio AND 
            MONTH(p.pedido_fecha) = t.tiempo_mes AND 
            DATEPART(QUARTER, p.pedido_fecha) = t.tiempo_cuatrimestre
        
        -- Para obtener la sucursal
        JOIN JOIN_FORCES.BI_DIM_SUCURSAL s ON p.sucursal_id = s.sucursal_id
        
        -- Para obtener el estado del pedido
        JOIN JOIN_FORCES.BI_DIM_ESTADO_PEDIDO e ON est.id = e.estado_pedido_id
        
        -- Para obtener el turno de venta
        JOIN JOIN_FORCES.BI_DIM_TURNO_VENTA tv ON 
            DATEPART(HOUR, p.pedido_fecha) BETWEEN tv.turno_ventas_horario_minimo AND tv.turno_ventas_horario_maximo
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hechos_envios
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHOS_ENVIOS(
        envio_numero, 
        tiempo_id, 
        ubicacion_id, 
        sucursal_id, 
        envio_fecha_programada, 
        envio_fecha, 
        envio_total
    )
    SELECT 
        e.numero,
        t.tiempo_id,
        u.ubicacion_id,
        s.sucursal_id,
        e.fecha_programada,
        e.fecha,
        e.total
    FROM JOIN_FORCES.envio e
        JOIN JOIN_FORCES.factura f ON e.factura_id = f.numero
        JOIN JOIN_FORCES.cliente c ON f.cliente_dni = c.dni
        JOIN JOIN_FORCES.direccion d ON c.direccion_id = d.id
        JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
        JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
        
        -- Para obtener el tiempo
        JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON 
            YEAR(e.fecha_programada) = t.tiempo_anio AND 
            MONTH(e.fecha_programada) = t.tiempo_mes AND 
            DATEPART(QUARTER, e.fecha_programada) = t.tiempo_cuatrimestre
        
        -- Para obtener la ubicacion
        JOIN JOIN_FORCES.BI_DIM_UBICACION u ON 
            u.ubicacion_provincia = p.nombre AND 
            u.ubicacion_localidad = l.nombre
        
        -- Para obtener la sucursal
        JOIN JOIN_FORCES.BI_DIM_SUCURSAL s ON f.sucursal_id = s.sucursal_id
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_bi
AS
BEGIN
    EXEC JOIN_FORCES.migrar_dim_tiempo;
    EXEC JOIN_FORCES.migrar_dim_sucursal;
    EXEC JOIN_FORCES.migrar_dim_ubicacion;
    EXEC JOIN_FORCES.migrar_dim_turno_venta;
    EXEC JOIN_FORCES.migrar_dim_estado_pedido;
    EXEC JOIN_FORCES.migrar_dim_tipo_material;
    EXEC JOIN_FORCES.migrar_dim_modelo;
    EXEC JOIN_FORCES.migrar_dim_rango_etario;
    
    -- Migrar tablas de hechos
    EXEC JOIN_FORCES.migrar_hechos_ventas;
    EXEC JOIN_FORCES.migrar_hechos_compras;
    EXEC JOIN_FORCES.migrar_hechos_pedidos;
    EXEC JOIN_FORCES.migrar_hechos_envios;
END;
GO

EXEC JOIN_FORCES.migrar_bi;
GO

--- VISTAS ---
-- 1. Ganancias: Total de ingresos (facturación) - total de egresos (compras), por
--     cada mes, por cada sucursal.
--     [VENTAS, COMPRAS]

CREATE VIEW JOIN_FORCES.V_Ganancias_Mensuales AS
SELECT 
    t.tiempo_anio,
    t.tiempo_mes,
    s.sucursal_id,
    ISNULL(SUM(v.detalle_subtotal),0) - 
        (
            SELECT ISNULL(SUM(c.detalle_subtotal),0) AS Egresos
            FROM JOIN_FORCES.BI_HECHOS_COMPRAS c
            JOIN JOIN_FORCES.BI_DIM_TIEMPO tc ON c.tiempo_id = tc.tiempo_id
            WHERE tc.tiempo_anio = t.tiempo_anio 
              AND tc.tiempo_mes = t.tiempo_mes 
              AND c.sucursal_id = s.sucursal_id
        ) AS Ganancias
FROM JOIN_FORCES.BI_HECHOS_VENTAS v
    LEFT JOIN
        JOIN_FORCES.BI_DIM_TIEMPO t ON v.tiempo_id = t.tiempo_id
    LEFT JOIN
        JOIN_FORCES.BI_DIM_SUCURSAL s ON v.sucursal_id = s.sucursal_id
GROUP BY
    t.tiempo_anio,
    t.tiempo_mes,
    s.sucursal_id
GO


