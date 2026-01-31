# Flujo de Autenticacion

## Descripcion General

El sistema utiliza **Azure Active Directory (Azure AD)** como proveedor de identidad, implementando el flujo **OAuth 2.0 Authorization Code** con **OpenID Connect** para la autenticacion de usuarios.

## Diagrama de Flujo de Autenticacion

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                        FLUJO DE AUTENTICACION COMPLETO                               │
└─────────────────────────────────────────────────────────────────────────────────────┘

     Usuario                Frontend              NextAuth           Azure AD            Backend
        │                   (Next.js)             (API Route)        (OAuth)            (NestJS)
        │                      │                      │                 │                   │
        │  1. Click "Login"    │                      │                 │                   │
        │─────────────────────>│                      │                 │                   │
        │                      │                      │                 │                   │
        │                      │  2. signIn("azure")  │                 │                   │
        │                      │─────────────────────>│                 │                   │
        │                      │                      │                 │                   │
        │                      │                      │  3. Redirect    │                   │
        │                      │                      │  to Azure       │                   │
        │<─────────────────────┼──────────────────────┼────────────────>│                   │
        │                      │                      │                 │                   │
        │  4. Usuario ingresa credenciales           │                 │                   │
        │────────────────────────────────────────────────────────────>│                   │
        │                      │                      │                 │                   │
        │                      │                      │  5. Auth Code   │                   │
        │<─────────────────────┼──────────────────────┼─────────────────│                   │
        │                      │                      │                 │                   │
        │                      │  6. Exchange Code    │                 │                   │
        │                      │  for Tokens          │                 │                   │
        │                      │                      │────────────────>│                   │
        │                      │                      │                 │                   │
        │                      │                      │  7. Access Token│                   │
        │                      │                      │  + ID Token     │                   │
        │                      │                      │<────────────────│                   │
        │                      │                      │                 │                   │
        │                      │  8. Session Created  │                 │                   │
        │                      │  (JWT Cookie)        │                 │                   │
        │<─────────────────────┼──────────────────────│                 │                   │
        │                      │                      │                 │                   │
        │                      │  9. UserVerification │                 │                   │
        │                      │  Component           │                 │                   │
        │                      │──────────────────────┼─────────────────┼──────────────────>│
        │                      │                      │                 │                   │
        │                      │                      │                 │  10. Verify User  │
        │                      │                      │                 │  in Database      │
        │                      │                      │                 │<──────────────────│
        │                      │                      │                 │                   │
        │                      │  11. User Verified   │                 │                   │
        │                      │<─────────────────────┼─────────────────┼───────────────────│
        │                      │                      │                 │                   │
        │  12. Redirect to     │                      │                 │                   │
        │  Dashboard           │                      │                 │                   │
        │<─────────────────────│                      │                 │                   │
        │                      │                      │                 │                   │
```

## Componentes del Flujo

### 1. Pagina de Login (Frontend)

```typescript
// src/pages/index.tsx
const handleLogin = async () => {
  await signIn('azure-ad', {
    callbackUrl: '/dashboard'
  });
};
```

**Caracteristicas:**
- Boton de inicio de sesion con Microsoft
- Redireccion automatica si ya esta autenticado
- Logo y branding de la empresa

### 2. Configuracion de NextAuth

```typescript
// src/pages/api/auth/[...nextauth].ts
export const authOptions: AuthOptions = {
  providers: [
    AzureADProvider({
      clientId: process.env.AZURE_AD_CLIENT_ID!,
      clientSecret: process.env.AZURE_AD_CLIENT_SECRET!,
      tenantId: process.env.AZURE_AD_TENANT_ID!,
      authorization: {
        params: {
          scope: 'openid email profile User.Read'
        }
      }
    })
  ],
  session: {
    strategy: 'jwt',
    maxAge: 24 * 60 * 60 // 24 horas
  },
  callbacks: {
    jwt: async ({ token, account, profile }) => {
      if (account && profile) {
        token.sub = profile.sub;
        token.name = profile.name;
        token.preferred_username = profile.preferred_username;
        token.id_token = account.id_token;
      }
      return token;
    },
    session: async ({ session, token }) => {
      session.id_token = token.id_token;
      session.user.email = token.preferred_username;
      return session;
    },
    redirect: async ({ baseUrl }) => {
      return `${baseUrl}/dashboard`;
    }
  }
};
```

### 3. Verificacion de Usuario (Frontend)

```typescript
// src/components/UserVerification.tsx
const UserVerification = ({ children }) => {
  const { data: session, status } = useSession();
  const [isVerified, setIsVerified] = useState(false);

  useEffect(() => {
    if (session?.user?.email) {
      verifyUser(session.user.email);
    }
  }, [session]);

  const verifyUser = async (email: string) => {
    const response = await api.user.verify(email);

    if (response.success) {
      setIsVerified(true);
    } else {
      // Mostrar error segun tipo
      switch(response.errorType) {
        case 'USER_NOT_FOUND':
          // Usuario no registrado
          break;
        case 'USER_INACTIVE':
          // Usuario desactivado
          break;
        case 'NO_ROLE_ASSIGNED':
          // Sin rol asignado
          break;
        case 'NO_PERMISSIONS':
          // Sin permisos
          break;
      }
      await signOut();
    }
  };

  if (!isVerified) return <LoadingSpinner />;
  return children;
};
```

### 4. Middleware de Autenticacion (Backend)

```typescript
// src/auth/simple-auth.middleware.ts
@Injectable()
export class SimpleAuthMiddleware implements NestMiddleware {
  constructor(private readonly databaseService: DatabaseService) {}

