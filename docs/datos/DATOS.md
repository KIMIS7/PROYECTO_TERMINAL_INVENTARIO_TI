# Modelo de Datos - Sistema de Inventario TI

## Descripcion General

El sistema utiliza **SQL Server 2019+** como motor de base de datos y **Prisma ORM** como capa de abstraccion. El modelo de datos esta diseñado para gestionar el ciclo de vida completo de los activos de TI de una organizacion, desde su alta hasta su baja, incluyendo movimientos, reasignaciones y trazabilidad historica.

## Diagrama Entidad-Relacion General

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        MODELO RELACIONAL COMPLETO                           │
└─────────────────────────────────────────────────────────────────────────────┘

  ┌──────────┐    N:1    ┌──────────┐    1:N    ┌───────────────────┐
  │   User   │──────────►│   rol    │◄──────────│ rol_dashboard_path│
  └────┬─────┘           └──────────┘           └────────┬──────────┘
       │                                                  │
       │ N:1                                         N:1  │
       ▼                                                  ▼
  ┌──────────┐                                  ┌─────────────────┐
  │   Site   │                                  │ dashboard_paths │
  └────┬─────┘                                  └─────────────────┘
       │ N:1
       ▼
  ┌──────────┐    1:N    ┌──────────────┐
  │ Company  │◄──────────│    Site      │
  └──────────┘           └──────────────┘

  ┌──────────┐    1:N    ┌─────────────┐    1:N    ┌──────────────┐
  │  Asset   │──────────►│ AssetDetail │    │      │ AssetHistory │
  │          │──────────────────────────────►│      └──────────────┘
  │          │    1:N    ┌─────────────────────────┐
  │          │──────────►│ AssetOwnershipHistory   │
  └────┬─────┘           └─────────────────────────┘
       │
       │ N:1 (FK a catalogos)
       ▼
  ┌──────────┐  ┌─────────────┐  ┌────────────┐  ┌──────────┐
  │  Vendor  │  │ ProductType │  │ AssetState │  │  Depart  │
  └──────────┘  └─────────────┘  └────────────┘  └──────────┘
