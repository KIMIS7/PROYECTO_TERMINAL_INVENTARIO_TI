-- =============================================================================
--  DATOS DUMMY PARA VERIFICAR EL DASHBOARD DE INVENTARIO TI
-- -----------------------------------------------------------------------------
--  Genera ~120 activos repartidos en TODOS los estados, varias sedes,
--  tipos de producto, vendors, garantías (vigentes / por vencer / vencidas)
--  y fechas de adquisición (recientes y obsoletos > 4 años),
--  más historial de movimientos en los últimos 6 meses
--  (CREATE / REASIGNACION / UPDATE / BAJA) y AssetOwnershipHistory.
--
--  Todos los registros llevan el prefijo  [DUMMY]  para poder borrarlos
--  fácilmente al final con la sección "ROLLBACK / LIMPIEZA".
--
--  USO:
--      1. Abrir SSMS / Azure Data Studio conectado a InventarioIT
--      2. Pegar TODO este archivo y ejecutar
--      3. Refrescar el dashboard
--
--  COMPATIBLE CON: SQL Server (sintaxis T-SQL)
-- =============================================================================
USE InventarioIT;
GO

SET NOCOUNT ON;
PRINT '>>> Iniciando seed de datos dummy para el dashboard...';
GO

-- =============================================================================
-- 1) CATÁLOGOS BÁSICOS (idempotente: sólo inserta si no existen)
-- =============================================================================

-- Estados que dibuja el dashboard (donut + KPIs)
IF NOT EXISTS (SELECT 1 FROM dbo.AssetState WHERE Name = N'Asignado')
    INSERT INTO dbo.AssetState (Name) VALUES (N'Asignado');
IF NOT EXISTS (SELECT 1 FROM dbo.AssetState WHERE Name = N'Stock')
    INSERT INTO dbo.AssetState (Name) VALUES (N'Stock');
IF NOT EXISTS (SELECT 1 FROM dbo.AssetState WHERE Name = N'Mantenimiento')
    INSERT INTO dbo.AssetState (Name) VALUES (N'Mantenimiento');
IF NOT EXISTS (SELECT 1 FROM dbo.AssetState WHERE Name = N'Resguardo')
    INSERT INTO dbo.AssetState (Name) VALUES (N'Resguardo');
IF NOT EXISTS (SELECT 1 FROM dbo.AssetState WHERE Name = N'Baja')
    INSERT INTO dbo.AssetState (Name) VALUES (N'Baja');

-- Vendors
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'Dell')      INSERT INTO dbo.Vendor (Name) VALUES (N'Dell');
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'HP')        INSERT INTO dbo.Vendor (Name) VALUES (N'HP');
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'Lenovo')    INSERT INTO dbo.Vendor (Name) VALUES (N'Lenovo');
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'Apple')     INSERT INTO dbo.Vendor (Name) VALUES (N'Apple');
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'Cisco')     INSERT INTO dbo.Vendor (Name) VALUES (N'Cisco');
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'Epson')     INSERT INTO dbo.Vendor (Name) VALUES (N'Epson');
IF NOT EXISTS (SELECT 1 FROM dbo.Vendor WHERE Name = N'Logitech')  INSERT INTO dbo.Vendor (Name) VALUES (N'Logitech');

-- Tipos de producto (con Group, que se usa como filtro del dashboard)
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Laptop')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Laptop',     N'Equipo de cómputo', N'Hardware',   N'Portátil');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Desktop')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Desktop',    N'Equipo de cómputo', N'Hardware',   N'Escritorio');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Servidor')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Servidor',   N'Equipo de cómputo', N'Hardware',   N'Server');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Monitor')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Monitor',    N'Periférico',        N'Hardware',   N'Pantalla');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Impresora')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Impresora',  N'Periférico',        N'Hardware',   N'Impresión');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Switch')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Switch',     N'Red',               N'Networking', N'Switch');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Router')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Router',     N'Red',               N'Networking', N'Router');
IF NOT EXISTS (SELECT 1 FROM dbo.ProductType WHERE Name = N'Teléfono IP')
    INSERT INTO dbo.ProductType (Name, Category, [Group], SubCategory) VALUES (N'Teléfono IP',N'Red',               N'Networking', N'VoIP');

-- Company / Site / Depart / User mínimos para FK (sólo si la BD viene vacía)
IF NOT EXISTS (SELECT 1 FROM dbo.Company WHERE Description = N'[DUMMY] Demo Corp')
    INSERT INTO dbo.Company (Description) VALUES (N'[DUMMY] Demo Corp');

