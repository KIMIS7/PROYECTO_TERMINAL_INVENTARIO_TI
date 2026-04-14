-- ============================================================
-- ETL Resguardos - Generado: 2026-04-14 00:19:37
-- ============================================================
-- LÓGICA:
-- 1. Solo procesa grupos donde el CPU YA EXISTE en la BD
-- 2. Busca el CPU por SerialNumber → obtiene AssetID, SiteID, DepartID
-- 3. Inserta accesorios HEREDANDO ubicación del CPU padre
-- 4. DOMAIN = NULL para accesorios (solo se usa para equipos principales)
-- 5. CPUs que NO existen fueron exportados a Excel para revisión
-- ============================================================

USE InventarioIT;
GO

-- Variables globales
DECLARE @ETLUserID INT = 11;
DECLARE @VendorID INT = 1;
DECLARE @NewDetailID INT;
DECLARE @NewAssetID INT;
DECLARE @ParentAssetID INT;
DECLARE @ParentSiteID INT;
DECLARE @ParentDepartID INT;
DECLARE @ParentCompanyID INT;
DECLARE @AssetTAG NVARCHAR(20);
DECLARE @ProductTypeID INT;
DECLARE @AssetStateID INT;
DECLARE @SiteID INT;
DECLARE @CompanyID INT;
DECLARE @DepartID INT;

-- ============================================================
-- GRUPO: PRINCESS SUNSET / CAJA 1
-- CPU: 6915JL2 (YA EXISTE EN BD)
-- Accesorios a insertar: 9
-- ============================================================

-- Obtener datos del CPU padre (Serial: 6915JL2)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'6915JL2';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: CAJON DE DINERO (Serial: 500D010153867)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'500D010153867', N'EC-CD-50M',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER (Serial: 6820450782)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Honeywell', N'6820450782', N'MS3580',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: 85322110050787206)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'3nStar', N'85322110050787206', N'RPT006',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE (Serial: 2428HS025B68)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LOGITECH', N'2428HS025B68', N'MU0026',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 MOUSE', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MULTIPUERTOS USB (Serial: HUB-2025009)
SET @ProductTypeID = 14;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    NULL, N'HUB-2025009', NULL,
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 MULTIPUERTOS USB', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'HUB' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 4B1604P18601)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'APC', N'4B1604P18601', N'BE750G',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: SWITCH (Serial: 2211532008613)
SET @ProductTypeID = 11;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'TP-LINK', N'2211532008613', N'TLSG1008D',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 SWITCH', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SWI' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 2437MRR1WWL8)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LOGITECH', N'2437MRR1WWL8', N'YU0042',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: QVFN3HA053593)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'AOC', N'QVFN3HA053593', N'20E1H',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 1 MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: PRINCESS SUNSET / CAJA 2
-- CPU: 171F8R2 (YA EXISTE EN BD)
-- Accesorios a insertar: 7
-- ============================================================

-- Obtener datos del CPU padre (Serial: 171F8R2)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'171F8R2';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: CAJON DE DINERO (Serial: 500D010159284)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'500D010159284', N'EC-CD-50M',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER (Serial: 6821150654)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Honeywell', N'6821150654', N'MS3580',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: 8532110050814409)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'3nStar', N'8532110050814409', N'RPT008',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE (Serial: 4CLA7Y0)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'4CLA7Y0', N'EMS537A',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 MOUSE', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 220132505127)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Forza', N'220132505127', N'NT-1011',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 4CEDATH)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'4CEDATH', N'SK8825',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: PYGM1HA018286)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'AOC', N'PYGM1HA018286', N'20E1H',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET CAJA 2 MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: PRINCESS SUNSET / SERVIDOR
-- CPU: YJ01ZK08 (YA EXISTE EN BD)
-- Accesorios a insertar: 8
-- ============================================================

-- Obtener datos del CPU padre (Serial: YJ01ZK08)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'YJ01ZK08';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: ESCANER (Serial: 14079010500126)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Motorola', N'14079010500126', N'Ds9208',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: LECTOR DE HUELLA (Serial: D100E015190)
SET @ProductTypeID = 12;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HID', N'D100E015190', N'4500 FINGERPRINT',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR LECTOR DE HUELLA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'HUE' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE (Serial: CN09NK27382675M0W8K)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'CN09NK27382675M0W8K', N'MS116P',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR MOUSE', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MULTIPUERTOS USB (Serial: HUB-2025008)
SET @ProductTypeID = 14;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    NULL, N'HUB-2025008', NULL,
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR MULTIPUERTOS USB', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'HUB' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 201132502290)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Forza', N'201132502290', N'NT-1011',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: SWITCH (Serial: A330218101358)
SET @ProductTypeID = 11;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'PLANET', N'A330218101358', N'SW-804',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR SWITCH', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'SWI' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: CN0F2JV2LO3007BN0CK7A03)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DELL', N'CN0F2JV2LO3007BN0CK7A03', N'KB216t',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: G615HDPL)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'BENQ', N'G615HDPL', N'ET-0024-TA',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS SUNSET SERVIDOR MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: HYATT ZILARA MULTI / JOYERIA
-- CPU: YJ01TQRZ (YA EXISTE EN BD)
-- Accesorios a insertar: 9
-- ============================================================