```

## Esquema de la Base de Datos

### Fuente de Verdad

El esquema de la base de datos esta definido en:
```
InventarioIT-API-icel/prisma/inventarioit/schema.prisma
```

El proveedor de datos es **SQL Server**:
```prisma
datasource db {
  provider = "sqlserver"
  url      = env("DATABASE_URL")
}
```

---

## Entidades del Sistema

### 1. Asset (Activos de TI)

Tabla principal que almacena cada activo tecnologico registrado en el sistema.

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `AssetID` | Int (PK) | No | Identificador unico autoincremental |
| `Name` | NVarChar(255) | No | Nombre descriptivo del activo |
| `VendorID` | Int (FK) | No | Proveedor/fabricante del equipo |
| `ProductTypeID` | Int (FK) | No | Tipo de producto (categoria, grupo, subcategoria) |
| `AssetState` | Int (FK) | No | Estado actual del activo |
| `CompanyID` | Int (FK) | Si | Empresa propietaria |
| `SiteID` | Int (FK) | Si | Ubicacion fisica del activo |
| `UserID` | Int (FK) | Si | Usuario actualmente asignado |
| `ParentAssetID` | Int (FK) | Si | Activo padre (relacion jerarquica) |
| `DepartID` | Int (FK) | Si | Departamento asignado |

**Relaciones clave:**
- **Auto-referencia**: Un activo puede tener un `ParentAssetID` que apunta a otro activo. Esto permite modelar componentes (ej: un monitor asignado a una laptop).
- **Propiedad**: El campo `UserID` indica quien tiene asignado el activo actualmente.
- **Catalogos**: Se conecta con Vendor, ProductType, AssetState, Company, Site y Depart.

### 2. AssetDetail (Especificaciones Tecnicas)

Almacena informacion tecnica detallada de cada activo. Relacion 1:N con Asset.

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `AssetDetailID` | Int (PK) | No | Identificador unico |
| `AssetID` | Int (FK) | No | Activo relacionado |
| `ProductManuf` | NVarChar(50) | Si | Fabricante del producto |
| `IPAddress` | NVarChar(50) | Si | Direccion IP asignada |
| `MACAddress` | NVarChar(50) | Si | Direccion MAC de red |
| `Loanable` | NVarChar(50) | Si | Si es prestable |
| `VMPlatform` | NVarChar(50) | Si | Plataforma de virtualizacion |
| `VirtualHost` | NVarChar(50) | Si | Host virtual |
| `OperatingSystem` | NVarChar(50) | Si | Sistema operativo |
| `Domain` | NVarChar(50) | Si | Dominio de red |
| `ProcessorInfo` | NVarChar(50) | Si | Informacion del procesador |
| `Processor` | NVarChar(50) | Si | Modelo del procesador |
| `PhysicalMemory` | NVarChar(50) | Si | Memoria fisica |
| `HDDModel` | NVarChar(50) | Si | Modelo del disco duro |
| `HDDSerial` | NVarChar(50) | Si | Serie del disco duro |
| `HDDCapacity` | NVarChar(50) | Si | Capacidad del disco duro |
| `KeyboardType` | NVarChar(50) | Si | Tipo de teclado |
| `MouseType` | NVarChar(50) | Si | Tipo de raton |
| `NumModel` | NVarChar(50) | Si | Numero de modelo |
| `Model` | NVarChar(50) | Si | Modelo del equipo |
| `IMEI` | NVarChar(50) | Si | IMEI (dispositivos moviles) |
| `ModemFirmwareVersion` | NVarChar(50) | Si | Version del firmware del modem |
| `Platform` | NVarChar(50) | Si | Plataforma |
| `OSName` | NVarChar(50) | Si | Nombre del sistema operativo |
| `OSVersion` | NVarChar(50) | Si | Version del sistema operativo |
| `RAM` | NVarChar(50) | Si | Memoria RAM |
| `SerialNum` | NVarChar(150) | Si | Numero de serie del equipo |
| `PurchaseDate` | Date | Si | Fecha de compra |
| `WarrantyExpiryDate` | Date | Si | Fecha de vencimiento de garantia |
| `CreatedTime` | DateTime | Si | Fecha de creacion del registro |
| `LastUpdateTime` | DateTime | Si | Ultima actualizacion |
| `AssetACQDate` | Date | Si | Fecha de adquisicion |
| `AssetExpiryDate` | Date | Si | Fecha de expiracion del activo |
| `AssetTAG` | NVarChar(150) | Si | Etiqueta de activo |
| `WarrantyExpiry` | Date | Si | Expiracion de garantia |
| `AssignedTime` | DateTime | Si | Fecha de asignacion |
| `Barcode` | VarChar(50) | Si | Codigo de barras |
| `Factura` | NVarChar(150) | Si | Numero de factura |
| `Ticket` | NVarChar(150) | Si | Numero de ticket de soporte |
| `LastUpdateBy` | Int (FK) | No | Usuario que realizo la ultima modificacion |

**Datos que se capturan:**
- **Red**: IP, MAC, dominio
- **Hardware**: procesador, RAM, disco duro, modelo, serie
- **Software**: sistema operativo, version, plataforma de virtualizacion
- **Administrativos**: fecha de compra, garantia, factura, ticket, codigo de barras
- **Trazabilidad**: quien modifico y cuando

### 3. AssetHistory (Historial de Operaciones)

Registro de auditoria de todas las operaciones realizadas sobre activos.

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `AssetHistoryID` | Int (PK) | No | Identificador unico |
| `AssetID` | Int (FK) | No | Activo relacionado |
| `Operation` | NVarChar(255) | No | Tipo de operacion realizada |
| `Description` | NVarChar(500) | No | Descripcion detallada |
| `CreatedTime` | DateTime | No | Fecha y hora de la operacion |

**Tipos de operacion soportados:**
- `ALTA` - Registro inicial del activo
- `BAJA` - Retirada del activo del inventario
- `REASIGNACION` - Cambio de usuario asignado
- `RESGUARDO` - Activo en resguardo
- `REPARACION` - Activo enviado a reparacion
- `ACTUALIZACION` - Modificacion de datos del activo

### 4. AssetOwnershipHistory (Historial de Propiedad)

Rastrea todos los cambios de asignacion de activos a usuarios a lo largo del tiempo.

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `AssetOwnershipHistoryID` | Int (PK) | No | Identificador unico |
| `UserID` | Int (FK) | No | Usuario que tuvo el activo |
| `AssetID` | Int (FK) | No | Activo asignado |
| `FromDate` | Date | No | Fecha de inicio de la asignacion |
| `ToDate` | Date | No | Fecha de fin de la asignacion |

Esta tabla permite responder preguntas como:
- Quien ha tenido asignado un equipo especifico?
- Cuantos equipos ha tenido un usuario a lo largo del tiempo?
- Cual es la cadena de custodia de un activo?

---

## Entidades de Usuarios y Permisos

### 5. User (Usuarios)

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `UserID` | Int (PK) | No | Identificador unico |
| `Email` | NVarChar(100) | No | Correo electronico (vinculado a Azure AD) |
| `FirstName` | NVarChar(100) | No | Nombre |
| `LastName` | NVarChar(100) | No | Apellido |
| `Name` | NVarChar(200) | No | Nombre completo |
| `rolD` | Int (FK) | No | Rol asignado |
| `isActive` | Boolean | No | Estado del usuario (activo/inactivo) |
| `token` | NVarChar(Max) | Si | Token JWT de sesion |
| `createdAt` | DateTime | No | Fecha de creacion |
| `DepartmentID` | Int (FK) | No | Departamento asignado |
| `SiteID` | Int (FK) | Si | Sitio/ubicacion asignada |

### 6. rol (Roles)

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `rolID` | Int (PK) | No | Identificador unico |
| `name` | NVarChar(100) | No | Nombre del rol |
| `isActive` | Boolean | Si | Estado (default: true) |

### 7. dashboard_paths (Rutas del Dashboard)

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `dashboarpathID` | Int (PK) | No | Identificador unico |
| `path` | NVarChar(100) | No | Ruta URL (unica) |
| `name` | NVarChar(100) | No | Nombre descriptivo |
| `icon` | NVarChar(Max) | Si | Icono de Lucide React |

### 8. rol_dashboard_path (Permisos Rol-Ruta)

Tabla pivote que implementa la relacion N:M entre roles y rutas.

| Campo | Tipo | Null | Descripcion |
|-------|------|------|-------------|
| `roldashboardpathID` | Int (PK) | No | Identificador unico |
| `rolID` | Int (FK) | No | Rol relacionado |
| `dashboarpathID` | Int (FK) | No | Ruta relacionada |

**Comportamiento en cascada:** Al eliminar un rol o una ruta, se eliminan automaticamente los permisos asociados (`ON DELETE CASCADE`).

---

## Entidades de Catalogos

### 9. Company (Empresas)

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `CompanyID` | Int (PK) | Identificador unico |
| `Description` | NVarChar(100) | Nombre de la empresa |

### 10. Site (Sitios/Ubicaciones)

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `SiteID` | Int (PK) | Identificador unico |
| `Name` | NVarChar(150) | Nombre del sitio |
| `CompanyID` | Int (FK) | Empresa a la que pertenece |

### 11. Vendor (Proveedores)

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `VendorID` | Int (PK) | Identificador unico |
| `Name` | NVarChar(150) | Nombre del proveedor |

### 12. ProductType (Tipos de Producto)

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `ProductTypeID` | Int (PK) | Identificador unico |
| `Name` | NVarChar(150) | Nombre del tipo de producto |
| `Category` | NVarChar(150) | Categoria libre |
| `Group` | NVarChar(150) | Grupo predefinido (Equipo, Accesorio, Componente, Otros) |
| `SubCategory` | NVarChar(150) | Subcategoria especifica |

**Jerarquia de clasificacion:**
```
Group (Grupo predefinido)
  └── Category (Categoria libre)
       └── SubCategory (Subcategoria)
            └── Name (Nombre especifico)
