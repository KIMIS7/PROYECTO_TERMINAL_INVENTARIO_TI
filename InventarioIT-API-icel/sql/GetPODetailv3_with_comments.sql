USE [InventarioIT]
GO

/****** Object:  StoredProcedure [cpo].[GetPODetailv3]    Script Date: 13/11/2025 10:50:51 a. m. ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [cpo].[GetPODetailv3]
    @PONum           int            = NULL, 
    @Proveedor       varchar(100)   = NULL,
    @SKu             varchar(50)    = NULL,
    @PartDescripción varchar(50)    = NULL,
    @Comprador       varchar(50)    = NULL,
    @Departamento    varchar(20)    = NULL,
    @Estatus         varchar(20)    = NULL,
    @Eta1            date           = NULL,
    @Eta2            date           = NULL,
    @Destino         varchar(8)     = NULL,
    @Company         varchar(8)     = NULL,
    @OrderDate       date           = NULL,
    @PageNumber      int            = NULL,
    @PageSize        int            = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#Base') IS NOT NULL DROP TABLE #Base;

    -- 1) Construir el conjunto base con RN (ANTES era un CTE; ahora lo materializamos)
    SELECT
        COUNT(*) OVER()                                         AS TotalRecords,
        POHeader.Company                                        AS Company,
        Company.Country                                         AS Destino,
        POHeader.OrderDate                                      AS Fecha,
        POHeader.PONum                                          AS PO,
        pg.Description                                          AS Departamento,
        ca.COLECCION,
        ca.Categoria,
        ca.Subcategoria,
        ca.Familia,
        ca.PORTAFOLIO,
        ca.CAPSULA,
        ca.MODELOHS,
        ca.Gema,
        ca.COLOR_MATERIAL,
        Vendor.Country                                          AS Origen,
        ''                                                      AS FOB,
        cPOD.ProgramacionAuditoria,
        cPOD.Estatus,
        p.PartNum,
        p.PartDescription,
        pa.Name                                                 AS Responsable,
        Vendor.Name                                             AS Proveedor,
        Vendor.vendorNum                                        AS vendorID,
        CASE WHEN POHeader.OpenOrder = 1 THEN 'Abierto' ELSE 'Cerrado' END AS EstatusEpicor,
        cPOH.Estatus                                            AS EstatusPO,
        POHeader.DueDate                                        AS DueDateInicial, 
        ISNULL(cPOD.DueDate, PODetail.DueDate)                  AS DueDateFinal,
        u.EstETADate_c                                          AS ETAInicial,
        ISNULL(cPOD.ETA, u.EstETADate_c)                        AS ETAFinal, 
        0                                                       AS Weak,
        cPOD.NumEmbarque                                        AS NumEmarque,
        cPOH.LastDateUpdated                                    AS UltimaModificacion,
        PODetail.Rpt1ExtCost                                    AS CostoUSD,
        0                                                       AS LandedCost,
        PODetail.Rpt1ExtCost + 0                                AS CostoFinal,
        ''                                                      AS Destino_ShipTo,
        cPOD.Habilitar,
        PODetail.SysRowID,
        PODetail.POLine                                         AS POline,
        -- Indicador de comentarios de línea
        CAST(CASE WHEN EXISTS (
            SELECT 1 
            FROM cpo.POLineComments plc 
            WHERE plc.Company = POHeader.Company 
              AND plc.PONum = POHeader.PONum 
              AND plc.POLine = PODetail.POLine
              AND plc.DeletedAtUtc IS NULL
        ) THEN 1 ELSE 0 END AS bit)                             AS HasLineComments,
        ROW_NUMBER() OVER (ORDER BY POHeader.OrderDate DESC, POHeader.PONum ASC) AS rn
    INTO #Base
    FROM E10Prod.Erp.POHeader      AS POHeader
    INNER JOIN E10Prod.Erp.POHeader_UD AS u
        ON POHeader.SysRowID = u.ForeignSysRowID
    LEFT  JOIN cpo.POHeader        AS cPOH
        ON POHeader.Company = cPOH.Company AND POHeader.PONum = cPOH.PONum
    INNER JOIN E10Prod.Erp.PurAgent AS pa
        ON POHeader.Company = pa.Company AND POHeader.BuyerID = pa.BuyerID
    INNER JOIN E10Prod.Erp.Company  AS Company
        ON POHeader.Company = Company.Company
    INNER JOIN E10Prod.Erp.PODetail  AS PODetail
        ON POHeader.Company = PODetail.Company AND POHeader.PONum = PODetail.PONUM
    LEFT  JOIN cpo.POLines          AS cPOD
        ON PODetail.Company = cPOD.Company AND PODetail.PONUM = cPOD.PONum AND PODetail.POLine = cPOD.POLine
    INNER JOIN E10Prod.Erp.Part     AS p
        ON PODetail.Company = p.Company AND PODetail.PartNum = p.PartNum
    LEFT  JOIN Catalogo_Maestro.dbo.PartClasificacion AS ca
        ON p.PartNum = ca.PartNum
    INNER JOIN E10Prod.Erp.ProdGrup AS pg
        ON p.Company = pg.Company AND p.ProdCode = pg.ProdCode
    INNER JOIN E10Prod.Erp.PORel    AS PORel
        ON PODetail.Company = PORel.Company AND PODetail.PONUM = PORel.PONum AND PODetail.POLine = PORel.POLine
    LEFT  JOIN E10Prod.Erp.RcvDtl   AS rd
        ON PORel.Company = rd.Company AND PORel.PONum = rd.PONum AND PORel.POLine = rd.POLine AND PORel.PORelNum = rd.PORelNum
    INNER JOIN E10Prod.Erp.Vendor   AS Vendor
        ON POHeader.Company = Vendor.Company AND POHeader.VendorNum = Vendor.VendorNum
    WHERE
        (POHeader.OpenOrder = 1)
        AND (@Company  IS NULL OR POHeader.Company = @Company)
        AND (
            (@PONum IS NOT NULL AND @Proveedor IS NULL AND @SKu IS NULL AND POHeader.PONum = @PONum)
            OR
            (@PONum IS NULL AND @Proveedor IS NOT NULL AND @SKu IS NOT NULL AND @Proveedor = @SKu
             AND (Vendor.Name LIKE '%' + @Proveedor + '%' OR p.PartNum LIKE '%' + @SKu + '%'))
            OR
            (@Proveedor IS NOT NULL AND @SKu IS NOT NULL AND @Proveedor <> @SKu
             AND Vendor.Name LIKE '%' + @Proveedor + '%' 
             AND p.PartNum LIKE '%' + @SKu + '%')
            OR
            (@PONum IS NULL AND @Proveedor IS NOT NULL AND @SKu IS NULL 
             AND Vendor.Name LIKE '%' + @Proveedor + '%')
            OR
            (@PONum IS NULL AND @Proveedor IS NULL AND @SKu IS NOT NULL 
             AND p.PartNum LIKE '%' + @SKu + '%')
            OR
            (@PONum IS NULL AND @Proveedor IS NULL AND @SKu IS NULL)
        )
        AND (@PONum           IS NULL OR POHeader.PONum = @PONum)
        AND (@Proveedor       IS NULL OR Vendor.Name LIKE '%' + @Proveedor + '%')
        AND (@SKu             IS NULL OR p.PartNum   LIKE '%' + @SKu + '%')
        AND (@PartDescripción IS NULL OR p.PartDescription LIKE '%' + @PartDescripción + '%')
        AND (@Comprador       IS NULL OR pa.Name = @Comprador)
        AND (@Departamento    IS NULL OR pg.ProdCode = @Departamento)
        AND (@Estatus         IS NULL OR cPOD.Estatus = @Estatus)
        AND (@Eta1            IS NULL OR COALESCE(cPOD.ETA, u.EstETADate_c) >= @Eta1)
        AND (@Eta2            IS NULL OR COALESCE(cPOD.ETA, u.EstETADate_c) < DATEADD(DAY, 1, @Eta2))
        AND (@OrderDate       IS NULL OR CAST(POHeader.OrderDate AS DATE) = CAST(@OrderDate AS DATE))
        AND (
            @Destino IS NULL
            OR Company.Country COLLATE Latin1_General_CI_AI LIKE N'%' + @Destino + N'%'
        );

    -- 2) Salida SIN paginar (o paginación inválida) => todos los registros
    IF (@PageNumber IS NULL OR @PageSize IS NULL OR @PageNumber < 1 OR @PageSize < 1)
    BEGIN
        SELECT
            TotalRecords, Company, Destino, Fecha, PO, Departamento,
            COLECCION, Categoria, Subcategoria, Familia, PORTAFOLIO, CAPSULA, MODELOHS, Gema, COLOR_MATERIAL,
            Origen, FOB, ProgramacionAuditoria, Estatus, PartNum, PartDescription, Responsable, Proveedor, vendorID,
            EstatusEpicor, EstatusPO, DueDateInicial, DueDateFinal, ETAInicial, ETAFinal, Weak, NumEmarque,
            UltimaModificacion, CostoUSD, LandedCost, CostoFinal, Destino_ShipTo, Habilitar, SysRowID, POline,
            HasLineComments
        FROM #Base
        ORDER BY Fecha DESC, PO ASC;

        RETURN;
    END

    -- 3) Salida paginada
    SELECT
        TotalRecords, Company, Destino, Fecha, PO, Departamento,
        COLECCION, Categoria, Subcategoria, Familia, PORTAFOLIO, CAPSULA, MODELOHS, Gema, COLOR_MATERIAL,
        Origen, FOB, ProgramacionAuditoria, Estatus, PartNum, PartDescription, Responsable, Proveedor, vendorID,
        EstatusEpicor, EstatusPO, DueDateInicial, DueDateFinal, ETAInicial, ETAFinal, Weak, NumEmarque,
        UltimaModificacion, CostoUSD, LandedCost, CostoFinal, Destino_ShipTo, Habilitar, SysRowID, POline,
        HasLineComments
    FROM #Base
    WHERE rn BETWEEN ((@PageNumber - 1) * @PageSize + 1) AND (@PageNumber * @PageSize)
    ORDER BY Fecha DESC, PO ASC;

END

