# Sistema de Gestion de Inventario de TI

Sistema empresarial full-stack para la gestion de activos tecnologicos, usuarios, roles y permisos dentro de una organizacion. Desarrollado como Proyecto Terminal con arquitectura moderna de microservicios y autenticacion empresarial mediante Azure Active Directory.

## Stack Tecnologico

| Capa | Tecnologia | Version |
|------|------------|---------|
| **Frontend** | Next.js, React, TypeScript, Tailwind CSS, Radix UI | 15 / 19 |
| **Backend** | NestJS, TypeScript, Prisma ORM | 11 / 6.19 |
| **Base de Datos** | SQL Server | 2019+ |
| **Autenticacion** | Azure Active Directory (OAuth 2.0 / OpenID Connect) | - |
| **Contenedores** | Docker (multi-stage builds) | - |
| **Orquestacion** | Kubernetes con Helm Charts | - |
| **CI/CD** | GitHub Actions (staging + produccion) | - |
| **Registro** | Azure Container Registry | - |

## Estructura del Proyecto

```
PROYECTO_TERMINAL_INVENTARIO_TI/
├── docs/                          # Documentacion completa del proyecto
│   ├── diagramas/                 # Diagramas de arquitectura y secuencia
│   ├── api/                       # Documentacion de endpoints REST
│   ├── componentes/               # Documentacion de componentes React
│   ├── datos/                     # Modelo de datos y base de datos
│   ├── guias/                     # Guias de uso
│   └── instalacion/               # Guias de instalacion
├── BASE_DATOS/                    # Respaldos de base de datos (.bak)
├── InventarioIT-API-icel/         # Backend (NestJS)
│   ├── src/                       # Codigo fuente (modulos NestJS)
│   │   ├── auth/                  # Autenticacion y middleware
│   │   ├── asset/                 # Gestion de activos
│   │   ├── user/                  # Gestion de usuarios
│   │   ├── rol/                   # Gestion de roles
│   │   ├── permission/            # Gestion de permisos
│   │   ├── movement/              # Movimientos de activos
│   │   ├── vendor/                # Catalogo de proveedores
│   │   ├── product-type/          # Catalogo de tipos de producto
│   │   ├── asset-state/           # Catalogo de estados
│   │   ├── company/               # Catalogo de empresas
│   │   ├── site/                  # Catalogo de sitios
│   │   └── database/              # Servicio de base de datos
│   ├── prisma/                    # Schema de Prisma y migraciones
│   ├── sql/                       # Scripts SQL y stored procedures
│   ├── .chart/                    # Helm chart (staging)
│   ├── .chart-prod/               # Helm chart (produccion)
│   └── .github/workflows/         # CI/CD pipelines
└── InventarioIT-web-main/         # Frontend (Next.js)
    ├── src/
    │   ├── pages/                 # Paginas de Next.js
    │   ├── components/            # Componentes React (30+ UI)
    │   ├── hooks/                 # Custom hooks
    │   ├── lib/                   # Cliente API y utilidades
    │   ├── types/                 # Definiciones TypeScript
    │   └── middleware.ts          # Proteccion de rutas
    ├── .chart/                    # Helm chart
    └── .github/workflows/         # CI/CD pipelines
```

## Funcionalidades Principales

### Gestion de Activos TI
- Registro completo de activos tecnologicos (CRUD)
- Especificaciones tecnicas detalladas (IP, MAC, CPU, RAM, serie, garantia, factura)
- Clasificacion jerarquica: Grupo > Categoria > Subcategoria > Producto
- Relaciones padre-hijo entre activos (ej: monitor asignado a laptop)
- Codigo de barras y etiquetas de activo
- Estados de ciclo de vida: Activo, Inactivo, En Reparacion, Resguardo, Baja

### Movimientos y Trazabilidad
- **Reasignacion**: Cambio de usuario responsable
- **Resguardo**: Activo en almacen temporal
- **Reparacion**: Envio a servicio tecnico
- **Baja**: Retiro del inventario
- Movimientos masivos (bulk operations)
- Historial completo de operaciones por activo
- Cadena de custodia con fechas de asignacion

### Gestion de Usuarios y Acceso
- Autenticacion empresarial con Azure Active Directory
- Roles configurables con permisos granulares
- Permisos basados en rutas del dashboard
- Navegacion dinamica segun permisos del usuario
- Activacion/desactivacion de usuarios y roles
- Asignacion a departamentos y sitios

### Catalogos del Sistema
- Empresas (Companies)
- Sitios/Ubicaciones (Sites)
- Departamentos (Departs)
- Proveedores (Vendors)
- Tipos de producto con jerarquia (ProductTypes)
- Estados de activo (AssetStates)

## Paginas de la Aplicacion

