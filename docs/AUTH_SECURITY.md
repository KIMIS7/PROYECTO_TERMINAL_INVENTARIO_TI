# Documentacion de Autenticacion y Seguridad - InventarioIT API

## Arquitectura de Autenticacion

### Flujo Completo

```
[Usuario] --> [Azure AD Login] --> [Next.js Frontend]
                                        |
                                   NextAuth.js
                                   (JWT session)
                                        |
                                   Cada request:
                                   - Authorization: Bearer {id_token}
                                   - user-email: {preferred_username}
                                        |
                                        v
                                   [NestJS API]
                                        |
                                   AzureAuthGuard (global)
                                   1. Verifica JWT con Azure AD public keys
                                   2. Valida issuer y expiracion
                                   3. Busca usuario en BD por email
                                   4. Adjunta req.user con datos del usuario
                                        |
                              +---------+---------+
                              |                   |
                         [Protegido]         [@Public()]
                         (todos los          (solo /health)
                          endpoints)
```

### Componentes

#### 1. Frontend (Next.js + NextAuth.js)

**Archivo:** `InventarioIT-web-main/src/pages/api/auth/[...nextauth].ts`

- **Proveedor:** Azure AD OAuth 2.0
- **Estrategia de sesion:** JWT (no base de datos)
- **Duracion de sesion:** 24 horas
- **Datos en sesion:** `id_token`, `preferred_username`, `name`, `oid`
- **Tokens NO almacenados:** `access_token`, `refresh_token` (buena practica de seguridad)

**Archivo:** `InventarioIT-web-main/src/middleware.ts`

- Protege rutas del frontend: `/dashboard/*`, `/roles/*`, `/usuarios/*`, `/permisos/*`, `/movimientos/*`
- Redirige a login si no hay token JWT valido

**Archivo:** `InventarioIT-web-main/src/lib/api.ts`

- Interceptor de Axios que automaticamente adjunta `Authorization` y `user-email` en cada request

#### 2. Backend (NestJS - AzureAuthGuard)

**Archivo:** `InventarioIT-API-icel/src/azure-auth/azure-auth.guard.ts`

Guard global que protege TODOS los endpoints. Para cada request:

1. Verifica si el endpoint esta marcado con `@Public()` - si lo esta, permite el acceso
2. Extrae el JWT del header `Authorization: Bearer {token}`
3. Obtiene las claves publicas de Azure AD (con cache de 1 hora)
4. Verifica la firma del JWT con RS256
5. Valida el issuer (`https://login.microsoftonline.com/{TENANT_ID}/v2.0`)
6. Verifica que el header `user-email` este presente
7. Busca al usuario en la base de datos (activo = true)
8. Adjunta `req.user` con: UserID, Email, Name, rolD, rolName, isActive

#### 3. Decorador @Public()

**Archivo:** `InventarioIT-API-icel/src/auth/public.decorator.ts`

```typescript
import { SetMetadata } from '@nestjs/common';
export const IS_PUBLIC_KEY = 'isPublic';
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);
```

Usar en cualquier controller o metodo que NO requiera autenticacion:

```typescript
@Public()
@Get('health')
healthCheck() {
  return { status: 'ok' };
}
```

### Endpoints Publicos (sin autenticacion)

| Endpoint | Controller | Razon |
|----------|-----------|-------|
| `GET /health` | AppController | Health check para monitoreo |

**Todos los demas endpoints requieren autenticacion.**

### Variables de Entorno Requeridas

**Backend (.env):**
```
TENANT_ID=<Azure AD Tenant ID>
DATABASE_URL=<SQL Server connection string>
```

**Frontend (.env.local):**
```
AZURE_AD_CLIENT_ID=<Azure AD App ID>
AZURE_AD_CLIENT_SECRET=<Azure AD Client Secret>
AZURE_AD_TENANT_ID=<Azure AD Tenant ID>
NEXTAUTH_SECRET=<Random secret for JWT signing>
```

### Respuestas de Error

| Codigo | Mensaje | Causa |
|:------:|---------|-------|
| 401 | Token no proporcionado. Inicia sesion para acceder. | No se envio header Authorization |
| 401 | Token malformado | JWT no se puede decodificar |
| 401 | Clave publica no encontrada | kid del JWT no coincide con Azure AD |
| 401 | Header user-email es requerido | No se envio header user-email |
| 401 | Usuario no autorizado. Contacta al administrador. | Email no existe en BD o usuario inactivo |
| 401 | Token invalido o expirado | JWT expirado o firma invalida |
