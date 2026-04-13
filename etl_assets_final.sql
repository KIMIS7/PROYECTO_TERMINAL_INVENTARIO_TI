-- ============================================================
-- ETL Generado: 2026-04-13 02:28:59
-- Total registros: 142
-- ============================================================

USE InventarioIT;
GO

-- Variables globales
DECLARE @ETLUserID INT = 11;
DECLARE @VendorID INT = 1;
DECLARE @AssetStateID INT = 2;
DECLARE @NewDetailID INT;
DECLARE @NewAssetID INT;
DECLARE @AssetTAG NVARCHAR(20);
DECLARE @ProductTypeID INT;
DECLARE @SiteID INT;
DECLARE @CompanyID INT;
DECLARE @DepartID INT;

-- ============================================================
-- INSERCIÓN DE ACTIVOS
-- ============================================================

-- Registro 1: BEACHPALACE SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 2;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'3DDL9N2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5 7500T', N'SSD', N'250 GB', 
    N'16 GB', N'DDR4',
    N'BEACHSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACHPALACE SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 2: BEACHPALACE TAB CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 2;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XGPE', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'16 GB', N'DDR3',
    N'CUNBEACHPTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACHPALACE TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 3: BEACHPALACE JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 2;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0360BT', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'HDD', N'500 GB', 
    N'16 GB', N'DDR3',
    N'JoyBeachPalace',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACHPALACE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 4: CUN T2 TDA CORONA PA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 3;
