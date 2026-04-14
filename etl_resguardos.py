"""
ETL para Resguardos (Accesorios) - Versión 3
Autor: Claude para CAMARA
Fecha: Abril 2026

LÓGICA:
1. Lee el Excel de Resguardos
2. Agrupa por HOTEL+DEPART
3. Para CPUs que YA EXISTEN en BD → genera SQL para insertar accesorios
4. Para CPUs que NO EXISTEN en BD → exporta a Excel para revisión
5. DOMAIN solo se llena para equipos principales, NO para accesorios
"""

import pandas as pd
import re
from datetime import datetime

# ============================================================
# CONFIGURACIÓN
# ============================================================

ETL_USER_ID = 11
VENDOR_ID = 1

# ============================================================
# CPUs QUE YA EXISTEN EN TU BD (SerialNumbers)
# Actualiza esta lista con los que tienes
# ============================================================
CPUS_EN_BD = [
    'MJ03XGPE',   # BEACHPALACE TAB CAJA
    'MJ0360BT',   # BEACHPALACE JOY CAJA
    'YJ01TQRZ',   # HYATT ZILARA JOY CAJA
    '3D7M9N2',    # PRINCESS RIV CAJA1
    'YJ01ZK08',   # PRINCESS SUNSET SERVIDOR
    '6915JL2',    # PRINCESS SUNSET TAB CAJA1
    '171F8R2',    # PRINCESS SUNSET TAB CAJA2
    'MJ0FF9F3',   # ROYALTON RIV SERVIDOR
    'JGHLQP2',    # ROYALTON RIV CAJA3 PIER27
    'MJ03XMTQ',   # ROYALTON RIV CAJA4 AMIANI
]

# ============================================================
# MAPEOS
# ============================================================
ASSET_STATE_MAP = {
    'RESGUARDO': 2,
    'BAJA': 3,
}

COMPANY_MAP = {
    'ISLA17': 1,
    'HSPRO': 2,
    'PTOARENAS': 9,
}

SITE_MAP = {
    'BEACH PALACE': 2,
    'BEACHPALACE': 2,
    'PRINCESS SUNSET': 35,
    'HYATT ZILARA MULTI': 18,
    'HYATT ZILARA': 18,
    'ROYALTON RIVIERA MULTI': 41,
    'ROYALTON RIVIERA PLAYA': 42,
    'PRINCESS RIVIERA': 26,
    'PRINCESS RIVIERA TDA PLAYA': 26,
    'PRINCESS RIVIERA TDA PLAY': 26,
}

DEPART_MAP = {
    'IT': 1,
    'SERVIDOR': 1,
    'AMIANI': 2,
    'PIER27': 3,
    'PIER 27': 3,
    'MULTI': 4,
    'JOYERIA': 5,
    'JOY': 5,
    'CEDIS': 6,
    'AUDITORIA': 7,
    'TABAQUERIA': 8,
    'ALMACEN': 9,
    'TRAFICO': 10,
    'CORPORATIVO': 11,
    'CAJA': 12,
    'CAJA 1': 12,
    'CAJA 2': 12,
    'CAJA 3 PIER 27': 3,
    'CAJA 4 AMIANI': 2,
    'AQUAPARK': 13,
    'CARRETA': 14,
    'CORAZON': 15,
    'CORONA': 16,
    'PROSHOP': 19,
    'PUEBLITO': 20,
    'RECEPTORIA': 21,
    'SUNGLASS': 22,
    'VIVA MEXICO': 23,
}

PRODUCT_TYPE_MAP = {
    'CPU': 1, 'COMPUTADORA': 1, 'PC': 1, 'MINI PC': 1, 'SERVIDOR': 2, 'TERMINAL': 1,
    'MONITOR': 3, 'MONITOR 19.5 "': 3,
    'MOUSE': 4, 'MOUSE ALAMBRICO': 4,
    'TECLADO': 5, 'TECLADO ALAMBRICO': 5,
    'ESCANER': 6, 'ESCANER ALAMBRICO': 6,
    'NO BREAK': 7, 'NO BREAK 1000 WATTS': 7, 'UPS': 7,
    'IMP TICKETS': 8, 'IMPRESORA TICKETS': 8,
    'IMP DOCUMENTOS': 9, 'IMPRESORA DOCUMENTOS': 9,
    'CAJON DE DINERO': 10, 'CAJÓN DE DINERO': 10,
    'SWITCH': 11,
    'LECTOR DE HUELLA': 12, 'LECTOR DE HUELLAS': 12,
    'DIGITALIZADOR': 13,
    'MULTIPUERTOS USB': 14, 'HUB USB': 14,
    'LECTOR DE TARJETAS': 15,
}

