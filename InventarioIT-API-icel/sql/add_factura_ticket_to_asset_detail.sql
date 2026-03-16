-- Agregar columnas Factura y Ticket a la tabla AssetDetail
-- Fecha: 2026-03-16
-- Descripcion: Se agregan los campos Factura y Ticket para registrar
-- la informacion de factura y ticket asociados a cada activo.

IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'AssetDetail' AND COLUMN_NAME = 'Factura'
)
BEGIN
    ALTER TABLE AssetDetail
    ADD Factura NVARCHAR(150) NULL;
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'AssetDetail' AND COLUMN_NAME = 'Ticket'
)
BEGIN
    ALTER TABLE AssetDetail
    ADD Ticket NVARCHAR(150) NULL;
END
GO
