"""
ETL para convertir CSVs de inventario IT a SQL INSERT
Autor: Claude para CAMARA
Fecha: Abril 2026
"""

import pandas as pd
import re
from datetime import datetime

# ============================================================
# CONFIGURACIÓN - IDs de tu base de datos
# ============================================================

# Usuario que registra (Israel Cel)
ETL_USER_ID = 11

# Vendor genérico
VENDOR_ID = 1  # POR ASIGNAR

# AssetState
ASSET_STATE_ID = 2  # Asignado

# ProductType
PRODUCT_TYPE_COMPUTADORA = 1
PRODUCT_TYPE_SERVIDOR = 2

# ============================================================
# ABREVIATURAS PARA EL TAG (ProductTypeID → 3 letras)
# ============================================================
PRODUCT_TYPE_ABREV = {
    1: 'CPU',  # COMPUTADORA (Desktop)
    2: 'SRV',  # SERVIDOR
    # Agrega más cuando tengas otros tipos:
    # 3: 'LAP',  # LAPTOP
    # 4: 'IMP',  # IMPRESORA
    # 5: 'MON',  # MONITOR
    # 6: 'SWI',  # SWITCH
    # 7: 'TAB',  # TABLET
}

# ============================================================
# MAPEO DE COMPANIES (nombre archivo → CompanyID)
# ============================================================
COMPANY_MAP = {
    'ISLA17_42_': 1,   # ISLA17
    'HSPRO_33_': 2,    # HSPRO
    'PTOARENAS': 9,    # PTOARENAS
}

# ============================================================
# MAPEO DE SITES (palabra clave → SiteID)
# Basado en los Sites que tienes en tu DB
# ============================================================
SITE_MAP = {
    # ISLA17 (CompanyID=1)
    'BEACHPALACE': 2,
    'BEACH PALACE': 2,
    'CUN T2': 3,
    '*CUN T2': 3,
    'CUN T3': 5,
    'LE BLANC': 7,
    'MOON GRAND': 8,
    'MOON GOLF': 9,
    'MOON PROSHOP': 9,  # ProShop es parte de Golf
    'MOON SUNRISE': 10,
    'PLAYACAR': 11,
    'SUN PALACE': 12,
    'MOON NIZUC': 13,
    'COZUMEL': 14,
    
    # HSPRO (CompanyID=2)
    'BLUEBAY': 15,
    'H10 OCEAN': 16,
    'H10 RIVIERA': 17,
    'HYATT ZILARA': 18,
    'HYATT ZILA': 18,
    'PALLADIUM RIV': 20,
    'PALLADIUM JOY': 20,  # PALLADIUM JOY COLONIAL → PALLADIUM RIV
    'PALLADIUM ROYAL': 25,
    'PRINCESS RIV': 26,
    'RIU LUPITA': 27,
    'SANDOS CANCUN': 28,
    'SANDOS CUN': 28,
    'SANDOS CARACOL': 29,
    'SANDOS PLAYACAR': 30,
    'SANDOS PLAY': 30,
    'THE FIVES': 31,
    'FIVES': 31,
    'THE ROYAL': 32,
    'HILTON': 33,
    'PRINCESS YUC': 34,
    'PRINCESS SUNSET': 35,
    'WYNDHAM': 36,
    
    # PTOARENAS (CompanyID=9)
    'AEROPUERTO': 37,  # Aeropuerto → CUN T2
    'TERMINAL 2': 37,
    'TERMINAL 3': 38,
    'H10 PTO MORELOS': 39,
    'H10 PTO': 39,
    'HAVEN': 40,
    'HIPOTELS': 40,
    'ROYALTON RIV': 41,
    'ROYALTON SPLASH': 42,
    'HARDROCK HACI': 43,
    'HARDROCK HACIENDA': 43,
    'HARDROCK HEAV': 44,
    'HARDROCK HEAVEN': 44,
    'UNICO': 45,
    'SIRENIS': 46,
    'PALMAR BEACH': 47,
    'PALMAR': 47,
    'PARAISO': 48,
}

