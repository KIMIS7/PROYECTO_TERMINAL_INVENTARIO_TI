-- =============================================================
-- Migración: Crear tabla AssetHistory
-- Proyecto: InventarioIT
-- Descripción: Crea la tabla necesaria para el sistema de
--              movimientos de activos (Alta, Baja, Reasignación, Préstamo)
--              Los movimientos se almacenan directamente en AssetHistory
-- =============================================================

-- 1. Crear tabla AssetHistory (si no existe)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AssetHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
    CREATE TABLE [dbo].[AssetHistory] (
        [AssetHistoryID] INT IDENTITY(1,1) NOT NULL,
        [AssetID] INT NOT NULL,
        [Operation] NVARCHAR(255) NOT NULL,
        [Description] NVARCHAR(500) NOT NULL,
        [CreatedTime] DATETIME NOT NULL,
        CONSTRAINT [PK_AssetHistory] PRIMARY KEY ([AssetHistoryID]),
        CONSTRAINT [FK_AssetHistory_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset]([AssetID]) ON DELETE NO ACTION ON UPDATE NO ACTION
    );
    PRINT 'Tabla AssetHistory creada exitosamente';
END
ELSE
BEGIN
    PRINT 'Tabla AssetHistory ya existe, se omite';
END
GO
