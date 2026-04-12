-- ============================================================
-- ETL COMPLETO v4: Todos los NOT NULL y FK resueltos
-- 337 registros
-- ============================================================

USE InventarioIT;
GO

-- PASO 1: Companies
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'HSPRO_33_')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'HSPRO_33_');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'ISLA17_42_')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'ISLA17_42_');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'OHSGRLTD_92_')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'OHSGRLTD_92_');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'OHSXCD')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'OHSXCD');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'PELTJAM_72_')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'PELTJAM_72_');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'PTO85_44_')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'PTO85_44_');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'PTOARENAS')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'PTOARENAS');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'PTOHSRD')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'PTOHSRD');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Company] WHERE [Description] = N'PTOHS_44_')
    INSERT INTO [dbo].[Company] ([Description]) VALUES (N'PTOHS_44_');
GO

-- PASO 2: Sites (334)
DECLARE @CompanyID INT;
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'HSPRO_33_';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) PRINCESS SUNSET SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) PRINCESS SUNSET SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) PRINCESS YUC SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) PRINCESS YUC SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) SANDOS PLAYACAR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) SANDOS PLAYACAR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) THE FIVES SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) THE FIVES SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) WYNDHAM' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) WYNDHAM', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY BOUTIQUE SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BLUEBAY BOUTIQUE SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BLUEBAY JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY PLAYA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BLUEBAY PLAYA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY TAB CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BLUEBAY TAB CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY TAB CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BLUEBAY TAB CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY TABAQUERIA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BLUEBAY TABAQUERIA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN PARADISE JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE RECEPTOR Juan Yanos' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN PARADISE RECEPTOR Juan Yanos', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE SERVIDOR - caja 3' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN PARADISE SERVIDOR - caja 3', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE TAB CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN PARADISE TAB CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE TAB CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN PARADISE TAB CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE TAB RECEPTOR - impresora' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN PARADISE TAB RECEPTOR - impresora', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 RIVIERA SERVIDOR (ocean maya)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 RIVIERA SERVIDOR (ocean maya)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 RIVIERA TAB CAJA (ocean maya)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 RIVIERA TAB CAJA (ocean maya)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT ZILARA JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT ZILARA JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT ZILARA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT ZILARA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Hilton THE ROYAL CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Hilton THE ROYAL CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Hilton THE ROYAL JOY' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Hilton THE ROYAL JOY', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM JOY COLONIAL' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM JOY COLONIAL', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV COL AMIANI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV COL AMIANI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV KANTENAH CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV KANTENAH CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV KANTENAH CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV KANTENAH CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV KANTENAH RECEPTOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV KANTENAH RECEPTOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV PLAYA CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV PLAYA CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV WHITESANDS CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV WHITESANDS CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV WHITESANDS CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIV WHITESANDS CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIVIERA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM RIVIERA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM ROYAL JOY SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM ROYAL JOY SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS RIV CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS RIV CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS RIV JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV TDA PLAYA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS RIV TDA PLAYA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIVIERA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS RIVIERA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS SUNSET TAB CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS SUNSET TAB CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS SUNSET TAB CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS SUNSET TAB CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS YUC AMIANI CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS YUC AMIANI CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS YUC JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS YUC JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS YUC TAB CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS YUC TAB CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU LUPITA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU LUPITA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CANCUN' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CANCUN', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CARACOL CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL CAJA 2 (Anydesk del servidor)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CARACOL CAJA 2 (Anydesk del servidor)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL CAJA 3' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CARACOL CAJA 3', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL JOY' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CARACOL JOY', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL RECEPTOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CARACOL RECEPTOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS CARACOL SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS PLAYACAR CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS PLAYACAR CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR JOY (forti client)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS PLAYACAR JOY (forti client)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR LOBBY' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS PLAYACAR LOBBY', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'ISLA17_42_';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*CUN T2 TDA CORONA PA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*CUN T2 TDA CORONA PA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*CUN T2 TDA CORONA PB' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*CUN T2 TDA CORONA PB', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BEACHPALACE JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BEACHPALACE JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BEACHPALACE SERVIDOR*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BEACHPALACE SERVIDOR*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BEACHPALACE TAB CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BEACHPALACE TAB CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'COZUMEL PALACE PIER 27-' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'COZUMEL PALACE PIER 27-', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'CUN T3 ISLA CORONA C11' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'CUN T3 ISLA CORONA C11', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'CUN T3 ISLA CORONA C20' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'CUN T3 ISLA CORONA C20', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CANCUN JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CANCUN JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CANCUN SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CANCUN SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CANCUN TAB CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CANCUN TAB CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND AMIANI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND AMIANI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND AQUA PARK-' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND AQUA PARK-', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND GERENTE' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND GERENTE', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PIER 27 PERUANO*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND PIER 27 PERUANO*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PIER27 RESTAURANTE CARIBEÑO' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND PIER27 RESTAURANTE CARIBEÑO', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND RECEPTORÍA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND RECEPTORÍA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON GRAND SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON NIZUC JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC PUEBLITO CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON NIZUC PUEBLITO CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC SERVIDOR*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON NIZUC SERVIDOR*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC TAB CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON NIZUC TAB CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC TAB CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON NIZUC TAB CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON PROSHOP' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON PROSHOP', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON PROSHOP CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON PROSHOP CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE CORAZON CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON CAJA 3' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE CORAZON CAJA 3', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON CAJA 4' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE CORAZON CAJA 4', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON SERVIDOR*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE CORAZON SERVIDOR*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE MULTI CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE MULTI CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI CAJA 3 BORDADORA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE MULTI CAJA 3 BORDADORA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI SERVIDOR*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE MULTI SERVIDOR*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE PIER27 PLAYA*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON SUNRISE PIER27 PLAYA*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PLAYACAR PALACE SERVIDOR*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PLAYACAR PALACE SERVIDOR*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SUN PALACE JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SUN PALACE JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SUN PALACE SERVIDOR*' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SUN PALACE SERVIDOR*', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SUN PALACE TAB CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SUN PALACE TAB CAJA', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'OHSGRLTD_92_';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'EQUIPO DE STOCK ROYALTON VESSENCE BARBADOS' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'EQUIPO DE STOCK ROYALTON VESSENCE BARBADOS', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON GRENADA PIER27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON GRENADA PIER27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON VESSENCE BARBADOS SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON VESSENCE BARBADOS SERVIDOR', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'OHSXCD';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON STA LUCIA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA AMIANI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON STA LUCIA AMIANI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA Caja 2 (M02)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON STA LUCIA Caja 2 (M02)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA Caja 3 (M01)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON STA LUCIA Caja 3 (M01)', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PELTJAM_72_';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'CEDIS Montego Bay Jamaica' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'CEDIS Montego Bay Jamaica', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 JAMAICA (CORAL SPRINGS) SERVIDOR M02' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 JAMAICA (CORAL SPRINGS) SERVIDOR M02', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 JAMAICA CAJA M01' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 JAMAICA CAJA M01', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 JAMAICA CAJA M03' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 JAMAICA CAJA M03', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA AMIANI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'IBEROSTAR JAMAICA AMIANI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'IBEROSTAR JAMAICA MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'IBEROSTAR JAMAICA MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA PIER 27 CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'IBEROSTAR JAMAICA PIER 27 CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'IBEROSTAR JAMAICA PIER 27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE BODEGA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON PALACE BODEGA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE CAJA NUEVA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON PALACE CAJA NUEVA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE GRAND JAMAICA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON PALACE GRAND JAMAICA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Natesha Young' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Natesha Young', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA AMIANI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS JAMAICA AMIANI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS SERVIDOR (MULTI)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS SERVIDOR (MULTI)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RECEPTOR CLUB NEGRIL' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RECEPTOR CLUB NEGRIL', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU AQUARELLE AMIANI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU AQUARELLE AMIANI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU AQUARELLE PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU AQUARELLE PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU AQUARELLE PIER27 CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU AQUARELLE PIER27 CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU CLUB NEGRIL BOARDWALK' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU CLUB NEGRIL BOARDWALK', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU CLUB NEGRIL RIDDIM' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU CLUB NEGRIL RIDDIM', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU CLUB NEGRIL RIDDIM CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU CLUB NEGRIL RIDDIM CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU MONTEGO BAY MULTI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU MONTEGO BAY MULTI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU MONTEGO BAY MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU MONTEGO BAY MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU OCHO RIOS CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU OCHO RIOS CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU OCHO RIOS RECEPTOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU OCHO RIOS RECEPTOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU OCHO RIOS SERVDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU OCHO RIOS SERVDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE JAMAICA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PALACE JAMAICA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU REGGAE CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU REGGAE CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU REGGAE SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU REGGAE SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU TROPICAL BAY MULTI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU TROPICAL BAY MULTI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON BLUE WATERS' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON BLUE WATERS', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON BLUE WATERS CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON BLUE WATERS CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON NEGRIL CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON NEGRIL CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON NEGRIL RECEPTOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON NEGRIL RECEPTOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON NEGRIL SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON NEGRIL SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON WHITE SANDS CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON WHITE SANDS CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON WHITE SANDS SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON WHITE SANDS SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Riu Club Negril Almacen (JAMRICNGLALM)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Riu Club Negril Almacen (JAMRICNGLALM)', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTO85_44_';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AEROPUERTO T2 CABOS CORONASHOP' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AEROPUERTO T2 CABOS CORONASHOP', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ALMACEN CABOS' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ALMACEN CABOS', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Adanelida Flores' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Adanelida Flores', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Angélica Sandoval' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Angélica Sandoval', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS ALMACEN' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CABOS ALMACEN', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS JOYERIA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CABOS JOYERIA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CABOS MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CABOS MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS PIER27 PLAYA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CABOS PIER27 PLAYA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS VIVA MEXICO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CABOS VIVA MEXICO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK VALLARTA PIER27 CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK VALLARTA PIER27 CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK VALLARTA PIER27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK VALLARTA PIER27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS PIER 27 PLAYA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT CABOS PIER 27 PLAYA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT CABOS SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS TAB CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT CABOS TAB CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS TAB CAJA 2 (ANTES JOYERÍA)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT CABOS TAB CAJA 2 (ANTES JOYERÍA)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'JW MARRIOT LOS CABOS' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'JW MARRIOT LOS CABOS', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LAPTOP DE TIENDA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LAPTOP DE TIENDA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS JOY CAJA (fini-amiani)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CABOS JOY CAJA (fini-amiani)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CABOS SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS TAB CAJA PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CABOS TAB CAJA PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS TAB RECEPT' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'LE BLANC CABOS TAB RECEPT', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM VALLARTA CAJA NEW' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM VALLARTA CAJA NEW', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM VALLARTA pier27 CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM VALLARTA pier27 CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM VALLARTA pier27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM VALLARTA pier27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU MAZATLAN' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU MAZATLAN', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYAL SOLARIS LOS CABOS CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYAL SOLARIS LOS CABOS CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYAL SOLARIS LOS CABOS SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYAL SOLARIS LOS CABOS SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SANDOS FINISTERRA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SANDOS FINISTERRA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SOLARIS LIGHTHOUSE' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SOLARIS LIGHTHOUSE', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Salvador Rodriguez' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Salvador Rodriguez', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'UNICO VALLARTA MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'UNICO VALLARTA MULTI SERVIDOR', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTOARENAS';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'(NO) HAVEN HIPOTELS Amiani SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'(NO) HAVEN HIPOTELS Amiani SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*HARDROCK HACIENDAS AMIANI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*HARDROCK HACIENDAS AMIANI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*PALMAR BEACH PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*PALMAR BEACH PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'*SIRENIS TDA DE PLAYA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'*SIRENIS TDA DE PLAYA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AEROPUERTO TERMINAL 2 SERVIDOR PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AEROPUERTO TERMINAL 2 SERVIDOR PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AEROPUERTO TERMINAL 3 SERVIDOR PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AEROPUERTO TERMINAL 3 SERVIDOR PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 PTO MORELOS TAB CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 PTO MORELOS TAB CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 PTO MORELOS TAB CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 PTO MORELOS TAB CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS MARINI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HACIENDAS MARINI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS PIER27 CAJA 1x' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HACIENDAS PIER27 CAJA 1x', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS PIER27 CAJA 2x' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HACIENDAS PIER27 CAJA 2x', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS PIER27 SERVIDORx' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HACIENDAS PIER27 SERVIDORx', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN AMIANI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HEAVEN AMIANI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN JOYERIA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HEAVEN JOYERIA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN PIER27 CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HEAVEN PIER27 CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN PIER27 CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HEAVEN PIER27 CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN PIER27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK HEAVEN PIER27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HAVEN HIPOTELS Amiani Caja' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HAVEN HIPOTELS Amiani Caja', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HAVEN HIPOTELS SUNGLASSCHIC' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HAVEN HIPOTELS SUNGLASSCHIC', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALMAR BEACH ALBERCA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALMAR BEACH ALBERCA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALMAR BEACH AMIANI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALMAR BEACH AMIANI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PARAISO LA BONITA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PARAISO LA BONITA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA 5 PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV MUL CAJA 5 PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV MUL CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV MUL CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA3 PIER27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV MUL CAJA3 PIER27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA4 AMIANI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV MUL CAJA4 AMIANI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV MUL SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV PLAYA PIER27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON RIV PLAYA PIER27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV BOARDWALK CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON SPLASH RIV BOARDWALK CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV BOARDWALK SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON SPLASH RIV BOARDWALK SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV JOYERIA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON SPLASH RIV JOYERIA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIVIERA EL CORAZON CJ1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON SPLASH RIVIERA EL CORAZON CJ1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SIRENIS CARRETA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SIRENIS CARRETA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SIRENIS MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SIRENIS MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SIRENIS MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SIRENIS MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SIRENIS VIVA MEXICO CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SIRENIS VIVA MEXICO CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'SIRENIS VIVA MEXICO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'SIRENIS VIVA MEXICO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'UNICO CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'UNICO CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'UNICO JOY' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'UNICO JOY', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'UNICO PIER27 VIVA MEXICO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'UNICO PIER27 VIVA MEXICO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'UNICO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'UNICO SERVIDOR', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTOHSRD';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 EL FARO CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 EL FARO CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 EL FARO CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 EL FARO CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 EL FARO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 EL FARO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN BLUE PLAYA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 OCEAN BLUE PLAYA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Lobby' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 Ocean Blue Lobby', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Lobby Caja 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 Ocean Blue Lobby Caja 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Multi Caja 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 Ocean Blue Multi Caja 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Riddim SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 Ocean Blue Riddim SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC ALBERCA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC ALBERCA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC ALBERCA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC ALBERCA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC ALBERCA 3' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC ALBERCA 3', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC BODEGA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC BODEGA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC MULTI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC MULTI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC MULTI CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC MULTI CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC MULTI CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC MULTI CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC SPLASH' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC SPLASH', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC VIVA CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC VIVA CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC VIVA SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARD ROCK PC VIVA SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE RD GOLF' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'MOON PALACE RD GOLF', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO ALBERCA PLAYA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM BAVARO ALBERCA PLAYA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO ALMACEN' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM BAVARO ALMACEN', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO AMIANI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM BAVARO AMIANI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO M1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM BAVARO M1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO MULTI SERVER' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM BAVARO MULTI SERVER', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE ALMACEN' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM PALACE ALMACEN', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE MULTI ALMACEN' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM PALACE MULTI ALMACEN', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM PALACE MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM PALACE MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO MULTI SERVER NUEVO' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO MULTI SERVER NUEVO', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD JOY' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RD JOY', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD MULTI caja 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RD MULTI caja 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD MULTI caja 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RD MULTI caja 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD MULTI caja1 (ANTES RIDDIM)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RD MULTI caja1 (ANTES RIDDIM)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD PLAYA PIER27 SVR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RD PLAYA PIER27 SVR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD RIDDIM' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RD RIDDIM', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RIDDIM SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PRINCESS BAVARO RIDDIM SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON BAVARO BOARDWALK Servidor' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON BAVARO BOARDWALK Servidor', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Royalton Bavaro Boardwalk Caja' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Royalton Bavaro Boardwalk Caja', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'Royalton Bavaro CJ2 Pier27 Server' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'Royalton Bavaro CJ2 Pier27 Server', @CompanyID);
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTOHS_44_';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA AMIANI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA AMIANI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA BODEGA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA BODEGA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA CORAZON CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA CORAZON CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA CORAZÓN SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA CORAZÓN SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA FINI SUNGLASS CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA FINI SUNGLASS CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA FINI SUNGLASS SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA FINI SUNGLASS SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA MARINI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA MARINI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 ALBERCA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27 ALBERCA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 EMBARCADERO CAJA1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27 EMBARCADERO CAJA1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 EMBARCADERO CAJA2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27 EMBARCADERO CAJA2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 EMBARCADERO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27 EMBARCADERO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 SPLASH(AQUAPARQUE)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27 SPLASH(AQUAPARQUE)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27-AMIANI (MULTI) SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27-AMIANI (MULTI) SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27-AMIANI CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA PIER27-AMIANI CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA VIVA MÉXICO CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA VIVA MÉXICO CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'AVA VIVA MÉXICO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'AVA VIVA MÉXICO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'BAZAR TABAQUERIA CORPORATIVO(TABLET)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'BAZAR TABAQUERIA CORPORATIVO(TABLET)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'EMPORIO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'EMPORIO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'GR SOLARIS CANCÚN MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'GR SOLARIS CANCÚN MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'GR SOLARIS CARIBE' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'GR SOLARIS CARIBE', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'GRAND HYATT PUERTO CANCUN SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'GRAND HYATT PUERTO CANCUN SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 COSTA MUJERES CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 COSTA MUJERES CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'H10 COSTA MUJERES SERVIDOR (H10 OCEAN AZURE)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'H10 COSTA MUJERES SERVIDOR (H10 OCEAN AZURE)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN JOYERIA (MARINI)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CANCUN JOYERIA (MARINI)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN PIER27 CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CANCUN PIER27 CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN PIER27 CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CANCUN PIER27 CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN PIER27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CANCUN PIER27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN TDA DE PLAYA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HARDROCK CANCUN TDA DE PLAYA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HILARIO RASCON' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HILARIO RASCON', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HILTON CANCUN MULTI' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HILTON CANCUN MULTI', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT CANCUN PIER 27' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT CANCUN PIER 27', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT ZIVA CANCUN JOY CAJA (forti)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT ZIVA CANCUN JOY CAJA (forti)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT ZIVA CANCUN MULTI CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT ZIVA CANCUN MULTI CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'HYATT ZIVA CANCUN MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'HYATT ZIVA CANCUN MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM AMIANI ALBERCA ADULTOS CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM AMIANI ALBERCA ADULTOS CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM AMIANI LOBBY TRS CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM AMIANI LOBBY TRS CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM BOARWALK CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM BOARWALK CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM BOARWALK CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM BOARWALK CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM BOARWALK CAJA 3' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM BOARWALK CAJA 3', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM PIER 27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM PIER27 HOLBIE (alberca niños) CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PALLADIUM CM PIER27 HOLBIE (alberca niños) CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM ALBERCA ADULTOS AMIANI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PLANET HWD CM ALBERCA ADULTOS AMIANI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM ALBERCA NIÑOS PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PLANET HWD CM ALBERCA NIÑOS PIER 27 SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM BOARDWALK CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PLANET HWD CM BOARDWALK CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM BOARDWALK SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PLANET HWD CM BOARDWALK SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'PLANET HWD CM JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RENAISSANCE' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RENAISSANCE', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU DUNAMAR JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU DUNAMAR JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU DUNAMAR SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU DUNAMAR SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU DUNAMAR TAB CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU DUNAMAR TAB CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU KUKULKAN SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU KUKULKAN SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU LATINO CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU LATINO CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU LATINO JOY (forti)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU LATINO JOY (forti)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU LATINO SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU LATINO SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE COSTA MUJERES' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PALACE COSTA MUJERES', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PALACE JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE TAB CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PALACE TAB CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE TAB CAJA 2' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PALACE TAB CAJA 2', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PENINSULA JOY CAJA' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PENINSULA JOY CAJA', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU PENINSULA TAB SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU PENINSULA TAB SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU VENTURA MULTI CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU VENTURA MULTI CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'RIU VENTURA MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'RIU VENTURA MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYAL SOLARIS MULTI SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYAL SOLARIS MULTI SERVIDOR', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON CANCUN JOY CAJA (forti)' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON CANCUN JOY CAJA (forti)', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON CANCUN TAB CAJA 1' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON CANCUN TAB CAJA 1', @CompanyID);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Site] WHERE [Name] = N'ROYALTON CANCUN TAB SERVIDOR' AND [CompanyID] = @CompanyID)
    INSERT INTO [dbo].[Site] ([Name], [CompanyID]) VALUES (N'ROYALTON CANCUN TAB SERVIDOR', @CompanyID);
