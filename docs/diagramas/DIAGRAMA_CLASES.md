# Diagrama de Clases y Modelo de Datos

## Diagrama Entidad-Relacion (ER)

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                           MODELO DE DATOS - INVENTARIO TI                            │
└─────────────────────────────────────────────────────────────────────────────────────┘

                              GESTION DE USUARIOS Y PERMISOS
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                      │
│   ┌─────────────────────┐         ┌─────────────────────┐                           │
│   │        User         │         │         rol         │                           │
│   ├─────────────────────┤         ├─────────────────────┤                           │
│   │ PK ID: Int          │         │ PK rolID: Int       │                           │
│   │    Email: String    │◄────────┤    name: String     │                           │
│   │    Name: String     │   FK    │    isActive: Bool   │                           │
│   │    FirstName: String│  rolD   │    createdAt: Date  │                           │
│   │    LastName: String │         └──────────┬──────────┘                           │
│   │    Department: String         ▲          │                                      │
│   │ FK SiteID: Int      │         │          │ 1:N                                  │
│   │ FK rolD: Int ───────┼─────────┘          │                                      │
│   │    isActive: Bool   │                    │                                      │
│   │    token: String?   │         ┌──────────▼──────────┐                           │
│   │    createdAt: Date  │         │ rol_dashboard_path  │                           │
│   └─────────────────────┘         ├─────────────────────┤                           │
│            │                      │ PK roldashboardpath │                           │
│            │ 1:N                  │    ID: Int          │                           │
│            │                      │ FK rolID: Int ──────┼───────────┐               │
│            ▼                      │ FK dashboarpathID:  │           │               │
│   ┌─────────────────────┐         │    Int ─────────────┼─────┐     │               │
│   │AssetOwnershipHistory│         └─────────────────────┘     │     │               │
│   ├─────────────────────┤                                     │     │               │
│   │ PK AssetOwnership   │         ┌─────────────────────┐     │     │               │
│   │    HistoryID: Int   │         │   dashboard_paths   │◄────┘     │               │
│   │ FK UserID: Int      │         ├─────────────────────┤           │               │
│   │ FK AssetID: Int     │         │ PK dashboarpathID:  │           │               │
│   │    FromDate: Date   │         │    Int              │           │               │
│   │    ToDate: Date?    │         │    path: String     │           │               │
│   └─────────────────────┘         │    name: String     │           │               │
│                                   │    icon: String?    │           │               │
│                                   └─────────────────────┘           │               │
│                                                                     │               │
└─────────────────────────────────────────────────────────────────────┼───────────────┘
                                                                      │
                                                                      │
                              GESTION DE ACTIVOS TI                   │
┌─────────────────────────────────────────────────────────────────────┼───────────────┐
│                                                                     │               │
│   ┌─────────────────────┐         ┌─────────────────────┐           │               │
│   │       Asset         │         │     AssetDetail     │           │               │
│   ├─────────────────────┤         ├─────────────────────┤           │               │
│   │ PK AssetID: Int     │◄────────┤ PK AssetDetailID:   │           │               │
│   │    Name: String     │   FK    │    Int              │           │               │
│   │ FK VendorID: Int    │ AssetID │ FK AssetID: Int     │           │               │
│   │ FK ProductTypeID:   │         │    ProductManuf:    │           │               │
│   │    Int              │         │    String           │           │               │
│   │ FK AssetStateID:    │         │    IPAddress: String│           │               │
│   │    Int              │         │    MACAddress: String           │               │
│   │ FK CompanyID: Int   │         │    OperatingSystem: │           │               │
│   │ FK SiteID: Int      │         │    String           │           │               │
│   │ FK UserID: Int?     │         │    Processor: String│           │               │
│   └──────────┬──────────┘         │    RAM: String      │           │               │
│              │                    │    SerialNum: String│           │               │
│              │ 1:N                │    PurchaseDate:    │           │               │
│              │                    │    Date             │           │               │
│              ▼                    │    WarrantyExpiry   │           │               │
│   ┌─────────────────────┐         │    Date: Date       │           │               │
│   │    AssetHistory     │         │    Barcode: String  │           │               │
│   ├─────────────────────┤         │    LastUpdateBy:    │           │               │
│   │ PK AssetHistoryID:  │         │    String           │           │               │
│   │    Int              │         └─────────────────────┘           │               │
│   │ FK AssetID: Int     │                                           │               │
│   │    Operation: String│                                           │               │
│   │    Description:     │                                           │               │
│   │    String           │                                           │               │
│   │    CreatedTime: Date│                                           │               │
│   └─────────────────────┘                                           │               │
│                                                                     │               │
└─────────────────────────────────────────────────────────────────────────────────────┘


                                    CATALOGOS
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                      │
│   ┌─────────────────────┐         ┌─────────────────────┐                           │
│   │      Company        │         │        Site         │                           │
│   ├─────────────────────┤         ├─────────────────────┤                           │
│   │ PK CompanyID: Int   │◄────────┤ PK SiteID: Int      │                           │
│   │    Description:     │   FK    │    Name: String     │                           │
│   │    String           │ Company │ FK CompanyID: Int   │                           │
│   └─────────────────────┘   ID    └─────────────────────┘                           │
│                                                                                      │
│   ┌─────────────────────┐         ┌─────────────────────┐                           │
│   │       Vendor        │         │    ProductType      │                           │
│   ├─────────────────────┤         ├─────────────────────┤                           │
│   │ PK VendorID: Int    │         │ PK ProductTypeID:   │                           │
│   │    Name: String     │         │    Int              │                           │
│   └─────────────────────┘         │    Name: String     │                           │
│                                   │    Category: String │                           │
│   ┌─────────────────────┐         │    Group: String    │                           │
│   │     AssetState      │         │    SubCategory:     │                           │
│   ├─────────────────────┤         │    String           │                           │
│   │ PK AssetStateID: Int│         └─────────────────────┘                           │
│   │    Name: String     │                                                           │
│   └─────────────────────┘                                                           │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