EQUIPOS_PRINCIPALES = {'CPU', 'COMPUTADORA', 'PC', 'MINI PC', 'SERVIDOR', 'TERMINAL'}

PRODUCT_TYPE_ABREV = {
    1: 'CPU', 2: 'SRV', 3: 'MON', 4: 'MOU', 5: 'TEC',
    6: 'ESC', 7: 'UPS', 8: 'IMP', 9: 'IPD', 10: 'CAJ',
    11: 'SWI', 12: 'HUE', 13: 'DIG', 14: 'HUB', 15: 'LEC',
}

# ============================================================
# FUNCIONES AUXILIARES
# ============================================================

def clean_text(value):
    if pd.isna(value) or value == '':
        return None
    text = str(value).strip()
    text = re.sub(r'\s+', ' ', text)
    return text

def normalize_text(value):
    if pd.isna(value) or value == '':
        return ''
    return str(value).strip().upper()

def find_company_id(razon_social):
    return COMPANY_MAP.get(normalize_text(razon_social))

def find_site_id(hotel):
    key = normalize_text(hotel)
    if key in SITE_MAP:
        return SITE_MAP[key]
    for site_key, site_id in SITE_MAP.items():
        if site_key in key or key in site_key:
            return site_id
    return None

def find_depart_id(depart):
    key = normalize_text(depart)
    if key in DEPART_MAP:
        return DEPART_MAP[key]
    for depart_key, depart_id in DEPART_MAP.items():
        if depart_key in key:
            return depart_id
    return 1

def find_product_type_id(dispositivo):
    key = normalize_text(dispositivo)
    if key in PRODUCT_TYPE_MAP:
        return PRODUCT_TYPE_MAP[key]
    for prod_key, prod_id in PRODUCT_TYPE_MAP.items():
        if prod_key in key or key in prod_key:
            return prod_id
    return None

def is_equipo_principal(dispositivo):
    return normalize_text(dispositivo) in EQUIPOS_PRINCIPALES

def find_asset_state_id(estatus):
    return ASSET_STATE_MAP.get(normalize_text(estatus), 2)

def sql_string(value):
    if value is None or pd.isna(value) or str(value).strip() == '' or str(value).upper() == 'NAN':
        return 'NULL'
    value = str(value).replace("'", "''")
    return f"N'{value}'"

def cpu_existe_en_bd(serial_num):
    """Verifica si el CPU ya existe en la BD"""
    if not serial_num:
        return False
    return serial_num.upper() in [s.upper() for s in CPUS_EN_BD]

# ============================================================
# PROCESAMIENTO
# ============================================================

def process_excel(filepath):
    """Procesa el Excel y agrupa por HOTEL+DEPART"""
    
    df = pd.read_excel(filepath, sheet_name='Hoja1')
    grupos = {}
    
    for idx, row in df.iterrows():
        serial = clean_text(row.get('NUMERO DE SERIE', ''))
        if not serial or serial.upper() in ['NAN', 'SN', '']:
            continue
        
        hotel = normalize_text(row.get('HOTEL', ''))
        depart = normalize_text(row.get('DEPART', ''))
        grupo_key = f"{hotel}|{depart}"
        
        dispositivo = normalize_text(row.get('DISPOSITIVO', ''))
        product_type_id = find_product_type_id(dispositivo)
        
        if not product_type_id:
            print(f"ADVERTENCIA: Dispositivo no mapeado: {dispositivo}")
            continue
        
        record = {
            'dispositivo': dispositivo,
            'is_principal': is_equipo_principal(dispositivo),
            'product_type_id': product_type_id,
            'company_id': find_company_id(row.get('RAZÓN SOCIAL', '')),
            'site_id': find_site_id(row.get('HOTEL', '')),
            'depart_id': find_depart_id(row.get('DEPART', '')),
            'asset_state_id': find_asset_state_id(row.get('ESTATUS', '')),
            'serial_num': serial,
            'marca': clean_text(row.get('MARCA', '')),
            'modelo': clean_text(row.get('MODELO ', '')),
            'hotel': clean_text(row.get('HOTEL', '')),
            'depart_name': clean_text(row.get('DEPART', '')),
            'observaciones': clean_text(row.get('OBSERVACIONES', '')),
            'razon_social': clean_text(row.get('RAZÓN SOCIAL', '')),
            'estatus': clean_text(row.get('ESTATUS', '')),
        }
        
        if grupo_key not in grupos:
            grupos[grupo_key] = {'cpu': None, 'accesorios': []}
        
        if record['is_principal']:
            grupos[grupo_key]['cpu'] = record
        else:
            grupos[grupo_key]['accesorios'].append(record)
    
    return grupos