GO

-- PASO 3: Catálogos de soporte (Vendor, ProductType, AssetState, User ETL)
-- Vendor
IF NOT EXISTS (SELECT 1 FROM [dbo].[Vendor] WHERE [Name] = N'Dell')
    INSERT INTO [dbo].[Vendor] ([Name]) VALUES (N'Dell');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Vendor] WHERE [Name] = N'HP')
    INSERT INTO [dbo].[Vendor] ([Name]) VALUES (N'HP');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo')
    INSERT INTO [dbo].[Vendor] ([Name]) VALUES (N'Lenovo');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Vendor] WHERE [Name] = N'Microsoft')
    INSERT INTO [dbo].[Vendor] ([Name]) VALUES (N'Microsoft');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Vendor] WHERE [Name] = N'Sin identificar')
    INSERT INTO [dbo].[Vendor] ([Name]) VALUES (N'Sin identificar');

-- ProductType (NOT NULL en Asset)
IF NOT EXISTS (SELECT 1 FROM [dbo].[ProductType] WHERE [Name] = N'Equipo')
    INSERT INTO [dbo].[ProductType] ([Name], [Category], [SubCategory], [Group]) VALUES (N'Equipo', N'Computadoras', N'Desktop', N'Oficina');

-- AssetState (NOT NULL en Asset)
IF NOT EXISTS (SELECT 1 FROM [dbo].[AssetState] WHERE [Name] = N'En uso')
    INSERT INTO [dbo].[AssetState] ([Name]) VALUES (N'En uso');

-- User para LastUpdateBy (FK a User, NOT NULL)
-- Usa el primer usuario existente en la DB para no crear registros innecesarios
-- Si no hay usuarios, crea uno de sistema
GO

-- PASO 4: AssetDetail + Asset (337 registros)
DECLARE @CompanyID INT;
DECLARE @NewDetailID INT;
DECLARE @VendorID INT;
DECLARE @SiteID INT;
DECLARE @ProductTypeID INT;
DECLARE @DefaultVendorID INT;
DECLARE @AssetStateID INT;
DECLARE @ETLUserID INT;

SELECT @ProductTypeID = [ProductTypeID] FROM [dbo].[ProductType] WHERE [Name] = N'Equipo';
SELECT @DefaultVendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Sin identificar';
SELECT @AssetStateID = [AssetStateID] FROM [dbo].[AssetState] WHERE [Name] = N'En uso';
SELECT @ETLUserID = MIN([UserID]) FROM [dbo].[User];
IF @ETLUserID IS NULL
BEGIN
    INSERT INTO [dbo].[User] ([Email], [FirstName], [LastName], [Name], [isActive], [createdAt])
    VALUES (N'etl@sistema.local', N'ETL', N'Sistema', N'ETL Sistema', 0, GETDATE());
    SET @ETLUserID = SCOPE_IDENTITY();
END

-- === Company: HSPRO_33_ ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'HSPRO_33_';

