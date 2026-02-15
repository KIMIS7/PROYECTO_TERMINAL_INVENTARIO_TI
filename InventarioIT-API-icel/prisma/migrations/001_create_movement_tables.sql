-- =============================================================
-- Migración: Crear tablas Movement y AssetHistory
-- Proyecto: InventarioIT
-- Descripción: Crea las tablas necesarias para el sistema de
--              movimientos de activos (Alta, Baja, Reasignación, Préstamo)
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

-- 2. Crear tabla Movement (si no existe)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Movement' AND TABLE_SCHEMA = 'dbo')
BEGIN
    CREATE TABLE [dbo].[Movement] (
        [MovementID] INT IDENTITY(1,1) NOT NULL,
        [AssetID] INT NOT NULL,
        [MovementType] NVARCHAR(50) NOT NULL,
        [Description] NVARCHAR(500) NULL,
        [Responsible] NVARCHAR(255) NULL,
        [CreatedTime] DATETIME NOT NULL,
        [CreatedBy] NVARCHAR(100) NULL,
        CONSTRAINT [PK_Movement] PRIMARY KEY ([MovementID]),
        CONSTRAINT [FK_Movement_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset]([AssetID]) ON DELETE NO ACTION ON UPDATE NO ACTION
    );
    PRINT 'Tabla Movement creada exitosamente';
END
ELSE
BEGIN
    PRINT 'Tabla Movement ya existe, se omite';
END
GO