-- Obtener datos del CPU padre (Serial: YJ01TQRZ)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'YJ01TQRZ';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: ESCANER (Serial: 6822210670)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HONEYWELL', N'6822210670', N'MS3580',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 44CA5B1)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'44CA5B1', N'EKB536A',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: MMLTYAA003637014264206)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ACER', N'MMLTYAA003637014264206', N'P166HQL',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP DOCUMENTOS (Serial: VNB3D43044)
SET @ProductTypeID = 9;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HP', N'VNB3D43044', N'LASERJET M111W',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA IMP DOCUMENTOS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IPD' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE (Serial: 44PC797)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'44PC797', N'MOEUUOA',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA MOUSE', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: LECTOR DE HUELLA (Serial: F400E028415)
SET @ProductTypeID = 12;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'DIGTALPERSONA', N'F400E028415', N'4500 FINGERPRINT',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA LECTOR DE HUELLA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'HUE' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: TC6Y227061)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'EPSON', N'TC6Y227061', N'TMT20II',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: CAJON DE DINERO (Serial: 50D010121026)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'50D010121026', N'ECCD50M',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 4B1704P07516)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'APC', N'4B1704P07516', N'BE750G',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'HYATT ZILARA MULTI JOYERIA NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: BEACH PALACE / CAJA 1
-- CPU: MJ03XGPE (YA EXISTE EN BD)
-- Accesorios a insertar: 7
-- ============================================================

-- Obtener datos del CPU padre (Serial: MJ03XGPE)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'MJ03XGPE';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: MONITOR (Serial: ETT8F02362019)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'BENQ', N'ETT8F02362019', N'SENSEYE 3',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 2207SC321SB8)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Logitech', N'2207SC321SB8', N'K120',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: MXDF353092)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Epson', N'MXDF353092', N'TM-T88V',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER (Serial: 1325900501031)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Motorola', N'1325900501031', N'DS9208',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP DOCUMENTOS (Serial: VND3N95635)
SET @ProductTypeID = 9;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HP', N'VND3N95635', N'Laserjet P1102w',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 IMP DOCUMENTOS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IPD' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: CAJON DE DINERO (Serial: 50D010143908)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'50D010143908', N'EC-50M',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 322203505243)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'Smartbitt', N'322203505243', N'SBNB800',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE CAJA 1 NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: BEACH PALACE / JOYERIA
-- CPU: MJ0360BT (YA EXISTE EN BD)
-- Accesorios a insertar: 8
-- ============================================================

-- Obtener datos del CPU padre (Serial: MJ0360BT)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'MJ0360BT';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: MONITOR (Serial: ET7AA00794SL0)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'BENQ', N'ET7AA00794SL0', N'SENSEYE 3',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 2252385)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'2252385', N'SK8825',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE (Serial: 1805HS03L348)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LOGITECH', N'1805HS03L348', N'M90',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA MOUSE', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: TC6Y246744)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'EPSON', N'TC6Y246744', N'TM-T20II',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER (Serial: 18159010506268)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'SYMBOL', N'18159010506268', N'DS9208',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: LECTOR DE HUELLA (Serial: 50013001104)
SET @ProductTypeID = 12;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HID', N'50013001104', N'4500 FINGERPRINT',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA LECTOR DE HUELLA', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'HUE' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: CAJON DE DINERO (Serial: DGA03JW54880)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'DGA03JW54880', N'EC-G5100-CII',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 4B1311B00320)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'APC', N'4B1311B00320', N'750',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'BEACH PALACE JOYERIA NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: ROYALTON RIVIERA MULTI / CAJA 3 PIER 27
-- CPU: JGHLQP2 (YA EXISTE EN BD)
-- Accesorios a insertar: 8
-- ============================================================

-- Obtener datos del CPU padre (Serial: JGHLQP2)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'JGHLQP2';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: DIGITALIZADOR (Serial: TS460HM10C29764)
SET @ProductTypeID = 13;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'TOPAZ', N'TS460HM10C29764', N'T-S460-HSB-R',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 DIGITALIZADOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'DIG' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER (Serial: 15260010504888)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'SYMBOL', N'15260010504888', N'DS9208',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: MXDF506169)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'EPSON', N'MXDF506169', N'TM-T88V',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE (Serial: 44KN912)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'44KN912', N'MOEUUOA',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 MOUSE', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 2503LOZ18PY8)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LOGITECH', N'2503LOZ18PY8', N'YU0036',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: PYGM1HA018472)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'AOC', N'PYGM1HA018472', N'20E1H',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: CAJON DE DINERO (Serial: 50D010164382)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'50D010164382', N'EC-CD-50M',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 241232507187)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'FORZA', N'241232507187', N'NT-1011',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 3 Pier 27 NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: ROYALTON RIVIERA MULTI / CAJA 4 AMIANI
-- CPU: MJ03XMTQ (YA EXISTE EN BD)
-- Accesorios a insertar: 7
-- ============================================================

