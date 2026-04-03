-- =============================================================
-- Migracion: Agregar columnas Empresa, Hotel, Tienda a AssetDetail
-- Proyecto: InventarioIT
-- Descripcion: Agrega 3 columnas para descomponer el campo Location
--              del inventario importado en Empresa, Hotel y Tienda
-- =============================================================

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'AssetDetail' AND COLUMN_NAME = 'Empresa')
BEGIN
    ALTER TABLE [dbo].[AssetDetail] ADD [Empresa] NVARCHAR(150) NULL;
    PRINT 'Columna Empresa agregada a AssetDetail';
END
ELSE
BEGIN
    PRINT 'Columna Empresa ya existe en AssetDetail, se omite';
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'AssetDetail' AND COLUMN_NAME = 'Hotel')
BEGIN
    ALTER TABLE [dbo].[AssetDetail] ADD [Hotel] NVARCHAR(150) NULL;
    PRINT 'Columna Hotel agregada a AssetDetail';
END
ELSE
BEGIN
    PRINT 'Columna Hotel ya existe en AssetDetail, se omite';
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'AssetDetail' AND COLUMN_NAME = 'Tienda')
BEGIN
    ALTER TABLE [dbo].[AssetDetail] ADD [Tienda] NVARCHAR(150) NULL;
    PRINT 'Columna Tienda agregada a AssetDetail';
END
ELSE
BEGIN
    PRINT 'Columna Tienda ya existe en AssetDetail, se omite';
END
GO