```

Ejemplo:
```
Equipo
  └── Computadoras
       └── Portatiles
            └── Laptop Dell Latitude 5540
```

### 13. AssetState (Estados de Activo)

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `AssetStateID` | Int (PK) | Identificador unico |
| `Name` | NVarChar(100) | Nombre del estado |

Estados tipicos: Activo, Inactivo, En Reparacion, Dado de Baja, En Resguardo.

### 14. Depart (Departamentos)

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `DepartID` | Int (PK) | Identificador unico |
| `Name` | NVarChar(255) | Nombre del departamento |

### 15. Site_Depart (Relacion Sitio-Departamento)

Tabla pivote que relaciona sitios con departamentos disponibles.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| `ID_site` | Int (PK, FK) | Sitio |
| `ID_depart` | Int (PK, FK) | Departamento |

Llave primaria compuesta `(ID_site, ID_depart)`. Cascada en eliminacion.

---

## Relaciones del Modelo

### Diagrama de Relaciones Completo

```
┌─────────────────────────────────────────────────────────────────────┐
│                    RELACIONES PRINCIPALES                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  User ────────► rol (N:1)          Un usuario tiene un rol          │
│  User ────────► Site (N:1)         Un usuario pertenece a un sitio  │
│  User ────────► Depart (N:1)       Un usuario tiene un departamento │
│                                                                      │
│  Asset ───────► Vendor (N:1)       Cada activo tiene un proveedor   │
│  Asset ───────► ProductType (N:1)  Cada activo tiene un tipo        │
│  Asset ───────► AssetState (N:1)   Cada activo tiene un estado      │
│  Asset ───────► Company (N:1)      Activo pertenece a empresa       │
│  Asset ───────► Site (N:1)         Activo ubicado en un sitio       │
│  Asset ───────► User (N:1)         Activo asignado a usuario        │
│  Asset ───────► Depart (N:1)       Activo en un departamento        │
│  Asset ───────► Asset (N:1)        Activo hijo de otro (jerarquia)  │
│                                                                      │
│  Asset ◄────── AssetDetail (1:N)   Detalle tecnico del activo       │
│  Asset ◄────── AssetHistory (1:N)  Historial de operaciones         │
│  Asset ◄────── AssetOwnershipHistory (1:N)  Historial de propiedad  │
│                                                                      │
│  rol ◄────────► dashboard_paths (N:M via rol_dashboard_path)        │
│  Site ◄────────► Depart (N:M via Site_Depart)                       │
│  Company ◄──── Site (1:N)          Una empresa tiene muchos sitios  │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### Reglas de Integridad Referencial

