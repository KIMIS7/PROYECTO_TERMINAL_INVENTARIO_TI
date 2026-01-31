# Diagramas de Secuencia

## 1. Flujo de Login Completo

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                          SECUENCIA: LOGIN DE USUARIO                                 │
└─────────────────────────────────────────────────────────────────────────────────────┘

  Usuario          Browser         Next.js        NextAuth       Azure AD       NestJS         SQL Server
     │                │               │               │              │             │                │
     │  1. Accede     │               │               │              │             │                │
     │  a /           │               │               │              │             │                │
     │───────────────>│               │               │              │             │                │
     │                │  2. GET /     │               │              │             │                │
     │                │──────────────>│               │              │             │                │
     │                │               │               │              │             │                │
     │                │  3. Render    │               │              │             │                │
     │                │  Login Page   │               │              │             │                │
     │                │<──────────────│               │              │             │                │
     │                │               │               │              │             │                │
     │  4. Click      │               │               │              │             │                │
     │  "Login"       │               │              │             │                │
     │───────────────>│               │               │              │             │                │
     │                │  5. signIn    │               │              │             │                │
     │                │  ('azure-ad') │               │              │             │                │
     │                │──────────────>│               │              │             │                │
     │                │               │  6. Redirect  │              │             │                │
     │                │               │  to Azure     │              │             │                │
     │                │               │──────────────>│              │             │                │
     │                │               │               │  7. OAuth    │             │                │
     │                │               │               │  Authorize   │             │                │
     │                │               │               │─────────────>│             │                │
     │                │               │               │              │             │                │
     │                │  8. Azure Login Page         │              │             │                │
     │                │<─────────────────────────────────────────────│             │                │
     │                │               │               │              │             │                │
     │  9. Ingresa    │               │               │              │             │                │
     │  credenciales  │               │               │              │             │                │
     │───────────────>│               │               │              │             │                │
     │                │  10. POST     │               │              │             │                │
     │                │  credentials  │               │              │             │                │
     │                │──────────────────────────────────────────────>│             │                │
     │                │               │               │              │             │                │
     │                │               │               │ 11. Auth     │             │                │
     │                │               │               │ Code         │             │                │
     │                │               │               │<─────────────│             │                │
     │                │               │               │              │             │                │
     │                │               │ 12. Exchange  │              │             │                │
     │                │               │ code for      │              │             │                │
     │                │               │ tokens        │              │             │                │
     │                │               │──────────────>│              │             │                │
     │                │               │               │ 13. Token    │             │                │
     │                │               │               │ request      │             │                │
     │                │               │               │─────────────>│             │                │
     │                │               │               │              │             │                │
     │                │               │               │ 14. Tokens   │             │                │
     │                │               │               │ (id_token,   │             │                │
     │                │               │               │ access_token)│             │                │
     │                │               │               │<─────────────│             │                │
     │                │               │               │              │             │                │
     │                │               │ 15. Create    │              │             │                │
     │                │               │ JWT Session   │              │             │                │
     │                │               │<──────────────│              │             │                │
     │                │               │               │              │             │                │
     │                │ 16. Set       │               │              │             │                │
     │                │ Cookie +      │               │              │             │                │
     │                │ Redirect      │               │              │             │                │
     │                │<──────────────│               │              │             │                │
     │                │               │               │              │             │                │
     │                │ 17. GET       │               │              │             │                │
     │                │ /dashboard    │               │              │             │                │
     │                │──────────────>│               │              │             │                │
     │                │               │               │              │             │                │
     │                │               │ 18. Verify    │              │             │                │
     │                │               │ user in DB    │              │             │                │
     │                │               │───────────────────────────────────────────>│                │
     │                │               │              │             │  19. SELECT  │                │
     │                │               │               │              │  User WHERE  │                │
     │                │               │               │              │  email       │                │
     │                │               │               │              │─────────────────────────────>│
     │                │               │               │              │             │                │
     │                │               │               │              │             │ 20. User data  │
     │                │               │               │              │             │<───────────────│
     │                │               │               │              │             │                │
     │                │               │ 21. User      │              │             │                │
     │                │               │ verified      │              │             │                │
     │                │               │<───────────────────────────────────────────│                │
     │                │               │               │              │             │                │
     │                │ 22. Render    │               │              │             │                │
     │                │ Dashboard     │               │              │             │                │
     │                │<──────────────│               │              │             │                │
     │                │               │               │              │             │                │
     │ 23. Dashboard  │               │               │              │             │                │
     │    visible     │               │               │              │             │                │
     │<───────────────│               │               │              │             │                │
     │                │               │               │              │             │                │