-- Registro 1: BLUEBAY BOUTIQUE SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VNDA', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'BBAYBOUTSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY BOUTIQUE SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BLUEBAY BOUTIQUE SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 2: BLUEBAY PLAYA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9EJ', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'i5-10400T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'BBAYPYASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY PLAYA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BLUEBAY PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 3: BLUEBAY TABAQUERIA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'95T8CM2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'i5-7500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'BBAYSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY TABAQUERIA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BLUEBAY TABAQUERIA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 4: BLUEBAY TAB CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ04LR7E', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB', N'RIVBLUBAYTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY TAB CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BLUEBAY TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 5: BLUEBAY TAB CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02JRRT', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'RIVBLUBAYTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY TAB CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BLUEBAY TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 6: BLUEBAY JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ04LR5U', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'120 GB', N'8 GB', N'BBAYJOYERIA-J01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BLUEBAY JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BLUEBAY JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 7: H10 OCEAN PARADISE SERVIDOR - caja 3
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VPD6', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'H10PARSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE SERVIDOR - caja 3' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN PARADISE SERVIDOR - caja 3', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 8: H10 OCEAN PARADISE TAB CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEF9', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DDR 3 DIMM', N'RIVH10OCPTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE TAB CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN PARADISE TAB CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 9: H10 OCEAN PARADISE TAB CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03V9LL', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'500 GB', N'8 GB DDR 3 DIMM', N'RIVH10OCPTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE TAB CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN PARADISE TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 10: H10 OCEAN PARADISE RECEPTOR Juan Yanos
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE RECEPTOR Juan Yanos' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN PARADISE RECEPTOR Juan Yanos', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 11: H10 OCEAN PARADISE TAB RECEPTOR - impresora
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JD6KWW2', N'DELL OptiPlex 7060 Tower', N'Windows 10', N'Windows 10', N'I5-8400', N'HDD', N'1 TB', N'8 GB DDR 3 DIMM', N'RIVH10OCPTR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE TAB RECEPTOR - impresora' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN PARADISE TAB RECEPTOR - impresora', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 12: H10 OCEAN PARADISE JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEJR', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'i5-6400', N'HDD', N'500 GB', N'8 GB DDR 3 DIMM', N'CAJAJOY',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN PARADISE JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN PARADISE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 13: H10 RIVIERA SERVIDOR (ocean maya)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBG8JG2', N'DELL OptiPlex 7060 Micro', N'Windows 11', N'Windows 11', N'i5-8500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'H10RSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 RIVIERA SERVIDOR (ocean maya)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 RIVIERA SERVIDOR (ocean maya)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 14: H10 RIVIERA TAB CAJA (ocean maya)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XGQ3', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'i5-6400', N'HDD', N'500 GB', N'8 GB DDR 3 DIMM', N'RIVH10OCMTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 RIVIERA TAB CAJA (ocean maya)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 RIVIERA TAB CAJA (ocean maya)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 15: HYATT ZILARA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01ZK81', N'Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIM', N'HYTZILSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT ZILARA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT ZILARA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 16: HYATT ZILARA JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01TQRZ', N'Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I3-1215U', N'NVMe', N'500 GB', N'16 GB SODIM', N'HYATTZILARAJOY',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT ZILARA JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT ZILARA JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 17: PALLADIUM RIVIERA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'65SCDZ3', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'24 GB DRR4 SODIMM', N'SVRPCOLONIA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIVIERA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIVIERA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 18: PALLADIUM RIV WHITESANDS CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XMTE', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DRR3 DIMM', N'RIVPALWHSBC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV WHITESANDS CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV WHITESANDS CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 19: PALLADIUM RIV WHITESANDS CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEJE', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'i5-6400', N'SSD', N'120 GB', N'8 GB DRR3 DIMM', N'RIVPALWHSBC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV WHITESANDS CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV WHITESANDS CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 20: PALLADIUM RIV PLAYA CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VQEU', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'RIVPALPYAPC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV PLAYA CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV PLAYA CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 21: PALLADIUM RIV COL AMIANI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7M5S5S3', N'DELL OptiPlex 7000 Micro', N'Windows 10', N'Windows 10', N'I5-12500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVPALCOLBC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV COL AMIANI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV COL AMIANI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 22: PALLADIUM JOY COLONIAL
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN2N', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVPALCOLJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM JOY COLONIAL' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM JOY COLONIAL', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 23: PALLADIUM RIV KANTENAH CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ04LRA5', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'8 GB DRR3 DIMM', N'RIVPALKANTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV KANTENAH CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV KANTENAH CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 24: PALLADIUM RIV KANTENAH CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ039676', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I3-4150', N'SSD', N'250 GB', N'8 GB DRR3 DIMM', N'RIVPALKANTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV KANTENAH CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV KANTENAH CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 25: PALLADIUM RIV KANTENAH RECEPTOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, N'Windows 10', N'Windows 10', N'I5-7500T', N'HDD', N'1 TB', N'8 GB DRR3 DIMM', N'RIVPALKANRCP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM RIV KANTENAH RECEPTOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM RIV KANTENAH RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 26: PALLADIUM ROYAL JOY SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01TQVZ', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i3-1215U', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRPROYAL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM ROYAL JOY SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM ROYAL JOY SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 27: PRINCESS RIVIERA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VMMJ', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'PRINRIVSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIVIERA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS RIVIERA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 28: PRINCESS RIV CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3D7M9N2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'HDD', N'1 TB', N'8 GB DRR4 SODIMM', N'RIVPRNRIVMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS RIV CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 29: PRINCESS RIV CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02YE3J', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'120 GB', N'8 GB DRR3 DIMM', N'RIVPRNRIVMC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS RIV CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 30: PRINCESS RIV JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ015XJT', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'SSD', N'120 GB', N'8 GB DRR3 DIMM', N'RIVPRNRIVJOY',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS RIV JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 31: PRINCESS RIV TDA PLAYA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0GHWS3', N'LENOVO M75q Gen 2', N'Windows 11', N'Windows 11', N'RYZEN 5 PRO 4650GE', N'NVMe', N'250 GB', N'8 GB DRR4 SODIMM', N'PRIVPYASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS RIV TDA PLAYA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS RIV TDA PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 32: RIU LUPITA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6943JL2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'i5-7500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRRIULUP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU LUPITA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU LUPITA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 33: SANDOS CANCUN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01ZK1P', N'Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRSDOSCUN',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CANCUN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CANCUN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 34: SANDOS CARACOL SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGH3DP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'i5-7500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRSDOSCAR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CARACOL SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 35: SANDOS CARACOL RECEPTOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ00XLV1', N'LENOV O M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'SVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL RECEPTOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CARACOL RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 36: SANDOS CARACOL CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0360BL', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVSANCARTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CARACOL CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 37: SANDOS CARACOL CAJA 2 (Anydesk del servidor)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XGP1', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVSANCARTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL CAJA 2 (Anydesk del servidor)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CARACOL CAJA 2 (Anydesk del servidor)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 38: SANDOS CARACOL CAJA 3
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ01R3XG', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVSANCARTC3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL CAJA 3' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CARACOL CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 39: SANDOS CARACOL JOY
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'1QS56Q2', N'DELL Vostro 3470', N'Windows 10', N'Windows 10', N'I5-8400', N'HDD', N'1 TB', N'8 GB DRR3 DIM', N'RIVSANCARJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS CARACOL JOY' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS CARACOL JOY', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 40: (NO) SANDOS PLAYACAR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6955JL2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'i5-7500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRSDOSPCAR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) SANDOS PLAYACAR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) SANDOS PLAYACAR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 41: SANDOS PLAYACAR CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ00YKVK', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'SSD', N'120 GB', N'8 GB DRR3 DIM', N'RIVSANPYCTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS PLAYACAR CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 42: SANDOS PLAYACAR CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ01MGT7', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVSANPYCTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS PLAYACAR CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 43: SANDOS PLAYACAR LOBBY
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0431MZ', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVSANPYCTC3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR LOBBY' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS PLAYACAR LOBBY', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 44: SANDOS PLAYACAR JOY (forti client)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ003SJY', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVSANPYCJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS PLAYACAR JOY (forti client)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS PLAYACAR JOY (forti client)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 45: (NO) THE FIVES SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01J6PD', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRTHEFIVES',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) THE FIVES SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) THE FIVES SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 46: (NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XMTS', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'500 GB', N'16 GB DIMM', N'THEROYALSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) Hilton THE ROYAL SERVIDOR (hyatt vivid)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 47: Hilton THE ROYAL CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEGP', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DRR3 DIM', N'RIVTHEROYTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Hilton THE ROYAL CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Hilton THE ROYAL CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 48: Hilton THE ROYAL JOY
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03608G', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'250 GB', N'16 GB DDR3 DIMM', N'RIVTHEROYJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Hilton THE ROYAL JOY' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Hilton THE ROYAL JOY', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 49: (NO) PRINCESS YUC SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0GHWQG', N'LENOVO M75q Gen 2', N'Windows 11', N'Windows 11', N'RYZEN 5 PRO 4650GE', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'PRINYUCSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) PRINCESS YUC SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) PRINCESS YUC SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 50: PRINCESS YUC TAB CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02T07C', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'120 GB', N'12 GB DDR3 DIMM', N'RIVPRNYUCBC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS YUC TAB CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS YUC TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 51: PRINCESS YUC AMIANI CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VNFD', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'PRINYUCCJ1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS YUC AMIANI CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS YUC AMIANI CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 52: PRINCESS YUC JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ01HXHQ', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'HDD', N'500 GB', N'8 GB DDR3 DIMM', N'RIVPRNYUCJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS YUC JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS YUC JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 53: (NO) PRINCESS SUNSET SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01ZK08', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'PRINSUNSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) PRINCESS SUNSET SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) PRINCESS SUNSET SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 54: PRINCESS SUNSET TAB CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6915JL2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVPRNSUNTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS SUNSET TAB CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS SUNSET TAB CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 55: PRINCESS SUNSET TAB CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'171F8R2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVPRNSUNTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS SUNSET TAB CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS SUNSET TAB CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 56: (NO) WYNDHAM
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01M97M', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVWYNDHASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) WYNDHAM' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) WYNDHAM', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: ISLA17_42_ ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'ISLA17_42_';