def generate_excel_faltantes(grupos, output_path):
    """Genera Excel con CPUs que NO existen en BD y sus accesorios"""
    
    rows = []
    
    for grupo_key, grupo in grupos.items():
        cpu = grupo['cpu']
        accesorios = grupo['accesorios']
        
        if not cpu:
            continue
        
        # Solo si el CPU NO existe en BD
        if cpu_existe_en_bd(cpu['serial_num']):
            continue
        
        # Agregar el CPU
        rows.append({
            'TIPO': 'CPU (FALTA EN BD)',
            'RAZON_SOCIAL': cpu['razon_social'],
            'HOTEL': cpu['hotel'],
            'DEPART': cpu['depart_name'],
            'DISPOSITIVO': cpu['dispositivo'],
            'MARCA': cpu['marca'],
            'MODELO': cpu['modelo'],
            'SERIAL': cpu['serial_num'],
            'ESTATUS': cpu['estatus'],
            'OBSERVACIONES': cpu['observaciones'],
            'GRUPO': grupo_key.replace('|', ' / '),
        })
        
        # Agregar sus accesorios
        for acc in accesorios:
            rows.append({
                'TIPO': 'ACCESORIO (sin CPU en BD)',
                'RAZON_SOCIAL': acc['razon_social'],
                'HOTEL': acc['hotel'],
                'DEPART': acc['depart_name'],
                'DISPOSITIVO': acc['dispositivo'],
                'MARCA': acc['marca'],
                'MODELO': acc['modelo'],
                'SERIAL': acc['serial_num'],
                'ESTATUS': acc['estatus'],
                'OBSERVACIONES': acc['observaciones'],
                'GRUPO': grupo_key.replace('|', ' / '),
            })
    
    if rows:
        df = pd.DataFrame(rows)
        df.to_excel(output_path, index=False, sheet_name='CPUs_Faltantes')
        return len([r for r in rows if 'CPU' in r['TIPO']]), len([r for r in rows if 'ACCESORIO' in r['TIPO']])
    
    return 0, 0