-- Obtener datos del CPU padre (Serial: MJ03XMTQ)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'MJ03XMTQ';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: ESCANER (Serial: 22232B3E6E)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HONEYWELL', N'22232B3E6E', N'HF680',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 240732505951)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'FORZA', N'240732505951', N'NT-1011',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP TICKETS (Serial: 8532110050788210)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'3NSTAR', N'8532110050788210', N'RPT006',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani IMP TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: TECLADO (Serial: 8SSD51B37241AVLC2421JA0)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'8SSD51B37241AVLC2421JA0', N'SK-8823',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani TECLADO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: DIGITALIZADOR (Serial: TS460HM10C30200)
SET @ProductTypeID = 13;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'TOPAZ', N'TS460HM10C30200', N'T-S460-HSB-R',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani DIGITALIZADOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'DIG' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: ETF8E01338019)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'BENQ', N'ETF8E01338019', N'G615HDPL',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: CAJON DE DINERO (Serial: DGA03JW57367)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'ECLINE', N'DGA03JW57367', N'EC-G5100-II',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI CAJA 4 Amiani CAJON DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: ROYALTON RIVIERA MULTI / SERVIDOR
-- CPU: MJ0FF9F3 (YA EXISTE EN BD)
-- Accesorios a insertar: 6
-- ============================================================

-- Obtener datos del CPU padre (Serial: MJ0FF9F3)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'MJ0FF9F3';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: ESCANER (Serial: 22232B35E4)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HONEYWELL', N'22232B35E4', N'HF680',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI SERVIDOR ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: E2108063340)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'EPCOM', N'E2108063340', N'EPU850L',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI SERVIDOR NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: 63E2KAC6LAV90D4BPC)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LENOVO', N'63E2KAC6LAV90D4BPC', N'C22E-20',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI SERVIDOR MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMP DOCUMENTOS (Serial: K3A753232)
SET @ProductTypeID = 9;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'XEROX', N'K3A753232', N'PHASER 3020',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI SERVIDOR IMP DOCUMENTOS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IPD' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER (Serial: 6822210953)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'HONEYWELL', N'6822210953', N'MS3580-38',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI SERVIDOR ESCANER', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: HPDEB1A000853)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'AOC', N'HPDEB1A000853', N'E1670SWU',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'ROYALTON RIVIERA MULTI SERVIDOR MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- ============================================================
-- GRUPO: PRINCESS RIVIERA / CAJA 1
-- CPU: 3D7M9N2 (YA EXISTE EN BD)
-- Accesorios a insertar: 7
-- ============================================================

-- Obtener datos del CPU padre (Serial: 3D7M9N2)
SET @ParentAssetID = NULL;
SET @ParentSiteID = NULL;
SET @ParentDepartID = NULL;
SET @ParentCompanyID = NULL;

SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = N'3D7M9N2';

PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);

-- Accesorio: TECLADO ALAMBRICO (Serial: 2103SC314AH8)
SET @ProductTypeID = 5;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LOGITECH', N'2103SC314AH8', N'YU0036',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 TECLADO ALAMBRICO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'TEC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MOUSE ALAMBRICO (Serial: 2116HS00QBA8)
SET @ProductTypeID = 4;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LOGITECH', N'2116HS00QBA8', N'M90',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 MOUSE ALAMBRICO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MOU' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: ESCANER ALAMBRICO (Serial: M1K95C44C)
SET @ProductTypeID = 6;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'SYMBOL', N'M1K95C44C', N'LS9208',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 ESCANER ALAMBRICO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'ESC' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: IMPRESORA TICKETS (Serial: tc6y354194)
SET @ProductTypeID = 8;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'EPSON', N'tc6y354194', N'TM-T20II',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 IMPRESORA TICKETS', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'IMP' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: CAJÓN DE DINERO (Serial: 50d010150144)
SET @ProductTypeID = 10;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'EC Line', N'50d010150144', N'EC-CD-50M',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 CAJÓN DE DINERO', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'CAJ' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: MONITOR (Serial: 405ntabdx776)
SET @ProductTypeID = 3;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'LG', N'405ntabdx776', N'19M38H',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 MONITOR', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'MON' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

-- Accesorio: NO BREAK (Serial: 240732504881)
SET @ProductTypeID = 7;
SET @AssetStateID = 2;

-- Heredar ubicación del CPU padre
SET @CompanyID = @ParentCompanyID;
SET @SiteID = @ParentSiteID;
SET @DepartID = @ParentDepartID;

INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    N'FORZA', N'240732504881', N'NT-1011',
    NULL,
    GETDATE(), @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();

INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    N'PRINCESS RIVIERA CAJA 1 NO BREAK', @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);
SET @NewAssetID = SCOPE_IDENTITY();

-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    'UPS' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;

GO

-- ============================================================
-- RESUMEN
-- ============================================================
-- Grupos procesados (con CPU en BD): 10
-- Accesorios insertados: 76
-- 
-- NOTA: Los CPUs que NO existen en BD fueron exportados a Excel
-- Revisa el archivo Excel antes de insertarlos manualmente