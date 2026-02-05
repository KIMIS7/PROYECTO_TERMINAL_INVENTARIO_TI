# Guias de Desarrollo - Inventario TI

Este directorio contiene documentacion tecnica para desarrolladores del sistema de inventario.

## Indice de Guias

| Guia | Descripcion |
|------|-------------|
| [Tipos de Activo](./TIPOS_DE_ACTIVO.md) | Gestion de tipos de activo con plantillas por categoria |

## Estructura del Proyecto

```
PROYECTO_TERMINAL_INVENTARIO_TI/
├── InventarioIT-API-icel/          # Backend NestJS
│   ├── src/
│   │   ├── asset/                  # Modulo de activos
│   │   ├── product-type/           # Modulo de tipos de producto
│   │   ├── vendor/                 # Modulo de proveedores
│   │   ├── company/                # Modulo de empresas
│   │   ├── site/                   # Modulo de sitios
│   │   ├── user/                   # Modulo de usuarios
│   │   ├── rol/                    # Modulo de roles
│   │   └── permission/             # Modulo de permisos
│   └── prisma/                     # Schema de base de datos
│
├── InventarioIT-web-main/          # Frontend Next.js
│   ├── src/
│   │   ├── components/             # Componentes React
│   │   ├── pages/                  # Paginas Next.js
│   │   ├── lib/                    # Utilidades y API client
│   │   ├── hooks/                  # Custom hooks
│   │   └── types/                  # Interfaces TypeScript
│   └── public/                     # Archivos estaticos
│
├── docs/                           # Documentacion
│   └── guias/                      # Guias de desarrollo
│
└── BASE_DATOS/                     # Backups de base de datos
```

## Stack Tecnologico

- **Frontend**: Next.js 15, React 19, TypeScript, Tailwind CSS, shadcn/ui
- **Backend**: NestJS, TypeScript, Prisma ORM
- **Base de Datos**: SQL Server 2019+
- **Autenticacion**: Azure Active Directory (OAuth 2.0)

## Convenciones

### Commits
```
feat: nueva funcionalidad
fix: correccion de bug
docs: documentacion
refactor: refactorizacion
```

### Nombres de archivos
- Componentes: `PascalCase.tsx` (ej: `CreateAssetModal.tsx`)
- Paginas: `kebab-case/index.tsx` (ej: `altas/index.tsx`)
- Utilidades: `camelCase.ts` (ej: `api.ts`)

## Como Contribuir

1. Crear branch desde main: `git checkout -b feature/nombre-feature`
2. Hacer cambios y commits siguiendo convenciones
3. Documentar cambios importantes en `/docs/guias/`
4. Crear Pull Request