```

## 2. Flujo CRUD de Usuario

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                         SECUENCIA: CREAR USUARIO                                     │
└─────────────────────────────────────────────────────────────────────────────────────┘

  Admin          Frontend         API Client        NestJS           Prisma         SQL Server
    │               │                  │               │                │                │
    │  1. Click     │                  │               │                │                │
    │  "Nuevo       │                  │               │                │                │
    │  Usuario"     │                  │               │                │                │
    │──────────────>│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 2. Open          │               │                │                │
    │               │ CreateUserModal  │               │                │                │
    │<──────────────│                  │               │                │                │
    │               │                  │               │                │                │
    │  3. Fill form │                  │               │                │                │
    │  - Email      │                  │               │                │                │
    │  - Name       │                  │               │                │                │
    │  - Role       │                  │               │                │                │
    │──────────────>│                  │               │                │                │
    │               │                  │               │                │                │
    │  4. Click     │                  │               │                │                │
    │  "Guardar"    │                  │               │                │                │
    │──────────────>│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 5. Validate      │               │                │                │
    │               │ form locally     │               │                │                │
    │               │──────┐           │               │                │                │
    │               │      │           │               │                │                │
    │               │<─────┘           │               │                │                │
    │               │                  │               │                │                │
    │               │ 6. POST /user    │               │                │                │
    │               │ { email, name,   │               │                │                │
    │               │   rolD }         │               │                │                │
    │               │─────────────────>│               │                │                │
    │               │                  │               │                │                │
    │               │                  │ 7. Add headers│               │                │
    │               │                  │ Authorization │               │                │
    │               │                  │ user-email    │               │                │
    │               │                  │───────┐       │                │                │
    │               │                  │       │       │                │                │
    │               │                  │<──────┘       │                │                │
    │               │                  │               │                │                │
    │               │                  │ 8. POST /user │                │                │
    │               │                  │──────────────>│                │                │
    │               │                  │               │                │                │
    │               │                  │               │ 9. Validate    │                │
    │               │                  │               │ CreateUserDto  │                │
    │               │                  │               │───────┐        │                │
    │               │                  │               │       │        │                │
    │               │                  │               │<──────┘        │                │
    │               │                  │               │                │                │
    │               │                  │               │ 10. Check      │                │
    │               │                  │               │ email exists   │                │
    │               │                  │               │───────────────>│                │
    │               │                  │               │                │                │
    │               │                  │               │                │ 11. SELECT     │
    │               │                  │               │                │ WHERE email    │
    │               │                  │               │                │───────────────>│
    │               │                  │               │                │                │
    │               │                  │               │                │ 12. null       │
    │               │                  │               │                │ (not found)    │
    │               │                  │               │                │<───────────────│
    │               │                  │               │                │                │
    │               │                  │               │ 13. Email      │                │
    │               │                  │               │ available      │                │
    │               │                  │               │<───────────────│                │
    │               │                  │               │                │                │
    │               │                  │               │ 14. Create     │                │
    │               │                  │               │ user           │                │
    │               │                  │               │───────────────>│                │
    │               │                  │               │                │                │
    │               │                  │               │                │ 15. INSERT     │
    │               │                  │               │                │ INTO User      │
    │               │                  │               │                │───────────────>│
    │               │                  │               │                │                │
    │               │                  │               │                │ 16. User       │
    │               │                  │               │                │ created        │
    │               │                  │               │                │<───────────────│
    │               │                  │               │                │                │
    │               │                  │               │ 17. User       │                │
    │               │                  │               │ object         │                │
    │               │                  │               │<───────────────│                │
    │               │                  │               │                │                │
    │               │                  │ 18. Response  │                │                │
    │               │                  │ { success,    │                │                │
    │               │                  │   user }      │                │                │
    │               │                  │<──────────────│                │                │
    │               │                  │               │                │                │
    │               │ 19. Response     │               │                │                │
    │               │ data             │               │                │                │
    │               │<─────────────────│               │                │                │
    │               │                  │               │                │                │
    │               │ 20. Show toast   │               │                │                │
    │               │ "Usuario creado" │               │                │                │
    │<──────────────│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 21. Close modal  │               │                │                │
    │               │ Refresh list     │               │                │                │
    │<──────────────│                  │               │                │                │
    │               │                  │               │                │                │
```

