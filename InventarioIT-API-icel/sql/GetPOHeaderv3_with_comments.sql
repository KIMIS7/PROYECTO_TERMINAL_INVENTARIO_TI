USE [InventarioIT]
GO

/****** Object:  StoredProcedure [cpo].[GetPOHeaderv3]    Script Date: 13/11/2025 10:51:09 a. m. ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [cpo].[GetPOHeaderv3]
    @Company                varchar(20)      = NULL,
    @PONum                   int                     = NULL, 
    @Proveedor              varchar(100)    = NULL,
    @SKu                          varchar(50)      = NULL,
    @PartDescripción    varchar(50)      = NULL,
    @Comprador            varchar(50)      = NULL,
    @Departamento      varchar(20)      = NULL,
    @Estatus                   varchar(20)      = NULL,
    @Eta1                        date                  = NULL,
    @Eta2                        date                  =  NULL,
    @Destino                  varchar(25)      = NULL,
    @OpenOrder           bit                      = NULL,
    @OrderDate            date                   = NULL,
    @PageNumber        int                      = NULL,
    @PageSize                int                      = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET @Destino = NULLIF(LTRIM(RTRIM(@Destino)), N'');

    IF OBJECT_ID('tempdb..#POs')       IS NOT NULL DROP TABLE #POs;
    IF OBJECT_ID('tempdb..#POsWithRN') IS NOT NULL DROP TABLE #POsWithRN;
    IF OBJECT_ID('tempdb..#PagePOs')   IS NOT NULL DROP TABLE #PagePOs;

    ----------------------------------------------------------------
    -- 1) UNIVERSO DE POs (1 fila por PO) con TODOS los filtros
    ----------------------------------------------------------------
    SELECT  H.Company,
            H.PONum,
            H.VendorNum,
            H.BuyerID,
            H.SysRowID,
            H.DueDate,
            H.OrderDate,
            H.OpenOrder
    INTO    #POs
    FROM    E10Prod.Erp.POHeader H
    WHERE   (@OpenOrder IS NULL OR H.OpenOrder = @OpenOrder)
        AND (@Company   IS NULL OR H.Company   = @Company)
        AND (@OrderDate IS NULL OR H.OrderDate = @OrderDate)
        AND (
              (@PONum IS NOT NULL AND @Proveedor IS NULL AND @SKu IS NULL AND @PartDescripción IS NULL AND @Departamento IS NULL AND H.PONum = @PONum)
              OR (@PONum IS NULL)
            )
        AND (
              @Proveedor IS NULL
              OR EXISTS (SELECT 1 FROM E10Prod.Erp.Vendor V
                         WHERE V.Company=H.Company AND V.VendorNum=H.VendorNum
                           AND V.Name LIKE '%' + @Proveedor + '%')
            )
        AND (
              @SKu IS NULL
              OR EXISTS (SELECT 1
                         FROM E10Prod.Erp.PODetail pd
                         JOIN E10Prod.Erp.Part p ON p.Company=pd.Company AND p.PartNum=pd.PartNum
                         WHERE pd.Company=H.Company AND pd.PONum=H.PONum
                           AND p.PartNum LIKE '%' + @SKu + '%')
            )
        AND (
              @PartDescripción IS NULL
              OR EXISTS (SELECT 1
                         FROM E10Prod.Erp.PODetail pd
                         JOIN E10Prod.Erp.Part p ON p.Company=pd.Company AND p.PartNum=pd.PartNum
                         WHERE pd.Company=H.Company AND pd.PONum=H.PONum
                           AND p.PartDescription LIKE '%' + @PartDescripción + '%')
            )
        AND (
              @Departamento IS NULL
              OR EXISTS (SELECT 1
                         FROM E10Prod.Erp.PODetail pd
                         JOIN E10Prod.Erp.Part p ON p.Company=pd.Company AND p.PartNum=pd.PartNum
                         WHERE pd.Company=H.Company AND pd.PONum=H.PONum
                           AND p.ProdCode=@Departamento)
            )
        AND (
              @Comprador IS NULL
              OR EXISTS (SELECT 1
                         FROM E10Prod.Erp.PurAgent pa
                         WHERE pa.Company=H.Company AND pa.BuyerID=H.BuyerID
                           AND pa.Name=@Comprador)
            )
        AND (
              @Estatus IS NULL
              OR EXISTS (SELECT 1
                         FROM cpo.POHeader x
                         WHERE x.Company=H.Company AND x.PONum=H.PONum AND x.Estatus=@Estatus)
            )
        AND (
              @Destino IS NULL
              OR EXISTS (SELECT 1
                         FROM E10Prod.Erp.Company C
                         WHERE C.Company=H.Company
                           AND C.Country COLLATE Latin1_General_CI_AI LIKE N'%' + @Destino + N'%')
            )
        AND (
              (@Eta1 IS NULL AND @Eta2 IS NULL)
              OR EXISTS (SELECT 1
                         FROM E10Prod.Erp.POHeader_UD u
                         LEFT JOIN cpo.POLines cpl ON cpl.Company=H.Company AND cpl.PONum=H.PONum
                         WHERE u.ForeignSysRowID=H.SysRowID
                           AND (@Eta1 IS NULL OR ISNULL(cpl.ETA, u.EstETADate_c) >= @Eta1)
                           AND (@Eta2 IS NULL OR ISNULL(cpl.ETA, u.EstETADate_c) < DATEADD(DAY,1,@Eta2)))
            );

    ----------------------------------------------------------------
    -- 2) Total y LastETA (globales, posfiltros) sin warning
    ----------------------------------------------------------------
    DECLARE @TotalRecords bigint;
    SELECT @TotalRecords = COUNT(*) FROM #POs;
    DECLARE @LastETA date;

    SELECT @LastETA = MAX(T.ETA)
    FROM (
        SELECT ISNULL(cpl.ETA, u.EstETADate_c) AS ETA
        FROM #POs H
        JOIN E10Prod.Erp.POHeader_UD u ON u.ForeignSysRowID = H.SysRowID
        LEFT JOIN cpo.POLines cpl      ON cpl.Company=H.Company AND cpl.PONum=H.PONum
    ) AS T
    WHERE T.ETA IS NOT NULL;

    ----------------------------------------------------------------
    -- 3) Paginar con ROW_NUMBER() -> #PagePOs
    ----------------------------------------------------------------
   SELECT  Company, PONum, VendorNum, BuyerID, SysRowID, DueDate, OrderDate, OpenOrder,
        ROW_NUMBER() OVER (ORDER BY OrderDate DESC) AS rn
INTO    #POsWithRN
FROM    #POs;

CREATE TABLE #PagePOs (
    Company     varchar(20),
    PONum       int,
    VendorNum   int,
    BuyerID     varchar(50),
    SysRowID    uniqueidentifier,
    DueDate     date,
    OrderDate   date,
    OpenOrder   bit
);

IF @PageNumber IS NULL OR @PageSize IS NULL
BEGIN
    INSERT INTO #PagePOs (Company, PONum, VendorNum, BuyerID, SysRowID, DueDate, OrderDate, OpenOrder)
    SELECT Company, PONum, VendorNum, BuyerID, SysRowID, DueDate, OrderDate, OpenOrder
    FROM   #POsWithRN;
END
ELSE
BEGIN
    INSERT INTO #PagePOs (Company, PONum, VendorNum, BuyerID, SysRowID, DueDate, OrderDate, OpenOrder)
    SELECT Company, PONum, VendorNum, BuyerID, SysRowID, DueDate, OrderDate, OpenOrder
    FROM   #POsWithRN
    WHERE  rn BETWEEN ((@PageNumber - 1) * @PageSize + 1) AND (@PageNumber * @PageSize);
END

    ----------------------------------------------------------------
    -- 4) SELECT final (mismos alias/orden que el original) + indicadores de comentarios
    ----------------------------------------------------------------
    SELECT
        @LastETA                                                                    AS LastETA,
        CAST(@TotalRecords AS bigint)                              AS TotalRecords,
        P.Company                                                                AS Company,
        C.Country                                                                   AS Destino,
        P.OrderDate                                                              AS Fecha,
        P.PONum                                                                   AS PO,
        MAX(pg.Description)                                                AS Departamento,
        pa.Name                                                                    AS Responsable,
        V.Name                                                                      AS Proveedor,
        CASE 
            WHEN P.OpenOrder = 1 
            THEN 'Abierto' 
            ELSE 'Cerrado' 
        END                                                                            AS EstatusEpicor,
        cPOH.Estatus                                                            AS EstatusPO,
        P.DueDate                                                                 AS DueDateInicial, 
        MAX(ISNULL(cPOD.DueDate, PD.DueDate))        AS DueDateFinal,
        u.EstETADate_c                                                         AS ETAInicial,
        MAX(ISNULL(cPOD.ETA, u.EstETADate_c))            AS ETAInicial,
        u.EstETADate_c                                                         AS ETAInicial,
        MAX(ISNULL(cPOD.ETA, u.EstETADate_c))            AS ETAFinal, 
        0                                                                                  AS Weak,
        ''                                                                                  AS Destino_ShipTo,
        MAX(cPOD.NumEmbarque)                                   AS NumEmarque,
        cPOH.LastDateUpdated                                         AS UltimaModificacion,
        COUNT(PD.POLine)                                                 AS Lineas,
        SUM(PD.BaseQty - ISNULL(rd.OurQty,0))            AS UnidadesPendientes,
        SUM(PD.Rpt1ExtCost)                                             AS ValorUSD,
        -- Indicadores de comentarios
        CAST(CASE WHEN EXISTS (
            SELECT 1 
            FROM cpo.POComments pc 
            WHERE pc.Company = P.Company 
              AND pc.PONum = P.PONum 
              AND pc.DeletedAtUtc IS NULL
        ) THEN 1 ELSE 0 END AS bit)                                    AS HasPOComments,
        CAST(CASE WHEN EXISTS (
            SELECT 1 
            FROM cpo.POLineComments plc
            INNER JOIN E10Prod.Erp.PODetail pd2 ON pd2.Company = plc.Company 
                                                 AND pd2.PONum = plc.PONum 
                                                 AND pd2.POLine = plc.POLine
            WHERE pd2.Company = P.Company 
              AND pd2.PONum = P.PONum
              AND plc.DeletedAtUtc IS NULL
        ) THEN 1 ELSE 0 END AS bit)                                    AS HasLineComments
    FROM #PagePOs P
    INNER JOIN E10Prod.Erp.POHeader_UD  u
      ON P.SysRowID = u.ForeignSysRowID
    LEFT  JOIN cpo.POHeader             cPOH
      ON P.Company = cPOH.Company AND P.PONum = cPOH.PONum
    INNER JOIN E10Prod.Erp.PurAgent     pa
      ON P.Company = pa.Company AND P.BuyerID = pa.BuyerID
    INNER JOIN E10Prod.Erp.Company      C
      ON P.Company = C.Company
    INNER JOIN E10Prod.Erp.PODetail     PD
      ON P.Company = PD.Company AND P.PONum = PD.PONUM
    LEFT  JOIN cpo.POLines              cPOD
      ON PD.Company = cPOD.Company AND PD.PONUM = cPOD.PONum AND PD.POLine = cPOD.POLine
    INNER JOIN E10Prod.Erp.Part         p2
      ON PD.Company = p2.Company AND PD.PartNum = p2.PartNum
    INNER JOIN E10Prod.Erp.ProdGrup     pg
      ON p2.Company = pg.Company AND p2.ProdCode = pg.ProdCode
    INNER JOIN E10Prod.Erp.PORel        PORel
      ON PD.Company = PORel.Company AND PD.PONUM = PORel.PONum AND PD.POLine = PORel.POLine
    LEFT  JOIN E10Prod.Erp.RcvDtl       rd
      ON PORel.Company = rd.Company AND PORel.PONum = rd.PONum AND PORel.POLine = rd.POLine AND PORel.PORelNum = rd.PORelNum
    INNER JOIN E10Prod.Erp.Vendor       V
      ON P.Company = V.Company AND P.VendorNum = V.VendorNum
    GROUP BY
        P.Company,
        C.Country,
        P.OrderDate,
        P.PONum,
        pa.Name,
        V.Name,
        P.OpenOrder,
        P.DueDate,
        u.EstETADate_c,
        cPOH.LastDateUpdated,
        cPOH.Estatus
    ORDER BY P.OrderDate DESC
    OPTION (RECOMPILE);

END

