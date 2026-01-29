# Sistema de Protección de Rutas Basado en Permisos

## 🔐 **Descripción**

Se ha implementado un sistema completo de protección de rutas que:

1. **✅ Verifica permisos en tiempo real** para cada ruta
2. **✅ Bloquea acceso directo** a URLs sin permisos
3. **✅ Navegación dinámica** que solo muestra enlaces permitidos
4. **✅ Redirección automática** a dashboard si no hay permisos
5. **✅ Interfaz de usuario clara** para acceso denegado

## 🏗️ **Componentes Implementados**

### **Hooks**

#### **usePermissions** (`src/hooks/usePermissions.ts`)
```typescript
const { 
  permissions, 
  loading, 
  error, 
  hasPermission, 
  canAccessRoute,
  getPermissionByPath 
} = usePermissions();
```

**Funciones disponibles:**
- `hasPermission(path)` - Verifica si tiene permiso para una ruta específica
- `canAccessRoute(path)` - Verifica acceso considerando rutas públicas
- `getPermissionByPath(path)` - Obtiene información del permiso
- `refreshPermissions()` - Actualiza permisos desde la API

### **Componentes**

#### **ProtectedRoute** (`src/components/ProtectedRoute.tsx`)
```typescript
<ProtectedRoute>
  <YourPageContent />
</ProtectedRoute>
```

**Características:**
- Verifica permisos automáticamente
- Muestra loading mientras verifica
- Redirige si no tiene permisos
- Página de "Acceso Denegado" personalizada

#### **PermissionBasedNav** (`src/components/PermissionBasedNav.tsx`)
```typescript
<PermissionBasedNav />
```

**Características:**
- Solo muestra enlaces a rutas permitidas
- Indicador de número de permisos
- Loading state mientras carga permisos
- Navegación activa resaltada

#### **Layout** (`src/components/Layout.tsx`)
```typescript
<Layout>
  <YourPageContent />
</Layout>
```

**Características:**
- Combina ProtectedRoute + PermissionBasedNav
- Layout consistente para todas las páginas
- Protección automática de rutas

## 🔄 **Flujo de Protección**

### 1. **Carga de Página**
```
Usuario accede a URL → ProtectedRoute → Verifica permisos → Permite/Deniega acceso
```

### 2. **Verificación de Permisos**
```
usePermissions → API /permission/:email → Compara con ruta actual → Resultado
```

### 3. **Navegación**
```
PermissionBasedNav → Filtra permisos → Muestra solo enlaces permitidos
```

## 📝 **Cómo Usar**

### **Proteger una Página Individual**
```typescript
import ProtectedRoute from '@/components/ProtectedRoute';

export default function MyPage() {
  return (
    <ProtectedRoute>
      <div>Contenido de la página</div>
    </ProtectedRoute>
  );
}
```

### **Usar Layout Completo**
```typescript
import Layout from '@/components/Layout';

export default function MyPage() {
  return (
    <Layout>
      <div>Contenido de la página</div>
    </Layout>
  );
}
```

### **Verificar Permisos en Componentes**
```typescript
import { usePermissions } from '@/hooks/usePermissions';

export default function MyComponent() {
  const { hasPermission, permissions } = usePermissions();

  return (
    <div>
      {hasPermission('/usuarios') && (
        <button>Gestionar Usuarios</button>
      )}
      
      <p>Tienes {permissions.length} permisos</p>
    </div>
  );
}
```

## 🛡️ **Rutas Protegidas**

### **Rutas Públicas** (No requieren permisos)
- `/` - Página de login
- `/login` - Página de login
- `/dashboard` - Dashboard principal

### **Rutas Protegidas** (Requieren permisos específicos)
- `/usuarios/*` - Gestión de usuarios
- `/roles/*` - Gestión de roles
- `/permisos/*` - Gestión de permisos
- Cualquier otra ruta definida en la base de datos

## 🚨 **Comportamiento de Acceso Denegado**

### **Acceso Directo a URL**
1. Usuario intenta acceder a `/usuarios` sin permisos
2. Sistema verifica permisos
3. Redirige a `/dashboard` automáticamente
4. Muestra mensaje en consola: "Acceso denegado a: /usuarios"

### **Navegación**
1. Solo se muestran enlaces a rutas permitidas
2. Enlaces a rutas sin permisos no aparecen
3. Usuario no puede navegar a rutas prohibidas

### **Página de Acceso Denegado**
```typescript
// Se muestra si ProtectedRoute detecta acceso sin permisos
<div className="text-center">
  <div className="text-red-600 text-6xl mb-4">🚫</div>
  <h1>Acceso Denegado</h1>
  <p>No tienes permisos para acceder a esta página.</p>
  <button onClick={() => router.push('/dashboard')}>
    Volver al Dashboard
  </button>
</div>
```

## 🔧 **Configuración**

### **Middleware Actualizado**
```typescript
// Protege todas las rutas excepto login
const isProtectedRoute = !isLoginPage;

// Redirige a login si no hay sesión
if (!token && isProtectedRoute) {
  return NextResponse.redirect(signin);
}
```

### **Variables de Entorno**
```env
NEXT_PUBLIC_API=http://localhost:5000
```

## 🧪 **Testing**

### **Probar Usuario con Permisos**
1. Login con usuario que tiene permisos
2. Navegar a rutas permitidas → ✅ Acceso permitido
3. Verificar que aparecen enlaces en navegación

### **Probar Usuario sin Permisos**
1. Login con usuario sin permisos específicos
2. Intentar acceder directamente a `/usuarios` → ❌ Redirige a dashboard
3. Verificar que no aparecen enlaces en navegación

### **Probar Acceso Directo**
1. Sin sesión, intentar acceder a cualquier ruta
2. Debería redirigir a login automáticamente
3. Después del login, verificar permisos

## 📊 **Logs y Debugging**

### **Console Logs**
```javascript
// Acceso denegado
console.warn('Acceso denegado a: /usuarios');

// Permisos cargados
console.log('Usuario verificado:', { userID, email, name, rolID });

// Error al cargar permisos
console.error('Error fetching permissions:', error);
```

### **Network Requests**
- `GET /permission/:email` - Carga permisos del usuario
- Se ejecuta en cada carga de página protegida

## 🚀 **Próximos Pasos**

1. **Implementar en páginas existentes** usando Layout o ProtectedRoute
2. **Agregar permisos granulares** para acciones específicas
3. **Implementar caché de permisos** para mejor rendimiento
4. **Agregar métricas** de acceso denegado
5. **Notificaciones** cuando se deniega acceso

## 🔒 **Seguridad**

### **Validaciones Implementadas**
- ✅ Verificación de sesión activa
- ✅ Validación de permisos en cada ruta
- ✅ Redirección automática para acceso denegado
- ✅ Navegación basada en permisos
- ✅ Logging de intentos de acceso

### **Buenas Prácticas**
- ✅ Verificación en cliente y servidor
- ✅ Interfaz de usuario clara
- ✅ Manejo graceful de errores
- ✅ Logging para auditoría
- ✅ Experiencia de usuario consistente