-- Registro 57: BEACHPALACE SERVIDOR*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3DDL9N2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5 7500T', N'SSD', N'250 GB', N'16 GB DDR4 SODIMM', N'BEACHSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BEACHPALACE SERVIDOR*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BEACHPALACE SERVIDOR*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 58: BEACHPALACE TAB CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XGPE', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'16 GB DDR3 DIMM', N'CUNBEACHPTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BEACHPALACE TAB CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BEACHPALACE TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 59: BEACHPALACE JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0360BT', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'500 GB', N'16 GB DDR3 DIMM', N'JoyBeachPalace',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BEACHPALACE JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BEACHPALACE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 60: *CUN T2 TDA CORONA PA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HG4V', N'LENOVO Neo 50q Gen 4 Desktop (ThinkCentre)', N'Windows 11', N'Windows 11', N'I5 13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'SVRCUNT2PA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*CUN T2 TDA CORONA PA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*CUN T2 TDA CORONA PA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 61: *CUN T2 TDA CORONA PB
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'DCSMHK2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5 7500T', N'SSD', N'250 GB', N'16 GB DDR4 SODIMM', N'SVRCUNT2PB',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*CUN T2 TDA CORONA PB' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*CUN T2 TDA CORONA PB', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 62: CUN T3 ISLA CORONA C11
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7V2L8X2', N'OptiPlex 7060 Micro', N'Windows 11', N'Windows 11', N'I5 8500T', N'SSD', N'500 GB', N'16 GB DDR4 SODIMM', N'SVRCUNT3C11',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'CUN T3 ISLA CORONA C11' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'CUN T3 ISLA CORONA C11', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 63: CUN T3 ISLA CORONA C20
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7TSM8X2', N'DELL OptiPlex 7060 Micro', N'Windows 10', N'Windows 10', N'i5-8500T', N'SSD', N'500 GB', N'16 GB DDR4 SODIMM', N'SVRCUNT3C20',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'CUN T3 ISLA CORONA C20' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'CUN T3 ISLA CORONA C20', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 64: LE BLANC CANCUN SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q7J5', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'LEBLANCSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CANCUN SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CANCUN SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 65: LE BLANC CANCUN TAB CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ00HB8V', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'SSD', N'120 GB', N'8 GB DDR3 DIMM', N'CANLEBLANB01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CANCUN TAB CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CANCUN TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 66: LE BLANC CANCUN JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ01R425', N'LENOVO M70q Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'1 TB', N'8 GB DDR3 DIMM', N'CUNLEBLANCJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CANCUN JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CANCUN JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 67: MOON GRAND SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, N'MJ0FF9E9', NULL, N'Windows 11', N'Windows 11', N'i5-10400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'MULTIMOONGRANDSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 68: MOON GRAND MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGHSQP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'8 GB DDR4 SODIMM', N'CUNMONGRDMC02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 69: MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VNKP', N'LENOVO Thinkcentre Neo50q 12LM', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'480 GB', N'16 GB DDR4 SODIMM', N'MoonGrand_Sipatron',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND PUEBLITO CAJA 1 (multi.corazon.c3)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 70: MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMW7T', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'NVMe', N'250 GB', N'16 GB DDR4 SODIMM', N'CUNMONGRDCC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND PUEBLITO CAJA 2 (multi.corazon.c4)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 71: MOON GRAND JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VPA7', N'LENOVO Neo 50q Gen 4 Desktop (ThinkCentre)', N'Windows 11', N'Windows 11', N'I5 13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'JoyMoonGrand',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 72: MOON GRAND RECEPTORÍA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VQEP', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DDR3 DIMM', N'MOONGRANDRECEP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND RECEPTORÍA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND RECEPTORÍA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 73: MOON GRAND GERENTE
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CUNMONGRDGTE',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND GERENTE' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND GERENTE', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 74: MOON GRAND AMIANI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN0L', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5 13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'MGRANDAMIANISVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND AMIANI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND AMIANI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 75: MOON GRAND AQUA PARK-
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBGYP52', N'DELL OptiPlex 7060 Micro', N'Windows 11', N'Windows 11', N'I5-8500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRAQUAPARK',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND AQUA PARK-' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND AQUA PARK-', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 76: MOON GRAND PIER 27 PERUANO*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9EQ', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'I5-10400T', NULL, N'500 GB', N'16 GB', N'MGRANDPIER27SVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PIER 27 PERUANO*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND PIER 27 PERUANO*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 77: MOON GRAND PIER27 RESTAURANTE CARIBEÑO
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNY0X', N'LENOVO M70q Gen 2 Desktop', N'Windows 11', N'Windows 11', N'I5-11400T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'MOONRESTSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON GRAND PIER27 RESTAURANTE CARIBEÑO' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON GRAND PIER27 RESTAURANTE CARIBEÑO', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 78: MOON PROSHOP
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VP68', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5 13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'MGOLFSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON PROSHOP' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON PROSHOP', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 79: MOON PROSHOP CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGMVQP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'8 GB DRR4 SODIMM', N'MOONGOLF-CAJA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON PROSHOP CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON PROSHOP CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 80: MOON SUNRISE CORAZON SERVIDOR*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VMM1', N'LENOVO Neo 50q Gen 4 Desktop', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SUNCORAZONSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON SERVIDOR*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE CORAZON SERVIDOR*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 81: MOON SUNRISE CORAZON CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03608Z', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'120 GB', N'8 GB DDR3 DIMM', N'CUNMONSUNCC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE CORAZON CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 82: MOON SUNRISE CORAZON CAJA 3
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01YC75', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'CUNMONSUNCC3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON CAJA 3' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE CORAZON CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 83: MOON SUNRISE CORAZON CAJA 4
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01YC86', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'CUNMONSUNCC4',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE CORAZON CAJA 4' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE CORAZON CAJA 4', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 84: MOON SUNRISE MULTI SERVIDOR*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HSVZLP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'SUNARTESVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI SERVIDOR*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE MULTI SERVIDOR*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 85: MOON SUNRISE MULTI CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ003SKJ', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'i5-4440S', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'MPSunriseCj1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE MULTI CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 86: MOON SUNRISE MULTI CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XGPH', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'120 GB', N'16 GB', N'CUNMONSUNTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE MULTI CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 87: MOON SUNRISE MULTI CAJA 3 BORDADORA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03V9L3', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'500 GB', N'16 GB DRR3 DIMM', N'CUNMONSUNTC3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE MULTI CAJA 3 BORDADORA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE MULTI CAJA 3 BORDADORA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 88: MOON SUNRISE JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ015XK4', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'SSD', N'120 GB', N'8 GB DDR DIMM', N'RIVMONSUNJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 89: MOON SUNRISE PIER27 PLAYA*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNXY4', N'LENOVO M70q Gen 2 Desktop', N'Windows 11', N'Windows 11', N'I5-11400T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SUNPLAYASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON SUNRISE PIER27 PLAYA*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON SUNRISE PIER27 PLAYA*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 90: PLAYACAR PALACE SERVIDOR*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ04LR8Y', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'500 GB', N'16 GB', N'PLAYACARSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PLAYACAR PALACE SERVIDOR*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PLAYACAR PALACE SERVIDOR*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 91: SUN PALACE SERVIDOR*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEJ6', N'LENOVO MJ03VEJ6', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'SUNSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SUN PALACE SERVIDOR*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SUN PALACE SERVIDOR*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 92: SUN PALACE TAB CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0360A0', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'120 GB', N'8 GB DDR3 DIMM', N'CUNSUNPALTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SUN PALACE TAB CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SUN PALACE TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 93: SUN PALACE JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEHT', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'CUNSUNPALJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SUN PALACE JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SUN PALACE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 94: MOON NIZUC SERVIDOR*
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEJU', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB DIMM', N'MOONNIZUCSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC SERVIDOR*' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON NIZUC SERVIDOR*', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 95: MOON NIZUC TAB CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, N'Windows 10', N'Windows 10', N'i5-4460', N'HDD', N'500 GB', N'8 GB DDR3 DIMM', N'POS-MX25-MNIZT01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC TAB CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON NIZUC TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 96: MOON NIZUC TAB CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'FP5S5S3', N'DELL OptiPlex 7000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'MOONNIZUCCJ2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC TAB CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON NIZUC TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 97: MOON NIZUC PUEBLITO CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q7B0', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'CUNMONNIZVC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC PUEBLITO CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON NIZUC PUEBLITO CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 98: MOON NIZUC JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'QCM1250', N'DELL D19U MINI', N'Windows 11', N'Windows 11', N'i5-14500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'CANMONNIZJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON NIZUC JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON NIZUC JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 99: COZUMEL PALACE PIER 27-
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'GM5S5S3', N'DELL OptiPlex 7000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRCOZPAL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'COZUMEL PALACE PIER 27-' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'COZUMEL PALACE PIER 27-', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: OHSGRLTD_92_ ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'OHSGRLTD_92_';

-- Registro 101: ROYALTON GRENADA PIER27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01YBT9', N'LENOVO THINKCENTRE NEO 50Q GEN 4 12LM MINI CPU', N'Windows 11', N'Windows 11', N'13th Gen Intel(R) Core(TM) i5-13420H (2.10 GHz)', N'NVMe', N'480 GB', N'16 GB DDR4 3200 MHz SODIMM', N'SVRROYGRENADA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON GRENADA PIER27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON GRENADA PIER27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 102: ROYALTON VESSENCE BARBADOS SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ02N27R', N'LENOVO THINKCENTRE NEO 50Q GEN 5', N'Windows 11', N'Windows 11', N'Intel core i5 210h', N'NVMe', N'512 GB', N'16 GB', N'SVR-BB26-RVB01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON VESSENCE BARBADOS SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON VESSENCE BARBADOS SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 103: EQUIPO DE STOCK ROYALTON VESSENCE BARBADOS
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'9FP8ND4', N'DELL PRO MICRO QCM1250', N'Windows 11', N'Windows 11', N'Intel core i5-14500T', N'NVMe', N'512 GB', N'16 GB', N'NA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'EQUIPO DE STOCK ROYALTON VESSENCE BARBADOS' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'EQUIPO DE STOCK ROYALTON VESSENCE BARBADOS', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: OHSXCD ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'OHSXCD';

-- Registro 104: ROYALTON STA LUCIA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGJQQP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRROYSTALUCIA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON STA LUCIA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 105: ROYALTON STA LUCIA Caja 2 (M02)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGKMQP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'8 GB SODIMM', N'DESKTOP-TCG7RTG',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA Caja 2 (M02)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON STA LUCIA Caja 2 (M02)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 106: ROYALTON STA LUCIA Caja 3 (M01)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, N'Windows 7', N'Windows 7', N'corei5 6gen', N'HDD', N'500 GB', N'8gb', N'HS-SERVER-PC',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA Caja 3 (M01)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON STA LUCIA Caja 3 (M01)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 107: ROYALTON STA LUCIA AMIANI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEFM', N'LENOVO M800', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DIMM', N'StaLuciaCaja',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON STA LUCIA AMIANI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON STA LUCIA AMIANI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: PELTJAM_72_ ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PELTJAM_72_';