SET @DepartID = 16;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01HG4V', N'LENOVO Neo 50q Gen 4 Desktop (ThinkCentre) - Type 12LM', 
    N'Windows 11', N'Windows 11', 
    N'I5 13420H', N'NVMe', N'500 GB', 
    N'16 GB', N'DDR4',
    N'SVRCUNT2PA',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'CUN T2 TDA CORONA PA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 5: CUN T2 TDA CORONA PB
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 3;
SET @DepartID = 16;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'DCSMHK2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5 7500T', N'SSD', N'250 GB', 
    N'16 GB', N'DDR4',
    N'SVRCUNT2PB',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'CUN T2 TDA CORONA PB', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 6: CUN T3 ISLA CORONA C11
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 5;
SET @DepartID = 16;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'7V2L8X2', N'OptiPlex 7060 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5 8500T', N'SSD', N'500 GB', 
    N'16 GB', N'DDR4',
    N'SVRCUNT3C11',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'CUN T3 ISLA CORONA C11', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 7: CUN T3 ISLA CORONA C20
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 5;
SET @DepartID = 16;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'7TSM8X2', N'DELL OptiPlex 7060 Micro', 
    N'Windows 10', N'Windows 10', 
    N'i5-8500T', N'SSD', N'500 GB', 
    N'16 GB', N'DDR4',
    N'SVRCUNT3C20',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'CUN T3 ISLA CORONA C20', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 8: LE BLANC CANCUN SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 7;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q7J5', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', N'DDR4',
    N'LEBLANCSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'LE BLANC CANCUN SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 9: LE BLANC CANCUN TAB CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 7;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ00HB8V', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'SSD', N'120 GB', 
    N'8 GB', N'DDR3',
    N'CANLEBLANB01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'LE BLANC CANCUN TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 10: LE BLANC CANCUN JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 7;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ01R425', N'LENOVO M70q Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'HDD', N'1 TB', 
    N'8 GB', N'DDR3',
    N'CUNLEBLANCJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'LE BLANC CANCUN JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 11: MOON GRAND SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'SIN IDENTIFICAR', N'MJ0FF9E9', NULL, 
    N'Windows 11', N'Windows 11', 
    N'i5-10400T', N'NVMe', N'500 GB', 
    N'16 GB', N'DDR4',
    N'MULTIMOONGRANDSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 12: MOON GRAND MULTI CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JGHSQP2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'500 GB', 
    N'8 GB', N'DDR4',
    N'CUNMONGRDMC02',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 13: MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VNKP', N'LENOVO Thinkcentre Neo50q 12LM', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'480 GB', 
    N'16 GB', N'DDR4',
    N'MoonGrand_Sipatron',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 14: MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0KMW7T', N'LENOVO M70q Gen 3', 
    N'Windows 11', N'Windows 11', 
    N'I5-12400T', N'NVMe', N'250 GB', 
    N'16 GB', N'DDR4',
    N'CUNMONGRDCC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 15: MOON GRAND JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VPA7', N'LENOVO Neo 50q Gen 4 Desktop (ThinkCentre) - Type 12LM', 
    N'Windows 11', N'Windows 11', 
    N'I5 13420H', N'NVMe', N'500 GB', 
    N'16 GB', N'DDR4',
    N'JoyMoonGrand',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 16: MOON GRAND RECEPTORÍA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 21;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VQEP', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', N'DDR3',
    N'MOONGRANDRECEP',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND RECEPTORÍA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 17: MOON GRAND AMIANI
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VN0L', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5 13420H', N'NVMe', N'500 GB', 
    N'16 GB', N'DDR4',
    N'MGRANDAMIANISVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND AMIANI', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 18: MOON GRAND AQUA PARK
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 13;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JBGYP52', N'DELL OptiPlex 7060 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-8500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'SVRAQUAPARK',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND AQUA PARK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 19: MOON GRAND PIER 27 PERUANO
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0FF9EQ', N'LENOVO M70q Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-10400T', NULL, N'500 GB', 
    N'16 GB', NULL,
    N'MGRANDPIER27SVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND PIER 27 PERUANO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 20: MOON GRAND PIER27 RESTAURANTE CARIBEÑO
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 8;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0HNY0X', N'LENOVO M70q Gen 2 Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-11400T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'MOONRESTSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON GRAND PIER27 RESTAURANTE CARIBEÑO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 21: MOON PROSHOP
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 9;
SET @DepartID = 19;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VP68', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5 13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'MGOLFSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON PROSHOP', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 22: MOON PROSHOP CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 9;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JGMVQP2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'250 GB', 
    N'8 GB', NULL,
    N'MOONGOLF-CAJA',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON PROSHOP CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 23: MOON SUNRISE CORAZON SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 15;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VMM1', N'LENOVO Neo 50q Gen 4 Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SUNCORAZONSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE CORAZON SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 24: MOON SUNRISE CORAZON CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03608Z', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'SSD', N'120 GB', 
    N'8 GB', N'DDR3',
    N'CUNMONSUNCC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE CORAZON CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 25: MOON SUNRISE CORAZON CAJA 3
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01YC75', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'CUNMONSUNCC3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE CORAZON CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 26: MOON SUNRISE CORAZON CAJA 4
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01YC86', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'CUNMONSUNCC4',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE CORAZON CAJA 4', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 27: MOON SUNRISE MULTI SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'HSVZLP2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'SUNARTESVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 28: MOON SUNRISE MULTI CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ003SKJ', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-4440S', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'MPSunriseCj1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE MULTI CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 29: MOON SUNRISE MULTI CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XGPH', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'120 GB', 
    N'16 GB', NULL,
    N'CUNMONSUNTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE MULTI CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 30: MOON SUNRISE  MULTI CAJA 3 BORDADORA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03V9L3', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'CUNMONSUNTC3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE  MULTI CAJA 3 BORDADORA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 31: MOON SUNRISE JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ015XK4', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'RIVMONSUNJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 32: MOON SUNRISE PIER27 PLAYA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 10;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0HNXY4', N'LENOVO M70q Gen 2 Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-11400T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SUNPLAYASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON SUNRISE PIER27 PLAYA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 33: PLAYACAR PALACE SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 11;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ04LR8Y', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'PLAYACARSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PLAYACAR PALACE SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 34: SUN PALACE SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 12;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEJ6', N'LENOVO MJ03VEJ6', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'SUNSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SUN PALACE SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 35: SUN PALACE TAB CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 12;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0360A0', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'SSD', N'120 GB', 
    N'8 GB', N'DDR3',
    N'CUNSUNPALTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SUN PALACE TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 36: SUN PALACE JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 12;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEHT', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'CUNSUNPALJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SUN PALACE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 37: MOON NIZUC SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 1;
