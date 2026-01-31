# Sistema de Gestion de Inventario de TI

Sistema empresarial para la gestion de activos tecnologicos, usuarios, roles y permisos. Desarrollado con arquitectura moderna full-stack.

## Stack Tecnologico

| Capa | Tecnologia |
|------|------------|
| **Frontend** | Next.js 15, React 19, TypeScript, Tailwind CSS, Radix UI |
| **Backend** | NestJS, TypeScript, Prisma ORM |
| **Base de Datos** | SQL Server 2019+ |
| **Autenticacion** | Azure Active Directory (OAuth 2.0) |

## Estructura del Proyecto

```
PROYECTO_TERMINAL_INVENTARIO_TI/
├── docs/                          # Documentacion completa
├── BASE_DATOS/                    # Respaldos de base de datos
├── InventarioIT-API-icel/         # Backend (NestJS)
└── InventarioIT-web-main/         # Frontend (Next.js)
```

## Documentacion

| Documento | Descripcion |
|-----------|-------------|
| [Documentacion Principal](./docs/README.md) | Indice de toda la documentacion |
| [Arquitectura](./docs/diagramas/ARQUITECTURA.md) | Diagrama de arquitectura del sistema |
| [Diagrama de Clases](./docs/diagramas/DIAGRAMA_CLASES.md) | Modelo de datos y entidades |
| [Infraestructura](./docs/diagramas/INFRAESTRUCTURA.md) | Componentes tecnologicos |
| [Autenticacion](./docs/diagramas/AUTENTICACION.md) | Flujo de autenticacion Azure AD |
| [Diagramas de Secuencia](./docs/diagramas/SECUENCIAS.md) | Flujos de operaciones |
| [API Reference](./docs/api/API_REFERENCE.md) | Documentacion de endpoints REST |
| [Componentes](./docs/componentes/COMPONENTES.md) | Componentes React del frontend |
| [Instalacion](./docs/instalacion/INSTALACION.md) | Guia de instalacion |

## Inicio Rapido

### Requisitos
- Node.js 18+
- SQL Server 2019+
- Azure AD Tenant

### Instalacion

```bash
# Backend
cd InventarioIT-API-icel
npm install
cp .env.example .env  # Configurar variables
npm run db:generate
npm run start:dev

# Frontend
cd InventarioIT-web-main
npm install
cp .env.example .env.local  # Configurar variables
npm run dev
```

### URLs
- Frontend: http://localhost:3000
- Backend: http://localhost:3001

## Funcionalidades

- Autenticacion con Azure Active Directory
- Gestion de usuarios (CRUD)
- Gestion de roles
- Sistema de permisos por ruta
- Inventario de activos de TI
- Historial de activos y propiedad

## Autores

Proyecto Terminal - Israel Cel y Salvador Salas

## Licencia

Proyecto academico y empresarial interno.