-- Registro 108: H10 JAMAICA (CORAL SPRINGS) SERVIDOR M02
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'B4ST9W2', N'DELL OptiPlex 3060 Micro', N'Windows 10', N'Windows 10', N'I5-8400T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRH10J',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 JAMAICA (CORAL SPRINGS) SERVIDOR M02' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 JAMAICA (CORAL SPRINGS) SERVIDOR M02', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 109: H10 JAMAICA CAJA M03
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'B2PR9W2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8400T', N'SSD', N'500 GB', N'8 GB SODIMM', N'JAMH10JAMTC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 JAMAICA CAJA M03' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 JAMAICA CAJA M03', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 110: H10 JAMAICA CAJA M01
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'B4XS9W2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8400T', N'SSD', N'500 GB', N'8 GB SODIMM', N'JAMH10TCJ1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 JAMAICA CAJA M01' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 JAMAICA CAJA M01', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 111: MOON PALACE GRAND JAMAICA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7B4JRR2', N'DELLOptiPlex 3060 Micro', N'Windows 10', N'Windows 10', N'I5-8500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRMOONJAM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE GRAND JAMAICA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON PALACE GRAND JAMAICA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 112: MOON PALACE CAJA NUEVA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'HP', N'8CC9242F2W', N'HP Pavilion All-in-One - 24-xa0032', N'Windows 11', N'Windows 11', N'I5-9400T', N'NVMe', N'500 GB', N'12 GB SODIMM', N'MOONPALACECJ',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'HP';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE CAJA NUEVA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON PALACE CAJA NUEVA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 113: MOON PALACE BODEGA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, N'8CC9242F27', NULL, N'Windows 10', N'Windows 10', N'I5-9400T', N'SSD', N'500 GB', N'12 GB SODIMM', N'JAM-DCMB2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE BODEGA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON PALACE BODEGA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 114: RIU MONTEGO BAY MULTI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'71PGJ13', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRIUMONTEGO',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU MONTEGO BAY MULTI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU MONTEGO BAY MULTI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 115: RIU MONTEGO BAY MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JX86R23', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'HDD', N'1 TB', N'8 GB SODIMM', N'MontegoBayC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU MONTEGO BAY MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU MONTEGO BAY MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 116: RIU PALACE JAMAICA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6Y86R23', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRIUPALACE',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE JAMAICA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PALACE JAMAICA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 117: RIU OCHO RIOS SERVDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'CLNZ833', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRIUOCHORIOS',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU OCHO RIOS SERVDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU OCHO RIOS SERVDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 118: RIU OCHO RIOS CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6LNZ833', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'JAMRIU8RIOM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU OCHO RIOS CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU OCHO RIOS CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 119: RIU OCHO RIOS RECEPTOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU OCHO RIOS RECEPTOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU OCHO RIOS RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 120: RIU REGGAE SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'11PGJ13', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIM', N'SVRRIUREGGAE',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU REGGAE SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU REGGAE SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 121: RIU REGGAE CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HESZ', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-1342H', N'NVMe', N'500 GB', N'16 GB SODIM', N'JAMRIURGEIC02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU REGGAE CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU REGGAE CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 122: RIU TROPICAL BAY MULTI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'DY86R23', N'DELL OptiPlex 7070 Micro', N'Windows 10', N'Windows 10', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRIUTROPICAL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU TROPICAL BAY MULTI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU TROPICAL BAY MULTI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 123: ROYALTON BLUE WATERS
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'BFCH0S2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8400T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRROYBW',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON BLUE WATERS' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON BLUE WATERS', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 124: ROYALTON BLUE WATERS CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'HP', N'8CC9242FWD', N'HP Pavilion All-in-One - 24-xa0032', N'Windows 11', N'Windows 11', N'I5-9400T', N'NVMe', N'500 GB', N'12 GB SODIMM', N'JAMROYBWCJ2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'HP';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON BLUE WATERS CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON BLUE WATERS CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 125: ROYALTON NEGRIL SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEGG', N'LENOVO M800', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'500 GB', N'24 GB DIMM', N'SVRROYNEGRIL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON NEGRIL SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON NEGRIL SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 126: ROYALTON NEGRIL RECEPTOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7B4DRR2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8500T', N'SSD', N'500 GB', N'8 GB SODIMM', N'NegrilJamCj2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON NEGRIL RECEPTOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON NEGRIL RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 127: ROYALTON NEGRIL CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03V9LD', N'LENOVO M800', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'3.6 TB', N'8 GB DIMM', N'NegrilJamCj',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON NEGRIL CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON NEGRIL CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 128: ROYALTON WHITE SANDS SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02T02B', N'LENOVO M83', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'500 GB', N'12 GB DDR3 DIMM', N'SVRROYWTESANDS',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON WHITE SANDS SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON WHITE SANDS SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 129: ROYALTON WHITE SANDS CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'WhitesandsCj1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON WHITE SANDS CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON WHITE SANDS CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 130: RIU CLUB NEGRIL RIDDIM
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'4Y86R23', N'DELL OptiPlex 7070 Micro', N'Windows 11', N'Windows 11', N'I5-9500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRIUCLUB',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU CLUB NEGRIL RIDDIM' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU CLUB NEGRIL RIDDIM', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 131: RIU CLUB NEGRIL RIDDIM CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01PBEX', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-1342H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'RIUCLUBRDDIMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU CLUB NEGRIL RIDDIM CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU CLUB NEGRIL RIDDIM CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 132: RIU CLUB NEGRIL BOARDWALK
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'B34W9W2', N'DELL OptiPlex 3060 Micro', N'Windows 10', N'Windows 10', N'I5-8400T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRCLNBOW',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU CLUB NEGRIL BOARDWALK' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU CLUB NEGRIL BOARDWALK', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 133: RECEPTOR CLUB NEGRIL
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RECEPTOR CLUB NEGRIL' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RECEPTOR CLUB NEGRIL', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 134: Riu Club Negril Almacen (JAMRICNGLALM)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'JAMRICNGLALM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Riu Club Negril Almacen (JAMRICNGLALM)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Riu Club Negril Almacen (JAMRICNGLALM)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 135: CEDIS Montego Bay Jamaica
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'AM-DCMB2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'CEDIS Montego Bay Jamaica' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'CEDIS Montego Bay Jamaica', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 136: RIU AQUARELLE AMIANI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'2D7S704', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'JAMRIUAQUAMI',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU AQUARELLE AMIANI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU AQUARELLE AMIANI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 137: RIU AQUARELLE PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'2JRTG04', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'JAMRIUAQUPIE',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU AQUARELLE PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU AQUARELLE PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 138: RIU AQUARELLE PIER27 CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'1LFZG04', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'JAMRIUAQUTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU AQUARELLE PIER27 CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU AQUARELLE PIER27 CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 139: PRINCESS JAMAICA PIER27 LOBBY ADULTOS SERVIDOR (MULTI)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'GQ8S704', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'JAMPRINCEPSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS SERVIDOR (MULTI)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS SERVIDOR (MULTI)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 140: PRINCESS JAMAICA PIER27 LOBBY ADULTOS CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HDBKNZ3', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'JAMPRINCEPC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS JAMAICA PIER27 LOBBY ADULTOS CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 141: PRINCESS JAMAICA PIER27 LOBBY FAMILIAR SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'4CPNG04', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'JAMPRINCEESVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 142: PRINCESS JAMAICA PIER27 LOBBY FAMILIAR CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'JAMPRINCEEC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS JAMAICA PIER27 LOBBY FAMILIAR CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 143: PRINCESS JAMAICA AMIANI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'1MHKNZ3', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-13500T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'JAMPRINCEASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS JAMAICA AMIANI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS JAMAICA AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 144: Natesha Young
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'JAM-AFERGUSONHP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Natesha Young' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Natesha Young', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 145: IBEROSTAR JAMAICA AMIANI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN52', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVR-JM25-IJA01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA AMIANI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'IBEROSTAR JAMAICA AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 146: IBEROSTAR JAMAICA MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MZ01LF3S', N'Lenovo ThinkCentre M70q Gen 5', N'Windows 11', N'Windows 11', N'i5-14400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'SVR-JM25-IJM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'IBEROSTAR JAMAICA MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 147: IBEROSTAR JAMAICA MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VMY8', N'Lenovo ThinkCentre neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'POS-JM25-IJM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'IBEROSTAR JAMAICA MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 148: IBEROSTAR JAMAICA PIER 27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN22', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVR-JM25-IJP01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'IBEROSTAR JAMAICA PIER 27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 149: IBEROSTAR JAMAICA PIER 27 CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'POS-JM25-IJP01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'IBEROSTAR JAMAICA PIER 27 CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'IBEROSTAR JAMAICA PIER 27 CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: PTO85_44_ ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTO85_44_';

-- Registro 150: HYATT CABOS SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3DJH9N2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRHYTTCBOS',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT CABOS SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 151: HYATT CABOS TAB CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3DCG9N2', N'DELL OptiPlex 7050 Micro', N'Windows 11', N'Windows 11', N'I5-7500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'CABHYTZIVM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS TAB CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT CABOS TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 152: HYATT CABOS PIER 27 PLAYA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3D7G9N2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'12 GB SODIMM', N'CABHYATTCPC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS PIER 27 PLAYA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT CABOS PIER 27 PLAYA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 153: HYATT CABOS TAB CAJA 2 (ANTES JOYERÍA)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XGPX', N'LENOVO M800', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'120 GB', N'16 GB DIMM', N'CABHYATTCJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT CABOS TAB CAJA 2 (ANTES JOYERÍA)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT CABOS TAB CAJA 2 (ANTES JOYERÍA)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 154: JW MARRIOT LOS CABOS
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01PAPF', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVRJWMCBOS',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'JW MARRIOT LOS CABOS' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'JW MARRIOT LOS CABOS', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 155: LE BLANC CABOS SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3NDWHK2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRLEBLANCCAB',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CABOS SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 156: LE BLANC CABOS TAB CAJA PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ05H4H1', N'LENOVO M710q', N'Windows 10', N'Windows 10', N'I3-7100T', N'SSD', N'250 GB', N'12 GB SODIMM', N'CABLEBLANEC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS TAB CAJA PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CABOS TAB CAJA PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 157: LE BLANC CABOS JOY CAJA (fini-amiani)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ05M20V', N'LENOVO M710q', N'Windows 10', N'Windows 10', N'I3-7100T', N'SSD', N'250 GB', N'12 GB SODIMM', N'CABLEBLANJ01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS JOY CAJA (fini-amiani)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CABOS JOY CAJA (fini-amiani)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 158: LE BLANC CABOS TAB RECEPT
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CABLEBLANRCP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LE BLANC CABOS TAB RECEPT' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LE BLANC CABOS TAB RECEPT', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 159: PALLADIUM VALLARTA pier27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN75', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVRPVALLARTA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM VALLARTA pier27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM VALLARTA pier27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 160: PALLADIUM VALLARTA pier27 CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'8D3C0Q2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'i5-7500T', N'SSD', N'500 GB', N'8 GB SODIMM', N'PALLVALLPC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM VALLARTA pier27 CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM VALLARTA pier27 CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 161: RIU MAZATLAN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FQCKZ', N'LENOVO M70q', N'Windows 10', N'Windows 10', N'I5-10500T', N'SSD', N'500 GB', N'16 GB SODIMM', N'SVRRIUMAZ',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU MAZATLAN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU MAZATLAN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 162: LAPTOP DE TIENDA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'LAPTOP DE TIENDA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'LAPTOP DE TIENDA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 163: AEROPUERTO T2 CABOS CORONASHOP
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9F1', N'LENOVO M70q', N'Windows 11', N'Windows 11', N'I5-10400T', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVRSJDT2SC',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AEROPUERTO T2 CABOS CORONASHOP' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AEROPUERTO T2 CABOS CORONASHOP', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 164: HARDROCK VALLARTA PIER27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMW87', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'SSD', N'250 GB', N'16 GB SODIMM', N'SVRHVP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK VALLARTA PIER27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK VALLARTA PIER27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 165: HARDROCK VALLARTA PIER27 CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMW89', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'SSD', N'250 GB', N'16 GB SODIMM', N'HRVCAJA1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK VALLARTA PIER27 CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK VALLARTA PIER27 CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 166: HARDROCK CABOS ALMACEN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMW84', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'SSD', N'250 GB', N'16 GB SODIMM', N'CABHRDRCKALM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS ALMACEN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CABOS ALMACEN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 167: HARDROCK CABOS PIER27 PLAYA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMGZD', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CABHRDRCKISVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS PIER27 PLAYA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CABOS PIER27 PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 168: HARDROCK CABOS VIVA MEXICO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMGXQ', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CABHRDRCKESVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS VIVA MEXICO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CABOS VIVA MEXICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 169: HARDROCK CABOS JOYERIA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMGX4', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'SSD', N'250 GB', N'16 GB SODIMM', N'CABHRDRCKJSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS JOYERIA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CABOS JOYERIA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 170: HARDROCK CABOS MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMGWJ', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CABHRDRCKMSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CABOS MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 171: HARDROCK CABOS MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KMGZ0', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CABHRDRCKMC02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CABOS MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CABOS MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 172: SANDOS FINISTERRA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HFXC', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'CABSANFINMSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SANDOS FINISTERRA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SANDOS FINISTERRA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 173: Angélica Sandoval
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Angélica Sandoval' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Angélica Sandoval', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 174: Adanelida Flores
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GTE-AFLORESLEN',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Adanelida Flores' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Adanelida Flores', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 175: ALMACEN CABOS
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01PANL', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'CABALM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ALMACEN CABOS' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ALMACEN CABOS', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 176: ALMACEN CABOS
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01PAPB', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'CABALM02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ALMACEN CABOS' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ALMACEN CABOS', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 177: Salvador Rodriguez
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ALM-SRODRIGUEZ',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Salvador Rodriguez' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Salvador Rodriguez', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 178: UNICO VALLARTA MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN2F', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVR-MX25-UVM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'UNICO VALLARTA MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'UNICO VALLARTA MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 179: PALLADIUM VALLARTA CAJA NEW
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VN75', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'PALLVALLPC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM VALLARTA CAJA NEW' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM VALLARTA CAJA NEW', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 180: SOLARIS LIGHTHOUSE
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ02C0XJ', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM 3200MHZ DDR4', N'SVR-MX25-GSL01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SOLARIS LIGHTHOUSE' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SOLARIS LIGHTHOUSE', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 181: ROYAL SOLARIS LOS CABOS SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'F9P8ND4', N'DELL Pro Micro QCM1250', N'Windows 11', N'Windows 11', N'i5-14500T', N'NVMe', N'500 GB', N'16 GB SODIMM 5600MHZ DDR5', N'SVR-MX25-RSL01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYAL SOLARIS LOS CABOS SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYAL SOLARIS LOS CABOS SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 182: ROYAL SOLARIS LOS CABOS CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PH2', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'DSK-MX25-RSL02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYAL SOLARIS LOS CABOS CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYAL SOLARIS LOS CABOS CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: PTOARENAS ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTOARENAS';