## 3. Flujo de Verificacion de Permisos

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                      SECUENCIA: CARGAR PERMISOS DE USUARIO                           │
└─────────────────────────────────────────────────────────────────────────────────────┘

  Dashboard        usePermissions       API Client        NestJS           Prisma         SQL Server
     │                  │                   │               │                │                │
     │  1. Mount        │                   │               │                │                │
     │  component       │                   │               │                │                │
     │─────────────────>│                   │               │                │                │
     │                  │                   │               │                │                │
     │                  │ 2. useEffect      │               │                │                │
     │                  │ fetchPermissions  │               │                │                │
     │                  │──────┐            │               │                │                │
     │                  │      │            │               │                │                │
     │                  │<─────┘            │               │                │                │
     │                  │                   │               │                │                │
     │                  │ 3. GET            │               │                │                │
     │                  │ /permission/:email│               │                │                │
     │                  │──────────────────>│               │                │                │
     │                  │                   │               │                │                │
     │                  │                   │ 4. GET        │                │                │
     │                  │                   │ /permission   │                │                │
     │                  │                   │ /user@mail    │                │                │
     │                  │                   │──────────────>│                │                │
     │                  │                   │               │                │                │
     │                  │                   │               │ 5. Find user   │                │
     │                  │                   │               │ by email       │                │
     │                  │                   │               │───────────────>│                │
     │                  │                   │               │                │                │
     │                  │                   │               │                │ 6. SELECT User │
     │                  │                   │               │                │ include rol    │
     │                  │                   │               │                │───────────────>│
     │                  │                   │               │                │                │
     │                  │                   │               │                │ 7. User + rol  │
     │                  │                   │               │                │<───────────────│
     │                  │                   │               │                │                │
     │                  │                   │               │ 8. Find rol    │                │
     │                  │                   │               │ permissions    │                │
     │                  │                   │               │───────────────>│                │
     │                  │                   │               │                │                │
     │                  │                   │               │                │ 9. SELECT      │
     │                  │                   │               │                │ rol_dashboard  │
     │                  │                   │               │                │ _path          │
     │                  │                   │               │                │ JOIN dashboard │
     │                  │                   │               │                │ _paths         │
     │                  │                   │               │                │───────────────>│
     │                  │                   │               │                │                │
     │                  │                   │               │                │ 10. Paths[]    │
     │                  │                   │               │                │<───────────────│
     │                  │                   │               │                │                │
     │                  │                   │               │ 11. Permissions│                │
     │                  │                   │               │ array          │                │
     │                  │                   │               │<───────────────│                │
     │                  │                   │               │                │                │
     │                  │                   │ 12. Response  │                │                │
     │                  │                   │ { permissions:│                │                │
     │                  │                   │   [paths] }   │                │                │
     │                  │                   │<──────────────│                │                │
     │                  │                   │               │                │                │
     │                  │ 13. Permissions   │               │                │                │
     │                  │ data              │               │                │                │
     │                  │<──────────────────│               │                │                │
     │                  │                   │               │                │                │
     │                  │ 14. setPermissions│               │                │                │
     │                  │ (paths)           │               │                │                │
     │                  │──────┐            │               │                │                │
     │                  │      │            │               │                │                │
     │                  │<─────┘            │               │                │                │
     │                  │                   │               │                │                │
     │ 15. Return       │                   │               │                │                │
     │ { permissions,   │                   │               │                │                │
     │   hasPermission }│                   │               │                │                │
     │<─────────────────│                   │               │                │                │
     │                  │                   │               │                │                │
     │ 16. Render       │                   │               │                │                │
     │ navigation       │                   │               │                │                │
     │ based on         │                   │               │                │                │
     │ permissions      │                   │               │                │                │
     │──────┐           │                   │               │                │                │
     │      │           │                   │               │                │                │
     │<─────┘           │                   │               │                │                │
     │                  │                   │               │                │                │