DECLARE @DummyCompanyID INT = (SELECT TOP 1 CompanyID FROM dbo.Company WHERE Description = N'[DUMMY] Demo Corp');

-- 6 sedes para que el dashboard tenga "sitio principal" + "Otras sedes"
IF NOT EXISTS (SELECT 1 FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Cancún')
    INSERT INTO dbo.Site (Name, CompanyID) VALUES (N'[DUMMY] Hotel Cancún',     @DummyCompanyID);
IF NOT EXISTS (SELECT 1 FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Playa del Carmen')
    INSERT INTO dbo.Site (Name, CompanyID) VALUES (N'[DUMMY] Hotel Playa del Carmen', @DummyCompanyID);
IF NOT EXISTS (SELECT 1 FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Tulum')
    INSERT INTO dbo.Site (Name, CompanyID) VALUES (N'[DUMMY] Hotel Tulum',      @DummyCompanyID);
IF NOT EXISTS (SELECT 1 FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Cozumel')
    INSERT INTO dbo.Site (Name, CompanyID) VALUES (N'[DUMMY] Hotel Cozumel',    @DummyCompanyID);
IF NOT EXISTS (SELECT 1 FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Mérida')
    INSERT INTO dbo.Site (Name, CompanyID) VALUES (N'[DUMMY] Hotel Mérida',     @DummyCompanyID);
IF NOT EXISTS (SELECT 1 FROM dbo.Site WHERE Name = N'[DUMMY] Hotel CDMX')
    INSERT INTO dbo.Site (Name, CompanyID) VALUES (N'[DUMMY] Hotel CDMX',       @DummyCompanyID);

-- Departamentos
IF NOT EXISTS (SELECT 1 FROM dbo.Depart WHERE Name = N'[DUMMY] Sistemas')      INSERT INTO dbo.Depart (Name) VALUES (N'[DUMMY] Sistemas');
IF NOT EXISTS (SELECT 1 FROM dbo.Depart WHERE Name = N'[DUMMY] Recepción')     INSERT INTO dbo.Depart (Name) VALUES (N'[DUMMY] Recepción');
IF NOT EXISTS (SELECT 1 FROM dbo.Depart WHERE Name = N'[DUMMY] Administración')INSERT INTO dbo.Depart (Name) VALUES (N'[DUMMY] Administración');
IF NOT EXISTS (SELECT 1 FROM dbo.Depart WHERE Name = N'[DUMMY] Almacén')       INSERT INTO dbo.Depart (Name) VALUES (N'[DUMMY] Almacén');

-- Rol mínimo
IF NOT EXISTS (SELECT 1 FROM dbo.rol WHERE name = N'Admin')
    INSERT INTO dbo.rol (name, isActive) VALUES (N'Admin', 1);

DECLARE @DummyRolID    INT = (SELECT TOP 1 rolID    FROM dbo.rol            WHERE name = N'Admin');
DECLARE @DummyDepartID INT = (SELECT TOP 1 DepartID FROM dbo.Depart         WHERE Name = N'[DUMMY] Sistemas');
DECLARE @DummySiteID   INT = (SELECT TOP 1 SiteID   FROM dbo.Site           WHERE Name = N'[DUMMY] Hotel Cancún');

-- Usuarios (4) — necesarios para AssetDetail.LastUpdateBy y para "Asignado"
IF NOT EXISTS (SELECT 1 FROM dbo.[User] WHERE Email = N'dummy.juan@demo.com')
    INSERT INTO dbo.[User] (Email, FirstName, LastName, Name, rolD, isActive, createdAt, DepartmentID, SiteID)
    VALUES (N'dummy.juan@demo.com',  N'Juan',  N'Pérez',    N'[DUMMY] Juan Pérez',    @DummyRolID, 1, GETDATE(), @DummyDepartID, @DummySiteID);
IF NOT EXISTS (SELECT 1 FROM dbo.[User] WHERE Email = N'dummy.maria@demo.com')
    INSERT INTO dbo.[User] (Email, FirstName, LastName, Name, rolD, isActive, createdAt, DepartmentID, SiteID)
    VALUES (N'dummy.maria@demo.com', N'María', N'González', N'[DUMMY] María González', @DummyRolID, 1, GETDATE(), @DummyDepartID, @DummySiteID);
IF NOT EXISTS (SELECT 1 FROM dbo.[User] WHERE Email = N'dummy.carlos@demo.com')
    INSERT INTO dbo.[User] (Email, FirstName, LastName, Name, rolD, isActive, createdAt, DepartmentID, SiteID)
    VALUES (N'dummy.carlos@demo.com',N'Carlos',N'Ramírez',  N'[DUMMY] Carlos Ramírez', @DummyRolID, 1, GETDATE(), @DummyDepartID, @DummySiteID);
IF NOT EXISTS (SELECT 1 FROM dbo.[User] WHERE Email = N'dummy.ana@demo.com')
    INSERT INTO dbo.[User] (Email, FirstName, LastName, Name, rolD, isActive, createdAt, DepartmentID, SiteID)
    VALUES (N'dummy.ana@demo.com',   N'Ana',   N'López',    N'[DUMMY] Ana López',     @DummyRolID, 1, GETDATE(), @DummyDepartID, @DummySiteID);
GO


-- =============================================================================
-- 2) RESOLVER IDs A USAR EN EL SEED MASIVO
-- =============================================================================
DECLARE @StateAsignado     INT = (SELECT AssetStateID FROM dbo.AssetState WHERE Name = N'Asignado');
DECLARE @StateStock        INT = (SELECT AssetStateID FROM dbo.AssetState WHERE Name = N'Stock');
DECLARE @StateMantenimiento INT = (SELECT AssetStateID FROM dbo.AssetState WHERE Name = N'Mantenimiento');
DECLARE @StateResguardo    INT = (SELECT AssetStateID FROM dbo.AssetState WHERE Name = N'Resguardo');
DECLARE @StateBaja         INT = (SELECT AssetStateID FROM dbo.AssetState WHERE Name = N'Baja');

DECLARE @VDell    INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'Dell');
DECLARE @VHP      INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'HP');
DECLARE @VLenovo  INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'Lenovo');
DECLARE @VApple   INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'Apple');
DECLARE @VCisco   INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'Cisco');
DECLARE @VEpson   INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'Epson');
DECLARE @VLogi    INT = (SELECT VendorID FROM dbo.Vendor WHERE Name = N'Logitech');

