# Diagrama de Infraestructura de Software

## Vista General de la Infraestructura

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                            INFRAESTRUCTURA DE PRODUCCION                             │
└─────────────────────────────────────────────────────────────────────────────────────┘

                                    INTERNET
                                       │
                                       │ HTTPS (443)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                              CAPA DE SEGURIDAD                                       │
│  ┌───────────────────────────────────────────────────────────────────────────────┐  │
│  │                           AZURE ACTIVE DIRECTORY                               │  │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐                │  │
│  │  │  App Registration│  │   OAuth 2.0     │  │  Token Service  │                │  │
│  │  │  Client ID       │  │   Authorization │  │  JWT Validation │                │  │
│  │  │  Client Secret   │  │   Code Flow     │  │                 │                │  │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘                │  │
│  └───────────────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────────────┘
                                       │
                              OAuth Tokens (JWT)
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                               CAPA DE APLICACION                                     │
│                                                                                      │
│  ┌───────────────────────────────────────────────────────────────────────────────┐  │
│  │                           SERVIDOR FRONTEND                                    │  │
│  │                         (Next.js Standalone)                                   │  │
│  │                                                                               │  │
│  │  Puerto: 3000                                                                 │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │  │
│  │  │   Next.js    │  │   React 19   │  │  NextAuth.js │  │   Tailwind   │      │  │
│  │  │   Server     │  │  Components  │  │   Session    │  │     CSS      │      │  │
│  │  │   (SSR)      │  │              │  │   Manager    │  │              │      │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘      │  │
│  │                                                                               │  │
│  │  Dependencias Clave:                                                          │  │
│  │  - next: 15.4.10           - @radix-ui/*: UI Components                      │  │
│  │  - react: 19.1.1           - @tanstack/react-table: Data Tables              │  │
│  │  - next-auth: 4.24.11      - axios: HTTP Client                              │  │
│  │  - tailwindcss: 4.0.0      - lucide-react: Icons                             │  │
│  └───────────────────────────────────────────────────────────────────────────────┘  │
│                                       │                                              │
│                              HTTP (REST API)                                         │
│                              Puerto: 3001                                            │
│                                       ▼                                              │
│  ┌───────────────────────────────────────────────────────────────────────────────┐  │
│  │                            SERVIDOR BACKEND                                    │  │
│  │                              (NestJS API)                                      │  │
│  │                                                                               │  │
│  │  Puerto: 3001                                                                 │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │  │
│  │  │   NestJS     │  │  Controllers │  │   Services   │  │  Middleware  │      │  │
│  │  │   Core       │  │  (REST API)  │  │   (Logic)    │  │   (Auth)     │      │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘      │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                        │  │
│  │  │   Prisma     │  │     DTOs     │  │   Modules    │                        │  │
│  │  │   Client     │  │  Validation  │  │  (DI/IoC)    │                        │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘                        │  │
│  │                                                                               │  │
│  │  Dependencias Clave:                                                          │  │
│  │  - @nestjs/core: 10.x       - class-validator: Validation                    │  │
│  │  - @prisma/client: 5.x      - class-transformer: DTO Transform               │  │
│  │  - @nestjs/platform-express - jsonwebtoken: JWT Handling                     │  │
│  └───────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘
                                       │
                               Prisma Client
                               SQL Server Driver
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                                CAPA DE DATOS                                         │
│                                                                                      │
│  ┌───────────────────────────────────────────────────────────────────────────────┐  │
│  │                          SQL SERVER 2019+                                      │  │
│  │                                                                               │  │
│  │  Puerto: 1433                                                                 │  │
│  │  Database: InventarioIT                                                       │  │
│  │                                                                               │  │
│  │  ┌──────────────────────────────────────────────────────────────────────────┐ │  │
│  │  │                         TABLAS PRINCIPALES                               │ │  │
│  │  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐ ┌───────────────────────┐   │ │  │
│  │  │  │  User    │ │   rol    │ │dashboard_path│ │  rol_dashboard_path   │   │ │  │
│  │  │  └──────────┘ └──────────┘ └──────────────┘ └───────────────────────┘   │ │  │
│  │  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐ ┌───────────────────────┐   │ │  │
│  │  │  │  Asset   │ │AssetDetail│ │ AssetHistory │ │AssetOwnershipHistory │   │ │  │
│  │  │  └──────────┘ └──────────┘ └──────────────┘ └───────────────────────┘   │ │  │
│  │  │  ┌──────────┐ ┌──────────┐ ┌──────────────┐ ┌───────────────────────┐   │ │  │
│  │  │  │ Company  │ │   Site   │ │    Vendor    │ │      ProductType      │   │ │  │
│  │  │  └──────────┘ └──────────┘ └──────────────┘ └───────────────────────┘   │ │  │
│  │  └──────────────────────────────────────────────────────────────────────────┘ │  │
│  │                                                                               │  │
│  │  Backup: BASE_DATOS/InventarioIT2.bak (5.9 MB)                               │  │
│  └───────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

## Diagrama de Componentes Tecnologicos

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                           STACK TECNOLOGICO DETALLADO                                │
└─────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────┐
│ FRONTEND (Next.js 15)                                                                │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                      │
│  Framework Core                 UI Components              State & Data             │
│  ┌─────────────────┐           ┌─────────────────┐        ┌─────────────────┐       │
│  │ Next.js 15      │           │ Radix UI        │        │ React Hooks     │       │
│  │ - App Router    │           │ - Dialog        │        │ - useState      │       │
│  │ - API Routes    │           │ - Select        │        │ - useEffect     │       │
│  │ - Middleware    │           │ - Checkbox      │        │ - useContext    │       │
│  │ - SSR/CSR       │           │ - Toast         │        │ - Custom Hooks  │       │
│  └─────────────────┘           │ - Dropdown      │        └─────────────────┘       │
│                                │ - Avatar        │                                   │
│  ┌─────────────────┐           └─────────────────┘        ┌─────────────────┐       │
│  │ React 19        │                                      │ TanStack Table  │       │
│  │ - Components    │           ┌─────────────────┐        │ - Sorting       │       │
│  │ - JSX           │           │ Tailwind CSS 4  │        │ - Filtering     │       │
│  │ - Virtual DOM   │           │ - Utility First │        │ - Pagination    │       │
│  └─────────────────┘           │ - Responsive    │        │ - Selection     │       │
│                                │ - Dark Mode     │        └─────────────────┘       │
│  ┌─────────────────┐           └─────────────────┘                                   │
│  │ TypeScript      │                                      ┌─────────────────┐       │
│  │ - Type Safety   │           ┌─────────────────┐        │ Axios           │       │
│  │ - Interfaces    │           │ Lucide React    │        │ - HTTP Client   │       │
│  │ - Generics      │           │ - Icon Library  │        │ - Interceptors  │       │
│  └─────────────────┘           └─────────────────┘        │ - Error Handle  │       │
│                                                           └─────────────────┘       │
│  Auth & Security                                                                     │
│  ┌─────────────────────────────────────────────────────────────────────────────┐    │
│  │ NextAuth.js 4.24                                                             │    │
│  │ - Azure AD Provider        - JWT Session Strategy        - Callbacks        │    │
│  │ - OAuth 2.0 Flow           - Token Management            - Middleware       │    │
│  └─────────────────────────────────────────────────────────────────────────────┘    │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────┐
│ BACKEND (NestJS 10)                                                                  │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                      │
│  Framework Core                 Modules                    Validation               │
│  ┌─────────────────┐           ┌─────────────────┐        ┌─────────────────┐       │
│  │ @nestjs/core    │           │ AuthModule      │        │ class-validator │       │
│  │ - Decorators    │           │ - Login         │        │ - @IsEmail()    │       │
│  │ - Providers     │           │ - Token Verify  │        │ - @IsNotEmpty() │       │
│  │ - Controllers   │           │ - Middleware    │        │ - @IsString()   │       │
│  │ - Modules       │           └─────────────────┘        │ - @IsOptional() │       │
│  └─────────────────┘                                      └─────────────────┘       │
│                                ┌─────────────────┐                                   │
│  ┌─────────────────┐           │ UserModule      │        ┌─────────────────┐       │
│  │ @nestjs/common  │           │ - CRUD Users    │        │class-transformer│       │
│  │ - Pipes         │           │ - Profile       │        │ - @Expose()     │       │
│  │ - Guards        │           │ - Verify        │        │ - @Transform()  │       │
│  │ - Interceptors  │           └─────────────────┘        │ - @Exclude()    │       │
│  │ - Exceptions    │                                      └─────────────────┘       │
│  └─────────────────┘           ┌─────────────────┐                                   │
│                                │ RolModule       │                                   │
│  ┌─────────────────┐           │ - CRUD Roles    │        ┌─────────────────┐       │
│  │ @nestjs/platform│           │ - Status        │        │ Prisma          │       │
│  │ -express        │           └─────────────────┘        │ - ORM           │       │
│  │ - HTTP Server   │                                      │ - Type-safe     │       │
│  │ - Express       │           ┌─────────────────┐        │ - Migrations    │       │
│  └─────────────────┘           │ PermissionModule│        │ - Introspection │       │
│                                │ - Assign        │        └─────────────────┘       │
│  ┌─────────────────┐           │ - List          │                                   │
│  │ TypeScript      │           └─────────────────┘                                   │
│  │ - Decorators    │                                                                │
│  │ - Metadata      │           ┌─────────────────┐                                   │
│  │ - Type Safety   │           │ DashboardPath   │                                   │
│  └─────────────────┘           │ Module          │                                   │
│                                │ - List Paths    │                                   │
│                                └─────────────────┘                                   │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────┐
│ DATABASE (SQL Server 2019+)                                                          │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                      │
│  ┌─────────────────────────────────────────────────────────────────────────────┐    │
│  │ Prisma Schema (schema.prisma)                                                │    │
│  │                                                                              │    │
│  │ generator client {                                                           │    │
│  │   provider = "prisma-client-js"                                              │    │
│  │   output   = "../node_modules/.prisma/inventarioit"                          │    │
│  │ }                                                                            │    │
│  │                                                                              │    │
│  │ datasource db {                                                              │    │
│  │   provider = "sqlserver"                                                     │    │
│  │   url      = env("DATABASE_URL")                                             │    │
│  │ }                                                                            │    │
│  └─────────────────────────────────────────────────────────────────────────────┘    │
│                                                                                      │
│  Connection String Format:                                                           │
│  sqlserver://[server]:[port];database=[db];user=[user];password=[pass];             │
│  encrypt=true;trustServerCertificate=false                                          │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

## Diagrama de Despliegue

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                              DIAGRAMA DE DESPLIEGUE                                  │
└─────────────────────────────────────────────────────────────────────────────────────┘

┌────────────────────┐
│    CLIENTE WEB     │
│  ┌──────────────┐  │
│  │   Browser    │  │
│  │  Chrome/Edge │  │
│  │  Firefox     │  │
│  └──────┬───────┘  │
└─────────┼──────────┘
          │
          │ HTTPS (Puerto 443)
          │
┌─────────▼──────────────────────────────────────────────────────────────────────────┐
│                              SERVIDOR DE APLICACIONES                               │
│                                                                                     │
│  ┌──────────────────────────────────┐  ┌──────────────────────────────────┐        │
│  │         CONTENEDOR FRONTEND      │  │         CONTENEDOR BACKEND       │        │
│  │                                  │  │                                  │        │
│  │  ┌────────────────────────────┐  │  │  ┌────────────────────────────┐  │        │
│  │  │      Node.js 18 LTS        │  │  │  │      Node.js 18 LTS        │  │        │
│  │  └────────────────────────────┘  │  │  └────────────────────────────┘  │        │
│  │              │                   │  │              │                   │        │
│  │  ┌───────────▼────────────────┐  │  │  ┌───────────▼────────────────┐  │        │
│  │  │   Next.js Standalone       │  │  │  │      NestJS Server         │  │        │
│  │  │                            │  │  │  │                            │  │        │
│  │  │   - SSR Pages              │  │  │  │   - REST Controllers       │  │        │
│  │  │   - API Routes (Auth)      │  │  │  │   - Business Services      │  │        │
│  │  │   - Static Assets          │  │  │  │   - Database Access        │  │        │
│  │  │   - Middleware             │  │  │  │   - Auth Middleware        │  │        │
│  │  └────────────────────────────┘  │  │  └────────────────────────────┘  │        │
│  │                                  │  │              │                   │        │
│  │  Puerto Expuesto: 3000           │  │  Puerto Expuesto: 3001           │        │
│  │  Base Path: /inventarioit        │  │  Prefix: /api (opcional)         │        │
│  └──────────────────────────────────┘  └──────────────┼───────────────────┘        │
│                                                       │                             │
│                                                       │ TCP 1433                    │
│                                                       ▼                             │
│  ┌────────────────────────────────────────────────────────────────────────────┐    │
│  │                         SERVIDOR DE BASE DE DATOS                          │    │
│  │  ┌──────────────────────────────────────────────────────────────────────┐  │    │
│  │  │                      SQL SERVER 2019+                                 │  │    │
│  │  │                                                                       │  │    │
│  │  │  Database: InventarioIT                                               │  │    │
│  │  │  Puerto: 1433                                                         │  │    │
│  │  │  Encryption: TLS                                                      │  │    │
│  │  └──────────────────────────────────────────────────────────────────────┘  │    │
│  └────────────────────────────────────────────────────────────────────────────┘    │
│                                                                                     │
└─────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────┐
│                              SERVICIOS EN LA NUBE                                    │
│                                                                                     │
│  ┌────────────────────────────────────────────────────────────────────────────┐    │
│  │                         AZURE ACTIVE DIRECTORY                             │    │
│  │                                                                            │    │
│  │  Tenant ID: [configurado]                                                  │    │
│  │  App Registration:                                                         │    │
│  │    - Client ID: [configurado]                                              │    │
│  │    - Client Secret: [secreto]                                              │    │
│  │    - Redirect URIs: https://[dominio]/inventarioit/api/auth/callback/azure-ad │ │
│  │                                                                            │    │
│  │  Scopes: openid, email, profile, User.Read                                 │    │
│  └────────────────────────────────────────────────────────────────────────────┘    │
│                                                                                     │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

## Puertos y Protocolos

| Componente | Puerto | Protocolo | Descripcion |
|------------|--------|-----------|-------------|
| Frontend | 3000 | HTTP/HTTPS | Servidor Next.js |
| Backend | 3001 | HTTP | API NestJS |
| SQL Server | 1433 | TDS | Base de datos |
| Azure AD | 443 | HTTPS | Autenticacion OAuth |

## Variables de Entorno

### Frontend (.env.local)
```bash
# API Backend
NEXT_PUBLIC_API=http://localhost:3001

# URLs de la aplicacion
NEXT_PUBLIC_REDIRECT_URL=/inventarioit
NEXT_BASE_PATH=/inventarioit-staging
NEXT_PUBLIC_APP_VERSION=0.0.1

# NextAuth
NEXTAUTH_SECRET=[secret-64-chars]
NEXTAUTH_URL=http://localhost:3000
NEXT_PUBLIC_AUTH_BASEPATH=/inventarioit/api/auth

# Azure AD
AZURE_AD_CLIENT_ID=[client-id]
AZURE_AD_CLIENT_SECRET=[client-secret]
AZURE_AD_TENANT_ID=[tenant-id]
```

### Backend (.env)
```bash
# Base de datos
DATABASE_URL=sqlserver://localhost:1433;database=InventarioIT;user=sa;password=xxx;encrypt=true;trustServerCertificate=true

# Servidor
API_PORT=3001
API_PREFIX=/api
NODE_ENV=development
```

## Requisitos de Hardware (Produccion)

| Recurso | Minimo | Recomendado |
|---------|--------|-------------|
| CPU | 2 cores | 4 cores |
| RAM | 4 GB | 8 GB |
| Disco | 20 GB SSD | 50 GB SSD |
| Red | 100 Mbps | 1 Gbps |

## Escalabilidad

El sistema soporta escalabilidad horizontal:

1. **Frontend**: Multiple instancias detras de un load balancer
2. **Backend**: Multiple instancias con sticky sessions o stateless
3. **Database**: Replicas de lectura para alta disponibilidad