| Relacion | ON DELETE | ON UPDATE | Nota |
|----------|-----------|-----------|------|
| Asset → Vendor | No Action | No Action | No se puede eliminar un proveedor con activos |
| Asset → ProductType | No Action | No Action | No se puede eliminar un tipo con activos |
| Asset → AssetState | No Action | No Action | No se puede eliminar un estado en uso |
| Asset → Asset (Parent) | No Action | No Action | Protege jerarquias de activos |
| rol_dashboard_path → rol | Cascade | No Action | Permisos se eliminan con el rol |
| rol_dashboard_path → dashboard_paths | Cascade | No Action | Permisos se eliminan con la ruta |
| Site_Depart → Site | Cascade | No Action | Relacion se limpia al eliminar sitio |
| Site_Depart → Depart | Cascade | No Action | Relacion se limpia al eliminar depto |

---

## Flujo de Datos

### 1. Alta de Activo

```
Usuario crea activo en /altas
        │
        ▼
┌─────────────────────┐
│   POST /asset       │  Se crea registro en tabla Asset
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│  Asset + AssetDetail│  Se crean registros con datos basicos
│  + AssetHistory     │  y especificaciones tecnicas.
└─────────┬───────────┘  Se registra operacion "ALTA" en historial.
          │
          ▼
┌─────────────────────┐
│ AssetOwnershipHistory│ Si se asigna usuario, se registra
└─────────────────────┘  la propiedad con FromDate = hoy.
```

### 2. Movimiento de Activo

```
Usuario registra movimiento en /movimientos
        │
        ▼
┌──────────────────────┐
│  POST /movement      │  Tipos: REASIGNACION, RESGUARDO,
└──────────┬───────────┘         REPARACION, BAJA
           │
           ▼
┌──────────────────────┐
│ Actualizacion Asset  │  Se actualiza estado, usuario,
│ + AssetHistory       │  sitio segun tipo de movimiento.
│ + OwnershipHistory   │  Se registra en historial.
└──────────────────────┘
```

### 3. Consulta de Trazabilidad

```
Consulta historial de activo
        │
        ▼
┌──────────────────────────────┐
│ GET /movement/asset/:assetId │
└──────────┬───────────────────┘
           │
           ▼
┌──────────────────────────────┐
│  AssetHistory                │  Operaciones: ALTA, BAJA,
│  + AssetOwnershipHistory     │  REASIGNACION, REPARACION...
│  + AssetDetail (estado)      │  Cadena de custodia completa.
└──────────────────────────────┘
```

---

## Stored Procedures

El sistema incluye stored procedures para integracion con el ERP (Epicor):