-- Registro 183: AEROPUERTO TERMINAL 2 SERVIDOR PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'BDVL0S2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8400T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRASURCUNT2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AEROPUERTO TERMINAL 2 SERVIDOR PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AEROPUERTO TERMINAL 2 SERVIDOR PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 184: AEROPUERTO TERMINAL 3 SERVIDOR PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q73W', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRASURCUNT3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AEROPUERTO TERMINAL 3 SERVIDOR PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AEROPUERTO TERMINAL 3 SERVIDOR PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 185: H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q29G', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRH10PTOM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 PTO MORELOS (ocean coral & turquesa) TAB SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 186: H10 PTO MORELOS TAB CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q1G2', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'H10PTOMCAJA1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 PTO MORELOS TAB CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 PTO MORELOS TAB CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 187: H10 PTO MORELOS TAB CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q1D5', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'H10PTOMCAJA2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 PTO MORELOS TAB CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 PTO MORELOS TAB CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 188: (NO) HAVEN HIPOTELS Amiani SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'95L9CM2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRHIPOTELS',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'(NO) HAVEN HIPOTELS Amiani SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'(NO) HAVEN HIPOTELS Amiani SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 189: HAVEN HIPOTELS Amiani Caja
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'95H8CM2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'8 GB DRR4 SODIMM', N'RIVHAVHIPA01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HAVEN HIPOTELS Amiani Caja' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HAVEN HIPOTELS Amiani Caja', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 190: HAVEN HIPOTELS SUNGLASSCHIC
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'DCQDHK2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVHAVHIPS01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HAVEN HIPOTELS SUNGLASSCHIC' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HAVEN HIPOTELS SUNGLASSCHIC', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 191: ROYALTON RIV MUL SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9F3', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'I5-10400T', N'SSD', N'500 GB', N'32 GB DRR4 SODIMM', N'SVRROYALTON',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV MUL SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 192: ROYALTON RIV MUL CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q1Z2', N'NEO 50q Gen4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'512 GB', N'16 GB DRR4 SODIMM', N'ROYSIPATCJ1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV MUL CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 193: ROYALTON RIV MUL CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEH7', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'i5-6400', N'HDD', N'500 GB', N'16 GB DDR3 DIMM', N'SIPATRONCAJA2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV MUL CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 194: ROYALTON RIV MUL CAJA3 PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGHLQP2', N'DELL OPTIPLEX 7050 MINI', N'Windows 11', N'Windows 11', N'i5-7500T', N'NVMe', N'480 GB', N'16 GB SODIMM', N'ROYPIERCJ3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA3 PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV MUL CAJA3 PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 195: ROYALTON RIV MUL CAJA 5 PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'DRS8ND4', N'DELL PRO MICRO QCM1250', N'Windows 11', N'Windows 11', N'i5-14500T', N'NVMe', N'480 GB', N'16 GB SODIMM', N'POS-MX25-RYT01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA 5 PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV MUL CAJA 5 PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 196: ROYALTON RIV MUL CAJA4 AMIANI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XMTQ', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'i5-6400', N'SSD', N'120 GB', N'16 GB DDR3 DIMM', N'RoyAmianiCaja4',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV MUL CAJA4 AMIANI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV MUL CAJA4 AMIANI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 197: ROYALTON RIV JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEH4', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'i5-6400', N'SSD', N'500 GB', N'24 GB DDR3 DIMM', N'RIVROYRIVJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 198: ROYALTON RIV PLAYA PIER27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VP9Z', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'SSD', N'500 GB', N'16 GB DDR3 DIMM', N'SVRROYPY',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON RIV PLAYA PIER27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON RIV PLAYA PIER27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 199: ROYALTON SPLASH RIV BOARDWALK SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HM5S5S3', N'DELL OptiPlex 7000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRRYTSPL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV BOARDWALK SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON SPLASH RIV BOARDWALK SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 200: ROYALTON SPLASH RIV BOARDWALK CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'1R5S5S3', N'DELL OptiPlex 7000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVROYSPLM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV BOARDWALK CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON SPLASH RIV BOARDWALK CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 201: ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01YBZ6', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVROYSPLMC3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON SPLASH RIV BOARDWALK AMIANI CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 202: ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02T0DG', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'i5-4460', N'SSD', N'240 GB', N'16 GB DDR3 DIMM', N'RIVROYSPLR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON SPLASH RIVIERA BOARDWALK RECEPTOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 203: ROYALTON SPLASH RIV JOYERIA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VMLA', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVROYSPLJ01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIV JOYERIA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON SPLASH RIV JOYERIA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 204: *ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'CN5S5S4', N'DELL OptiPlex 7000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'SVRRYTSPLCZ',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*ROYALTON SPLASH RIVIERA EL CORAZON SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 205: ROYALTON SPLASH RIVIERA EL CORAZON CJ1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'98DYRT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'8 GB SODIMM', N'ROYCORAZONCJ1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON SPLASH RIVIERA EL CORAZON CJ1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON SPLASH RIVIERA EL CORAZON CJ1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 206: *ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'2Q5S5S3', N'DELL OptiPlex 7000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'500 GB', N'16 GB RAM', N'SVRRYTSPL27',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*ROYALTON SPLASH RIVIERA PIER 27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 207: HARDROCK HACIENDAS PIER27 SERVIDORx
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9F2', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'I5-10400T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'RHPSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS PIER27 SERVIDORx' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HACIENDAS PIER27 SERVIDORx', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 208: HARDROCK HACIENDAS PIER27 CAJA 1x
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'DCNMHK2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVHRDHDATC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS PIER27 CAJA 1x' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HACIENDAS PIER27 CAJA 1x', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 209: HARDROCK HACIENDAS PIER27 CAJA 2x
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7TYK8X2', N'DELL OptiPlex 7060 Micro', N'Windows 11', N'Windows 11', N'I5-8500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVHRDHDATC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS PIER27 CAJA 2x' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HACIENDAS PIER27 CAJA 2x', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 210: HARDROCK HACIENDAS MARINI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNWV8', N'LENOVO M70q Gen 2', N'Windows 11', N'Windows 11', N'I5-11400T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVHRDHDAJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HACIENDAS MARINI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HACIENDAS MARINI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 211: *HARDROCK HACIENDAS AMIANI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9EL', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'I5-10400T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RHASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*HARDROCK HACIENDAS AMIANI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*HARDROCK HACIENDAS AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 212: HARDROCK HEAVEN JOYERIA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEGL', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'HDD', N'500 GB', N'8 GB DIMM', N'RRASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN JOYERIA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HEAVEN JOYERIA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 213: HARDROCK HEAVEN AMIANI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'67DPRT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVHARDHEAAC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN AMIANI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HEAVEN AMIANI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 214: HARDROCK HEAVEN PIER27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'4J20GT3', N'LENOVO OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RRPSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN PIER27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HEAVEN PIER27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 215: HARDROCK HEAVEN PIER27 CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'FF20GT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVHRDHEAPC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN PIER27 CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HEAVEN PIER27 CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 216: HARDROCK HEAVEN PIER27 CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JQZXRT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB DRR4 SODIMM', N'RIVHRDHEAPC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK HEAVEN PIER27 CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK HEAVEN PIER27 CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 217: UNICO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9H1', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'I5-10400T', N'SSD', N'250 GB', N'16 GB DRR4 SODIMM', N'UNICOSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'UNICO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'UNICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 218: UNICO CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03VEJ7', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'120 GB', N'8 GB DIMM', N'RIVUNICOMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'UNICO CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'UNICO CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 219: UNICO JOY
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'1T856Q2', N'DELL Vostro 3470', N'Windows 10', N'Windows 10', N'I5-8400', N'HDD', N'1 TB', N'8 GB DIMM', N'JOYUNICO',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'UNICO JOY' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'UNICO JOY', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 220: UNICO PIER27 VIVA MEXICO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01J6Q5', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVUNIVMEPSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'UNICO PIER27 VIVA MEXICO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'UNICO PIER27 VIVA MEXICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 221: SIRENIS MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HF9S', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVSIRENIMSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SIRENIS MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SIRENIS MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 222: SIRENIS MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01J6MK', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVSIRENIMC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SIRENIS MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SIRENIS MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 223: *SIRENIS TDA DE PLAYA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HFFV', N'LENOVO Neo 50q Gen 3', N'Windows 10', N'Windows 10', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVSIRENIPSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*SIRENIS TDA DE PLAYA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*SIRENIS TDA DE PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 224: SIRENIS CARRETA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01MADE', N'LENOVO Neo 50q Gen 4', NULL, NULL, N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVSIRENIPC02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SIRENIS CARRETA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SIRENIS CARRETA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 225: *PALMAR BEACH PIER27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'5PJ7Z24', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVPALBEAPSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'*PALMAR BEACH PIER27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'*PALMAR BEACH PIER27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 226: PALMAR BEACH AMIANI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6XM7Z24', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVPALBEAASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALMAR BEACH AMIANI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALMAR BEACH AMIANI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 227: PALMAR BEACH ALBERCA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'RIVPALBEAESVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALMAR BEACH ALBERCA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALMAR BEACH ALBERCA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 228: SIRENIS VIVA MEXICO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HF8T', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVSIRENIVSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SIRENIS VIVA MEXICO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SIRENIS VIVA MEXICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 229: SIRENIS VIVA MEXICO CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01PALW', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'RIVSIRENIVC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'SIRENIS VIVA MEXICO CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'SIRENIS VIVA MEXICO CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 230: PARAISO LA BONITA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01ZKFG', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVR-MX25-PLB01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PARAISO LA BONITA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PARAISO LA BONITA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: PTOHSRD ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTOHSRD';