## Descripcion de Entidades

### Entidades Principales

#### User (Usuarios)
Almacena la informacion de los usuarios del sistema.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| ID | Int (PK) | Identificador unico |
| Email | String (Unique) | Correo electronico |
| Name | String | Nombre completo |
| FirstName | String? | Nombre |
| LastName | String? | Apellido |
| Department | String? | Departamento |
| SiteID | Int (FK) | Sitio asignado |
| rolD | Int (FK) | Rol asignado |
| isActive | Boolean | Estado del usuario |
| token | String? | Token de sesion |
| createdAt | DateTime | Fecha de creacion |

#### rol (Roles)
Define los roles disponibles en el sistema.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| rolID | Int (PK) | Identificador unico |
| name | String (Unique) | Nombre del rol |
| isActive | Boolean | Estado del rol |
| createdAt | DateTime | Fecha de creacion |

#### dashboard_paths (Rutas del Dashboard)
Define las rutas/modulos disponibles en la aplicacion.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| dashboarpathID | Int (PK) | Identificador unico |
| path | String (Unique) | Ruta URL |
| name | String | Nombre descriptivo |
| icon | String? | Icono de Lucide |

#### rol_dashboard_path (Permisos)
Tabla pivote que relaciona roles con rutas (permisos).

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| roldashboardpathID | Int (PK) | Identificador unico |
| rolID | Int (FK) | Rol relacionado |
| dashboarpathID | Int (FK) | Ruta relacionada |

### Entidades de Inventario

#### Asset (Activos)
Registro principal de activos de TI.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| AssetID | Int (PK) | Identificador unico |
| Name | String | Nombre del activo |
| VendorID | Int (FK) | Proveedor |
| ProductTypeID | Int (FK) | Tipo de producto |
| AssetStateID | Int (FK) | Estado actual |
| CompanyID | Int (FK) | Empresa propietaria |
| SiteID | Int (FK) | Ubicacion |
| UserID | Int? (FK) | Usuario asignado |

#### AssetDetail (Detalles de Activo)
Informacion tecnica detallada del activo.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| AssetDetailID | Int (PK) | Identificador unico |
| AssetID | Int (FK) | Activo relacionado |
| ProductManuf | String? | Fabricante |
| IPAddress | String? | Direccion IP |
| MACAddress | String? | Direccion MAC |
| OperatingSystem | String? | Sistema operativo |
| Processor | String? | Procesador |
| RAM | String? | Memoria RAM |
| SerialNum | String? | Numero de serie |
| PurchaseDate | DateTime? | Fecha de compra |
| WarrantyExpiryDate | DateTime? | Fin de garantia |
| Barcode | String? | Codigo de barras |
| LastUpdateBy | String? | Ultimo modificador |

#### AssetHistory (Historial de Activos)
Registro de operaciones realizadas sobre activos.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| AssetHistoryID | Int (PK) | Identificador unico |
| AssetID | Int (FK) | Activo relacionado |
| Operation | String | Tipo de operacion |
| Description | String? | Descripcion |
| CreatedTime | DateTime | Fecha de operacion |

#### AssetOwnershipHistory (Historial de Propiedad)
Rastrea los cambios de asignacion de activos.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| AssetOwnershipHistoryID | Int (PK) | Identificador unico |
| UserID | Int (FK) | Usuario asignado |
| AssetID | Int (FK) | Activo |
| FromDate | DateTime | Fecha inicio |
| ToDate | DateTime? | Fecha fin |

### Entidades de Catalogos

#### Company (Empresas)
| Campo | Tipo | Descripcion |
|-------|------|-------------|
| CompanyID | Int (PK) | Identificador unico |
| Description | String | Nombre de empresa |