SET @SiteID = 13;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEJU', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'MOONNIZUCSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON NIZUC SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 38: MOON NIZUC TAB CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 13;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'FP5S5S3', N'DELL OptiPlex 7000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'MOONNIZUCCJ2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON NIZUC TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 39: MOON NIZUC PUEBLITO CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 13;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q7B0', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'CUNMONNIZVC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON NIZUC PUEBLITO CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 40: MOON NIZUC JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 13;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'QCM1250', N'DELL D19U MINI', 
    N'Windows 11', N'Windows 11', 
    N'i5-14500T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'CANMONNIZJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'MOON NIZUC JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 41: COZUMEL PALACE PIER 27
SET @ProductTypeID = 1;
SET @CompanyID = 1;
SET @SiteID = 14;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'GM5S5S3', N'DELL OptiPlex 7000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'SVRCOZPAL',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'COZUMEL PALACE PIER 27', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 42: BLUEBAY BOUTIQUE SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 15;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VNDA', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'BBAYBOUTSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BLUEBAY BOUTIQUE SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 43: BLUEBAY PLAYA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 15;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0FF9EJ', N'LENOVO M70q Desktop', 
    N'Windows 11', N'Windows 11', 
    N'i5-10400T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'BBAYPYASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BLUEBAY PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 44: BLUEBAY TABAQUERIA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 15;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'95T8CM2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'i5-7500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'BBAYSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BLUEBAY TABAQUERIA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 45: BLUEBAY TAB CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 15;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ04LR7E', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'RIVBLUBAYTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BLUEBAY TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 46: BLUEBAY TAB CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 15;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ02JRRT', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'RIVBLUBAYTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BLUEBAY TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 47: BLUEBAY JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 15;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ04LR5U', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'BBAYJOYERIA-J01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BLUEBAY JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 48: H10 OCEAN PARADISE SERVIDOR - caja 3
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 16;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VPD6', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'H10PARSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 OCEAN PARADISE SERVIDOR - caja 3', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 49: H10 OCEAN PARADISE TAB CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 16;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEF9', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVH10OCPTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 OCEAN PARADISE TAB CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 50: H10 OCEAN PARADISE TAB CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 16;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03V9LL', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVH10OCPTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 OCEAN PARADISE TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 51: H10 OCEAN PARADISE TAB RECEPTOR - impresora
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 16;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JD6KWW2', N'DELL OptiPlex 7060 Tower', 
    N'Windows 10', N'Windows 10', 
    N'I5-8400', N'HDD', N'1 TB', 
    N'8 GB', NULL,
    N'RIVH10OCPTR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 OCEAN PARADISE TAB RECEPTOR - impresora', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 52: H10 OCEAN PARADISE JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 16;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEJR', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'CAJAJOY',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 OCEAN PARADISE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 53: H10 RIVIERA SERVIDOR (ocean maya)
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 17;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JBG8JG2', N'DELL OptiPlex 7060 Micro', 
    N'Windows 11', N'Windows 11', 
    N'i5-8500T', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'H10RSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 RIVIERA SERVIDOR (ocean maya)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 54: H10 RIVIERA TAB CAJA (ocean maya)
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 17;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XGQ3', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVH10OCMTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 RIVIERA TAB CAJA (ocean maya)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 55: HYATT ZILARA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 18;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01ZK81', N'Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'HYTZILSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 56: HYATT ZILARA JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 18;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01TQRZ', N'Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I3-1215U', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'HYATTZILARAJOY',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 57: PALLADIUM RIVIERA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'65SCDZ3', N'DELL OptiPlex Micro 7010', 
    N'Windows 11', N'Windows 11', 
    N'I5-13500T', N'NVMe', N'500 GB', 
    N'24 GB', NULL,
    N'SVRPCOLONIA',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIVIERA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 58: PALLADIUM RIV WHITESANDS CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XMTE', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVPALWHSBC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIV WHITESANDS CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 59: PALLADIUM RIV WHITESANDS CAJA2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEJE', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-6400', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'RIVPALWHSBC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIV WHITESANDS CAJA2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 60: PALLADIUM RIV PLAYA CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VQEU', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'RIVPALPYAPC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIV PLAYA CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 61: PALLADIUM RIV COL AMIANI CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'7M5S5S3', N'DELL OptiPlex 7000 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-12500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'RIVPALCOLBC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIV COL AMIANI CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 62: PALLADIUM JOY COLONIAL
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VN2N', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVPALCOLJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM JOY COLONIAL', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 63: PALLADIUM RIV KANTENAH CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ04LRA5', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'250 GB', 
    N'8 GB', NULL,
    N'RIVPALKANTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIV KANTENAH CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 64: PALLADIUM RIV KANTENAH CAJA2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 20;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ039676', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I3-4150', N'SSD', N'250 GB', 
    N'8 GB', NULL,
    N'RIVPALKANTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM RIV KANTENAH CAJA2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 65: PALLADIUM ROYAL JOY SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 25;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01TQVZ', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i3-1215U', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVRPROYAL',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALLADIUM ROYAL JOY SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 66: PRINCESS RIVIERA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 26;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VMMJ', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'PRINRIVSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 67: PRINCESS RIV CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 26;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'3D7M9N2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'HDD', N'1 TB', 
    N'8 GB', NULL,
    N'RIVPRNRIVMC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIV CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 68: PRINCESS RIV CAJA2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 26;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ02YE3J', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'RIVPRNRIVMC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIV CAJA2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 69: PRINCESS RIV JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 26;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ015XJT', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'RIVPRNRIVJOY',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIV JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 70: PRINCESS RIV TDA PLAYA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 26;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0GHWS3', N'LENOVO M75q Gen 2', 
    N'Windows 11', N'Windows 11', 
    N'RYZEN 5 PRO 4650GE', N'NVMe', N'250 GB', 
    N'8 GB', NULL,
    N'PRIVPYASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIV TDA PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 71: RIU LUPITA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 27;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'6943JL2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'i5-7500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'SVRRIULUP',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'RIU LUPITA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 72: SANDOS CANCUN
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 28;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01ZK1P', N'Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVRSDOSCUN',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CANCUN', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 73: SANDOS CARACOL SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 29;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JGH3DP2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'i5-7500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'SVRSDOSCAR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CARACOL SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 74: SANDOS CARACOL RECEPTOR
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 29;
SET @DepartID = 21;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'SIN IDENTIFICAR', N'MJ00XLV1', N'LENOV O M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'SVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CARACOL RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 75: SANDOS CARACOL CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 29;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0360BL', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVSANCARTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CARACOL CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 76: SANDOS CARACOL CAJA 2 (Anydesk del servidor)
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 29;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XGP1', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVSANCARTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CARACOL CAJA 2 (Anydesk del servidor)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 77: SANDOS CARACOL CAJA 3
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 29;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ01R3XG', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVSANCARTC3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CARACOL CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 78: SANDOS CARACOL JOY
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 29;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'1QS56Q2', N'DELL Vostro 3470', 
    N'Windows 10', N'Windows 10', 
    N'I5-8400', N'HDD', N'1 TB', 
    N'8 GB', NULL,
    N'RIVSANCARJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS CARACOL JOY', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 79: NO) SANDOS PLAYACAR
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 30;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'6955JL2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'i5-7500T', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'SVRSDOSPCAR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) SANDOS PLAYACAR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 80: SANDOS PLAYACAR CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 30;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ00YKVK', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'RIVSANPYCTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS PLAYACAR CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 81: SANDOS PLAYACAR CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 30;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ01MGT7', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVSANPYCTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS PLAYACAR CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 82: SANDOS PLAYACAR LOBBY
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 30;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0431MZ', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVSANPYCTC3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS PLAYACAR LOBBY', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 83: SANDOS PLAYACAR JOY (forti client)
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 30;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ003SJY', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVSANPYCJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SANDOS PLAYACAR JOY (forti client)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 84: NO) THE FIVES SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 31;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01J6PD', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVRTHEFIVES',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) THE FIVES SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 85: NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 32;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XMTS', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'THEROYALSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 86: Hilton THE ROYAL CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 32;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEGP', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RIVTHEROYTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'Hilton THE ROYAL CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 87: Hilton THE ROYAL JOY
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 32;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03608G', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', N'SSD', N'250 GB', 
    N'16 GB', N'DDR3',
    N'RIVTHEROYJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'Hilton THE ROYAL JOY', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 88: NO) PRINCESS YUC SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 34;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0GHWQG', N'LENOVO M75q Gen 2', 
    N'Windows 11', N'Windows 11', 
    N'RYZEN 5 PRO 4650GE', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'PRINYUCSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) PRINCESS YUC SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 89: PRINCESS YUC TAB CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 34;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ02T07C', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4460', NULL, N'120 GB', 
    N'12 GB', N'DDR3',
    N'RIVPRNYUCBC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS YUC TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 90: PRINCESS YUC AMIANI CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 34;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VNFD', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'PRINYUCCJ1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS YUC AMIANI CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 91: PRINCESS YUC JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 34;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ01HXHQ', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-4440S', N'HDD', N'500 GB', 
    N'8 GB', N'DDR3',
    N'RIVPRNYUCJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS YUC JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 92: NO) PRINCESS SUNSET SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 2;