-- Registro 231: H10 Ocean Blue Lobby
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9ES', N'LENOVO M70q Desktop', N'Windows 10', N'Windows 10', N'I5-10400T', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRMH10O',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Lobby' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 Ocean Blue Lobby', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 232: H10 Ocean Blue Multi Caja 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FG3CK', N'LENOVO M70q Desktop', N'Windows 11', N'Windows 11', N'I5-10400T', N'NVMe', N'500 GB', N'8 GB DRR4 SODIMM', N'DOMH10BLUEC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Multi Caja 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 Ocean Blue Multi Caja 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 233: H10 Ocean Blue Lobby Caja 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9E0', N'LENOVO M70q Desktop', N'Windows 10', N'Windows 10', N'I5-10400T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'DOMH10BLUEC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Lobby Caja 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 Ocean Blue Lobby Caja 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 234: H10 OCEAN BLUE PLAYA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MZ000Q4L', N'LENOVO IdeaCentre 3 07IRB8', N'Windows 11', N'Windows 11', N'I5-14400', N'NVMe', N'1 TB', N'16 GB DIMM', N'SVR-RD25-HPA01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 OCEAN BLUE PLAYA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 OCEAN BLUE PLAYA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 235: H10 Ocean Blue Riddim SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0GHWQN', N'LENOVO M75q Gen 2', N'Windows 10', N'Windows 10', N'RYZEN 5 PRO 4650GE', NULL, N'250 GB', N'8 GB', N'HORSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 Ocean Blue Riddim SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 Ocean Blue Riddim SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 236: H10 EL FARO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FF9EV', N'LENOVO M70q Desktop', N'Windows 10', N'Windows 10', N'I5-10400T', N'NVMe', N'500 GB', N'8 GB DRR4 SODIMM', N'SVRMHFA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 EL FARO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 EL FARO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 237: H10 EL FARO CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'DOMH10FARMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 EL FARO CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 EL FARO CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 238: H10 EL FARO CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'498BPK3', N'DELL OptiPlex 7090', N'Windows 11', N'Windows 11', N'I5-10505', N'SSD', N'500 GB', N'8 GB DIMM', N'DOMH10FARMC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 EL FARO CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 EL FARO CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 239: PALLADIUM PALACE MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'1YNGJ13', N'DELL OptiPlex 7070 Micro', N'Windows 10', N'Windows 10', N'I5-9500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRPLDPCPAL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM PALACE MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 240: PALLADIUM PALACE MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02N06F', N'LENOVO M83', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'500 GB', N'8 GB DDR3 DIMM', N'DOMPLDPCPALMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM PALACE MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 241: PALLADIUM PALACE MULTI ALMACEN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'500 GB', N'8 GB DDR3 DIMM', N'DOMPLDPCPALALM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE MULTI ALMACEN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM PALACE MULTI ALMACEN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 242: PALLADIUM BAVARO AMIANI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'SVRPLDPCBAV',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO AMIANI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM BAVARO AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 243: PALLADIUM PALACE ALMACEN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM PALACE ALMACEN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM PALACE ALMACEN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 244: PALLADIUM BAVARO MULTI SERVER
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'SVRPLDPCAMI',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO MULTI SERVER' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM BAVARO MULTI SERVER', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 245: PALLADIUM BAVARO M1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Pallbavmultic1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO M1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM BAVARO M1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 246: PALLADIUM BAVARO ALMACEN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO ALMACEN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM BAVARO ALMACEN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 247: PALLADIUM BAVARO ALBERCA PLAYA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PB0', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'SVR-RD25-PPA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO ALBERCA PLAYA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM BAVARO ALBERCA PLAYA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 248: PRINCESS BAVARO MULTI SERVER NUEVO
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KWNAR', N'LENOVO IdeaCentre Mini 01IRH8', N'Windows 11', N'Windows 11', N'I5-13500H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRPRINBAVMUL',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO MULTI SERVER NUEVO' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO MULTI SERVER NUEVO', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 249: PRINCESS BAVARO RD MULTI caja1 (ANTES RIDDIM)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0GHWQY', N'LENOVO M75q Gen 2', N'Windows 11', N'Windows 11', N'AMD Ryzen 5 PRO 4650GE', N'SSD', NULL, N'8 GB SODIMM', N'DOMPRNBV0TC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD MULTI caja1 (ANTES RIDDIM)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RD MULTI caja1 (ANTES RIDDIM)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 250: PRINCESS BAVARO RD MULTI caja 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'DOMPRNBAVMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD MULTI caja 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RD MULTI caja 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 251: PRINCESS BAVARO RD MULTI caja 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0FG3CM', N'LENOVO M70q', N'Windows 11', N'Windows 11', N'I5-10400T', N'NVMe', N'500 GB', N'8 GB SODIMM', N'DOMPRNBAVMC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD MULTI caja 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RD MULTI caja 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 252: PRINCESS BAVARO RD JOY
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'8FQCLM3', N'DELL OptiPlex 7090', N'Windows 11', N'Windows 11', N'I5-10505', N'NVMe', N'250 GB', N'8 GB DIMM', N'DOMPRNBAVMJOYC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD JOY' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RD JOY', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 253: PRINCESS BAVARO RIDDIM SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MZ004RZF', N'LENOVO IdeaCentre 3 07IRB8', N'Windows 11', N'Windows 11', N'I5-14400', N'NVMe', N'1 TB', N'16 GB DIMM', N'DOMPRNBVORSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RIDDIM SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RIDDIM SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 254: PRINCESS BAVARO RD RIDDIM
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'BGSM8X2', N'DELL OptiPlex 3060 Micro', N'Windows 11', N'Windows 11', N'I5-8400T', N'HDD', N'1 TB', N'8 GB SODIMM', N'DOMPRNBV0TC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD RIDDIM' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RD RIDDIM', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 255: PRINCESS BAVARO RD PLAYA PIER27 SVR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'B3PQ9W2', N'DELL OptiPlex 3060 Micro', N'Windows 10', N'Windows 10', N'I5-8400T', N'SSD', N'500 GB', N'8 GB SODIMM', N'SVRPRINBAVPYA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PRINCESS BAVARO RD PLAYA PIER27 SVR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PRINCESS BAVARO RD PLAYA PIER27 SVR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 256: PALLADIUM BAVARO ALMACEN
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM BAVARO ALMACEN' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM BAVARO ALMACEN', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 257: ROYALTON BAVARO BOARDWALK Servidor
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'J4SJ5S3', N'DELL OptiPlex 7000 Small Form Factor', N'Windows 11', N'Windows 11', N'I5-12500', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVRRYTBVB',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON BAVARO BOARDWALK Servidor' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON BAVARO BOARDWALK Servidor', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 258: Royalton Bavaro Boardwalk Caja
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'47SJ5S3', N'DELL OptiPlex 7000', N'Windows 11', N'Windows 11', N'I5-12500', N'NVMe', N'500 GB', NULL, N'DOMROYBAVJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Royalton Bavaro Boardwalk Caja' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Royalton Bavaro Boardwalk Caja', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 259: Royalton Bavaro CJ2 Pier27 Server
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'G5SJ5S3', N'DELL OptiPlex 7000 Small', N'Windows 11', N'Windows 11', N'I5-12500', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVRRYTBVP27',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'Royalton Bavaro CJ2 Pier27 Server' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'Royalton Bavaro CJ2 Pier27 Server', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 260: HARD ROCK PC VIVA SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'J01ZK7A', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD25-HRV01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC VIVA SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC VIVA SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 261: HARD ROCK PC VIVA CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'J01ZK5L', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'DSK-RD25-HRV01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC VIVA CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC VIVA CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 262: HARD ROCK PC ALBERCA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'J01ZK42', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD25-HRA01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC ALBERCA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC ALBERCA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 263: HARD ROCK PC ALBERCA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PHN', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD25-HRB01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC ALBERCA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC ALBERCA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 264: HARD ROCK PC ALBERCA 3
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PGM', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD25-HRC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC ALBERCA 3' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC ALBERCA 3', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 265: HARD ROCK PC SPLASH
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026P5H', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD25-HRS01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC SPLASH' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC SPLASH', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 266: HARD ROCK PC MULTI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PBS', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD25-HRM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC MULTI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC MULTI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 267: HARD ROCK PC MULTI CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026Q3W', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'POS-RD25-HRM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC MULTI CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC MULTI CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 268: HARD ROCK PC MULTI CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PFP', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'POS-RD25-HRM02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC MULTI CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC MULTI CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 269: HARD ROCK PC BODEGA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026PSN', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'ALM-RD25-HRL01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARD ROCK PC BODEGA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARD ROCK PC BODEGA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 270: MOON PALACE RD GOLF
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ0256WS', N'Lenovo ThinkCentre Neo 50Q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DIMM', N'SVR-RD26-PPR01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'MOON PALACE RD GOLF' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'MOON PALACE RD GOLF', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- === Company: PTOHS_44_ ===
SELECT @CompanyID = [CompanyID] FROM [dbo].[Company] WHERE [Description] = N'PTOHS_44_';

