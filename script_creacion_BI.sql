USE GD1C2025
GO
--- DROP DE TABLAS ---

IF OBJECT_ID('JOIN_FORCES.BI_HECHO_FACTURACION', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_FACTURACION;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_VENTAS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_VENTAS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_PEDIDOS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_PEDIDOS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_COMPRAS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_COMPRAS;
IF OBJECT_ID('JOIN_FORCES.BI_HECHO_ENVIOS', 'U') IS NOT NULL DROP TABLE JOIN_FORCES.BI_HECHO_ENVIOS;


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
IF OBJECT_ID('JOIN_FORCES.migrar_hecho_facturacion', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hecho_facturacion;
IF OBJECT_ID('JOIN_FORCES.migrar_hecho_pedidos', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hecho_pedidos;
IF OBJECT_ID('JOIN_FORCES.migrar_hecho_ventas', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hecho_ventas;
IF OBJECT_ID('JOIN_FORCES.migrar_hecho_compras', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hecho_compras;
IF OBJECT_ID('JOIN_FORCES.migrar_hecho_envios', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_hecho_envios;
IF OBJECT_ID('JOIN_FORCES.migrar_bi', 'P') IS NOT NULL DROP PROCEDURE JOIN_FORCES.migrar_bi;


--- DROP DE VISTAS ---
IF OBJECT_ID('JOIN_FORCES.V_GANANCIAS_MES_SUCURSAL', 'V') IS NOT NULL DROP VIEW JOIN_FORCES.V_GANANCIAS_MES_SUCURSAL;

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
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_UBICACION(ubicacion_id),
    PRIMARY KEY (tiempo_id, sucursal_id, ubicacion_id)
)

CREATE TABLE JOIN_FORCES.BI_HECHO_VENTAS(
    modelo NVARCHAR(255),
    valor_ventas decimal(18,2),
    cantidad_ventas DECIMAL(18,2),
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    rango_etario_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_RANGO_ETARIO(rango_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_UBICACION(ubicacion_id),
    PRIMARY KEY (modelo, tiempo_id, sucursal_id, rango_etario_id, ubicacion_id)
)

CREATE TABLE JOIN_FORCES.BI_HECHO_PEDIDOS(
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    turno_venta_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TURNO_VENTA(turno_venta_id),
    cantidad DECIMAL(18,2),
    cantidad_entregados DECIMAL(18,2),
    cantidad_pendiente DECIMAL(18,2),
    cantidad_cancelados DECIMAL(18,2),
    tiempo_registro_factura DECIMAL(18,2),
    PRIMARY KEY (tiempo_id, sucursal_id, turno_venta_id)
)
CREATE TABLE JOIN_FORCES.BI_HECHO_COMPRAS(
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    sucursal_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_SUCURSAL(sucursal_id),
    tipo_mat_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TIPO_MATERIAL(tipo_mat_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_UBICACION(ubicacion_id),
    subtotal DECIMAL(18,2),
    cantidad DECIMAL(18,2),
    PRIMARY KEY (tiempo_id, sucursal_id, tipo_mat_id, ubicacion_id)
)

CREATE TABLE JOIN_FORCES.BI_HECHO_ENVIOS(
    tiempo_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_TIEMPO(tiempo_id),
    ubicacion_id INT FOREIGN KEY REFERENCES JOIN_FORCES.BI_DIM_UBICACION(ubicacion_id),
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

----- POBLAR TABLAS DE HECHOS (Ya estan agregados/precalculados muchos datos) -----
CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hecho_facturacion
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHO_FACTURACION (subtotal, cantidad, tiempo_id, sucursal_id, ubicacion_id)
    SELECT DISTINCT SUM(ISNULL(f.total, 0)), COUNT(*), t.tiempo_id, s.id, ubi.ubicacion_id
    FROM JOIN_FORCES.factura f
    INNER JOIN JOIN_FORCES.sucursal s ON f.sucursal_id = s.id
    INNER JOIN JOIN_FORCES.direccion d ON s.direccion_id = d.id
    INNER JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
    INNER JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
    INNER JOIN JOIN_FORCES.BI_DIM_UBICACION ubi ON ubi.ubicacion_provincia = p.nombre AND ubi.ubicacion_localidad = l.nombre
    INNER JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON YEAR(f.fecha) = t.tiempo_anio AND MONTH(f.fecha) = t.tiempo_mes
    GROUP BY t.tiempo_id, s.id, ubi.ubicacion_id
END;
GO


CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hecho_ventas
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHO_VENTAS (
        modelo, valor_ventas, cantidad_ventas, tiempo_id, sucursal_id, rango_etario_id, ubicacion_id
    )
    SELECT DISTINCT m.nombre, SUM(ISNULL(detalle_pedido.subtotal, 0)), COUNT(*), t.tiempo_id, s.id, re.rango_id, ubi.ubicacion_id
    FROM JOIN_FORCES.pedido pedido
    INNER JOIN JOIN_FORCES.detalle_pedido AS detalle_pedido ON pedido.numero = detalle_pedido.pedido_numero
    INNER JOIN JOIN_FORCES.sillon sillon ON sillon.codigo = detalle_pedido.sillon_codigo
    INNER JOIN JOIN_FORCES.modelo m ON m.modelo_codigo = sillon.modelo_codigo
    INNER JOIN JOIN_FORCES.sucursal s ON s.id = pedido.sucursal_id
    INNER JOIN JOIN_FORCES.direccion d ON s.direccion_id = d.id
    INNER JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
    INNER JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
    INNER JOIN JOIN_FORCES.cliente c ON c.dni = pedido.cliente_dni
    INNER JOIN JOIN_FORCES.BI_DIM_UBICACION ubi ON ubi.ubicacion_provincia = p.nombre AND ubi.ubicacion_localidad = l.nombre
    INNER JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON YEAR(pedido.pedido_fecha) = t.tiempo_anio AND MONTH(pedido.pedido_fecha) = t.tiempo_mes
    INNER JOIN JOIN_FORCES.BI_DIM_RANGO_ETARIO re ON DATEDIFF(YEAR, c.fecha_nacimiento, GETDATE()) BETWEEN re.rango_edad_minima AND re.rango_edad_maxima
    GROUP BY m.nombre, t.tiempo_id, s.id, re.rango_id, ubi.ubicacion_id
END;
GO


CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hecho_pedidos
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHO_PEDIDOS 
    (tiempo_id, sucursal_id, turno_venta_id, cantidad, cantidad_entregados,  cantidad_cancelados, tiempo_registro_factura)
    SELECT DISTINCT 
        t.tiempo_id,
        s.sucursal_id,
        tv.turno_venta_id,
        COUNT(*),
        SUM(ISNULL(CASE WHEN estado.nombre = 'ENTREGADO' THEN 1 ELSE 0 END, 0)),
        SUM(ISNULL(CASE WHEN estado.nombre = 'CANCELADO' THEN 1 ELSE 0 END, 0)),
        SUM(
            CASE
                WHEN factura.fecha IS NOT NULL
                THEN DATEDIFF(DAY, pedido.pedido_fecha, factura.fecha)
                ELSE 0
            END
        )
    FROM JOIN_FORCES.pedido AS pedido
    JOIN JOIN_FORCES.estado AS estado  ON estado.id = pedido.estado_id
    LEFT JOIN JOIN_FORCES.detalle_pedido AS detalle_pedido ON pedido.numero = detalle_pedido.pedido_numero
    LEFT JOIN JOIN_FORCES.detalle_factura AS detalle_factura ON detalle_pedido.id = detalle_factura.detalle_pedido_id
    LEFT JOIN JOIN_FORCES.factura AS factura ON detalle_factura.factura_numero = factura.numero
    INNER JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON YEAR(pedido.pedido_fecha) = t.tiempo_anio AND MONTH(pedido.pedido_fecha) = t.tiempo_mes
    INNER JOIN JOIN_FORCES.BI_DIM_SUCURSAL s ON pedido.sucursal_id = s.sucursal_id
    INNER JOIN JOIN_FORCES.BI_DIM_TURNO_VENTA tv ON tv.turno_ventas_horario_minimo = DATEPART(HOUR, pedido.pedido_fecha)
    GROUP BY t.tiempo_id, s.sucursal_id, tv.turno_venta_id
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hecho_compras
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHO_COMPRAS (tiempo_id, sucursal_id, tipo_mat_id, ubicacion_id, subtotal, cantidad)
    SELECT DISTINCT t.tiempo_id, c.sucursal_id, tm.tipo_mat_id, ubi.ubicacion_id, SUM(ISNULL(c.total, 0)), COUNT(*)
    FROM JOIN_FORCES.compra c
    INNER JOIN JOIN_FORCES.compra_detalle cd ON cd.compra_numero = c.numero
    INNER JOIN JOIN_FORCES.material m ON m.id = cd.material_id
    INNER JOIN JOIN_FORCES.sucursal s ON s.id = c.sucursal_id
    INNER JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON YEAR(c.fecha) = t.tiempo_anio AND MONTH(c.fecha) = t.tiempo_mes
    INNER JOIN JOIN_FORCES.BI_DIM_TIPO_MATERIAL tm ON tm.tipo_mat_id = m.tipo_material_id
    INNER JOIN JOIN_FORCES.direccion d ON s.direccion_id = d.id
    INNER JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
    INNER JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
    INNER JOIN JOIN_FORCES.BI_DIM_UBICACION ubi ON ubi.ubicacion_provincia = p.nombre AND ubi.ubicacion_localidad = l.nombre
    GROUP BY t.tiempo_id, c.sucursal_id, tm.tipo_mat_id, ubi.ubicacion_id
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_hecho_envios
AS
BEGIN
    INSERT INTO JOIN_FORCES.BI_HECHO_ENVIOS (tiempo_id, ubicacion_id, costo_total, cantidad, cantidad_tiempo)
    SELECT DISTINCT t.tiempo_id, ubi.ubicacion_id,
    SUM(ISNULL(e.total, 0)),
    COUNT(*),
    SUM(
        CASE WHEN e.fecha < = e.fecha_programada
        THEN 1
        ELSE 0
        END
    ) 
    FROM JOIN_FORCES.envio e
    INNER JOIN JOIN_FORCES.factura f ON f.numero = e.factura_id
    INNER JOIN JOIN_FORCES.cliente c ON c.dni = f.cliente_dni
    INNER JOIN JOIN_FORCES.BI_DIM_TIEMPO t ON YEAR(e.fecha) = t.tiempo_anio AND MONTH(e.fecha) = t.tiempo_mes
    INNER JOIN JOIN_FORCES.SUCURSAL s ON s.id = f.sucursal_id
    INNER JOIN JOIN_FORCES.direccion d ON s.direccion_id = d.id
    INNER JOIN JOIN_FORCES.localidad l ON d.localidad_id = l.id
    INNER JOIN JOIN_FORCES.provincia p ON l.provincia_id = p.id
    INNER JOIN JOIN_FORCES.BI_DIM_UBICACION ubi ON ubi.ubicacion_provincia = p.nombre AND ubi.ubicacion_localidad = l.nombre
    GROUP BY t.tiempo_id, ubi.ubicacion_id
END;
GO

CREATE OR ALTER PROCEDURE JOIN_FORCES.migrar_bi
AS
BEGIN
    EXEC JOIN_FORCES.migrar_dim_tiempo
    EXEC JOIN_FORCES.migrar_dim_sucursal
    EXEC JOIN_FORCES.migrar_dim_ubicacion
    EXEC JOIN_FORCES.migrar_dim_turno_venta
    EXEC JOIN_FORCES.migrar_dim_estado_pedido
    EXEC JOIN_FORCES.migrar_dim_tipo_material
    EXEC JOIN_FORCES.migrar_dim_modelo
    EXEC JOIN_FORCES.migrar_dim_rango_etario
    EXEC JOIN_FORCES.migrar_hecho_facturacion
    EXEC JOIN_FORCES.migrar_hecho_pedidos
    EXEC JOIN_FORCES.migrar_hecho_ventas
    EXEC JOIN_FORCES.migrar_hecho_compras
    EXEC JOIN_FORCES.migrar_hecho_envios
END;
GO

--- VISTAS -----

-- 1. Ganancias: Total de ingresos (facturacion) - total de egresos (compras), por cada mes, por cada sucursal.
CREATE OR ALTER VIEW JOIN_FORCES.V_GANANCIAS_MES_SUCURSAL
AS
SELECT
    t.tiempo_mes,
    c.sucursal_id,
    SUM(ISNULL(f.subtotal, 0)) - SUM(ISNULL(c.subtotal, 0)) AS ganancia_total
FROM JOIN_FORCES.BI_HECHO_FACTURACION AS f
JOIN JOIN_FORCES.BI_HECHO_COMPRAS AS c ON f.sucursal_id = c.sucursal_id AND f.tiempo_id = c.tiempo_id
JOIN JOIN_FORCES.BI_DIM_TIEMPO AS t ON f.tiempo_id = t.tiempo_id 
GROUP BY  t.tiempo_mes, c.sucursal_id -- POR CADA MES, POR CADA SUCURSAL
GO


EXEC JOIN_FORCES.migrar_bi
GO