SET @SiteID = 35;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01ZK08', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'PRINSUNSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) PRINCESS SUNSET SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 93: PRINCESS SUNSET TAB CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 35;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'6915JL2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVPRNSUNTC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET TAB CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 94: PRINCESS SUNSET TAB CAJA2
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 35;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'171F8R2', N'DELL OptiPlex 3060 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-8500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'RIVPRNSUNTC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET TAB CAJA2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 95: NO) WYNDHAM
SET @ProductTypeID = 1;
SET @CompanyID = 2;
SET @SiteID = 36;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01M97M', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVWYNDHASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) WYNDHAM', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 96: AEROPUERTO TERMINAL 2 SERVIDOR PIER27
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 37;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'BDVL0S2', N'DELL OptiPlex 3060 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-8400T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'SVRASURCUNT2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'AEROPUERTO TERMINAL 2 SERVIDOR PIER27', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 97: AEROPUERTO TERMINAL 3 SERVIDOR PIER27
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 38;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q73W', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVRASURCUNT3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'AEROPUERTO TERMINAL 3 SERVIDOR PIER27', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 98: H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 39;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q29G', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVRH10PTOM',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 99: H10 PTO MORELOS TAB CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 39;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q1G2', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'H10PTOMCAJA1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 PTO MORELOS TAB CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 100: H10 PTO MORELOS TAB CAJA2
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 39;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q1D5', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'H10PTOMCAJA2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'H10 PTO MORELOS TAB CAJA2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 101: NO) HAVEN HIPOTELS Amiani SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 40;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'95L9CM2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'SVRHIPOTELS',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'NO) HAVEN HIPOTELS Amiani SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 102: HAVEN HIPOTELS Amiani Caja
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 40;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'95H8CM2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'250 GB', 
    N'8 GB', NULL,
    N'RIVHAVHIPA01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HAVEN HIPOTELS Amiani Caja', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 103: HAVEN HIPOTELS SUNGLASSCHIC
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 40;
SET @DepartID = 22;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'DCQDHK2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'RIVHAVHIPS01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HAVEN HIPOTELS SUNGLASSCHIC', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 104: ROYALTON RIV MUL SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0FF9F3', N'LENOVO M70q Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-10400T', N'SSD', N'500 GB', 
    N'32 GB', NULL,
    N'SVRROYALTON',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV MUL SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 105: ROYALTON RIV MUL CAJA1
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01Q1Z2', N'NEO 50q Gen4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'512 GB', 
    N'16 GB', NULL,
    N'ROYSIPATCJ1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV MUL CAJA1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 106: ROYALTON RIV MUL CAJA2
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEH7', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-6400', N'HDD', N'500 GB', 
    N'16 GB', N'DDR3',
    N'SIPATRONCAJA2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV MUL CAJA2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 107: ROYALTON RIV MUL CAJA3 PIER27
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JGHLQP2', N'DELL OPTIPLEX 7050 MINI', 
    N'Windows 11', N'Windows 11', 
    N'i5-7500T', N'NVMe', N'480 GB', 
    N'16 GB', NULL,
    N'ROYPIERCJ3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV MUL CAJA3 PIER27', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 108: ROYALTON RIV MUL CAJA 5 PIER27
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'DRS8ND4', N'DELL PRO MICRO QCM1250', 
    N'Windows 11', N'Windows 11', 
    N'i5-14500T', N'NVMe', N'480 GB', 
    N'16 GB', NULL,
    N'POS-MX25-RYT01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV MUL CAJA 5 PIER27', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 109: ROYALTON RIV MUL CAJA4 AMIANI
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03XMTQ', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-6400', N'SSD', N'120 GB', 
    N'16 GB', N'DDR3',
    N'RoyAmianiCaja4',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV MUL CAJA4 AMIANI', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 110: ROYALTON RIV JOY CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEH4', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-6400', N'SSD', N'500 GB', 
    N'24 GB', N'DDR3',
    N'RIVROYRIVJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 111: ROYALTON RIV PLAYA PIER27  SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 41;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VP9Z', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'SSD', N'500 GB', 
    N'16 GB', N'DDR3',
    N'SVRROYPY',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIV PLAYA PIER27  SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 112: ROYALTON SPLASH RIV BOARDWALK SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'HM5S5S3', N'DELL OptiPlex 7000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'SVRRYTSPL',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIV BOARDWALK SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 113: ROYALTON SPLASH RIV BOARDWALK CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'1R5S5S3', N'DELL OptiPlex 7000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'RIVROYSPLM01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIV BOARDWALK CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 114: ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01YBZ6', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVROYSPLMC3',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 115: ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 21;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ02T0DG', N'LENOVO M83 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'i5-4460', N'SSD', N'240 GB', 
    N'16 GB', N'DDR3',
    N'RIVROYSPLR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 116: ROYALTON SPLASH RIV JOYERIA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01VMLA', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'I5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVROYSPLJ01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIV JOYERIA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 117: ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 15;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'CN5S5S4', N'DELL OptiPlex 7000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'SVRRYTSPLCZ',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 118: ROYALTON SPLASH RIVIERA EL CORAZON CJ1
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 15;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'98DYRT3', N'DELL OptiPlex 3000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'8 GB', NULL,
    N'ROYCORAZONCJ1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIVIERA EL CORAZON CJ1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 119: ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 42;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'2Q5S5S3', N'DELL OptiPlex 7000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVRRYTSPL27',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 120: HARDROCK HACIENDAS PIER27 SERVIDORx
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 43;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0FF9F2', N'LENOVO M70q Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-10400T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'RHPSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HACIENDAS PIER27 SERVIDORx', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 121: HARDROCK HACIENDAS PIER27 CAJA 1x
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 43;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'DCNMHK2', N'DELL OptiPlex 7050 Micro', 
    N'Windows 10', N'Windows 10', 
    N'I5-7500T', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'RIVHRDHDATC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HACIENDAS PIER27 CAJA 1x', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 122: HARDROCK HACIENDAS PIER27 CAJA 2x
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 43;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'7TYK8X2', N'DELL OptiPlex 7060 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-8500T', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'RIVHRDHDATC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HACIENDAS PIER27 CAJA 2x', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 123: HARDROCK HACIENDAS MARINI
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 43;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0HNWV8', N'LENOVO M70q Gen 2', 
    N'Windows 11', N'Windows 11', 
    N'I5-11400T', N'SSD', N'500 GB', 
    N'16 GB', NULL,
    N'RIVHRDHDAJC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HACIENDAS MARINI', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 124: HARDROCK HACIENDAS AMIANI SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 43;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0FF9EL', N'LENOVO M70q Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-10400T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RHASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HACIENDAS AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 125: HARDROCK HEAVEN JOYERIA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 44;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEGL', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'HDD', N'500 GB', 
    N'8 GB', NULL,
    N'RRASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HEAVEN JOYERIA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 126: HARDROCK HEAVEN AMIANI CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 44;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'67DPRT3', N'DELL OptiPlex 3000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'RIVHARDHEAAC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HEAVEN AMIANI CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 127: HARDROCK HEAVEN PIER27 SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 44;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'4J20GT3', N'LENOVO OptiPlex 3000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RRPSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HEAVEN PIER27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 128: HARDROCK HEAVEN PIER27 CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 44;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'FF20GT3', N'DELL OptiPlex 3000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'RIVHRDHEAPC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HEAVEN PIER27 CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 129: HARDROCK HEAVEN PIER27 CAJA 2
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 44;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'JQZXRT3', N'DELL OptiPlex 3000 Micro', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'250 GB', 
    N'16 GB', NULL,
    N'RIVHRDHEAPC2',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HARDROCK HEAVEN PIER27 CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 130: UNICO SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 45;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ0FF9H1', N'LENOVO M70q Desktop', 
    N'Windows 11', N'Windows 11', 
    N'I5-10400T', N'SSD', N'250 GB', 
    N'16 GB', NULL,
    N'UNICOSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'UNICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 131: UNICO CAJA 1
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 45;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'MJ03VEJ7', N'LENOVO M800 Desktop', 
    N'Windows 10', N'Windows 10', 
    N'I5-6400', N'SSD', N'120 GB', 
    N'8 GB', NULL,
    N'RIVUNICOMC1',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'UNICO CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 132: UNICO JOY
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 45;
SET @DepartID = 5;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'1T856Q2', N'DELL Vostro 3470', 
    N'Windows 10', N'Windows 10', 
    N'I5-8400', N'HDD', N'1 TB', 
    N'8 GB', NULL,
    N'JOYUNICO',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'UNICO JOY', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 133: UNICO PIER27 VIVA MEXICO SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 45;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01J6Q5', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVUNIVMEPSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'UNICO PIER27 VIVA MEXICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 134: SIRENIS MULTI SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 46;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01HF9S', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVSIRENIMSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SIRENIS MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 135: SIRENIS MULTI CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 46;
