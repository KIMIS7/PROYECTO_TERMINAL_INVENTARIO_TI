# Documentacion de Procesos ETL - InventarioIT

## Indice

1. [Vision General](#vision-general)
2. [etl_assets.py - Carga Masiva de Activos](#1-etl_assetspy---carga-masiva-de-activos)
3. [etl_resguardos.py - Carga de Accesorios (Resguardos)](#2-etl_resguardospy---carga-de-accesorios-resguardos)
4. [etl.ipynb - Notebook de Desarrollo ETL Principal](#3-etlipynb---notebook-de-desarrollo-etl-principal)
5. [etl_itam_dry_run_v2.ipynb - Dry Run con Schema Prisma](#4-etl_itam_dry_run_v2ipynb---dry-run-con-schema-prisma)
6. [limpieza_departamentos.ipynb - Limpieza de Departamentos](#5-limpieza_departamentosipynb---limpieza-de-departamentos)
7. [limpieza_assets_components.ipynb - Limpieza de Componentes](#6-limpieza_assets_componentsipynb---limpieza-de-componentes)
8. [Flujo Completo de Datos](#flujo-completo-de-datos)
9. [Archivos de Salida](#archivos-de-salida)

---

## Vision General

El proyecto cuenta con un pipeline ETL (Extract, Transform, Load) desarrollado en Python
que convierte datos de inventario IT desde archivos CSV/Excel a sentencias SQL listas
para ejecutarse contra la base de datos SQL Server (schema `InventarioIT`).

**Stack ETL:** Python 3, pandas, re (expresiones regulares), openpyxl

**Flujo general:**
```
CSV/Excel (fuentes) --> Python ETL (transformacion) --> SQL/CSV (salida) --> SQL Server (destino)
```

**Tablas destino principales:**
- `AssetDetail` - Especificaciones tecnicas del activo
- `Asset` - Activo con sus relaciones (empresa, sitio, departamento, padre)
- `AssetHistory` - Historial de operaciones sobre activos

---

## 1. etl_assets.py - Carga Masiva de Activos

**Ubicacion:** `/etl_assets.py`
**Proposito:** Convertir CSVs de inventario de equipos IT (computadoras y servidores) a sentencias SQL INSERT para carga masiva en la base de datos.

### Entrada

| Archivo CSV | Empresa | CompanyID |
|-------------|---------|-----------|
| `TIENDAS ACTUALIZACIONES - ISLA17(42).csv` | ISLA17 | 1 |
| `TIENDAS ACTUALIZACIONES - HSPRO(33).csv` | HSPRO | 2 |
| `TIENDAS ACTUALIZACIONES - PTOARENAS.csv` | PTOARENAS | 9 |

**Columnas esperadas del CSV:**
- `TIENDAS` - Nombre del hotel/tienda/ubicacion
- `NS` - Numero de serie del equipo
- `MODELO` - Modelo del equipo (Dell Optiplex, Lenovo, etc.)
- `HOSTNAME` - Nombre del equipo en red (se usa como campo Domain)
- `SO` - Sistema operativo
- `CPU` - Procesador
- `RAM` - Memoria RAM
- `HHD SSD NVME` - Almacenamiento

### Transformaciones

1. **Limpieza de texto** (`clean_text`): Remueve caracteres especiales (`*`, `(`, `-`) al inicio/fin, normaliza espacios.

2. **Clasificacion de equipo** (`is_servidor`): Si el nombre contiene "SERVIDOR", "SVR" o "SERVER" se clasifica como servidor (ProductTypeID=2); de lo contrario, como computadora (ProductTypeID=1).

3. **Mapeo de Site** (`find_site_id`): Busca coincidencias parciales entre el nombre de la tienda y un diccionario de 47+ sitios. Prioriza la coincidencia mas larga (mas especifica).
   - Ejemplo: `"MOON GRAND JOY CAJA"` matchea `"MOON GRAND"` -> SiteID=8

4. **Mapeo de Departamento** (`find_depart_id`): Busca coincidencia por palabra clave.
   - Ejemplo: `"...JOY CAJA"` matchea `"JOY"` -> DepartID=5 (Joyeria)
   - Default: DepartID=1 (IT)

5. **Extraccion de Marca** (`extract_marca`): Detecta DELL, LENOVO, HP, MICROSOFT a partir del modelo.

6. **Normalizacion de RAM** (`normalize_ram`): Separa capacidad ("16 GB") y tipo ("DDR4") de un string como "16 GB DDR4 SODIMM".

7. **Normalizacion de HDD** (`normalize_hdd`): Separa tipo (SSD/NVMe/HDD) y capacidad ("500 GB").

8. **Normalizacion de SO** (`normalize_os`): Estandariza nombres de Windows (W10 -> "Windows 10", W11 -> "Windows 11").

### Generacion de TAG

Cada activo recibe un TAG unico con el formato:
```
[CompanyID 2d][SiteID 2d][DepartID 2d]-[TIPO]-[AssetID 6d]
Ejemplo: 010208-CPU-000142
```
Donde TIPO puede ser: CPU, SRV, LAP, IMP, MON, SWI, TAB, etc.

### Salida

Archivo: `etl_assets_final.sql` (~189 KB)

Por cada registro genera:
1. `INSERT INTO AssetDetail (...)` - Datos tecnicos
2. `SET @NewDetailID = SCOPE_IDENTITY()` - Captura el ID autogenerado
3. `INSERT INTO Asset (...)` - Activo vinculado al detalle
4. `UPDATE AssetDetail SET AssetTAG = ...` - Genera y asigna el TAG

### Configuracion

```python
ETL_USER_ID = 11        # Usuario que registra (Israel Cel)
VENDOR_ID = 1           # Vendor generico "POR ASIGNAR"
ASSET_STATE_ID = 2      # Estado "Asignado"
```

---

## 2. etl_resguardos.py - Carga de Accesorios (Resguardos)

**Ubicacion:** `/etl_resguardos.py`
**Proposito:** Procesar documentos de resguardo (custodia) para insertar accesorios/perifericos como activos hijos vinculados a CPUs que ya existen en la base de datos.

### Entrada

Archivo Excel: `Resguardos oficial Nov25.xlsx` (hoja "Hoja1")

**Columnas esperadas:**
- `HOTEL` - Nombre del hotel
- `DEPART` - Departamento
- `DISPOSITIVO` - Tipo de dispositivo (CPU, Monitor, Mouse, Teclado, etc.)
- `MARCA` - Marca del dispositivo
- `MODELO ` - Modelo (nota: tiene espacio trailing en el nombre de columna)
- `NUMERO DE SERIE` - Numero de serie
- `ESTATUS` - Estado (RESGUARDO, BAJA)
- `RAZON SOCIAL` - Empresa
- `OBSERVACIONES` - Notas

### Logica de Procesamiento

1. **Agrupacion:** Los registros se agrupan por `HOTEL|DEPART`. Dentro de cada grupo se identifica el equipo principal (CPU) y sus accesorios.

2. **Clasificacion de dispositivos:**

   | Dispositivo | ProductTypeID | Es Principal? |
   |-------------|:-------------:|:-------------:|
   | CPU, COMPUTADORA, PC, MINI PC, SERVIDOR, TERMINAL | 1-2 | Si |
   | MONITOR | 3 | No |
   | MOUSE | 4 | No |
   | TECLADO | 5 | No |
   | ESCANER | 6 | No |
   | NO BREAK / UPS | 7 | No |
   | IMP TICKETS | 8 | No |
   | IMP DOCUMENTOS | 9 | No |
   | CAJON DE DINERO | 10 | No |
   | SWITCH | 11 | No |
   | LECTOR DE HUELLA | 12 | No |
   | DIGITALIZADOR | 13 | No |
   | MULTIPUERTOS USB | 14 | No |
   | LECTOR DE TARJETAS | 15 | No |

3. **Validacion contra BD:** El script mantiene una lista (`CPUS_EN_BD`) de numeros de serie de CPUs que ya existen en la base de datos.

4. **Bifurcacion:**
   - **CPU existe en BD** -> Genera SQL para insertar accesorios como activos hijos
   - **CPU NO existe en BD** -> Exporta a Excel (`CPUs_FALTANTES_EN_BD.xlsx`) para revision manual

5. **Herencia de ubicacion:** Los accesorios heredan `CompanyID`, `SiteID`, y `DepartID` del CPU padre mediante un `SELECT` que busca por numero de serie.

6. **DOMAIN = NULL para accesorios:** Solo los equipos principales (CPUs, servidores) tienen el campo Domain; los accesorios lo dejan en NULL.

### Salida

**SQL:** `etl_resguardos.sql` (~100 KB) - Solo accesorios de CPUs existentes
**Excel:** `CPUs_FALTANTES_EN_BD.xlsx` - CPUs que no se encontraron, para revision manual

### Configuracion

```python
ETL_USER_ID = 11
VENDOR_ID = 1
CPUS_EN_BD = ['MJ03XGPE', 'MJ0360BT', ...]  # Actualizar con seriales reales
```

---

## 3. etl.ipynb - Notebook de Desarrollo ETL Principal

**Ubicacion:** `/etl.ipynb`
**Proposito:** Notebook de desarrollo/exploracion para el pipeline ETL completo. Genera CSVs normalizados en formato dimensional (star schema).

### Pasos del Notebook

1. **Lectura:** Carga un Excel maestro de departamentos con multiples hojas (una por empresa)
2. **Limpieza:** Normaliza a mayusculas, corrige caracteres corruptos (RECEPTORIA), elimina simbolos
3. **Separacion HOTEL/TIPO_EQUIPO:** Usa expresiones regulares por empresa para separar el nombre del hotel del tipo de tienda
4. **Extraccion de Vendor:** Toma la primera palabra del modelo como vendor (ej: "DELL OPTIPLEX" -> "DELL")
5. **Generacion dimensional:**
   - `dim_company.csv` - 9 empresas
   - `dim_site.csv` - 178 sitios
   - `dim_product_type.csv` - 35 tipos
   - `dim_vendor.csv` - 9 vendors
   - `dim_asset_detail.csv` - 335 detalles
   - `fact_asset.csv` - 335 activos (tabla de hechos)
6. **Validacion:** Verifica que todas las FK esten resueltas (reporta SiteID nulos)

### Resultado
335 activos procesados de 9 empresas, con 4 registros sin SiteID resuelto.

---

## 4. etl_itam_dry_run_v2.ipynb - Dry Run con Schema Prisma

**Ubicacion:** `/etl_itam_dry_run_v2.ipynb`
**Proposito:** Version mejorada del ETL que genera CSVs con las columnas **exactas** del schema Prisma/SQL Server, respetando nombres de columna, tipos de datos y relaciones FK.

### Orden de Generacion (respeta dependencias FK)

| Orden | Tabla | FK Requeridas |
|:-----:|-------|---------------|
| 1 | `AssetState` | Ninguna (catalogo base) |
| 2 | `Company` | Ninguna |
| 3 | `Vendor` | Ninguna |
| 4 | `ProductType` | Ninguna |
| 5 | `Site` | CompanyID -> Company |
| 6 | `Asset` | CompanyID, SiteID, VendorID, ProductTypeID, AssetState |
| 7 | `AssetDetail` | AssetID -> Asset, LastUpdateBy -> User |

### Columnas Generadas por Tabla

**Asset:**
```
AssetID, Name, VendorID, ProductTypeID, AssetState,
CompanyID, SiteID, UserID(null), ParentAssetID(null), DepartID(null)
```

**AssetDetail:**
```
AssetDetailID, AssetID, Model, NumModel, SerialNum,
OperatingSystem, OSName, Processor, PhysicalMemory, RAM,
HDDCapacity, LastUpdateBy, CreatedTime, LastUpdateTime
```

### Validacion
- Verifica FK obligatorias (VendorID, ProductTypeID, AssetState) - deben ser 0 nulos
- Reporta FK opcionales (CompanyID, SiteID) - nulls permitidos pero se listan para revision

### Entorno
Disenado para ejecutarse en **Google Colab** (monta Google Drive para leer/escribir archivos).

---

## 5. limpieza_departamentos.ipynb - Limpieza de Departamentos

**Ubicacion:** `/limpieza_departamentos.ipynb`
**Proposito:** Limpiar y normalizar los datos de departamentos desde un Excel con multiples hojas, generando un CSV limpio que mapea Company -> Site -> Department.

### Proceso

1. **Lectura:** Lee las primeras 3 hojas del Excel `DEPARTAMENTOS_2.xlsx` (cada hoja = una empresa)
2. **Limpieza:**
   - Elimina columna `ESTACION` (no relevante)
   - Aplica correcciones conocidas (ej: "PIER27 CARIBENO" -> "PIER27 CARIBEÑO")
   - Normaliza a mayusculas, colapsa espacios multiples
   - Elimina filas sin SITIO o TIENDA
   - Remueve duplicados por (SITIO, TIENDA)
3. **Enriquecimiento:** Agrega columna COMPANY con el nombre de la hoja

### Salida

Archivo: `departamentos_limpio.csv`
- 93 filas totales
- 3 columnas: COMPANY, SITIO, TIENDA

**Distribucion:**
| Empresa | Sites | Departamentos | Filas |
|---------|:-----:|:------------:|:-----:|
| ISLA17(42) | 13 | 13 | 29 |
| HSPRO(33) | 22 | 6 | 35 |
| PTOARENAS | 12 | 10 | 29 |

---

## 6. limpieza_assets_components.ipynb - Limpieza de Componentes

**Ubicacion:** `/limpieza_assets_components.ipynb`
**Proposito:** Notebook educativo/exploratorio que documenta paso a paso la logica de mapeo usada en `etl_assets.py`. Sirve como guia de referencia para entender las funciones de transformacion.

### Contenido

- Definicion de mapeos (COMPANY_MAP, SITE_MAP, DEPART_MAP)
- Funcion `find_site_id()` con explicacion detallada
- Funcion `is_servidor()` para clasificar equipos
- Funcion `extract_marca()` para detectar fabricante
- Esqueleto de `generate_sql()` mostrando la logica de SCOPE_IDENTITY()
- Ejecucion completa del pipeline importando `etl_assets.py`

---

## Flujo Completo de Datos

```
FUENTES DE DATOS
    |
    +-- CSVs de inventario (ISLA17, HSPRO, PTOARENAS)
    |       Columnas: TIENDAS, NS, MODELO, HOSTNAME, SO, CPU, RAM, HDD
    |
    +-- Excel de Resguardos (Nov 2025)
    |       Columnas: HOTEL, DEPART, DISPOSITIVO, MARCA, MODELO, NS, ESTATUS
    |
    +-- Excel de Departamentos
            Columnas: SITIO, TIENDA, ESTACION
    |
    v
FASE 1: LIMPIEZA (notebooks)
    |
    +-- limpieza_departamentos.ipynb --> departamentos_limpio.csv
    +-- limpieza_assets_components.ipynb --> validacion de mapeos
    +-- etl.ipynb --> CSVs dimensionales (dry run)
    +-- etl_itam_dry_run_v2.ipynb --> CSVs con schema Prisma exacto
    |
    v
FASE 2: TRANSFORMACION Y CARGA (scripts Python)
    |
    +-- etl_assets.py
    |       Entrada: 3 CSVs de inventario
    |       Salida:  etl_assets_final.sql (189 KB)
    |       Inserta: AssetDetail + Asset + AssetTAG
    |
    +-- etl_resguardos.py
            Entrada: Excel de Resguardos
            Salida:  etl_resguardos.sql (100 KB)
                     CPUs_FALTANTES_EN_BD.xlsx
            Inserta: AssetDetail + Asset (accesorios hijos)
    |
    v
FASE 3: EJECUCION SQL
    |
    Ejecutar en SQL Server Management Studio:
    1. etl_assets_final.sql   (equipos principales)
    2. etl_resguardos.sql     (accesorios/perifericos)
```

---

## Archivos de Salida

| Archivo | Generado por | Descripcion | Tamano aprox. |
|---------|-------------|-------------|:-------------:|
| `etl_assets_final.sql` | etl_assets.py | INSERTs de equipos principales | 189 KB |
| `etl_resguardos.sql` | etl_resguardos.py | INSERTs de accesorios | 100 KB |
| `CPUs_FALTANTES_EN_BD.xlsx` | etl_resguardos.py | CPUs no encontrados en BD | Variable |
| `departamentos_limpio.csv` | limpieza_departamentos.ipynb | Mapeo Company-Site-Depart | 93 filas |
| `OUT/dim_*.csv, fact_*.csv` | etl.ipynb | CSVs dimensionales (dry run) | 335 filas |
| `etl_output/1-7_*.csv` | etl_itam_dry_run_v2.ipynb | CSVs con schema Prisma | 335 filas |