#### Site (Sitios)
| Campo | Tipo | Descripcion |
|-------|------|-------------|
| SiteID | Int (PK) | Identificador unico |
| Name | String | Nombre del sitio |
| CompanyID | Int (FK) | Empresa |

#### Vendor (Proveedores)
| Campo | Tipo | Descripcion |
|-------|------|-------------|
| VendorID | Int (PK) | Identificador unico |
| Name | String | Nombre |

#### ProductType (Tipos de Producto)
| Campo | Tipo | Descripcion |
|-------|------|-------------|
| ProductTypeID | Int (PK) | Identificador unico |
| Name | String | Nombre |
| Category | String? | Categoria |
| Group | String? | Grupo |
| SubCategory | String? | Subcategoria |

#### AssetState (Estados de Activo)
| Campo | Tipo | Descripcion |
|-------|------|-------------|
| AssetStateID | Int (PK) | Identificador unico |
| Name | String | Nombre del estado |

## Relaciones

### Relaciones de Usuario
```
User ──────────► rol (N:1)
    Un usuario pertenece a un rol
    Un rol puede tener muchos usuarios

User ──────────► Site (N:1)
    Un usuario pertenece a un sitio
    Un sitio puede tener muchos usuarios

User ◄─────────── AssetOwnershipHistory (1:N)
    Un usuario puede tener muchos historiales de propiedad
```

### Relaciones de Permisos
```
rol ◄─────────── rol_dashboard_path (1:N)
    Un rol puede tener muchos permisos

dashboard_paths ◄─────────── rol_dashboard_path (1:N)
    Una ruta puede estar en muchos permisos

rol ◄──────────► dashboard_paths (N:M via rol_dashboard_path)
    Relacion muchos a muchos entre roles y rutas
```

### Relaciones de Activos
```
Asset ◄─────────── AssetDetail (1:1)
    Un activo tiene un detalle

Asset ◄─────────── AssetHistory (1:N)
    Un activo puede tener muchos registros de historial

Asset ◄─────────── AssetOwnershipHistory (1:N)
    Un activo puede tener muchos propietarios en el tiempo

Asset ──────────► Vendor (N:1)
Asset ──────────► ProductType (N:1)
Asset ──────────► AssetState (N:1)
Asset ──────────► Company (N:1)
Asset ──────────► Site (N:1)
Asset ──────────► User (N:1) [opcional]
```

### Relaciones de Catalogos
```
Company ◄─────────── Site (1:N)
    Una empresa puede tener muchos sitios
```

## Diagrama de Clases TypeScript (Backend)

```typescript
// user.entity.ts
class User {
  ID: number;
  Email: string;
  Name: string;
  FirstName?: string;
  LastName?: string;
  Department?: string;
  SiteID?: number;
  rolD?: number;
  isActive: boolean;
  token?: string;
  createdAt: Date;

  // Relaciones
  rol?: Rol;
  Site?: Site;
  AssetOwnershipHistory?: AssetOwnershipHistory[];
}

// rol.entity.ts
class Rol {
  rolID: number;
  name: string;
  isActive: boolean;
  createdAt: Date;

  // Relaciones
  User?: User[];
  rol_dashboard_path?: RolDashboardPath[];
}

// dashboard_paths.entity.ts
class DashboardPath {
  dashboarpathID: number;
  path: string;
  name: string;
  icon?: string;

  // Relaciones
  rol_dashboard_path?: RolDashboardPath[];
}

// rol_dashboard_path.entity.ts
class RolDashboardPath {
  roldashboardpathID: number;
  rolID: number;
  dashboarpathID: number;

  // Relaciones
  rol?: Rol;
  dashboard_paths?: DashboardPath;
}

// asset.entity.ts
class Asset {
  AssetID: number;
  Name: string;
  VendorID?: number;
  ProductTypeID?: number;
  AssetStateID?: number;
  CompanyID?: number;
  SiteID?: number;
  UserID?: number;

  // Relaciones
  Vendor?: Vendor;
  ProductType?: ProductType;
  AssetState?: AssetState;
  Company?: Company;
  Site?: Site;
  User?: User;
  AssetDetail?: AssetDetail;
  AssetHistory?: AssetHistory[];
  AssetOwnershipHistory?: AssetOwnershipHistory[];
}
```

## Indices y Constraints

### Indices Unicos
- `User.Email` - Emails unicos
- `rol.name` - Nombres de rol unicos
- `dashboard_paths.path` - Rutas unicas

### Foreign Keys
Todas las relaciones FK tienen constraints de integridad referencial definidas en el schema de Prisma.

### Valores por Defecto
- `User.isActive` = true
- `User.createdAt` = now()
- `rol.isActive` = true
- `rol.createdAt` = now()