SET @DepartID = 4;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01J6MK', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVSIRENIMC01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SIRENIS MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 136: SIRENIS TDA DE PLAYA SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 46;
SET @DepartID = 8;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01HFFV', N'LENOVO Neo 50q Gen 3', 
    N'Windows 10', N'Windows 10', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVSIRENIPSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SIRENIS TDA DE PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 137: SIRENIS CARRETA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 46;
SET @DepartID = 14;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01MADE', N'LENOVO Neo 50q Gen 4', 
    NULL, NULL, 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVSIRENIPC02',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SIRENIS CARRETA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 138: PALMAR BEACH PIER27
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 47;
SET @DepartID = 3;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'5PJ7Z24', N'DELL OptiPlex Micro 7010', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVPALBEAPSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALMAR BEACH PIER27', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 139: PALMAR BEACH AMIANI
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 47;
SET @DepartID = 2;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'6XM7Z24', N'DELL OptiPlex Micro 7010', 
    N'Windows 11', N'Windows 11', 
    N'I5-12500T', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVPALBEAASVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PALMAR BEACH AMIANI', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 140: SIRENIS VIVA MEXICO SERVIDOR
SET @ProductTypeID = 2;
SET @CompanyID = 9;
SET @SiteID = 46;
SET @DepartID = 23;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01HF8T', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVSIRENIVSVR',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SIRENIS VIVA MEXICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SRV' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 141: SIRENIS VIVA MEXICO CAJA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 46;
SET @DepartID = 12;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01PALW', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'RIVSIRENIVC01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'SIRENIS VIVA MEXICO CAJA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Registro 142: PARAISO LA BONITA
SET @ProductTypeID = 1;
SET @CompanyID = 9;
SET @SiteID = 48;
SET @DepartID = 1;
INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'YJ01ZKFG', N'LENOVO Neo 50q Gen 4', 
    N'Windows 11', N'Windows 11', 
    N'i5-13420H', N'NVMe', N'500 GB', 
    N'16 GB', NULL,
    N'SVR-MX25-PLB01',
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PARAISO LA BONITA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();
-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CPU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

GO

-- RESUMEN: 142 activos insertados
-- Servidores: 43
-- Computadoras: 99