```

## 4. Flujo de Asignacion de Permisos a Rol

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                      SECUENCIA: ASIGNAR PERMISO A ROL                                │
└─────────────────────────────────────────────────────────────────────────────────────┘

  Admin          Frontend         API Client        NestJS           Prisma         SQL Server
    │               │                  │               │                │                │
    │  1. Click     │                  │               │                │                │
    │  "Asignar     │                  │               │                │                │
    │  Permiso"     │                  │               │                │                │
    │──────────────>│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 2. Open          │               │                │                │
    │               │ AssignPermission │               │                │                │
    │               │ Modal            │               │                │                │
    │<──────────────│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 3. Fetch roles   │               │                │                │
    │               │ GET /rol         │               │                │                │
    │               │─────────────────>│               │                │                │
    │               │                  │──────────────>│                │                │
    │               │                  │               │───────────────>│───────────────>│
    │               │                  │               │                │<───────────────│
    │               │                  │               │<───────────────│                │
    │               │                  │<──────────────│                │                │
    │               │<─────────────────│               │                │                │
    │               │                  │               │                │                │
    │               │ 4. Fetch paths   │               │                │                │
    │               │ GET /dashboard   │               │                │                │
    │               │ -path            │               │                │                │
    │               │─────────────────>│               │                │                │
    │               │                  │──────────────>│                │                │
    │               │                  │               │───────────────>│───────────────>│
    │               │                  │               │                │<───────────────│
    │               │                  │               │<───────────────│                │
    │               │                  │<──────────────│                │                │
    │               │<─────────────────│               │                │                │
    │               │                  │               │                │                │
    │  5. Select    │                  │               │                │                │
    │  role + path  │                  │               │                │                │
    │──────────────>│                  │               │                │                │
    │               │                  │               │                │                │
    │  6. Click     │                  │               │                │                │
    │  "Asignar"    │                  │               │                │                │
    │──────────────>│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 7. POST          │               │                │                │
    │               │ /permission      │               │                │                │
    │               │ { rolID,         │               │                │                │
    │               │   dashboardpath  │               │                │                │
    │               │   ID }           │               │                │                │
    │               │─────────────────>│               │                │                │
    │               │                  │               │                │                │
    │               │                  │ 8. POST       │                │                │
    │               │                  │ /permission   │                │                │
    │               │                  │──────────────>│                │                │
    │               │                  │               │                │                │
    │               │                  │               │ 9. Check if    │                │
    │               │                  │               │ exists         │                │
    │               │                  │               │───────────────>│                │
    │               │                  │               │                │ 10. SELECT     │
    │               │                  │               │                │ WHERE rolID    │
    │               │                  │               │                │ AND pathID     │
    │               │                  │               │                │───────────────>│
    │               │                  │               │                │                │
    │               │                  │               │                │ 11. null       │
    │               │                  │               │                │<───────────────│
    │               │                  │               │                │                │
    │               │                  │               │<───────────────│                │
    │               │                  │               │                │                │
    │               │                  │               │ 12. Create     │                │
    │               │                  │               │ permission     │                │
    │               │                  │               │───────────────>│                │
    │               │                  │               │                │ 13. INSERT     │
    │               │                  │               │                │ rol_dashboard  │
    │               │                  │               │                │ _path          │
    │               │                  │               │                │───────────────>│
    │               │                  │               │                │                │
    │               │                  │               │                │ 14. Created    │
    │               │                  │               │                │<───────────────│
    │               │                  │               │                │                │
    │               │                  │               │<───────────────│                │
    │               │                  │               │                │                │
    │               │                  │ 15. Success   │                │                │
    │               │                  │<──────────────│                │                │
    │               │                  │               │                │                │
    │               │ 16. Response     │               │                │                │
    │               │<─────────────────│               │                │                │
    │               │                  │               │                │                │
    │               │ 17. Toast        │               │                │                │
    │               │ "Permiso         │               │                │                │
    │               │ asignado"        │               │                │                │
    │<──────────────│                  │               │                │                │
    │               │                  │               │                │                │
    │               │ 18. Refresh      │               │                │                │
    │               │ permissions      │               │                │                │
    │               │ list             │               │                │                │
    │<──────────────│                  │               │                │                │
    │               │                  │               │                │                │
```