  async use(req: Request, res: Response, next: NextFunction) {
    const userEmail = req.headers['user-email'] as string;

    if (!userEmail) {
      return next();
    }

    const user = await this.databaseService.prisma.user.findFirst({
      where: {
        Email: {
          equals: userEmail,
          mode: 'insensitive'
        },
        isActive: true
      },
      include: {
        rol: true
      }
    });

    if (user) {
      req['user'] = user;
    }

    next();
  }
}
```

### 5. Cliente API con Interceptores

```typescript
// src/lib/api.ts
const apiClient = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API,
  timeout: 300000
});

apiClient.interceptors.request.use(async (config) => {
  const session = await getSession();

  if (session?.id_token) {
    config.headers.Authorization = `Bearer ${session.id_token}`;
  }

  if (session?.user?.email) {
    config.headers['user-email'] = session.user.email;
  }

  return config;
});
```

## Diagrama de Estados de Autenticacion

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                         ESTADOS DE AUTENTICACION                                     │
└─────────────────────────────────────────────────────────────────────────────────────┘

                    ┌───────────────────┐
                    │   NO AUTENTICADO  │
                    │   (Pagina Login)  │
                    └─────────┬─────────┘
                              │
                              │ Click "Login"
                              ▼
                    ┌───────────────────┐
                    │   AUTENTICANDO    │
                    │   (Azure AD)      │
                    └─────────┬─────────┘
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
    ┌─────────────────┐ ┌─────────────┐ ┌─────────────────┐
    │ ERROR AZURE AD  │ │  EXITO      │ │ CANCELADO       │
    │ (Credenciales)  │ │  TOKEN      │ │ (Usuario)       │
    └────────┬────────┘ └──────┬──────┘ └────────┬────────┘
             │                 │                  │
             │                 │                  │
             ▼                 ▼                  ▼
    ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
    │  RETRY LOGIN    │ │  VERIFICANDO    │ │  NO AUTENTICADO │
    │                 │ │  EN BD LOCAL    │ │                 │
    └─────────────────┘ └─────────┬───────┘ └─────────────────┘
                                  │
              ┌───────────────────┼───────────────────┐
              │                   │                   │
              ▼                   ▼                   ▼
    ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
    │ USUARIO NO      │ │ USUARIO         │ │ USUARIO SIN     │
    │ ENCONTRADO      │ │ INACTIVO        │ │ PERMISOS        │
    └────────┬────────┘ └────────┬────────┘ └────────┬────────┘
             │                   │                   │
             │                   │                   │
             └───────────────────┼───────────────────┘
                                 │
                                 ▼
                    ┌───────────────────┐
                    │  LOGOUT FORZADO   │
                    │  + Alerta Error   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │   NO AUTENTICADO  │
                    └───────────────────┘

                                 │
              ┌──────────────────┘ (Si verificacion exitosa)
              ▼
    ┌─────────────────┐
    │   AUTENTICADO   │
    │   (Dashboard)   │
    └─────────┬───────┘
              │
              │ Token expira (24h)
              │ o Logout manual
              ▼
    ┌─────────────────┐
    │  NO AUTENTICADO │
    └─────────────────┘
```

## Tipos de Error de Verificacion

| Tipo de Error | Descripcion | Accion |
|---------------|-------------|--------|
| `USER_NOT_FOUND` | Email no registrado en BD | Cerrar sesion, contactar admin |
| `USER_INACTIVE` | Usuario desactivado | Cerrar sesion, contactar admin |
| `NO_ROLE_ASSIGNED` | Usuario sin rol | Cerrar sesion, contactar admin |
| `NO_PERMISSIONS` | Rol sin permisos | Cerrar sesion, contactar admin |

## Middleware de Proteccion de Rutas (Frontend)

```typescript
// src/middleware.ts
import { withAuth } from 'next-auth/middleware';

export default withAuth({
  pages: {
    signIn: '/'
  }
});

export const config = {
  matcher: [
    '/dashboard/:path*',
    '/usuarios/:path*',
    '/roles/:path*',
    '/permisos/:path*',
    '/puertos-origen/:path*'
  ]
};
```

## Tokens y Sesiones

### Estructura del Token JWT (NextAuth)

```json
{
  "sub": "azure-user-id",
  "name": "Usuario Ejemplo",
  "email": "usuario@empresa.com",
  "preferred_username": "usuario@empresa.com",
  "id_token": "eyJhbG...[Azure AD ID Token]",
  "iat": 1699999999,
  "exp": 1700086399
}
```

### Cookie de Sesion

- **Nombre**: `next-auth.session-token`
- **Duracion**: 24 horas
- **HttpOnly**: Si
- **Secure**: Si (en produccion)
- **SameSite**: Lax

## Configuracion de Azure AD

### App Registration

1. Crear App Registration en Azure Portal
2. Configurar Redirect URIs:
   - `http://localhost:3000/api/auth/callback/azure-ad` (desarrollo)
   - `https://[dominio]/inventarioit/api/auth/callback/azure-ad` (produccion)
3. Generar Client Secret
4. Configurar API Permissions:
   - `openid`
   - `email`
   - `profile`
   - `User.Read`

### Variables Requeridas

```bash
AZURE_AD_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
AZURE_AD_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
AZURE_AD_TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

## Seguridad

### Buenas Practicas Implementadas

1. **Tokens seguros**: JWT firmados por Azure AD
2. **HTTPS obligatorio**: En produccion
3. **Cookies HttpOnly**: Previene XSS
4. **Verificacion doble**: Azure AD + BD local
5. **Expiracion de sesion**: 24 horas
6. **Headers de autenticacion**: Bearer token + user-email
7. **Validacion de email**: Case-insensitive en BD
