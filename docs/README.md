# Sistema de Gestion de Inventario de TI

## Descripcion General

El **Sistema de Gestion de Inventario de TI** es una aplicacion empresarial full-stack diseñada para gestionar activos tecnologicos, usuarios, roles y permisos dentro de una organizacion. La aplicacion implementa una arquitectura moderna de microservicios con autenticacion empresarial mediante Azure Active Directory.

## Indice de Documentacion

| Documento | Descripcion |
|-----------|-------------|
| [Arquitectura del Sistema](./diagramas/ARQUITECTURA.md) | Diagrama y descripcion de la arquitectura general |
| [Diagrama de Clases](./diagramas/DIAGRAMA_CLASES.md) | Modelo de datos y entidades de la base de datos |
| [Infraestructura de Software](./diagramas/INFRAESTRUCTURA.md) | Componentes tecnologicos y su interaccion |
| [Flujo de Autenticacion](./diagramas/AUTENTICACION.md) | Proceso de autenticacion con Azure AD |
| [Diagramas de Secuencia](./diagramas/SECUENCIAS.md) | Flujos de operaciones principales |
| [Documentacion de API](./api/API_REFERENCE.md) | Endpoints REST del backend |
| [Componentes Frontend](./componentes/COMPONENTES.md) | Componentes React del frontend |
| [Manual de Instalacion](./instalacion/INSTALACION.md) | Guia de configuracion e instalacion |

## Stack Tecnologico

### Frontend
- **Framework**: Next.js 15 con React 19
- **Lenguaje**: TypeScript
- **Estilos**: Tailwind CSS 4
- **Componentes UI**: Radix UI
- **Tablas**: TanStack React Table
- **Autenticacion**: NextAuth.js con Azure AD
- **HTTP Client**: Axios

### Backend
- **Framework**: NestJS
- **Lenguaje**: TypeScript
- **ORM**: Prisma
- **Validacion**: class-validator
- **Transformacion**: class-transformer

### Base de Datos
- **Motor**: SQL Server 2019+
- **ORM**: Prisma con provider sqlserver

### Autenticacion
- **Proveedor**: Azure Active Directory
- **Protocolo**: OAuth 2.0 / OpenID Connect
- **Sesion**: JWT

## Estructura del Proyecto

```
PROYECTO_TERMINAL_INVENTARIO_TI/
├── docs/                          # Documentacion del proyecto
│   ├── diagramas/                 # Diagramas de arquitectura
│   ├── api/                       # Documentacion de API
│   ├── componentes/               # Documentacion de componentes
│   └── instalacion/               # Guias de instalacion
├── BASE_DATOS/                    # Respaldos de base de datos
│   └── InventarioIT2.bak          # Backup SQL Server
├── InventarioIT-API-icel/         # Backend (NestJS)
│   ├── src/                       # Codigo fuente
│   ├── prisma/                    # Schema de Prisma
│   └── sql/                       # Scripts SQL
└── InventarioIT-web-main/         # Frontend (Next.js)
    ├── src/                       # Codigo fuente
    │   ├── pages/                 # Paginas de Next.js
    │   ├── components/            # Componentes React
    │   ├── hooks/                 # Custom hooks
    │   ├── lib/                   # Utilidades
    │   └── types/                 # Definiciones TypeScript
    └── public/                    # Archivos estaticos
```

## Funcionalidades Principales

### 1. Gestion de Usuarios
- Crear, editar y eliminar usuarios
- Asignar roles a usuarios
- Activar/desactivar usuarios
- Verificacion de usuarios con Azure AD

### 2. Gestion de Roles
- CRUD completo de roles
- Activar/desactivar roles
- Roles predefinidos del sistema

### 3. Sistema de Permisos
- Asignacion de permisos por rol
- Permisos basados en rutas del dashboard
- Navegacion dinamica segun permisos

### 4. Inventario de Activos TI
- Registro de activos tecnologicos
- Historial de cambios de activos
- Historial de propiedad de activos
- Clasificacion por tipo, categoria y subcategoria

### 5. Catalogos
- Empresas (Companies)
- Sitios/Ubicaciones (Sites)
- Proveedores (Vendors)
- Tipos de producto (ProductTypes)
- Estados de activo (AssetStates)

## Requisitos del Sistema

### Desarrollo
- Node.js 18+
- npm o yarn
- SQL Server 2019+
- Azure AD Tenant (para autenticacion)

### Produccion
- Docker (recomendado)
- SQL Server 2019+
- Certificados SSL
- Dominio configurado

## Inicio Rapido

```bash
# 1. Clonar el repositorio
git clone [url-del-repositorio]

# 2. Configurar Backend
cd InventarioIT-API-icel
cp .env.example .env
# Editar .env con credenciales de BD
npm install
npm run db:generate
npm run start:dev

# 3. Configurar Frontend
cd ../InventarioIT-web-main
cp .env.example .env.local
# Editar .env.local con credenciales de Azure AD
npm install
npm run dev

# 4. Acceder a la aplicacion
# Frontend: http://localhost:3000
# Backend: http://localhost:3001
```

## Autor

Proyecto Terminal - Sistema de Gestion de Inventario de TI

## Licencia

Este proyecto es de uso academico y empresarial interno.