-- Registro 271: HYATT ZIVA CANCUN MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'6ZT0CM2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRHYATTCUN',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT ZIVA CANCUN MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT ZIVA CANCUN MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 272: HYATT ZIVA CANCUN MULTI CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03608P', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'i5-4460', N'SSD', N'500 GB', N'16 GB DRR3 DIMM', N'CUNHYTZIVTC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT ZIVA CANCUN MULTI CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT ZIVA CANCUN MULTI CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 273: HYATT ZIVA CANCUN JOY CAJA (forti)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VMMZ', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'DSK-MX25-HYNJ1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT ZIVA CANCUN JOY CAJA (forti)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT ZIVA CANCUN JOY CAJA (forti)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 274: HYATT CANCUN PIER 27
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'3N9VHK2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'500 GB', NULL, N'SVRHYP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HYATT CANCUN PIER 27' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HYATT CANCUN PIER 27', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 275: PALLADIUM CM PIER 27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JPMPK44', N'DELL OptiPlex Micro 7010', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'500 GB', N'32 GB DRR4 SODIMM', N'SVRPCOSMUJERES',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM PIER 27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 276: PALLADIUM CM PIER27 HOLBIE (alberca niños) CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HR00MP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'HDD', N'1 TB', N'8 GB SODIMM', N'P-PIER27HOLBIE',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM PIER27 HOLBIE (alberca niños) CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM PIER27 HOLBIE (alberca niños) CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 277: PALLADIUM CM AMIANI ALBERCA ADULTOS CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HVPXLP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'HDD', N'1 TB', N'8 GB SODIMM', N'P-AMIANIALBERCA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM AMIANI ALBERCA ADULTOS CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM AMIANI ALBERCA ADULTOS CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 278: PALLADIUM CM AMIANI LOBBY TRS CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HT9YLP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'HDD', N'1 TB', N'8 GB SODIMM', N'CUNPALLADATRS',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM AMIANI LOBBY TRS CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM AMIANI LOBBY TRS CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 279: PALLADIUM CM BOARWALK CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ009K5S', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4440S', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'PBOARWALK-C1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM BOARWALK CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM BOARWALK CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 280: PALLADIUM CM BOARWALK CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HVS1HP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'16 GB SODIMM', N'PBOARWALK-C2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM BOARWALK CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM BOARWALK CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 281: PALLADIUM CM BOARWALK CAJA 3
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HQX2MP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'SSD', N'250 GB', N'16 GB SODIMM', N'PBOARWALK-C3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM BOARWALK CAJA 3' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM BOARWALK CAJA 3', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 282: PALLADIUM CM JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JGHTQP2', N'DELL OptiPlex 7050 Micro', N'Windows 10', N'Windows 10', N'I5-7500T', N'HDD', N'1 TB', N'8 GB SODIMM', N'PalCosMujJoy',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PALLADIUM CM JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PALLADIUM CM JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 283: PLANET HWD CM ALBERCA ADULTOS AMIANI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01V6D7', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'I3-1215U', N'NVMe', N'500 GB', N'16 GB DRR4 SODIMM', N'SVRPHCMAA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM ALBERCA ADULTOS AMIANI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PLANET HWD CM ALBERCA ADULTOS AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 284: PLANET HWD CM ALBERCA NIÑOS PIER 27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02JX0E', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'SVRPHCMAP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM ALBERCA NIÑOS PIER 27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PLANET HWD CM ALBERCA NIÑOS PIER 27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 285: PLANET HWD CM BOARDWALK SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03608C', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'SVRPHCM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM BOARDWALK SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PLANET HWD CM BOARDWALK SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 286: PLANET HWD CM BOARDWALK CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ02N08T', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'SSD', N'250 GB', N'16 GB DRR3 DIMM', N'CCMPNTHWDM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM BOARDWALK CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PLANET HWD CM BOARDWALK CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 287: PLANET HWD CM JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ01MGS3', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'500 GB', N'8 GB DDR 3 DIMM', N'CCMPNYHWDJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'PLANET HWD CM JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'PLANET HWD CM JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 288: RIU DUNAMAR SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ046K1F', N'LENOVO M700 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB DDR3 DIMM', N'RDMSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU DUNAMAR SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU DUNAMAR SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 289: RIU DUNAMAR TAB CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HV1LJK2', N'DELL OptiPlex 7050', N'Windows 10', N'Windows 10', N'I5-7500', N'SSD', N'250 GB', N'16 GB DIMM', N'RIU-DUNAMAR-CAJA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU DUNAMAR TAB CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU DUNAMAR TAB CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 290: RIU DUNAMAR JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HV14PD2', N'DELL OptiPlex 7050', N'Windows 10', N'Windows 10', N'I5-7500', N'SSD', N'500 GB', N'16 GB DIMM', N'RiuDunamar-Joy',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU DUNAMAR JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU DUNAMAR JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 291: RIU PALACE COSTA MUJERES
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ03XGQ4', N'LENOVO M800 Desktop', N'Windows 11', N'Windows 11', N'I5-6400', N'SSD', N'250 GB', N'16 GB DDR3 DIMM', N'SVRRIUPALACE',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE COSTA MUJERES' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PALACE COSTA MUJERES', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 292: RIU PALACE TAB CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBF5Z72', N'Dell optiplex 7050', N'Windows 11', N'Windows 11', N'i5-8500T', N'SSD', N'250 GB', N'16 GB DDR4 SODIMM', N'CCMRIUPALMC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE TAB CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PALACE TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 293: RIU PALACE TAB CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBF5Z72', N'DELL OptiPlex 7060', N'Windows 11', N'Windows 11', N'i5-8500T', N'SSD', N'250 GB', N'16 GB SODIMM', N'CCMRIUPALMC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE TAB CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PALACE TAB CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 294: RIU PALACE JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBHG8C2', N'DELL OptiPlex 7060', N'Windows 11', N'Windows 11', N'i5-8500T', N'SSD', N'250 GB', N'16 GB SODIMM', N'CCMRIUPALJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PALACE JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PALACE JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 295: RIU PENINSULA TAB SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ04LR62', N'LENOVO M800 Desktop', N'Windows 10', N'Windows 10', N'I5-6400', N'SSD', N'250 GB', N'16 GB SODIM', N'RPCSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PENINSULA TAB SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PENINSULA TAB SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 296: RIU PENINSULA JOY CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'HV1BD92', N'DELL OptiPlex 7050', N'Windows 10', N'Windows 10', N'I5-7500', N'HDD', N'1 TB', N'8 GB SODIMM', N'JOY-RIUPENINSULA',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU PENINSULA JOY CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU PENINSULA JOY CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 297: ROYALTON CANCUN TAB SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBH37J2', N'DELL OptiPlex 7060 Micro', N'Windows 11', N'Windows 11', N'I5-8500T', N'SSD', N'250 GB', N'16 GB DDR4 SODIMM', N'SVRROYALTONCUN',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON CANCUN TAB SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON CANCUN TAB SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 298: ROYALTON CANCUN TAB CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ01T1Q7', N'LENOVO M83 Desktop', N'Windows 10', N'Windows 10', N'I5-4460', N'HDD', N'1 TB', N'8 GB DDR3 DIMM', N'RYC-CAJA2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON CANCUN TAB CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON CANCUN TAB CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 299: ROYALTON CANCUN JOY CAJA (forti)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBH1C62', N'DELL OptiPlex 7060', N'Windows 10', N'Windows 10', N'I5-8500T', N'HDD', N'500 GB', N'8 GB SODIMM', N'CUNROYLTNJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYALTON CANCUN JOY CAJA (forti)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYALTON CANCUN JOY CAJA (forti)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 300: EMPORIO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNWTB', N'LENOVO M70q Gen 2', N'Windows 11', N'Windows 11', N'I5-11400T', N'NVMe', N'500 GB', N'8 GB DDR4 SODIMM', N'SVREMP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'EMPORIO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'EMPORIO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 301: RIU LATINO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNWZ9', N'LENOVO M70q Gen 2', N'Windows 11', N'Windows 11', N'I5-11400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'SVRRLO',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU LATINO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU LATINO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 302: RIU LATINO CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNX7Y', N'LENOVO M70q Gen 2', N'Windows 10', N'Windows 10', N'I5-11400T', N'SSD', N'500 GB', N'16 GB DDR4 SODIMM', N'CCMRIULATPC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU LATINO CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU LATINO CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 303: RIU LATINO JOY (forti)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'7FTCXP3', N'DELL OptiPlex 7090', N'Windows 10', N'Windows 10', N'I5-10500T', N'NVMe', N'250 GB', N'16 GB DDR4 SODIMM', N'CCMRIULATJC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU LATINO JOY (forti)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU LATINO JOY (forti)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 304: RENAISSANCE
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNX9B', N'LENOVO M70q Gen 2', N'Windows 11', N'Windows 11', N'I5-11400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'SVRREN',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RENAISSANCE' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RENAISSANCE', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 305: RIU KUKULKAN SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0HNWY7', N'LENOVO M70q Gen 2', N'Windows 11', N'Windows 11', N'I5-11400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'SVRRKN',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU KUKULKAN SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU KUKULKAN SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 306: HARDROCK CANCUN PIER27 SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0K9RW3', N'LENOVO M70s Gen 3', N'Windows 11', N'Windows 11', N'I5-12400', N'NVMe', N'250 GB', N'16 GB DIMM', N'SVRRHC',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN PIER27 SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CANCUN PIER27 SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 307: HARDROCK CANCUN PIER27 CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'BM50GT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CUNHRDRCKPC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN PIER27 CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CANCUN PIER27 CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 308: HARDROCK CANCUN PIER27 CAJA 2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'BD20GT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CUNHRDRCKPC2',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN PIER27 CAJA 2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CANCUN PIER27 CAJA 2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 309: HARDROCK CANCUN JOYERIA (MARINI)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'98ZZFT3', N'DELL OptiPlex 3000 Micro', N'Windows 11', N'Windows 11', N'I5-12500T', N'NVMe', N'250 GB', N'16 GB SODIMM', N'CUNHRDRCKSC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN JOYERIA (MARINI)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CANCUN JOYERIA (MARINI)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 310: HARDROCK CANCUN TDA DE PLAYA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JBFMJK2', N'DELL OptiPlex 7060 Micro', N'Windows 11', N'Windows 11', N'I5-8500T', N'NVMe', N'500 GB', N'8 GB SODIMM', N'CUNHRDRCKPC3',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HARDROCK CANCUN TDA DE PLAYA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HARDROCK CANCUN TDA DE PLAYA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 311: HILTON CANCUN MULTI
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0KS65E', N'LENOVO M70q Gen 3', N'Windows 11', N'Windows 11', N'I5-12400T', N'NVMe', N'250 GB', N'16 GB DDR4 SODIMM', N'CUNHILTONMSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HILTON CANCUN MULTI' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HILTON CANCUN MULTI', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 312: AVA AMIANI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HFJ9', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA AMIANI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA AMIANI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 313: AVA CORAZÓN SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HFD2', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVACSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA CORAZÓN SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA CORAZÓN SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 314: AVA CORAZON CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01HFH5', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB SODIMM', N'CUNAVACC02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA CORAZON CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA CORAZON CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 315: AVA MARINI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0LKF3R', N'LENOVO M70q Gen 4', N'Windows 11', N'Windows 11', N'I5-13400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAJSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA MARINI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA MARINI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 316: HILARIO RASCON
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'HRASCON',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SET @VendorID = @DefaultVendorID;
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'HILARIO RASCON' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'HILARIO RASCON', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 317: AVA PIER27 EMBARCADERO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0LKF53', N'LENOVO M70q Gen 4', N'Windows 11', N'Windows 11', N'I5-13400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPESVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 EMBARCADERO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27 EMBARCADERO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 318: AVA PIER27 EMBARCADERO CAJA1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0LKF3X', N'LENOVO M70q Gen 4', N'Windows 11', N'Windows 11', N'I5-13400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPEC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 EMBARCADERO CAJA1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27 EMBARCADERO CAJA1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 319: AVA PIER27 EMBARCADERO CAJA2
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0LKF3W', N'LENOVO M70q Gen 4', N'Windows 11', N'Windows 11', N'I5-13400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPEC02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 EMBARCADERO CAJA2' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27 EMBARCADERO CAJA2', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 320: AVA FINI SUNGLASS SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01MAH6', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAFSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA FINI SUNGLASS SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA FINI SUNGLASS SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 321: AVA FINI SUNGLASS CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01MAKW', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAFJ01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA FINI SUNGLASS CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA FINI SUNGLASS CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 322: AVA PIER27 ALBERCA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01M9SP', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPASVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 ALBERCA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27 ALBERCA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 323: AVA VIVA MÉXICO SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01MA23', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPVSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA VIVA MÉXICO SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA VIVA MÉXICO SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 324: AVA VIVA MÉXICO CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01M9WH', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPVC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA VIVA MÉXICO CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA VIVA MÉXICO CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 325: AVA PIER27-AMIANI (MULTI) SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01MA6N', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAMSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27-AMIANI (MULTI) SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27-AMIANI (MULTI) SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 326: AVA PIER27-AMIANI CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'MJ0LKF21', N'LENOVO M70q Gen 4', N'Windows 11', N'Windows 11', N'I5-13400T', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAMBC1',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27-AMIANI CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27-AMIANI CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 327: AVA PIER27 SPLASH(AQUAPARQUE)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01MAFK', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVAPSSVR',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA PIER27 SPLASH(AQUAPARQUE)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA PIER27 SPLASH(AQUAPARQUE)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 328: AVA BODEGA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01Q7A2', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'500 GB', N'16 GB DDR4 SODIMM', N'CUNAVABOD',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'AVA BODEGA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'AVA BODEGA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 329: BAZAR TABAQUERIA CORPORATIVO(TABLET)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Microsoft', N'61855305053', N'Surface Pro 7+', N'Windows 11', N'Windows 11', N'i5-1135g7', N'NVMe', N'250 GB', N'16 gb', N'SVR-MX25-BZR01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Microsoft';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'BAZAR TABAQUERIA CORPORATIVO(TABLET)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'BAZAR TABAQUERIA CORPORATIVO(TABLET)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 330: H10 COSTA MUJERES SERVIDOR (H10 OCEAN AZURE)
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01ZK97', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'512 GB', N'16 GB DDR4 3200MHZ SODIMM', N'SVR-MX25-H1C01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 COSTA MUJERES SERVIDOR (H10 OCEAN AZURE)' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 COSTA MUJERES SERVIDOR (H10 OCEAN AZURE)', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 331: H10 COSTA MUJERES CAJA
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ01VMRA', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'512 GB', N'16 GB DDR4 3200MHZ SODIMM', N'DSK-MX25-H1C02',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'H10 COSTA MUJERES CAJA' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'H10 COSTA MUJERES CAJA', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 332: RIU VENTURA MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026Q2N', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'512 GB', N'16 GB DDR4 3200MHZ SODIMM', N'SVR-MX25-RVM',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU VENTURA MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU VENTURA MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 333: RIU VENTURA MULTI CAJA 1
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', N'YJ026Q0Z', N'LENOVO Neo 50q Gen 4', N'Windows 11', N'Windows 11', N'i5-13420H', N'NVMe', N'512 GB', N'16 GB DDR4 3200MHZ SODIMM', N'POS-MX25-RVM01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'RIU VENTURA MULTI CAJA 1' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'RIU VENTURA MULTI CAJA 1', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 334: ROYAL SOLARIS MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'DFP8ND4', N'DELL Pro Micro QCM1250', N'Windows 11', N'Windows 11', N'i5-14500T', N'NVMe', N'512 GB', N'16 GB DDR5 SODIMM', N'SVR-MX25-RSC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'ROYAL SOLARIS MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'ROYAL SOLARIS MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 335: GR SOLARIS CANCÚN MULTI SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'CQS8ND4', N'DELL Pro Micro QCM1250', N'Windows 11', N'Windows 11', N'i5-14500T', N'NVMe', N'512 GB', N'16 GB DDR5 SODIMM', N'SVR-MX25-GSN01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'GR SOLARIS CANCÚN MULTI SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'GR SOLARIS CANCÚN MULTI SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 336: GR SOLARIS CARIBE
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Dell', N'JRS8ND4', N'DELL Pro Micro QCM1250', N'Windows 11', N'Windows 11', N'i5-14500T', N'NVMe', N'512 GB', N'16 GB DDR5 SODIMM', N'SVR-MX25-GSC01',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Dell';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'GR SOLARIS CARIBE' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'GR SOLARIS CARIBE', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

-- Registro 337: GRAND HYATT PUERTO CANCUN SERVIDOR
INSERT INTO [dbo].[AssetDetail] ([ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], [Processor], [HDDModel], [HDDCapacity], [RAM], [Domain],
    [IPAddress], [MACAddress], [Loanable], [VMPlatform], [VirtualHost], [ProcessorInfo], [PhysicalMemory], [HDDSerial], [KeyboardType], [MouseType],
    [NumModel], [IMEI], [ModemFirmwareVersion], [Platform], [OSVersion], [PurchaseDate], [WarrantyExpiryDate], [CreatedTime], [LastUpdateTime],
    [AssetACQDate], [AssetExpiryDate], [AssetTAG], [WarrantyExpiry], [AssignedTime], [Barcode], [Factura], [Ticket], [LastUpdateBy])
VALUES (N'Lenovo', NULL, N'LENOVO Neo 50q Gen 5', N'Windows 11', N'Windows 11', N'i5 210H', N'NVMe', N'512 GB', N'16 GB DDR5 SODIMM', N'SVR-MX26-GHP',
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @ETLUserID);
SET @NewDetailID = SCOPE_IDENTITY();
SELECT @VendorID = [VendorID] FROM [dbo].[Vendor] WHERE [Name] = N'Lenovo';
SELECT @SiteID = [SiteID] FROM [dbo].[Site] WHERE [Name] = N'GRAND HYATT PUERTO CANCUN SERVIDOR' AND [CompanyID] = @CompanyID;
INSERT INTO [dbo].[Asset] ([Name], [VendorID], [ProductTypeID], [AssetState], [CompanyID], [SiteID], [UserID], [ParentAssetID], [DepartID], [AssetDetailID])
VALUES (N'GRAND HYATT PUERTO CANCUN SERVIDOR', @VendorID, @ProductTypeID, @AssetStateID, @CompanyID, @SiteID, NULL, NULL, NULL, @NewDetailID);

GO
-- RESUMEN v4: 9 Companies, 334 Sites, 5 Vendors, 337 Assets+Details
-- NOT NULL resueltos: AssetState='En uso', ProductTypeID='Equipo', LastUpdateBy=user ETL, VendorID='Sin identificar'