| Pagina | Ruta | Descripcion |
|--------|------|-------------|
| Login | `/` | Autenticacion con Azure AD |
| Dashboard | `/dashboard` | Panel principal |
| Altas | `/altas` | Creacion y gestion de activos |
| Historial | `/historial` | Historial de operaciones de activos |
| Movimientos | `/movimientos` | Registro de movimientos de activos |
| Usuarios | `/usuarios` | Administracion de usuarios |
| Roles | `/roles` | Administracion de roles |
| Permisos | `/permisos` | Asignacion de permisos a roles |
| Puertos Origen | `/puertos-origen` | Gestion de puertos de origen |

## Documentacion

| Documento | Descripcion |
|-----------|-------------|
| [Documentacion Principal](./docs/README.md) | Indice completo de documentacion |
| [Modelo de Datos](./docs/datos/DATOS.md) | Esquema de BD, entidades, relaciones y flujo de datos |
| [Arquitectura](./docs/diagramas/ARQUITECTURA.md) | Diagrama de arquitectura del sistema |
| [Diagrama de Clases](./docs/diagramas/DIAGRAMA_CLASES.md) | Modelo de entidades y relaciones |
| [Infraestructura](./docs/diagramas/INFRAESTRUCTURA.md) | Componentes tecnologicos |
| [Autenticacion](./docs/diagramas/AUTENTICACION.md) | Flujo de autenticacion Azure AD |
| [Diagramas de Secuencia](./docs/diagramas/SECUENCIAS.md) | Flujos de operaciones principales |
| [API Reference](./docs/api/API_REFERENCE.md) | Documentacion de endpoints REST |
| [Componentes](./docs/componentes/COMPONENTES.md) | Componentes React del frontend |
| [Tipos de Activo](./docs/guias/TIPOS_DE_ACTIVO.md) | Guia de clasificacion de activos |
| [Instalacion](./docs/instalacion/INSTALACION.md) | Guia de configuracion e instalacion |

## Inicio Rapido

### Requisitos
- Node.js 18+
- SQL Server 2019+
- Azure AD Tenant (para autenticacion)
- Docker (opcional, para despliegue)

### Instalacion

```bash
# 1. Clonar el repositorio
git clone <url-del-repositorio>
cd PROYECTO_TERMINAL_INVENTARIO_TI

# 2. Restaurar base de datos (opcional - usar backup incluido)
# Restaurar BASE_DATOS/InventarioIT2.bak en SQL Server

# 3. Configurar e iniciar Backend
cd InventarioIT-API-icel
npm install
cp .env.example .env  # Configurar DATABASE_URL y variables
npm run db:generate
npm run start:dev      # Puerto 3001

# 4. Configurar e iniciar Frontend
cd ../InventarioIT-web-main
npm install
cp .env.example .env.local  # Configurar Azure AD y API URL
npm run dev                  # Puerto 3000
```

### Variables de Entorno

**Backend** (`InventarioIT-API-icel/.env`):
```env
DATABASE_URL="sqlserver://HOST:1433;database=InventarioIT;user=USER;password=PASS;encrypt=true;trustServerCertificate=true"
API_PREFIX=api
API_PORT=3001
```

**Frontend** (`InventarioIT-web-main/.env.local`):
```env
NEXT_PUBLIC_API=http://localhost:3001
AUTH_SECRET=<secreto-nextauth>
AZURE_AD_CLIENT_ID=<client-id>
AZURE_AD_CLIENT_SECRET=<client-secret>
AZURE_AD_TENANT_ID=<tenant-id>
```

### URLs de Desarrollo
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:3001

## Despliegue

El proyecto incluye configuracion completa para despliegue en Kubernetes:

- **Docker**: Dockerfiles multi-stage para frontend y backend (Node.js 20-alpine)
- **Helm Charts**: Configuraciones separadas para staging y produccion
- **CI/CD**: GitHub Actions con pipelines automaticos
- **Registro**: Azure Container Registry para imagenes Docker

```bash
# Build Docker (Backend)
cd InventarioIT-API-icel
docker build -t inventarioit-api .

# Build Docker (Frontend)
cd InventarioIT-web-main
docker build -t inventarioit-web .
```

## Arquitectura del Sistema

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│                  │     │                  │     │                  │
│   Cliente Web    │────►│   Next.js 15     │────►│   NestJS API     │
│   (Navegador)    │     │   (Frontend)     │     │   (Backend)      │
│                  │     │   Puerto 3000    │     │   Puerto 3001    │
└──────────────────┘     └────────┬─────────┘     └────────┬─────────┘
                                  │                         │
                         ┌────────▼─────────┐     ┌────────▼─────────┐
                         │   Azure AD       │     │   SQL Server     │
                         │   (OAuth 2.0)    │     │   (Prisma ORM)   │
                         └──────────────────┘     └──────────────────┘
```

## Autores

**Proyecto Terminal** - Israel Cel y Salvador Salas

## Licencia

Proyecto de uso academico y empresarial interno.
