# Arquitectura del Sistema

## Diagrama de Arquitectura General

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              CAPA DE PRESENTACION                            │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                         NAVEGADOR WEB                                   │ │
│  │                      (Chrome, Firefox, Edge)                            │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                    │                                         │
│                                    ▼                                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                    NEXT.JS 15 (FRONTEND)                                │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ │ │
│  │  │   React 19   │  │  NextAuth.js │  │ Tailwind CSS │  │  Radix UI   │ │ │
│  │  │  Components  │  │   Azure AD   │  │   Styling    │  │ Components  │ │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └─────────────┘ │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │ │
│  │  │   Axios      │  │ React Table  │  │   Hooks      │                  │ │
│  │  │ HTTP Client  │  │   TanStack   │  │   Custom     │                  │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘                  │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ HTTPS (REST API)
                                    │ Headers: Authorization, user-email
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              CAPA DE NEGOCIO                                 │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                     NESTJS (BACKEND API)                                │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ │ │
│  │  │  Controllers │  │   Services   │  │  Middleware  │  │    DTOs     │ │ │
│  │  │   REST API   │  │    Logic     │  │    Auth      │  │ Validation  │ │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └─────────────┘ │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │ │
│  │  │   Modules    │  │    Guards    │  │    Pipes     │                  │ │
│  │  │  Dependency  │  │  Protection  │  │  Transform   │                  │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘                  │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ Prisma ORM
                                    │ Type-safe queries
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              CAPA DE DATOS                                   │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                         PRISMA ORM                                      │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │ │
│  │  │   Schema     │  │   Client     │  │   Queries    │                  │ │
│  │  │ Definition   │  │  Generated   │  │  Type-safe   │                  │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘                  │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                    │                                         │
│                                    ▼                                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                      SQL SERVER 2019+                                   │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ │ │
│  │  │   Users &    │  │   Assets &   │  │  Catalogues  │  │   Audit &   │ │ │
│  │  │    Roles     │  │   Details    │  │    Data      │  │   History   │ │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └─────────────┘ │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         SERVICIOS EXTERNOS                                   │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                     AZURE ACTIVE DIRECTORY                              │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │ │
│  │  │   OAuth 2.0  │  │   OpenID     │  │    User      │                  │ │
│  │  │    Flow      │  │   Connect    │  │   Profile    │                  │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘                  │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Descripcion de Capas

### 1. Capa de Presentacion (Frontend)

La capa de presentacion esta construida con **Next.js 15** y **React 19**, proporcionando:

- **Server-Side Rendering (SSR)**: Mejora el SEO y tiempo de carga inicial
- **Client-Side Navigation**: Navegacion fluida entre paginas
- **Autenticacion con NextAuth.js**: Integracion nativa con Azure AD
- **Componentes UI con Radix**: Componentes accesibles y personalizables
- **Estilos con Tailwind CSS**: Sistema de utilidades CSS

**Responsabilidades:**
- Renderizar la interfaz de usuario
- Gestionar el estado local de la aplicacion
- Comunicarse con el backend via REST API
- Manejar la autenticacion del usuario
- Validar permisos y mostrar navegacion dinamica

### 2. Capa de Negocio (Backend)

El backend esta construido con **NestJS**, un framework Node.js que proporciona:

- **Arquitectura Modular**: Organizacion clara del codigo
- **Inyeccion de Dependencias**: Facilita testing y mantenimiento
- **Decoradores**: Sintaxis declarativa para rutas y validaciones
- **Middleware**: Interceptacion de requests para autenticacion

**Responsabilidades:**
- Exponer API REST para el frontend
- Validar datos de entrada con DTOs
- Implementar logica de negocio
- Gestionar autenticacion y autorizacion
- Comunicarse con la base de datos

### 3. Capa de Datos

La capa de datos utiliza **Prisma ORM** para interactuar con **SQL Server**:

- **Type Safety**: Queries con tipado fuerte
- **Migraciones**: Control de cambios en el schema
- **Introspection**: Sincronizacion con BD existente

**Responsabilidades:**
- Persistir datos de la aplicacion
- Mantener integridad referencial
- Ejecutar queries optimizadas
- Gestionar transacciones

### 4. Servicios Externos

**Azure Active Directory** proporciona:
- Autenticacion empresarial
- Single Sign-On (SSO)
- Gestion centralizada de usuarios
- Tokens JWT seguros

## Patrones de Arquitectura Utilizados

### 1. Arquitectura en Capas (Layered Architecture)
Separacion clara entre presentacion, logica de negocio y acceso a datos.

### 2. Repository Pattern
Prisma actua como capa de abstraccion sobre la base de datos.

### 3. Dependency Injection
NestJS implementa DI para gestionar dependencias entre modulos.

### 4. DTO Pattern (Data Transfer Objects)
Objetos especificos para transferir datos entre capas.

### 5. Middleware Pattern
Interceptacion de requests para autenticacion y logging.

## Comunicacion entre Componentes

```
┌─────────────┐     HTTP/REST      ┌─────────────┐
│   Browser   │ ◄───────────────► │   Next.js   │
└─────────────┘                    └──────┬──────┘
                                          │
                                   Axios + Headers
                                          │
                                   ┌──────▼──────┐
                                   │   NestJS    │
                                   │    API      │
                                   └──────┬──────┘
                                          │
                                    Prisma Client
                                          │
                                   ┌──────▼──────┐
                                   │  SQL Server │
                                   └─────────────┘
```

### Headers de Comunicacion

| Header | Descripcion | Ejemplo |
|--------|-------------|---------|
| `Authorization` | Token JWT de Azure AD | `Bearer eyJhbG...` |
| `user-email` | Email del usuario autenticado | `usuario@empresa.com` |
| `Content-Type` | Tipo de contenido | `application/json` |

## Consideraciones de Seguridad

1. **Autenticacion**: Azure AD con OAuth 2.0
2. **Autorizacion**: Sistema de roles y permisos
3. **Validacion**: DTOs con class-validator
4. **CORS**: Configurado para dominios permitidos
5. **HTTPS**: Obligatorio en produccion
6. **Tokens**: JWT con expiracion de 24 horas