def generate_sql(grupos):
    """Genera SQL SOLO para accesorios de CPUs que YA EXISTEN en BD"""
    
    sql_lines = []
    sql_lines.append("-- ============================================================")
    sql_lines.append(f"-- ETL Resguardos - Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    sql_lines.append("-- ============================================================")
    sql_lines.append("-- LÓGICA:")
    sql_lines.append("-- 1. Solo procesa grupos donde el CPU YA EXISTE en la BD")
    sql_lines.append("-- 2. Busca el CPU por SerialNumber → obtiene AssetID, SiteID, DepartID")
    sql_lines.append("-- 3. Inserta accesorios HEREDANDO ubicación del CPU padre")
    sql_lines.append("-- 4. DOMAIN = NULL para accesorios (solo se usa para equipos principales)")
    sql_lines.append("-- 5. CPUs que NO existen fueron exportados a Excel para revisión")
    sql_lines.append("-- ============================================================")
    sql_lines.append("")
    sql_lines.append("USE InventarioIT;")
    sql_lines.append("GO")
    sql_lines.append("")
    sql_lines.append("-- Variables globales")
    sql_lines.append(f"DECLARE @ETLUserID INT = {ETL_USER_ID};")
    sql_lines.append(f"DECLARE @VendorID INT = {VENDOR_ID};")
    sql_lines.append("DECLARE @NewDetailID INT;")
    sql_lines.append("DECLARE @NewAssetID INT;")
    sql_lines.append("DECLARE @ParentAssetID INT;")
    sql_lines.append("DECLARE @ParentSiteID INT;")
    sql_lines.append("DECLARE @ParentDepartID INT;")
    sql_lines.append("DECLARE @ParentCompanyID INT;")
    sql_lines.append("DECLARE @AssetTAG NVARCHAR(20);")
    sql_lines.append("DECLARE @ProductTypeID INT;")
    sql_lines.append("DECLARE @AssetStateID INT;")
    sql_lines.append("DECLARE @SiteID INT;")
    sql_lines.append("DECLARE @CompanyID INT;")
    sql_lines.append("DECLARE @DepartID INT;")
    sql_lines.append("")
    
    total_accesorios = 0
    grupos_procesados = 0
    
    for grupo_key, grupo in grupos.items():
        cpu = grupo['cpu']
        accesorios = grupo['accesorios']
        
        # Solo procesar si hay CPU y YA EXISTE en BD
        if not cpu:
            continue
        
        if not cpu_existe_en_bd(cpu['serial_num']):
            # Saltar este grupo - se exportó a Excel
            continue
        
        if not accesorios:
            continue
        
        grupos_procesados += 1
        
        sql_lines.append("-- ============================================================")
        sql_lines.append(f"-- GRUPO: {grupo_key.replace('|', ' / ')}")
        sql_lines.append(f"-- CPU: {cpu['serial_num']} (YA EXISTE EN BD)")
        sql_lines.append(f"-- Accesorios a insertar: {len(accesorios)}")
        sql_lines.append("-- ============================================================")
        sql_lines.append("")
        
        # Buscar el CPU existente y obtener sus datos
        sql_lines.append(f"-- Obtener datos del CPU padre (Serial: {cpu['serial_num']})")
        sql_lines.append("SET @ParentAssetID = NULL;")
        sql_lines.append("SET @ParentSiteID = NULL;")
        sql_lines.append("SET @ParentDepartID = NULL;")
        sql_lines.append("SET @ParentCompanyID = NULL;")
        sql_lines.append("")
        sql_lines.append(f"""SELECT TOP 1 
    @ParentAssetID = a.AssetID,
    @ParentSiteID = a.SiteID,
    @ParentDepartID = a.DepartID,
    @ParentCompanyID = a.CompanyID
FROM Asset a
JOIN AssetDetail ad ON a.AssetDetailID = ad.AssetDetailID
WHERE ad.SerialNum = {sql_string(cpu['serial_num'])};""")
        sql_lines.append("")
        sql_lines.append(f"PRINT 'CPU encontrado: AssetID=' + CAST(@ParentAssetID AS VARCHAR) + ', Site=' + CAST(@ParentSiteID AS VARCHAR) + ', Depart=' + CAST(@ParentDepartID AS VARCHAR);")
        sql_lines.append("")
        
        # Insertar accesorios
        for acc in accesorios:
            sql_lines.append(f"-- Accesorio: {acc['dispositivo']} (Serial: {acc['serial_num']})")
            sql_lines.append(f"SET @ProductTypeID = {acc['product_type_id']};")
            sql_lines.append(f"SET @AssetStateID = {acc['asset_state_id']};")
            sql_lines.append("")
            
            # Heredar ubicación del CPU padre
            sql_lines.append("-- Heredar ubicación del CPU padre")
            sql_lines.append("SET @CompanyID = @ParentCompanyID;")
            sql_lines.append("SET @SiteID = @ParentSiteID;")
            sql_lines.append("SET @DepartID = @ParentDepartID;")
            sql_lines.append("")
            
            # INSERT AssetDetail - DOMAIN = NULL para accesorios
            sql_lines.append(f"""INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    {sql_string(acc['marca'])}, {sql_string(acc['serial_num'])}, {sql_string(acc['modelo'])},
    NULL,
    GETDATE(), @ETLUserID);""")
            sql_lines.append("SET @NewDetailID = SCOPE_IDENTITY();")
            sql_lines.append("")
            
            # INSERT Asset
            nombre_acc = f"{acc['hotel']} {acc['depart_name']} {acc['dispositivo']}"
            sql_lines.append(f"""INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    {sql_string(nombre_acc)}, @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, @ParentAssetID, @NewDetailID);""")
            sql_lines.append("SET @NewAssetID = SCOPE_IDENTITY();")
            sql_lines.append("")
            
            # Generar TAG
            abrev = PRODUCT_TYPE_ABREV.get(acc['product_type_id'], 'EQP')
            sql_lines.append(f"""-- Generar AssetTAG
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    '{abrev}' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;""")
            sql_lines.append("")
            
            total_accesorios += 1
    
    sql_lines.append("GO")
    sql_lines.append("")
    sql_lines.append("-- ============================================================")
    sql_lines.append("-- RESUMEN")
    sql_lines.append("-- ============================================================")
    sql_lines.append(f"-- Grupos procesados (con CPU en BD): {grupos_procesados}")
    sql_lines.append(f"-- Accesorios insertados: {total_accesorios}")
    sql_lines.append("-- ")
    sql_lines.append("-- NOTA: Los CPUs que NO existen en BD fueron exportados a Excel")
    sql_lines.append("-- Revisa el archivo Excel antes de insertarlos manualmente")
    
    return '\n'.join(sql_lines), total_accesorios


# ============================================================
# MAIN
# ============================================================

if __name__ == "__main__":
    import os
    
    # Rutas para Windows
    EXCEL_FILE = r'C:\Users\RTX\Documents\GitHub\PT\PROYECTO_TERMINAL_INVENTARIO_TI\datos\Resguardos oficial Nov25.xlsx'
    OUTPUT_SQL = r'C:\Users\RTX\Documents\GitHub\PT\PROYECTO_TERMINAL_INVENTARIO_TI\etl_resguardos.sql'
    OUTPUT_EXCEL = r'C:\Users\RTX\Documents\GitHub\PT\PROYECTO_TERMINAL_INVENTARIO_TI\CPUs_FALTANTES_EN_BD.xlsx'
    
    if not os.path.exists(EXCEL_FILE):
        print(f"ERROR: No se encontró el archivo: {EXCEL_FILE}")
        exit(1)
    
    print(f"Procesando: {EXCEL_FILE}")
    print("=" * 60)
    grupos = process_excel(EXCEL_FILE)
    
    # Estadísticas
    total_grupos = len(grupos)
    cpus_en_excel = sum(1 for g in grupos.values() if g['cpu'])
    total_accs = sum(len(g['accesorios']) for g in grupos.values())
    
    cpus_existentes = sum(1 for g in grupos.values() if g['cpu'] and cpu_existe_en_bd(g['cpu']['serial_num']))
    cpus_faltantes = cpus_en_excel - cpus_existentes
    
    print(f"\n📊 ESTADÍSTICAS:")
    print(f"   Grupos (HOTEL/DEPART): {total_grupos}")
    print(f"   CPUs en Excel: {cpus_en_excel}")
    print(f"   └── YA existen en BD: {cpus_existentes} ✅")
    print(f"   └── NO existen en BD: {cpus_faltantes} ⚠️")
    print(f"   Accesorios total: {total_accs}")
    
    # Generar Excel con faltantes
    print(f"\n📄 Generando Excel con CPUs faltantes...")
    cpus_falt, accs_falt = generate_excel_faltantes(grupos, OUTPUT_EXCEL)
    if cpus_falt > 0:
        print(f"   ✅ Exportados: {cpus_falt} CPUs + {accs_falt} accesorios")
        print(f"   📁 Archivo: {OUTPUT_EXCEL}")
    else:
        print(f"   ℹ️  No hay CPUs faltantes")
    
    # Generar SQL
    print(f"\n📄 Generando SQL para accesorios...")
    sql_output, total_insertados = generate_sql(grupos)
    
    with open(OUTPUT_SQL, 'w', encoding='utf-8') as f:
        f.write(sql_output)
    
    print(f"   ✅ Accesorios a insertar: {total_insertados}")
    print(f"   📁 Archivo: {OUTPUT_SQL}")
    
    print("\n" + "=" * 60)
    print("✅ PROCESO COMPLETADO")
    print("=" * 60)
