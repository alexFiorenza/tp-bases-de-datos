USE GD1C2025
GO

----- ELIMINACION DE TABLAS -----
IF OBJECT_ID('JOIN_FORCES.detalles_temporales', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.detalles_temporales
IF OBJECT_ID('JOIN_FORCES.detalle_factura', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.detalle_factura
IF OBJECT_ID('JOIN_FORCES.envio', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.envio
IF OBJECT_ID('JOIN_FORCES.factura', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.factura
IF OBJECT_ID('JOIN_FORCES.cancelacion_pedido', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.cancelacion_pedido
IF OBJECT_ID('JOIN_FORCES.detalle_pedido', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.detalle_pedido
IF OBJECT_ID('JOIN_FORCES.pedido', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.pedido
IF OBJECT_ID('JOIN_FORCES.cliente', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.cliente
IF OBJECT_ID('JOIN_FORCES.compra_detalle', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.compra_detalle
IF OBJECT_ID('JOIN_FORCES.compra', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.compra
IF OBJECT_ID('JOIN_FORCES.sillon_material', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.sillon_material
IF OBJECT_ID('JOIN_FORCES.sillon', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.sillon
IF OBJECT_ID('JOIN_FORCES.modelo_medida', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.modelo_medida
IF OBJECT_ID('JOIN_FORCES.sucursal', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.sucursal
IF OBJECT_ID('JOIN_FORCES.direccion', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.direccion
IF OBJECT_ID('JOIN_FORCES.localidad', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.localidad
IF OBJECT_ID('JOIN_FORCES.material', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.material
IF OBJECT_ID('JOIN_FORCES.tipo_material', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.tipo_material
IF OBJECT_ID('JOIN_FORCES.medida', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.medida
IF OBJECT_ID('JOIN_FORCES.modelo', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.modelo
IF OBJECT_ID('JOIN_FORCES.estado', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.estado
IF OBJECT_ID('JOIN_FORCES.proveedor', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.proveedor
IF OBJECT_ID('JOIN_FORCES.provincia', 'U') IS NOT NULL
    DROP TABLE JOIN_FORCES.provincia
GO

----- ELIMINACION DE PROCEDURES -----
IF OBJECT_ID('JOIN_FORCES.migrar_datos', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_datos
IF OBJECT_ID('JOIN_FORCES.migrar_provincia', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_provincia
IF OBJECT_ID('JOIN_FORCES.migrar_localidad', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_localidad
IF OBJECT_ID('JOIN_FORCES.migrar_direccion', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_direccion
IF OBJECT_ID('JOIN_FORCES.migrar_estado', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_estado
IF OBJECT_ID('JOIN_FORCES.migrar_sucursal', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_sucursal
IF OBJECT_ID('JOIN_FORCES.migrar_cliente', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_cliente
IF OBJECT_ID('JOIN_FORCES.migrar_proveedor', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_proveedor
IF OBJECT_ID('JOIN_FORCES.migrar_compra', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_compra
IF OBJECT_ID('JOIN_FORCES.migrar_pedido', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_pedido
IF OBJECT_ID('JOIN_FORCES.migrar_modelo', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_modelo
IF OBJECT_ID('JOIN_FORCES.migrar_medida', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_medida
IF OBJECT_ID('JOIN_FORCES.migrar_modelo_medida', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_modelo_medida
IF OBJECT_ID('JOIN_FORCES.migrar_sillon', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_sillon
IF OBJECT_ID('JOIN_FORCES.migrar_sillon_material', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_sillon_material
IF OBJECT_ID('JOIN_FORCES.migrar_cancelacion_pedido', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_cancelacion_pedido
IF OBJECT_ID('JOIN_FORCES.migrar_factura', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_factura
IF OBJECT_ID('JOIN_FORCES.migrar_envio', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_envio
IF OBJECT_ID('JOIN_FORCES.migrar_material', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_material
IF OBJECT_ID('JOIN_FORCES.migrar_tipo_material', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_tipo_material
IF OBJECT_ID('JOIN_FORCES.migrar_detalles', 'P') IS NOT NULL
    DROP PROCEDURE JOIN_FORCES.migrar_detalles
GO


----- ELIMINACION DE ESQUEMA -----
IF SCHEMA_ID('JOIN_FORCES') IS NOT NULL
    DROP SCHEMA JOIN_FORCES
GO

----- ESQUEMA JOIN_FORCES -----
GO
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

CREATE TABLE JOIN_FORCES.tipo_material (
    id INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    nombre NVARCHAR (255) UNIQUE NOT NULL
)
   
CREATE TABLE JOIN_FORCES.material (
    id INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    tipo_material_id INT NOT NULL,
    nombre NVARCHAR (255) NOT NULL,
    descripcion NVARCHAR (255) NOT NULL,
    precio_unitario DECIMAL(18, 2) NOT NULL,
    color NVARCHAR (50) NULL,
    textura NVARCHAR (50) NULL,
    dureza NVARCHAR (50) NULL,
    densidad DECIMAL(18, 2) NULL,
    FOREIGN KEY (tipo_material_id) REFERENCES JOIN_FORCES.tipo_material(id)
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
    direccion_id INT NOT NULL,
    sucursal_telefono NVARCHAR(255) NOT NULL,
    sucursal_email NVARCHAR(255) NOT NULL,
    FOREIGN KEY (direccion_id) REFERENCES JOIN_FORCES.direccion(id)
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
    fecha_nacimiento DATETIME NOT NULL,
    direccion_id INT NOT NULL,
    FOREIGN KEY (direccion_id) REFERENCES JOIN_FORCES.direccion(id)
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
    id INT PRIMARY KEY NOT NULL,
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
    cantidad INT NULL,
    precio_unitario DECIMAL(18,2)  NULL,
    subtotal DECIMAL(18,2)  NULL,
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
    SELECT DISTINCT m.Cliente_Localidad, p.id
    FROM gd_esquema.Maestra AS m
    JOIN JOIN_FORCES.provincia AS p ON m.Cliente_Provincia = p.nombre
    WHERE m.Cliente_Localidad IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.localidad l 
        WHERE l.nombre = m.Cliente_Localidad 
        AND l.provincia_id = p.id
    )

    UNION

    SELECT DISTINCT m.Sucursal_Localidad, p.id
    FROM gd_esquema.Maestra AS m
    JOIN JOIN_FORCES.provincia AS p ON m.Sucursal_Provincia = p.nombre
    WHERE m.Sucursal_Localidad IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.localidad l 
        WHERE l.nombre = m.Sucursal_Localidad 
        AND l.provincia_id = p.id
    )

    UNION

    SELECT DISTINCT m.Proveedor_Localidad, p.id
    FROM gd_esquema.Maestra AS m
    JOIN JOIN_FORCES.provincia AS p ON m.Proveedor_Provincia = p.nombre
    WHERE m.Proveedor_Localidad IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.localidad l 
        WHERE l.nombre = m.Proveedor_Localidad 
        AND l.provincia_id = p.id
    );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_direccion
AS
BEGIN
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
    INSERT INTO JOIN_FORCES.sucursal (direccion_id, sucursal_telefono, sucursal_email)
    SELECT DISTINCT
        d.id,
        m.Sucursal_telefono,
        m.Sucursal_mail
    FROM gd_esquema.Maestra m
    JOIN JOIN_FORCES.direccion d ON m.Sucursal_Direccion = d.nombre
    WHERE m.Sucursal_telefono IS NOT NULL
      AND m.Sucursal_mail IS NOT NULL
      AND NOT EXISTS (
          SELECT 1 FROM JOIN_FORCES.sucursal s
          WHERE s.direccion_id = d.id
            AND s.sucursal_telefono = m.Sucursal_telefono
            AND s.sucursal_email = m.Sucursal_mail
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_cliente
AS
BEGIN
    INSERT INTO JOIN_FORCES.cliente (dni, nombre, email, telefono, fecha_nacimiento, direccion_id)
    SELECT DISTINCT
        m.Cliente_Dni,
        TRIM(ISNULL(m.Cliente_Nombre, N'') + N' ' + ISNULL(m.Cliente_Apellido, N'')),
        m.Cliente_Mail,
        m.Cliente_Telefono,
        m.Cliente_FechaNacimiento,
        d.id
    FROM gd_esquema.Maestra m
    INNER JOIN JOIN_FORCES.provincia AS prov ON m.Cliente_Provincia = prov.nombre
    INNER JOIN JOIN_FORCES.localidad AS l ON m.Cliente_Localidad = l.nombre AND l.provincia_id = prov.id
    INNER JOIN JOIN_FORCES.direccion AS d ON m.Cliente_Direccion = d.nombre AND d.localidad_id = l.id
    WHERE m.Cliente_Dni IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.cliente c WHERE c.dni = m.Cliente_Dni);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_proveedor
AS
BEGIN
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
    INSERT INTO JOIN_FORCES.compra (numero, proveedor_cuit, sucursal_id, fecha, total)
    SELECT DISTINCT
        m.Compra_Numero,
        m.Proveedor_Cuit,
        s.id, 
        m.Compra_Fecha,
        m.Compra_Total
    FROM gd_esquema.Maestra m
    INNER JOIN JOIN_FORCES.proveedor prov ON m.Proveedor_Cuit = prov.cuit
    INNER JOIN JOIN_FORCES.direccion d ON m.Sucursal_Direccion = d.nombre
    INNER JOIN JOIN_FORCES.sucursal s ON d.id = s.direccion_id
        AND m.Sucursal_telefono = s.sucursal_telefono
        AND m.Sucursal_mail = s.sucursal_email
    WHERE m.Compra_Numero IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.compra comp WHERE comp.numero = m.Compra_Numero);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_pedido
AS
BEGIN
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
    INNER JOIN JOIN_FORCES.direccion d ON m.Sucursal_Direccion = d.nombre
    INNER JOIN JOIN_FORCES.sucursal s ON d.id = s.direccion_id
        AND m.Sucursal_telefono = s.sucursal_telefono
        AND m.Sucursal_mail = s.sucursal_email
    WHERE m.Pedido_Numero IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM JOIN_FORCES.pedido p WHERE p.numero = m.Pedido_Numero);
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_modelo
AS
BEGIN
    INSERT INTO JOIN_FORCES.modelo (modelo_codigo, nombre, descripcion, precio)
    SELECT DISTINCT
        Sillon_Modelo_Codigo,
        Sillon_Modelo,
        Sillon_Modelo_Descripcion,
        Sillon_Modelo_Precio
    FROM gd_esquema.Maestra
    WHERE Sillon_Modelo_Codigo IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.modelo mo WHERE mo.modelo_codigo = Sillon_Modelo_Codigo
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_medida
AS
BEGIN
    INSERT INTO JOIN_FORCES.medida (altura, ancho, profundidad, precio)
    SELECT DISTINCT
        Sillon_Medida_Alto,
        Sillon_Medida_Ancho,
        Sillon_Medida_Profundidad,
        Sillon_Medida_Precio
    FROM gd_esquema.Maestra
    WHERE Sillon_Medida_Alto IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.medida me
        WHERE me.altura = Sillon_Medida_Alto
          AND me.ancho = Sillon_Medida_Ancho
          AND me.profundidad = Sillon_Medida_Profundidad
          AND me.precio = Sillon_Medida_Precio
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_modelo_medida
AS
BEGIN
    INSERT INTO JOIN_FORCES.modelo_medida (modelo_codigo, medida_id)
    SELECT DISTINCT
        mo.modelo_codigo,
        me.id
    FROM gd_esquema.Maestra m
    JOIN JOIN_FORCES.modelo mo ON mo.modelo_codigo = m.Sillon_Modelo_Codigo
    JOIN JOIN_FORCES.medida me ON me.altura = m.Sillon_Medida_Alto
        AND me.ancho = m.Sillon_Medida_Ancho
        AND me.profundidad = m.Sillon_Medida_Profundidad
        AND me.precio = m.Sillon_Medida_Precio
    WHERE NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.modelo_medida mm
        WHERE mm.modelo_codigo = mo.modelo_codigo AND mm.medida_id = me.id
    );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_sillon
AS
BEGIN
    INSERT INTO JOIN_FORCES.sillon (codigo, modelo_codigo)
    SELECT DISTINCT
        Sillon_Codigo,
        Sillon_Modelo_Codigo
    FROM gd_esquema.Maestra
    WHERE Sillon_Codigo IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.sillon s WHERE s.codigo = Sillon_Codigo
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_sillon_material
AS
BEGIN
    INSERT INTO JOIN_FORCES.sillon_material (sillon_codigo, material_id, cantidad)
    SELECT DISTINCT
        m.Sillon_Codigo,
        mat.id,
        1
    FROM gd_esquema.Maestra m
    JOIN JOIN_FORCES.material mat ON mat.nombre = m.Material_Nombre
        AND mat.tipo_material_id = (SELECT id FROM JOIN_FORCES.tipo_material WHERE nombre = m.Material_Tipo)
        AND mat.descripcion = m.Material_Descripcion
        AND mat.precio_unitario = m.Material_Precio
    WHERE m.Sillon_Codigo IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.sillon_material sm
        WHERE sm.sillon_codigo = m.Sillon_Codigo AND sm.material_id = mat.id
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_cancelacion_pedido
AS
BEGIN
    INSERT INTO JOIN_FORCES.cancelacion_pedido (pedido_numero, fecha, motivo)
    SELECT DISTINCT
        Pedido_Numero,
        Pedido_Cancelacion_Fecha,
        Pedido_Cancelacion_Motivo
    FROM gd_esquema.Maestra
    WHERE Pedido_Cancelacion_Fecha IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.cancelacion_pedido cp
        WHERE cp.pedido_numero = Pedido_Numero
      );
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_factura
AS
BEGIN
    INSERT INTO JOIN_FORCES.factura (numero, sucursal_id, pedido_numero, cliente_dni, fecha, total)
    SELECT DISTINCT
        Factura_Numero,
        s.id,
        Pedido_Numero,
        Cliente_Dni,
        Factura_Fecha,
        Factura_Total
    FROM gd_esquema.Maestra m
    JOIN JOIN_FORCES.direccion d ON m.Sucursal_Direccion = d.nombre
    JOIN JOIN_FORCES.sucursal s ON d.id = s.direccion_id
        AND m.Sucursal_telefono = s.sucursal_telefono
        AND m.Sucursal_mail = s.sucursal_email
    WHERE Factura_Numero IS NOT NULL
        AND Pedido_Numero IS NOT NULL
        AND Cliente_Dni IS NOT NULL
        AND Factura_Fecha IS NOT NULL
        AND Factura_Total IS NOT NULL
        AND NOT EXISTS (
            SELECT 1 FROM JOIN_FORCES.factura f WHERE f.numero = Factura_Numero
        );
END
GO



CREATE PROCEDURE JOIN_FORCES.migrar_envio
AS
BEGIN
    INSERT INTO JOIN_FORCES.envio (numero, factura_id, importe_traslado, importe_subida, fecha_programada, fecha, total)
    SELECT DISTINCT
        m.Envio_Numero,
        m.Factura_Numero,
        m.Envio_ImporteTraslado,
        m.Envio_ImporteSubida,
        m.Envio_Fecha_Programada,
        m.Envio_Fecha,
        m.Envio_Total
    FROM gd_esquema.Maestra m
    JOIN JOIN_FORCES.factura f ON f.numero = m.Factura_Numero
    WHERE m.Envio_Numero IS NOT NULL
        AND m.Factura_Numero IS NOT NULL
        AND m.Envio_ImporteTraslado IS NOT NULL
        AND m.Envio_ImporteSubida IS NOT NULL
        AND m.Envio_Fecha_Programada IS NOT NULL
        AND m.Envio_Fecha IS NOT NULL
        AND m.Envio_Total IS NOT NULL
        AND NOT EXISTS (
            SELECT 1 FROM JOIN_FORCES.envio e WHERE e.numero = m.Envio_Numero
        );
END
GO


CREATE PROCEDURE JOIN_FORCES.migrar_tipo_material
AS
BEGIN

    INSERT INTO
        JOIN_FORCES.tipo_material (nombre)
    SELECT DISTINCT
        Material_Tipo
    FROM
        gd_esquema.Maestra
    WHERE
        Material_Tipo IS NOT NULL;
END
GO

CREATE PROCEDURE JOIN_FORCES.migrar_material
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO
        JOIN_FORCES.material (
            tipo_material_id,
            nombre,
            descripcion,
            precio_unitario,
            color,
            textura,
            dureza,
            densidad
        )
    SELECT DISTINCT
        tm.id,
        m.Material_Nombre,
        m.Material_Descripcion,
        m.Material_Precio,
        CASE
            WHEN m.Material_Tipo = 'Tela' THEN m.Tela_Color
            WHEN m.Material_Tipo = 'Madera' THEN m.Madera_Color
            ELSE NULL
        END,
        CASE
            WHEN m.Material_Tipo = 'Tela' THEN m.Tela_Textura
            ELSE NULL
        END,
        CASE
            WHEN m.Material_Tipo = 'Madera' THEN m.Madera_Dureza
            ELSE NULL
        END,
        CASE
            WHEN m.Material_Tipo = 'Relleno' THEN m.Relleno_Densidad
            ELSE NULL
        END
    FROM
        gd_esquema.Maestra m
        JOIN JOIN_FORCES.tipo_material tm ON m.Material_Tipo = tm.nombre
    WHERE
        m.Material_Nombre IS NOT NULL
        AND m.Material_Descripcion IS NOT NULL
        AND m.Material_Precio IS NOT NULL
        AND NOT EXISTS (
            SELECT
                1
            FROM
                JOIN_FORCES.material mat
            WHERE
                mat.tipo_material_id = tm.id
                AND mat.nombre = m.Material_Nombre
        );
END
GO


CREATE PROCEDURE JOIN_FORCES.migrar_detalles
AS
BEGIN
    CREATE TABLE JOIN_FORCES.detalles_temporales (
        detalle_pedido_codigo bigint IDENTITY(1,1),
        detalle_pedido_numero decimal(18,0),
        detalle_pedido_sillon bigint,
        detalle_pedido_cantidad bigint,
        detalle_pedido_precio decimal(18,2),
        detalle_pedido_subtotal decimal(18,2),
        detalle_factura_numero bigint,
        detalle_factura_precio decimal(18,2),
        detalle_factura_cantidad decimal(18,0),
        detalle_factura_subtotal decimal(18,2)
    )

    INSERT INTO JOIN_FORCES.detalles_temporales (
        detalle_pedido_numero,
        detalle_pedido_sillon,
        detalle_pedido_cantidad,
        detalle_pedido_precio,
        detalle_pedido_subtotal,
        detalle_factura_numero,
        detalle_factura_precio,
        detalle_factura_cantidad,
        detalle_factura_subtotal
    )
    SELECT DISTINCT
        p.Pedido_Numero,
        p.Sillon_Codigo,
        p.Detalle_Pedido_Cantidad,
        p.Detalle_Pedido_Precio,
        p.Detalle_Pedido_Subtotal,
        f.Factura_Numero,
        f.Detalle_Factura_Precio,
        f.Detalle_Factura_Cantidad,
        f.Detalle_Factura_Subtotal
    FROM gd_esquema.Maestra p
    JOIN gd_esquema.Maestra f ON p.Pedido_Numero = f.Pedido_Numero
    WHERE
        p.Pedido_Numero IS NOT NULL AND
        p.Sillon_Codigo IS NOT NULL AND
        f.Factura_Numero IS NOT NULL;

    INSERT INTO JOIN_FORCES.detalle_pedido (
        id,
        pedido_numero,
        sillon_codigo,
        cantidad,
        precio_unitario,
        subtotal
    )
    SELECT
        detalle_pedido_codigo,
        detalle_pedido_numero,
        detalle_pedido_sillon,
        detalle_pedido_cantidad,
        detalle_pedido_precio,
        detalle_pedido_subtotal
    FROM JOIN_FORCES.detalles_temporales;

    INSERT INTO JOIN_FORCES.detalle_factura (
        factura_numero,
        detalle_pedido_id,
        cantidad,
        precio_unitario,
        subtotal
    )
    SELECT
        dt.detalle_factura_numero,
        dt.detalle_pedido_codigo,
        dt.detalle_factura_cantidad,
        dt.detalle_factura_precio,
        dt.detalle_factura_subtotal
    FROM JOIN_FORCES.detalles_temporales dt
    WHERE dt.detalle_factura_numero IS NOT NULL

    INSERT INTO JOIN_FORCES.compra_detalle (compra_numero, material_id, subtotal, precio_unitario, cantidad)
    SELECT DISTINCT
        m.Compra_Numero,
        mat.id,
        m.Detalle_Compra_SubTotal,
        m.Detalle_Compra_Precio,
        m.Detalle_Compra_Cantidad
    FROM gd_esquema.Maestra m
    JOIN JOIN_FORCES.material mat ON mat.nombre = m.Material_Nombre
        AND mat.tipo_material_id = (SELECT id FROM JOIN_FORCES.tipo_material WHERE nombre = m.Material_Tipo)
        AND mat.descripcion = m.Material_Descripcion
        AND mat.precio_unitario = m.Material_Precio
    WHERE m.Compra_Numero IS NOT NULL
      AND NOT EXISTS (
        SELECT 1 FROM JOIN_FORCES.compra_detalle cd
        WHERE cd.compra_numero = m.Compra_Numero AND cd.material_id = mat.id
      );
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
    EXEC JOIN_FORCES.migrar_tipo_material
    EXEC JOIN_FORCES.migrar_material
    EXEC JOIN_FORCES.migrar_compra
    EXEC JOIN_FORCES.migrar_pedido
    EXEC JOIN_FORCES.migrar_modelo;
    EXEC JOIN_FORCES.migrar_medida;
    EXEC JOIN_FORCES.migrar_modelo_medida;
    EXEC JOIN_FORCES.migrar_sillon;
    EXEC JOIN_FORCES.migrar_sillon_material;
    EXEC JOIN_FORCES.migrar_factura;
    EXEC JOIN_FORCES.migrar_cancelacion_pedido;
    EXEC JOIN_FORCES.migrar_detalles;
    EXEC JOIN_FORCES.migrar_envio;
END
GO

EXEC JOIN_FORCES.migrar_datos
GO