# ============================================================
# MAPEO DE DEPARTAMENTOS (palabra clave → DepartID)
# ============================================================
DEPART_MAP = {
    'IT': 1,
    'AMIANI': 2,
    'MARINI': 2,  # MARINI es typo de AMIANI
    'PIER27': 3,
    'PIER 27': 3,
    'MULTI': 4,
    'JOYERIA': 5,
    'JOY': 5,
    'CEDIS': 6,
    'AUDITORIA': 7,
    'TABAQUERIA': 8,
    'TAB': 8,
    'ALMACEN': 9,
    'TRAFICO': 10,
    'CORPORATIVO': 11,
    'CAJA': 12,
    'AQUAPARK': 13,
    'AQUA PARK': 13,
    'CARRETA': 14,
    'CORAZON': 15,
    'CORONA': 16,
    'PROSHOP': 19,
    'PUEBLITO': 20,
    'RECEPTORIA': 21,
    'RECEPTOR': 21,
    'SUNGLASS': 22,
    'VIVA MEXICO': 23,
    'BOARDWALK': 4,  # Relacionado con MULTI
    'PLAYA': 8,  # Relacionado con TAB
    'ALBERCA': 13,  # Relacionado con AQUAPARK
}

# ============================================================
# FUNCIONES DE MAPEO
# ============================================================

def clean_text(text):
    """Limpia y normaliza texto"""
    if pd.isna(text) or text == '':
        return None
    text = str(text).strip()
    # Quitar caracteres especiales al inicio
    text = re.sub(r'^[\*\(\-]+', '', text)
    text = re.sub(r'[\*\-]+$', '', text)
    return text.strip()

def is_servidor(tienda_name):
    """Determina si es SERVIDOR basándose en el nombre"""
    if not tienda_name:
        return False
    name_upper = tienda_name.upper()
    return 'SERVIDOR' in name_upper or 'SVR' in name_upper or 'SERVER' in name_upper

def find_site_id(tienda_name, company_id):
    """Busca el SiteID basándose en el nombre de la tienda"""
    if not tienda_name:
        return None
    
    name_upper = tienda_name.upper()
    
    # Buscar coincidencia más larga primero
    matches = []
    for keyword, site_id in SITE_MAP.items():
        if keyword.upper() in name_upper:
            matches.append((len(keyword), site_id, keyword))
    
    if matches:
        # Retornar el match más largo (más específico)
        matches.sort(reverse=True)
        return matches[0][1]
    
    return None

def find_depart_id(tienda_name):
    """Busca el DepartID basándose en el nombre de la tienda"""
    if not tienda_name:
        return 1  # IT por defecto
    
    name_upper = tienda_name.upper()
    
    # Buscar coincidencia específica primero
    for keyword, depart_id in DEPART_MAP.items():
        if keyword.upper() in name_upper:
            return depart_id
    
    # Si no hay match específico, asignar IT
    return 1  # IT por defecto

def extract_marca(modelo):
    """Extrae la marca del modelo"""
    if pd.isna(modelo) or modelo == '':
        return 'SIN IDENTIFICAR'
    
    modelo_upper = str(modelo).upper()
    
    if 'DELL' in modelo_upper or 'OPTIPLEX' in modelo_upper or 'VOSTRO' in modelo_upper:
        return 'DELL'
    elif 'LENOVO' in modelo_upper or 'THINKCENTRE' in modelo_upper or 'NEO' in modelo_upper:
        return 'LENOVO'
    elif 'HP' in modelo_upper or 'PRODESK' in modelo_upper:
        return 'HP'
    elif 'MICROSOFT' in modelo_upper:
        return 'MICROSOFT'
    else:
        return 'SIN IDENTIFICAR'

def normalize_os(so):
    """Normaliza el sistema operativo"""
    if pd.isna(so) or so == '':
        return None
    
    so_upper = str(so).upper().strip()
    
    if 'W11' in so_upper or 'WIN11' in so_upper or 'WINDOWS 11' in so_upper:
        return 'Windows 11'
    elif 'W10' in so_upper or 'WIN10' in so_upper or 'WINDOWS 10' in so_upper:
        return 'Windows 10'
    else:
        return so.strip()