## 5. Flujo de Logout

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                            SECUENCIA: LOGOUT                                         │
└─────────────────────────────────────────────────────────────────────────────────────┘

  Usuario          Browser         Next.js        NextAuth         Azure AD
     │                │               │               │                │
     │  1. Click      │               │               │                │
     │  "Cerrar       │               │               │                │
     │  Sesion"       │               │               │                │
     │───────────────>│               │               │                │
     │                │               │               │                │
     │                │ 2. signOut()  │               │                │
     │                │──────────────>│               │                │
     │                │               │               │                │
     │                │               │ 3. POST       │                │
     │                │               │ /api/auth/    │                │
     │                │               │ signout       │                │
     │                │               │──────────────>│                │
     │                │               │               │                │
     │                │               │               │ 4. Clear       │
     │                │               │               │ session        │
     │                │               │               │───────┐        │
     │                │               │               │       │        │
     │                │               │               │<──────┘        │
     │                │               │               │                │
     │                │               │ 5. Delete     │                │
     │                │               │ cookie        │                │
     │                │               │<──────────────│                │
     │                │               │               │                │
     │                │ 6. Redirect   │               │                │
     │                │ to /          │               │                │
     │                │<──────────────│               │                │
     │                │               │               │                │
     │                │ 7. GET /      │               │                │
     │                │──────────────>│               │                │
     │                │               │               │                │
     │                │ 8. Render     │               │                │
     │                │ Login page    │               │                │
     │                │<──────────────│               │                │
     │                │               │               │                │
     │ 9. Login page  │               │               │                │
     │    visible     │               │               │                │
     │<───────────────│               │               │                │
     │                │               │               │                │
```

## Notas sobre los Diagramas

### Convenciones

- **Lineas solidas (─)**: Flujo normal de datos
- **Flechas (>)**: Direccion del mensaje/llamada
- **Numeros**: Orden secuencial de operaciones

### Componentes

| Componente | Descripcion |
|------------|-------------|
| Usuario/Admin | Actor humano interactuando con el sistema |
| Browser | Navegador web del usuario |
| Frontend | Aplicacion Next.js |
| API Client | Cliente Axios con interceptores |
| NextAuth | Libreria de autenticacion |
| Azure AD | Proveedor de identidad |
| NestJS | Backend API |
| Prisma | ORM para base de datos |
| SQL Server | Base de datos |

### Tiempos de Respuesta Esperados

| Operacion | Tiempo Esperado |
|-----------|-----------------|
| Login completo | 2-5 segundos |
| CRUD Usuario | < 500ms |
| Carga de permisos | < 300ms |
| Logout | < 1 segundo |
