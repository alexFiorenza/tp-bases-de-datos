USE GD1C2025
GO

----- ELIMINACION DE TABLAS -----
IF OBJECT_ID('JOIN_FORCES.provincia', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.provincia
IF OBJECT_ID('JOIN_FORCES.localidad', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.localidad
IF OBJECT_ID('JOIN_FORCES.direccion', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.direccion
IF OBJECT_ID('JOIN_FORCES.estado', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.estado
IF OBJECT_ID('JOIN_FORCES.material', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.material
IF OBJECT_ID('JOIN_FORCES.tela', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.tela
IF OBJECT_ID('JOIN_FORCES.madera', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.madera
IF OBJECT_ID('JOIN_FORCES.relleno', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.relleno
IF OBJECT_ID('JOIN_FORCES.medida', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.medida
IF OBJECT_ID('JOIN_FORCES.modelo', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.modelo
IF OBJECT_ID('JOIN_FORCES.modelo_medida', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.modelo_medida
IF OBJECT_ID('JOIN_FORCES.sillon', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.sillon
IF OBJECT_ID('JOIN_FORCES.sillon_material', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.sillon_material
IF OBJECT_ID('JOIN_FORCES.proveedor', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.proveedor
IF OBJECT_ID('JOIN_FORCES.compra', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.compra
IF OBJECT_ID('JOIN_FORCES.compra_detalle', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.compra_detalle
IF OBJECT_ID('JOIN_FORCES.sucursal', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.sucursal
IF OBJECT_ID('JOIN_FORCES.cliente', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.cliente
IF OBJECT_ID('JOIN_FORCES.pedido', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.pedido
IF OBJECT_ID('JOIN_FORCES.detalle_pedido', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.detalle_pedido
IF OBJECT_ID('JOIN_FORCES.cancelacion_pedido', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.cancelacion_pedido
IF OBJECT_ID('JOIN_FORCES.factura', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.factura
IF OBJECT_ID('JOIN_FORCES.detalle_factura', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.detalle_factura
IF OBJECT_ID('JOIN_FORCES.envio', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.envio

----- ELIMINACION DE ESQUEMA -----
IF SCHEMA_ID('JOIN_FORCES') IS NOT NULL
    DROP SCHEMA JOIN_FORCES
GO

----- ESQUEMA JOIN_FORCES -----
CREATE SCHEMA JOIN_FORCES
GO

----- TABLAS -----
CREATE TABLE JOIN_FORCES.provincia(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
)

CREATE TABLE JOIN_FORCES.localidad(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    provincia_id INT NOT NULL,
    FOREIGN KEY (provincia_id) REFERENCES JOIN_FORCES.provincia(id)
)

CREATE TABLE JOIN_FORCES.direccion(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    localidad_id INT NOT NULL,
    FOREIGN KEY (localidad_id) REFERENCES JOIN_FORCES.localidad(id)
)

CREATE TABLE JOIN_FORCES.estado(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
)

CREATE TABLE JOIN_FORCES.material(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    tipo NVARCHAR(255) NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    descripcion NVARCHAR(255) NOT NULL,
    precio_unitario DECIMAL(18,2) NOT NULL
)

CREATE TABLE JOIN_FORCES.tela(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    material_id INT NOT NULL,
    color NVARCHAR(50) NOT NULL,
    textura NVARCHAR(50) NOT NULL,
    FOREIGN KEY (material_id) REFERENCES JOIN_FORCES.material(id)
)

CREATE TABLE JOIN_FORCES.madera(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    material_id INT NOT NULL,
    color NVARCHAR(50) NOT NULL,
    dureza NVARCHAR(50) NOT NULL,
    FOREIGN KEY (material_id) REFERENCES JOIN_FORCES.material(id)
)

CREATE TABLE JOIN_FORCES.relleno(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    material_id INT NOT NULL,
    densidad DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (material_id) REFERENCES JOIN_FORCES.material(id)
)

CREATE TABLE JOIN_FORCES.medida(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    altura DECIMAL(8,2) NOT NULL,
    ancho DECIMAL(8,2) NOT NULL,
    profundidad DECIMAL(8,2) NOT NULL,
    precio DECIMAL(8,2) NOT NULL
)

CREATE TABLE JOIN_FORCES.modelo(
    modelo_codigo BIGINT PRIMARY KEY NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    descripcion NVARCHAR(255) NOT NULL,
    precio DECIMAL(18,2) NOT NULL
)

CREATE TABLE JOIN_FORCES.modelo_medida(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    modelo_codigo BIGINT NOT NULL,
    medida_id INT NOT NULL,
    FOREIGN KEY (modelo_codigo) REFERENCES JOIN_FORCES.modelo(modelo_codigo),
    FOREIGN KEY (medida_id) REFERENCES JOIN_FORCES.medida(id)
)

CREATE TABLE JOIN_FORCES.sillon(
    codigo BIGINT PRIMARY KEY NOT NULL,
    modelo_codigo BIGINT NOT NULL,
    FOREIGN KEY (modelo_codigo) REFERENCES JOIN_FORCES.modelo(modelo_codigo)
)

CREATE TABLE JOIN_FORCES.sillon_material(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    sillon_codigo BIGINT NOT NULL,
    material_id INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (sillon_codigo) REFERENCES JOIN_FORCES.sillon(codigo),
    FOREIGN KEY (material_id) REFERENCES JOIN_FORCES.material(id)
)

CREATE TABLE JOIN_FORCES.proveedor(
    cuit NVARCHAR(255) PRIMARY KEY NOT NULL,
    razon_social NVARCHAR(255) NOT NULL,
    direccion NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL
)

CREATE TABLE JOIN_FORCES.sucursal(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    sucursal_direccion NVARCHAR(255) NOT NULL,
    sucursal_telefono NVARCHAR(255) NOT NULL,
    sucursal_email NVARCHAR(255) NOT NULL
)

CREATE TABLE JOIN_FORCES.compra(
    numero DECIMAL(18,0) PRIMARY KEY NOT NULL,
    proveedor_cuit NVARCHAR(255) NOT NULL,
    sucursal_id INT NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (proveedor_cuit) REFERENCES JOIN_FORCES.proveedor(cuit),
    FOREIGN KEY (sucursal_id) REFERENCES JOIN_FORCES.sucursal(id)
)

CREATE TABLE JOIN_FORCES.compra_detalle(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    compra_numero DECIMAL(18,0) NOT NULL,
    material_id INT NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    precio_unitario DECIMAL(18,2) NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (compra_numero) REFERENCES JOIN_FORCES.compra(numero),
    FOREIGN KEY (material_id) REFERENCES JOIN_FORCES.material(id)
)

CREATE TABLE JOIN_FORCES.cliente(
    dni BIGINT PRIMARY KEY NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(255) NOT NULL,
    fecha_nacimiento DATETIME NOT NULL
)

CREATE TABLE JOIN_FORCES.pedido(
    numero DECIMAL(18,0) PRIMARY KEY NOT NULL,
    sucursal_id INT NOT NULL,
    cliente_dni BIGINT NOT NULL,
    estado_id INT NOT NULL,
    pedido_fecha DATETIME NOT NULL,
    FOREIGN KEY (sucursal_id) REFERENCES JOIN_FORCES.sucursal(id),
    FOREIGN KEY (cliente_dni) REFERENCES JOIN_FORCES.cliente(dni),
    FOREIGN KEY (estado_id) REFERENCES JOIN_FORCES.estado(id)
)

CREATE TABLE JOIN_FORCES.detalle_pedido(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    sillon_codigo BIGINT NOT NULL,
    pedido_numero DECIMAL(18,0) NOT NULL,
    cantidad BIGINT NOT NULL,
    precio_unitario DECIMAL(18,2) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (sillon_codigo) REFERENCES JOIN_FORCES.sillon(codigo),
    FOREIGN KEY (pedido_numero) REFERENCES JOIN_FORCES.pedido(numero)
)

CREATE TABLE JOIN_FORCES.cancelacion_pedido(
    codigo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    pedido_numero DECIMAL(18,0) NOT NULL,
    fecha DATETIME NOT NULL,
    motivo NVARCHAR(255) NOT NULL,
    FOREIGN KEY (pedido_numero) REFERENCES JOIN_FORCES.pedido(numero)
)

CREATE TABLE JOIN_FORCES.factura(
    numero BIGINT PRIMARY KEY NOT NULL,
    sucursal_id INT NOT NULL,
    pedido_numero DECIMAL(18,0) NOT NULL,
    cliente_dni BIGINT NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (sucursal_id) REFERENCES JOIN_FORCES.sucursal(id),
    FOREIGN KEY (pedido_numero) REFERENCES JOIN_FORCES.pedido(numero),
    FOREIGN KEY (cliente_dni) REFERENCES JOIN_FORCES.cliente(dni)
)

CREATE TABLE JOIN_FORCES.detalle_factura(
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    factura_numero BIGINT NOT NULL,
    detalle_pedido_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(18,2) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (factura_numero) REFERENCES JOIN_FORCES.factura(numero),
    FOREIGN KEY (detalle_pedido_id) REFERENCES JOIN_FORCES.detalle_pedido(id)
)

CREATE TABLE JOIN_FORCES.envio(
    numero DECIMAL(18,0) PRIMARY KEY NOT NULL,
    factura_id BIGINT NOT NULL,
    importe_traslado DECIMAL(18,2) NOT NULL,
    importe_subida DECIMAL(18,2) NOT NULL,
    fecha_programada DATETIME NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES JOIN_FORCES.factura(numero)
)
GO

----- PROCEDURES -----
CREATE PROCEDURE JOIN_FORCES.migrar_provincia
AS
BEGIN
    INSERT INTO JOIN_FORCES.provincia (nombre)
    SELECT DISTINCT Cliente_Provincia FROM gd_esquema.Maestra
    WHERE Cliente_Provincia IS NOT NULL

    UNION

    SELECT DISTINCT Sucursal_Provincia FROM gd_esquema.Maestra
    WHERE Sucursal_Provincia IS NOT NULL

    UNION

    SELECT DISTINCT Proveedor_Provincia FROM gd_esquema.Maestra
    WHERE Proveedor_Provincia IS NOT NULL
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_localidad
AS
BEGIN
    INSERT INTO JOIN_FORCES.localidad (nombre, provincia_id)
    SELECT DISTINCT  m.Cliente_Localidad , p.id
    FROM gd_esquema.Maestra AS m
    JOIN JOIN_FORCES.provincia AS p ON m.Cliente_Provincia = p.nombre
    WHERE m.Cliente_Localidad IS NOT NULL

    UNION

    SELECT DISTINCT p.id, m.Sucursal_Localidad 
    FROM gd_esquema.Maestra AS m
    JOIN JOIN_FORCES.provincia AS p ON m.Sucursal_Provincia = p.nombre
    WHERE m.Sucursal_Localidad IS NOT NULL

    UNION

    SELECT DISTINCT p.id, m.Proveedor_Localidad 
    FROM gd_esquema.Maestra AS m
    JOIN JOIN_FORCES.provincia AS p ON m.Proveedor_Provincia = p.nombre
    WHERE m.Proveedor_Localidad IS NOT NULL
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_direccion
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO JOIN_FORCES.direccion (nombre, localidad_id)
    SELECT DISTINCT
        m.Cliente_Direccion,
        l.id
    FROM gd_esquema.Maestra AS m
    INNER JOIN JOIN_FORCES.provincia AS prov ON m.Cliente_Provincia = prov.nombre
    INNER JOIN JOIN_FORCES.localidad AS l ON m.Cliente_Localidad = l.nombre AND l.provincia_id = prov.id
    WHERE m.Cliente_Direccion IS NOT NULL 
      AND m.Cliente_Localidad IS NOT NULL 
      AND m.Cliente_Provincia IS NOT NULL
      AND NOT EXISTS ( 
        SELECT 1 FROM JOIN_FORCES.direccion d_exist
        WHERE d_exist.nombre = m.Cliente_Direccion AND d_exist.localidad_id = l.id
      )

    UNION

    SELECT DISTINCT
        m.Sucursal_Direccion,
        l.id
    FROM gd_esquema.Maestra AS m
    INNER JOIN JOIN_FORCES.provincia AS prov ON m.Sucursal_Provincia = prov.nombre
    INNER JOIN JOIN_FORCES.localidad AS l ON m.Sucursal_Localidad = l.nombre AND l.provincia_id = prov.id
    WHERE m.Sucursal_Direccion IS NOT NULL
      AND m.Sucursal_Localidad IS NOT NULL
      AND m.Sucursal_Provincia IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.direccion d_exist
        WHERE d_exist.nombre = m.Sucursal_Direccion AND d_exist.localidad_id = l.id
      )

    UNION

    SELECT DISTINCT
        m.Proveedor_Direccion,
        l.id
    FROM gd_esquema.Maestra AS m
    INNER JOIN JOIN_FORCES.provincia AS prov ON m.Proveedor_Provincia = prov.nombre
    INNER JOIN JOIN_FORCES.localidad AS l ON m.Proveedor_Localidad = l.nombre AND l.provincia_id = prov.id
    WHERE m.Proveedor_Direccion IS NOT NULL
      AND m.Proveedor_Localidad IS NOT NULL
      AND m.Proveedor_Provincia IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.direccion d_exist
        WHERE d_exist.nombre = m.Proveedor_Direccion AND d_exist.localidad_id = l.id
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_estado
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO JOIN_FORCES.estado (nombre)
    SELECT DISTINCT m.Pedido_Estado
    FROM gd_esquema.Maestra m
    WHERE m.Pedido_Estado IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.estado e WHERE e.nombre = m.Pedido_Estado);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_sucursal
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO JOIN_FORCES.sucursal (sucursal_direccion, sucursal_telefono, sucursal_email)
    SELECT DISTINCT
        m.Sucursal_Direccion,
        m.Sucursal_telefono,
        m.Sucursal_mail
    FROM gd_esquema.Maestra m
    WHERE m.Sucursal_Direccion IS NOT NULL
      AND m.Sucursal_telefono IS NOT NULL
      AND m.Sucursal_mail IS NOT NULL
      AND NOT EXISTS (
          SELECT 1 FROM JOIN_FORCES.sucursal s
          WHERE s.sucursal_direccion = m.Sucursal_Direccion
            AND s.sucursal_telefono = m.Sucursal_telefono
            AND s.sucursal_email = m.Sucursal_mail
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_cliente
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO JOIN_FORCES.cliente (dni, nombre, email, telefono, fecha_nacimiento)
    SELECT DISTINCT
        m.Cliente_Dni,
        TRIM(ISNULL(m.Cliente_Nombre, N'') + N' ' + ISNULL(m.Cliente_Apellido, N'')),
        m.Cliente_Mail,
        m.Cliente_Telefono,
        m.Cliente_FechaNacimiento
    FROM gd_esquema.Maestra m
    WHERE m.Cliente_Dni IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.cliente c WHERE c.dni = m.Cliente_Dni);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_proveedor
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO JOIN_FORCES.proveedor (cuit, razon_social, direccion, telefono, email)
    SELECT DISTINCT
        m.Proveedor_Cuit,
        m.Proveedor_RazonSocial,
        m.Proveedor_Direccion, 
        m.Proveedor_Telefono,
        m.Proveedor_Mail
    FROM gd_esquema.Maestra m
    WHERE m.Proveedor_Cuit IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.proveedor p WHERE p.cuit = m.Proveedor_Cuit);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_compra
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO JOIN_FORCES.compra (numero, proveedor_cuit, sucursal_id, fecha, total)
    SELECT DISTINCT
        m.Compra_Numero,
        m.Proveedor_Cuit,
        s.id, 
        m.Compra_Fecha,
        m.Compra_Total
    FROM gd_esquema.Maestra m
    INNER JOIN JOIN_FORCES.proveedor prov ON m.Proveedor_Cuit = prov.cuit
    INNER JOIN JOIN_FORCES.sucursal s ON m.Sucursal_Direccion = s.sucursal_direccion
        AND m.Sucursal_telefono = s.sucursal_telefono
        AND m.Sucursal_mail = s.sucursal_email
    WHERE m.Compra_Numero IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.compra comp WHERE comp.numero = m.Compra_Numero);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_pedido
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO JOIN_FORCES.pedido (numero, sucursal_id, cliente_dni, estado_id, pedido_fecha)
    SELECT DISTINCT
        m.Pedido_Numero,
        s.id,
        c.dni, 
        est.id,
        m.Pedido_Fecha
    FROM gd_esquema.Maestra m
    INNER JOIN JOIN_FORCES.cliente c ON m.Cliente_Dni = c.dni
    INNER JOIN JOIN_FORCES.estado est ON m.Pedido_Estado = est.nombre
    INNER JOIN JOIN_FORCES.sucursal s ON m.Sucursal_Direccion = s.sucursal_direccion
        AND m.Sucursal_telefono = s.sucursal_telefono
        AND m.Sucursal_mail = s.sucursal_email
    WHERE m.Pedido_Numero IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.pedido p WHERE p.numero = m.Pedido_Numero);
END
GO

---- PROCEDURE UNIFICADO ----

CREATE PROCEDURE JOIN_FORCES.migrar_datos
AS
BEGIN
    EXEC JOIN_FORCES.migrar_provincia
    EXEC JOIN_FORCES.migrar_localidad
    EXEC JOIN_FORCES.migrar_direccion
    EXEC JOIN_FORCES.migrar_estado
    EXEC JOIN_FORCES.migrar_sucursal
    EXEC JOIN_FORCES.migrar_cliente
    EXEC JOIN_FORCES.migrar_proveedor
    EXEC JOIN_FORCES.migrar_compra
    EXEC JOIN_FORCES.migrar_pedido
END
GO

EXEC JOIN_FORCES.migrar_datos
GO