def normalize_ram(ram):
    """Separa la RAM en capacidad y tipo
    Ejemplo: '16 GB DDR4 SODIMM' → ('16 GB', 'DDR4')
    """
    if pd.isna(ram) or ram == '':
        return None, None
    
    ram_str = str(ram).strip().upper()
    
    # Extraer capacidad (número + GB)
    capacity_match = re.search(r'(\d+)\s*(GB|TB)', ram_str)
    capacity = f"{capacity_match.group(1)} {capacity_match.group(2)}" if capacity_match else None
    
    # Extraer tipo (DDR3, DDR4, DDR5)
    type_match = re.search(r'(DDR\d)', ram_str)
    ram_type = type_match.group(1) if type_match else None
    
    return capacity, ram_type

def normalize_hdd(hdd):
    """Separa el HDD en tipo y capacidad
    Ejemplo: 'SSD 500 GB' → ('SSD', '500 GB')
    Ejemplo: 'NVMe 500 GB' → ('NVMe', '500 GB')
    """
    if pd.isna(hdd) or hdd == '':
        return None, None
    
    hdd_str = str(hdd).strip().upper()
    
    # Extraer tipo
    if 'NVME' in hdd_str or 'NVM' in hdd_str:
        hdd_type = 'NVMe'
    elif 'SSD' in hdd_str:
        hdd_type = 'SSD'
    elif 'HDD' in hdd_str:
        hdd_type = 'HDD'
    else:
        hdd_type = None
    
    # Extraer capacidad (número + GB/TB)
    capacity_match = re.search(r'(\d+)\s*(GB|TB)', hdd_str)
    capacity = f"{capacity_match.group(1)} {capacity_match.group(2)}" if capacity_match else None
    
    return hdd_type, capacity

def sql_string(value):
    """Convierte valor a string SQL seguro"""
    if value is None or pd.isna(value) or value == '':
        return 'NULL'
    # Escapar comillas simples
    value = str(value).replace("'", "''")
    return f"N'{value}'"

# ============================================================
# PROCESAMIENTO PRINCIPAL
# ============================================================

def process_csv(filepath, company_name):
    """Procesa un CSV y retorna lista de registros"""
    
    company_id = COMPANY_MAP.get(company_name)
    if not company_id:
        print(f"ERROR: Company {company_name} no encontrada en COMPANY_MAP")
        return []
    
    # Leer CSV
    df = pd.read_csv(filepath, encoding='utf-8')
    
    records = []
    
    for idx, row in df.iterrows():
        tienda = clean_text(row.get('TIENDAS', ''))
        
        # Saltar filas vacías
        if not tienda:
            continue
        
        # Saltar si no tiene número de serie (probablemente vacío)
        ns = clean_text(row.get('NS', ''))
        if not ns:
            continue
        # Separar RAM y HDD
        ram_capacity, ram_type = normalize_ram(row.get('RAM', ''))
        hdd_type, hdd_capacity = normalize_hdd(row.get('HHD SSD NVME', ''))
            
        record = {
            'name': tienda,
            'company_id': company_id,
            'site_id': find_site_id(tienda, company_id),
            'depart_id': find_depart_id(tienda),
            'product_type_id': PRODUCT_TYPE_SERVIDOR if is_servidor(tienda) else PRODUCT_TYPE_COMPUTADORA,
            'hostname': clean_text(row.get('HOSTNAME', '')),
            'serial_num': ns,
            'model': clean_text(row.get('MODELO', '')),
            'product_manuf': extract_marca(row.get('MODELO', '')),
            'os': normalize_os(row.get('SO', '')),
            'processor': clean_text(row.get('CPU', '')),
            'hdd_model': hdd_type,        # Tipo: SSD, NVMe, HDD
            'hdd_capacity': hdd_capacity,  # Capacidad: 500 GB
            'ram': ram_capacity,           # Capacidad: 16 GB
            'physical_memory': ram_type,   # Tipo: DDR4, DDR3
        }
        
        records.append(record)
    
    return records