### GetPOHeaderv3
- **Esquema**: `cpo`
- **Proposito**: Consulta cabeceras de ordenes de compra desde el ERP
- **Parametros**: Company, PONum, Proveedor, SKU, Departamento, Estatus, rango de ETA, paginacion
- **Fuente de datos**: `E10Prod.Erp.POHeader`, `E10Prod.Erp.Vendor`, `E10Prod.Erp.PODetail`
- **Caracteristicas**: Paginacion con `ROW_NUMBER()`, filtros multiples opcionales, conteo total de registros

### GetPODetailv3
- **Esquema**: `cpo`
- **Proposito**: Consulta detalle de lineas de ordenes de compra
- **Parametros**: Mismos que GetPOHeaderv3 + filtros a nivel de linea
- **Fuente de datos**: Mismas tablas + `Catalogo_Maestro.dbo.PartClasificacion`
- **Caracteristicas**: Tabla temporal `#Base` para materializar resultados, paginacion eficiente

---

## Migraciones de Base de Datos

Las migraciones se encuentran en `InventarioIT-API-icel/prisma/migrations/`:

### 001_create_movement_tables.sql
- Crea la tabla `AssetHistory` para el sistema de movimientos
- Incluye validacion `IF NOT EXISTS` para ejecucion idempotente
- Tipos de movimientos soportados: Alta, Baja, Reasignacion, Prestamo

### 002_swap_category_group_values.sql
- Corrige la asignacion de valores entre `Category` y `Group` en `ProductType`
- `Group` ahora almacena valores predefinidos (Equipo, Accesorio, Componente, Otros)
- `Category` ahora almacena texto libre (categorias descriptivas)
- Usa columna temporal para swap seguro

### Scripts SQL adicionales

| Script | Proposito |
|--------|-----------|
| `add_factura_ticket_to_asset_detail.sql` | Agrega campos Factura y Ticket a AssetDetail |
| `update_usuarios_icon.sql` | Actualiza icono de la ruta de usuarios |

---

## Respaldo de Base de Datos

Se incluye un respaldo de SQL Server en:
```
BASE_DATOS/InventarioIT2.bak
```

**Para restaurar:**
```sql
RESTORE DATABASE InventarioIT
FROM DISK = '/ruta/al/InventarioIT2.bak'
WITH MOVE 'InventarioIT' TO '/var/opt/mssql/data/InventarioIT.mdf',
     MOVE 'InventarioIT_log' TO '/var/opt/mssql/data/InventarioIT_log.ldf',
     REPLACE;
```

---

## Cadena de Conexion

La conexion a la base de datos se configura mediante la variable de entorno `DATABASE_URL`:

```
sqlserver://HOST:1433;database=InventarioIT;user=USUARIO;password=CONTRASEÑA;encrypt=true;trustServerCertificate=true
```

### Generacion del cliente Prisma

```bash
cd InventarioIT-API-icel
npx prisma generate --schema=./prisma/inventarioit/schema.prisma
```

---

## Consideraciones de Datos

### Volumetria Estimada

| Entidad | Volumen esperado | Crecimiento |
|---------|-----------------|-------------|
| Asset | Cientos a miles | Medio (altas periodicas) |
| AssetDetail | 1 por Asset | Proporcional a Asset |
| AssetHistory | Miles a decenas de miles | Alto (cada operacion genera registro) |
| AssetOwnershipHistory | Miles | Medio (cada reasignacion) |
| User | Decenas a cientos | Bajo |
| ProductType | Decenas | Bajo (catalogo estable) |
| Vendor | Decenas | Bajo |

### Indices Recomendados

El esquema actual define los siguientes indices:
- **PK en todas las tablas**: Indice clustered por ID autoincremental
- **Unique en `dashboard_paths.path`**: Garantiza rutas unicas
- **Unique en `Site_Depart(ID_site, ID_depart)`**: Evita duplicados en relacion

### Buenas Practicas de Datos

1. **Nunca eliminar activos directamente**: Usar movimiento de tipo `BAJA` para mantener trazabilidad
2. **Mantener historial**: Cada cambio significativo debe generar un registro en `AssetHistory`
3. **Cadena de custodia**: Siempre registrar cambios de propiedad en `AssetOwnershipHistory`
4. **Catalogos normalizados**: Usar las tablas de catalogo en lugar de texto libre donde sea posible
5. **Respaldos periodicos**: Realizar backups regulares del archivo `.bak`