DECLARE @PTLaptop  INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Laptop');
DECLARE @PTDesktop INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Desktop');
DECLARE @PTServer  INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Servidor');
DECLARE @PTMonitor INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Monitor');
DECLARE @PTPrinter INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Impresora');
DECLARE @PTSwitch  INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Switch');
DECLARE @PTRouter  INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Router');
DECLARE @PTPhone   INT = (SELECT ProductTypeID FROM dbo.ProductType WHERE Name = N'Teléfono IP');

DECLARE @SCancun  INT = (SELECT SiteID FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Cancún');
DECLARE @SPlaya   INT = (SELECT SiteID FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Playa del Carmen');
DECLARE @STulum   INT = (SELECT SiteID FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Tulum');
DECLARE @SCozumel INT = (SELECT SiteID FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Cozumel');
DECLARE @SMerida  INT = (SELECT SiteID FROM dbo.Site WHERE Name = N'[DUMMY] Hotel Mérida');
DECLARE @SCdmx    INT = (SELECT SiteID FROM dbo.Site WHERE Name = N'[DUMMY] Hotel CDMX');

DECLARE @CompID   INT = (SELECT CompanyID FROM dbo.Company WHERE Description = N'[DUMMY] Demo Corp');
DECLARE @DepSis   INT = (SELECT DepartID  FROM dbo.Depart  WHERE Name = N'[DUMMY] Sistemas');
DECLARE @DepRec   INT = (SELECT DepartID  FROM dbo.Depart  WHERE Name = N'[DUMMY] Recepción');
DECLARE @DepAdm   INT = (SELECT DepartID  FROM dbo.Depart  WHERE Name = N'[DUMMY] Administración');
DECLARE @DepAlm   INT = (SELECT DepartID  FROM dbo.Depart  WHERE Name = N'[DUMMY] Almacén');

DECLARE @U1 INT = (SELECT UserID FROM dbo.[User] WHERE Email = N'dummy.juan@demo.com');
DECLARE @U2 INT = (SELECT UserID FROM dbo.[User] WHERE Email = N'dummy.maria@demo.com');
DECLARE @U3 INT = (SELECT UserID FROM dbo.[User] WHERE Email = N'dummy.carlos@demo.com');
DECLARE @U4 INT = (SELECT UserID FROM dbo.[User] WHERE Email = N'dummy.ana@demo.com');

-- =============================================================================
-- 3) SEED MASIVO DE ASSETS + ASSETDETAIL + HISTORY
--     Recorremos un loop generando ~120 activos con variación controlada
--     para que el dashboard muestre TODOS sus paneles con datos.
-- =============================================================================
DECLARE @i INT = 1;
DECLARE @TOTAL INT = 120;
DECLARE @Today DATETIME = GETDATE();

WHILE @i <= @TOTAL
BEGIN
    -- ---- Selección rotativa de catálogos para cubrir todas las combinaciones
    DECLARE @StateID INT;
    DECLARE @UserID  INT;
    DECLARE @PTID    INT;
    DECLARE @PTName  NVARCHAR(50);
    DECLARE @VID     INT;
    DECLARE @SID     INT;
    DECLARE @DID     INT;

    -- Estados: 55% Asignado, 15% Stock, 10% Mantenimiento, 10% Resguardo, 10% Baja
    SET @StateID = CASE
        WHEN @i % 20 IN (0,1)         THEN @StateBaja          -- 10%
        WHEN @i % 20 IN (2,3)         THEN @StateResguardo     -- 10%
        WHEN @i % 20 IN (4,5)         THEN @StateMantenimiento -- 10%
        WHEN @i % 20 IN (6,7,8)       THEN @StateStock         -- 15%
        ELSE @StateAsignado                                    -- ~55%
    END;

    -- UserID sólo si está "Asignado", para que utilizationRate cuadre
    SET @UserID = CASE WHEN @StateID = @StateAsignado
                       THEN CASE @i % 4 WHEN 0 THEN @U1 WHEN 1 THEN @U2 WHEN 2 THEN @U3 ELSE @U4 END
                       ELSE NULL END;

    -- Tipo de producto (rota por 8 categorías → llena "Antigüedad por tipo")
    SET @PTID = CASE @i % 8
        WHEN 0 THEN @PTLaptop  WHEN 1 THEN @PTDesktop WHEN 2 THEN @PTServer  WHEN 3 THEN @PTMonitor
        WHEN 4 THEN @PTPrinter WHEN 5 THEN @PTSwitch  WHEN 6 THEN @PTRouter  ELSE @PTPhone
    END;
    SET @PTName = CASE @i % 8
        WHEN 0 THEN N'Laptop'  WHEN 1 THEN N'Desktop' WHEN 2 THEN N'Servidor' WHEN 3 THEN N'Monitor'
        WHEN 4 THEN N'Impresora' WHEN 5 THEN N'Switch'  WHEN 6 THEN N'Router'   ELSE N'Teléfono IP'
    END;

    SET @VID = CASE @i % 7
        WHEN 0 THEN @VDell WHEN 1 THEN @VHP    WHEN 2 THEN @VLenovo WHEN 3 THEN @VApple
        WHEN 4 THEN @VCisco WHEN 5 THEN @VEpson ELSE @VLogi
    END;

    -- Sites: distribución desigual para que se vea "Top 5 + Otras sedes"
    SET @SID = CASE
        WHEN @i % 10 IN (0,1,2,3) THEN @SCancun  -- 40%
        WHEN @i % 10 IN (4,5)     THEN @SPlaya   -- 20%
        WHEN @i % 10 = 6          THEN @STulum   -- 10%
        WHEN @i % 10 = 7          THEN @SCozumel -- 10%
        WHEN @i % 10 = 8          THEN @SMerida  -- 10%
        ELSE @SCdmx                              -- 10%
    END;

    SET @DID = CASE @i % 4 WHEN 0 THEN @DepSis WHEN 1 THEN @DepRec WHEN 2 THEN @DepAdm ELSE @DepAlm END;

    -- ---- Fechas: combinación que ejercita TODAS las métricas
    -- AcqDate:  35% obsoletos (>4 años), 25% 2-4 años, 40% recientes
    DECLARE @AcqDate DATE = CASE
        WHEN @i % 20 IN (0,1,2,3,4,5,6)   THEN DATEADD(MONTH, -(@i % 12) - 50, @Today) -- ~5 años
        WHEN @i % 20 IN (7,8,9,10,11)     THEN DATEADD(MONTH, -(@i % 12) - 30, @Today) -- ~3 años
        ELSE DATEADD(MONTH, -(@i % 18), @Today)                                        -- 0-18 meses
    END;

    -- WarrantyExpiry: variedad para alertas (0-30, 30-90 días, 3-6m, 6-12m, vigente largo, vencida)
    DECLARE @WarExp DATE = CASE @i % 12
        WHEN 0  THEN DATEADD(DAY,  15, @Today)       -- urgente <30
        WHEN 1  THEN DATEADD(DAY,  25, @Today)       -- urgente <30
        WHEN 2  THEN DATEADD(DAY,  60, @Today)       -- 30-90
        WHEN 3  THEN DATEADD(DAY,  80, @Today)       -- 30-90
        WHEN 4  THEN DATEADD(DAY, 120, @Today)       -- 3-6m
        WHEN 5  THEN DATEADD(DAY, 200, @Today)       -- 6-12m
        WHEN 6  THEN DATEADD(YEAR,  2, @Today)       -- vigente larga
        WHEN 7  THEN DATEADD(DAY, -30, @Today)       -- vencida
        WHEN 8  THEN DATEADD(DAY,-365, @Today)       -- muy vencida
        WHEN 9  THEN NULL                            -- sin garantía registrada
        WHEN 10 THEN DATEADD(DAY, 350, @Today)       -- 6-12m
        ELSE        DATEADD(DAY,  45, @Today)        -- 30-90
    END;

    -- ---- Insertar AssetDetail
    DECLARE @DetailID INT;
    INSERT INTO dbo.AssetDetail
        (ProductManuf, SerialNum, AssetTAG, AssetACQDate, WarrantyExpiryDate,
         CreatedTime, LastUpdateTime, LastUpdateBy, RAM, OperatingSystem, Model, Barcode)
    VALUES
        (@PTName,
         CONCAT(N'DUMMY-SN-', RIGHT('0000' + CAST(@i AS NVARCHAR(10)), 4)),
         CONCAT(N'DUMMY-TAG-', RIGHT('0000' + CAST(@i AS NVARCHAR(10)), 4)),
         @AcqDate, @WarExp,
         @Today, @Today, @U1,
         CASE @i % 3 WHEN 0 THEN N'8GB' WHEN 1 THEN N'16GB' ELSE N'32GB' END,
         CASE @i % 3 WHEN 0 THEN N'Windows 11' WHEN 1 THEN N'Windows 10' ELSE N'Ubuntu 22.04' END,
         CONCAT(@PTName, N' Model-', @i),
         CONCAT(N'BC', RIGHT('00000' + CAST(@i AS NVARCHAR(10)), 5))
        );
    SET @DetailID = SCOPE_IDENTITY();

    -- ---- Insertar Asset
    DECLARE @AssetID INT;
    INSERT INTO dbo.Asset
        (Name, VendorID, ProductTypeID, AssetState, CompanyID, SiteID, UserID,
         ParentAssetID, DepartID, AssetDetailID)
    VALUES
        (CONCAT(N'[DUMMY] ', @PTName, N' #', @i),
         @VID, @PTID, @StateID, @CompID, @SID, @UserID,
         NULL, @DID, @DetailID);
    SET @AssetID = SCOPE_IDENTITY();

    -- ---- Historial: SIEMPRE un CREATE en los últimos 6 meses
    DECLARE @CreateDate DATETIME = DATEADD(DAY, -((@i * 3) % 180), @Today);
    INSERT INTO dbo.AssetHistory (AssetID, Operation, Description, CreatedTime)
    VALUES (@AssetID, N'CREATE', CONCAT(N'Alta de activo #', @i), @CreateDate);

    -- ~30% reciben además una REASIGNACION
    IF @i % 3 = 0
    BEGIN
        DECLARE @ReasigDate DATETIME = DATEADD(DAY, -((@i * 2) % 150), @Today);
        INSERT INTO dbo.AssetHistory (AssetID, Operation, Description, CreatedTime)
        VALUES (@AssetID, N'REASIGNACION',
                CONCAT(N'Reasignado al usuario #', (@i % 4) + 1), @ReasigDate);

        -- AssetOwnershipHistory para trazabilidad
        IF @UserID IS NOT NULL
            INSERT INTO dbo.AssetOwnershipHistory (UserID, AssetID, FromDate, ToDate)
            VALUES (@UserID, @AssetID,
                    CAST(DATEADD(DAY, -180, @Today) AS DATE),
                    CAST(@ReasigDate AS DATE));
    END

    -- ~20% reciben un UPDATE
    IF @i % 5 = 0
    BEGIN
        INSERT INTO dbo.AssetHistory (AssetID, Operation, Description, CreatedTime)
        VALUES (@AssetID, N'UPDATE', N'Actualización de detalles',
                DATEADD(DAY, -((@i + 7) % 120), @Today));
    END

    -- Si quedó dado de Baja, lo registramos en historial
    IF @StateID = @StateBaja
    BEGIN
        INSERT INTO dbo.AssetHistory (AssetID, Operation, Description, CreatedTime)
        VALUES (@AssetID, N'BAJA', N'Baja por obsolescencia',
                DATEADD(DAY, -((@i + 3) % 90), @Today));
    END

    -- Forzar varios CREATE en el mes actual (para "+N este mes")
    IF @i <= 8
    BEGIN
        INSERT INTO dbo.AssetHistory (AssetID, Operation, Description, CreatedTime)
        VALUES (@AssetID, N'CREATE', N'Alta del mes en curso',
                DATEADD(DAY, -(@i % 25), @Today));
    END

    SET @i += 1;
END
GO


-- =============================================================================
-- 4) VERIFICACIÓN — los conteos deberían reflejarse en el dashboard
-- =============================================================================
PRINT '';
PRINT '>>> Resumen de datos dummy insertados:';
SELECT N'Assets [DUMMY]'        AS Tabla, COUNT(*) AS Total FROM dbo.Asset         WHERE Name LIKE N'[[]DUMMY]%'
UNION ALL SELECT N'AssetDetail',          COUNT(*)          FROM dbo.AssetDetail   WHERE SerialNum LIKE N'DUMMY-SN-%'
UNION ALL SELECT N'AssetHistory',         COUNT(*)          FROM dbo.AssetHistory  WHERE AssetID IN (SELECT AssetID FROM dbo.Asset WHERE Name LIKE N'[[]DUMMY]%')
UNION ALL SELECT N'AssetOwnershipHistory',COUNT(*)          FROM dbo.AssetOwnershipHistory WHERE AssetID IN (SELECT AssetID FROM dbo.Asset WHERE Name LIKE N'[[]DUMMY]%')
UNION ALL SELECT N'Sites [DUMMY]',        COUNT(*)          FROM dbo.Site          WHERE Name LIKE N'[[]DUMMY]%'
UNION ALL SELECT N'Users [DUMMY]',        COUNT(*)          FROM dbo.[User]        WHERE Email LIKE N'dummy.%@demo.com';

PRINT '';
PRINT '>>> Distribución por estado (donut del dashboard):';
SELECT s.Name AS Estado, COUNT(*) AS Cantidad
FROM dbo.Asset a
JOIN dbo.AssetState s ON s.AssetStateID = a.AssetState
WHERE a.Name LIKE N'[[]DUMMY]%'
GROUP BY s.Name
ORDER BY Cantidad DESC;

PRINT '';
PRINT '>>> Distribución por sede:';
SELECT st.Name AS Sede, COUNT(*) AS Cantidad
FROM dbo.Asset a
JOIN dbo.Site st ON st.SiteID = a.SiteID
WHERE a.Name LIKE N'[[]DUMMY]%'
GROUP BY st.Name
ORDER BY Cantidad DESC;

PRINT '';
PRINT '>>> Listo. Refresca el dashboard.';
GO


-- =============================================================================
-- 5) ROLLBACK / LIMPIEZA  (descomenta y ejecuta si quieres borrar todo lo dummy)
-- -----------------------------------------------------------------------------
/*
USE InventarioIT;
GO
BEGIN TRAN;

DELETE FROM dbo.AssetOwnershipHistory
WHERE AssetID IN (SELECT AssetID FROM dbo.Asset WHERE Name LIKE N'[[]DUMMY]%');

DELETE FROM dbo.AssetHistory
WHERE AssetID IN (SELECT AssetID FROM dbo.Asset WHERE Name LIKE N'[[]DUMMY]%');

DELETE a
FROM dbo.Asset a
WHERE a.Name LIKE N'[[]DUMMY]%';

DELETE FROM dbo.AssetDetail WHERE SerialNum LIKE N'DUMMY-SN-%';
DELETE FROM dbo.[User]      WHERE Email     LIKE N'dummy.%@demo.com';
DELETE FROM dbo.Site        WHERE Name      LIKE N'[[]DUMMY]%';
DELETE FROM dbo.Depart      WHERE Name      LIKE N'[[]DUMMY]%';
DELETE FROM dbo.Company     WHERE Description = N'[DUMMY] Demo Corp';

COMMIT TRAN;
PRINT 'Datos dummy eliminados.';
*/