def generate_sql(records):
    """Genera SQL INSERT para los registros"""
    
    sql_lines = []
    sql_lines.append("-- ============================================================")
    sql_lines.append(f"-- ETL Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    sql_lines.append(f"-- Total registros: {len(records)}")
    sql_lines.append("-- ============================================================")
    sql_lines.append("")
    sql_lines.append("USE InventarioIT;")
    sql_lines.append("GO")
    sql_lines.append("")
    sql_lines.append("-- Variables globales")
    sql_lines.append(f"DECLARE @ETLUserID INT = {ETL_USER_ID};")
    sql_lines.append(f"DECLARE @VendorID INT = {VENDOR_ID};")
    sql_lines.append(f"DECLARE @AssetStateID INT = {ASSET_STATE_ID};")
    sql_lines.append("DECLARE @NewDetailID INT;")
    sql_lines.append("DECLARE @NewAssetID INT;")
    sql_lines.append("DECLARE @AssetTAG NVARCHAR(20);")
    sql_lines.append("DECLARE @ProductTypeID INT;")
    sql_lines.append("DECLARE @SiteID INT;")
    sql_lines.append("DECLARE @CompanyID INT;")
    sql_lines.append("DECLARE @DepartID INT;")
    sql_lines.append("")
    sql_lines.append("-- ============================================================")
    sql_lines.append("-- INSERCIÓN DE ACTIVOS")
    sql_lines.append("-- ============================================================")
    sql_lines.append("")
    
    for i, rec in enumerate(records, 1):
        sql_lines.append(f"-- Registro {i}: {rec['name']}")
        
        # Asignar variables
        sql_lines.append(f"SET @ProductTypeID = {rec['product_type_id']};")
        
        if rec['company_id']:
            sql_lines.append(f"SET @CompanyID = {rec['company_id']};")
        else:
            sql_lines.append("SET @CompanyID = NULL;")
            
        if rec['site_id']:
            sql_lines.append(f"SET @SiteID = {rec['site_id']};")
        else:
            sql_lines.append("SET @SiteID = NULL;")
            
        if rec['depart_id']:
            sql_lines.append(f"SET @DepartID = {rec['depart_id']};")
        else:
            sql_lines.append("SET @DepartID = NULL;")
        
        # INSERT AssetDetail
        sql_lines.append(f"""INSERT INTO [dbo].[AssetDetail] (
    [ProductManuf], [SerialNum], [Model], [OperatingSystem], [OSName], 
    [Processor], [HDDModel], [HDDCapacity], [RAM], [PhysicalMemory], [Domain],
    [CreatedTime], [LastUpdateBy])
VALUES (
    {sql_string(rec['product_manuf'])}, {sql_string(rec['serial_num'])}, {sql_string(rec['model'])}, 
    {sql_string(rec['os'])}, {sql_string(rec['os'])}, 
    {sql_string(rec['processor'])}, {sql_string(rec['hdd_model'])}, {sql_string(rec['hdd_capacity'])}, 
    {sql_string(rec['ram'])}, {sql_string(rec['physical_memory'])},
    {sql_string(rec['hostname'])},
    GETDATE(), @ETLUserID);""")
        
        sql_lines.append("SET @NewDetailID = SCOPE_IDENTITY();")
        
        # INSERT Asset
        abrev = PRODUCT_TYPE_ABREV.get(rec['product_type_id'], 'EQP')  # EQP = Equipo genérico
        sql_lines.append(f"""INSERT INTO [dbo].[Asset] (
    [Name], [VendorID], [ProductTypeID], [AssetState], 
    [CompanyID], [SiteID], [DepartID], [UserID], [ParentAssetID], [AssetDetailID])
VALUES (
    {sql_string(rec['name'])}, @VendorID, @ProductTypeID, @AssetStateID, 
    @CompanyID, @SiteID, @DepartID, NULL, NULL, @NewDetailID);""")
        
        # Obtener el AssetID recién insertado y generar el TAG
        sql_lines.append("SET @NewAssetID = SCOPE_IDENTITY();")
        sql_lines.append(f"""-- Generar AssetTAG: [CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
SET @AssetTAG = 
    RIGHT('00' + CAST(@CompanyID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@SiteID AS VARCHAR), 2) +
    RIGHT('00' + CAST(@DepartID AS VARCHAR), 2) + '-' +
    '{abrev}' + '-' +
    RIGHT('000000' + CAST(@NewAssetID AS VARCHAR), 6);
UPDATE [dbo].[AssetDetail] SET [AssetTAG] = @AssetTAG WHERE [AssetDetailID] = @NewDetailID;""")
        
        sql_lines.append("")
    
    sql_lines.append("GO")
    sql_lines.append("")
    sql_lines.append(f"-- RESUMEN: {len(records)} activos insertados")
    sql_lines.append(f"-- Servidores: {sum(1 for r in records if r['product_type_id'] == PRODUCT_TYPE_SERVIDOR)}")
    sql_lines.append(f"-- Computadoras: {sum(1 for r in records if r['product_type_id'] == PRODUCT_TYPE_COMPUTADORA)}")
    
    return '\n'.join(sql_lines)

# ============================================================
# MAIN
# ============================================================

if __name__ == "__main__":
    all_records = []
    
    # ============================================================
    # CONFIGURACIÓN DE RUTAS - MODIFICA AQUÍ
    # ============================================================
    
    # Carpeta donde están tus CSVs
    CARPETA_DATOS = r'C:\Users\RTX\Documents\GitHub\PT\PROYECTO_TERMINAL_INVENTARIO_TI\datos'
    
    # Archivos CSV (nombre exacto como aparece en tu carpeta)
    csv_files = [
        ('TIENDAS ACTUALIZACIONES - ISLA17(42).csv', 'ISLA17_42_'),
        ('TIENDAS ACTUALIZACIONES - HSPRO(33).csv', 'HSPRO_33_'),
        ('TIENDAS ACTUALIZACIONES - PTOARENAS.csv', 'PTOARENAS'),
    ]
    
    # Donde guardar el SQL generado
    OUTPUT_FILE = r'C:\Users\RTX\Documents\GitHub\PT\PROYECTO_TERMINAL_INVENTARIO_TI\datos\etl_assets_final.sql'
    
    # ============================================================
    # PROCESAMIENTO (no tocar)
    # ============================================================
    
    import os
    
    for filename, company_name in csv_files:
        filepath = os.path.join(CARPETA_DATOS, filename)
        
        # Verificar que el archivo existe
        if not os.path.exists(filepath):
            print(f"ERROR: No se encontró el archivo: {filepath}")
            print(f"       Verifica el nombre exacto del archivo en tu carpeta")
            continue
            
        print(f"Procesando: {company_name}...")
        records = process_csv(filepath, company_name)
        print(f"  -> {len(records)} registros válidos")
        all_records.extend(records)
    
    if not all_records:
        print("\nERROR: No se procesó ningún registro. Verifica los nombres de tus archivos.")
        exit(1)
    
    print(f"\nTotal registros: {len(all_records)}")
    
    # Generar SQL
    sql_output = generate_sql(all_records)
    
    # Guardar archivo
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        f.write(sql_output)
    
    print(f"\nSQL generado en: {OUTPUT_FILE}")
    
    # Mostrar estadísticas de mapeo
    print("\n--- ESTADÍSTICAS DE MAPEO ---")
    sin_site = sum(1 for r in all_records if r['site_id'] is None)
    sin_depart = sum(1 for r in all_records if r['depart_id'] is None)
    print(f"Sin Site asignado: {sin_site}")
    print(f"Sin Depart asignado: {sin_depart}")
    
    # Estadísticas adicionales
    servidores = sum(1 for r in all_records if r['product_type_id'] == PRODUCT_TYPE_SERVIDOR)
    computadoras = sum(1 for r in all_records if r['product_type_id'] == PRODUCT_TYPE_COMPUTADORA)
    print(f"Servidores: {servidores}")
    print(f"Computadoras: {computadoras}")
