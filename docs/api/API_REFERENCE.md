# Documentacion de API REST

## Informacion General

- **Base URL**: `http://localhost:3001` (desarrollo) / `https://[dominio]/api` (produccion)
- **Formato**: JSON
- **Autenticacion**: Bearer Token + Header user-email

## Headers Requeridos

| Header | Tipo | Descripcion |
|--------|------|-------------|
| `Authorization` | String | `Bearer {id_token}` - Token JWT de Azure AD |
| `user-email` | String | Email del usuario autenticado |
| `Content-Type` | String | `application/json` |

## Respuestas Estandar

### Respuesta Exitosa
```json
{
  "message": "Operacion exitosa",
  "data": { ... }
}
```

### Respuesta de Error
```json
{
  "success": false,
  "message": "Descripcion del error",
  "statusCode": 400
}
```

---

## Endpoints de Usuarios

### GET /user
Obtiene la lista de todos los usuarios.

**Request:**
```http
GET /user
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "data": [
    {
      "ID": 1,
      "Email": "usuario@empresa.com",
      "Name": "Usuario Ejemplo",
      "FirstName": "Usuario",
      "LastName": "Ejemplo",
      "Department": "TI",
      "SiteID": 1,
      "rolD": 1,
      "isActive": true,
      "createdAt": "2024-01-15T10:30:00.000Z",
      "rol": {
        "rolID": 1,
        "name": "Administrador"
      }
    }
  ]
}
```

---

### GET /user/:id
Obtiene un usuario por su ID.

**Request:**
```http
GET /user/1
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "data": {
    "ID": 1,
    "Email": "usuario@empresa.com",
    "Name": "Usuario Ejemplo",
    "FirstName": "Usuario",
    "LastName": "Ejemplo",
    "Department": "TI",
    "SiteID": 1,
    "rolD": 1,
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00.000Z",
    "rol": {
      "rolID": 1,
      "name": "Administrador"
    }
  }
}
```

**Response (404):**
```json
{
  "success": false,
  "message": "Usuario no encontrado",
  "statusCode": 404
}
```

---

### GET /user/verify/:email
Verifica si un usuario existe y esta activo.

**Request:**
```http
GET /user/verify/usuario@empresa.com
Authorization: Bearer {token}
user-email: usuario@empresa.com
```

**Response (200) - Usuario valido:**
```json
{
  "success": true,
  "message": "Usuario verificado",
  "data": {
    "ID": 1,
    "Email": "usuario@empresa.com",
    "Name": "Usuario Ejemplo",
    "isActive": true,
    "rol": {
      "rolID": 1,
      "name": "Administrador"
    }
  }
}
```

**Response (200) - Usuario no encontrado:**
```json
{
  "success": false,
  "message": "Usuario no registrado en el sistema",
  "errorType": "USER_NOT_FOUND",
  "data": null
}
```

**Response (200) - Usuario inactivo:**
```json
{
  "success": false,
  "message": "Usuario desactivado",
  "errorType": "USER_INACTIVE",
  "data": null
}
```

**Response (200) - Sin rol:**
```json
{
  "success": false,
  "message": "Usuario sin rol asignado",
  "errorType": "NO_ROLE_ASSIGNED",
  "data": null
}
```

---

### GET /user/profile/:email
Obtiene el perfil extendido de un usuario.

**Request:**
```http
GET /user/profile/usuario@empresa.com
Authorization: Bearer {token}
user-email: usuario@empresa.com
```

**Response (200):**
```json
{
  "data": {
    "ID": 1,
    "Email": "usuario@empresa.com",
    "Name": "Usuario Ejemplo",
    "FirstName": "Usuario",
    "LastName": "Ejemplo",
    "Department": "TI",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00.000Z",
    "rol": {
      "rolID": 1,
      "name": "Administrador",
      "isActive": true
    },
    "Site": {
      "SiteID": 1,
      "Name": "Oficina Central"
    }
  }
}
```

---

### POST /user
Crea un nuevo usuario.

**Request:**
```http
POST /user
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "Email": "nuevo@empresa.com",
  "Name": "Nuevo Usuario",
  "FirstName": "Nuevo",
  "LastName": "Usuario",
  "Department": "Ventas",
  "SiteID": 1,
  "rolD": 2
}
```

**Response (201):**
```json
{
  "message": "Usuario creado exitosamente",
  "data": {
    "ID": 5,
    "Email": "nuevo@empresa.com",
    "Name": "Nuevo Usuario",
    "FirstName": "Nuevo",
    "LastName": "Usuario",
    "Department": "Ventas",
    "SiteID": 1,
    "rolD": 2,
    "isActive": true,
    "createdAt": "2024-01-20T14:00:00.000Z"
  }
}
```

**Response (409) - Email duplicado:**
```json
{
  "success": false,
  "message": "El email ya esta registrado",
  "statusCode": 409
}
```

**Response (400) - Validacion:**
```json
{
  "success": false,
  "message": ["Email debe ser un email valido", "Name no puede estar vacio"],
  "statusCode": 400
}
```

---

### PATCH /user/:id
Actualiza un usuario existente.

**Request:**
```http
PATCH /user/5
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "Name": "Usuario Actualizado",
  "Department": "Marketing",
  "rolD": 3
}
```

**Response (200):**
```json
{
  "message": "Usuario actualizado exitosamente",
  "data": {
    "ID": 5,
    "Email": "nuevo@empresa.com",
    "Name": "Usuario Actualizado",
    "Department": "Marketing",
    "rolD": 3,
    "isActive": true
  }
}
```

---

### PATCH /user/:id/updateUserStatus
Cambia el estado activo/inactivo de un usuario.

**Request:**
```http
PATCH /user/5/updateUserStatus
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "isActive": false
}
```

**Response (200):**
```json
{
  "message": "Estado del usuario actualizado",
  "data": {
    "ID": 5,
    "isActive": false
  }
}
```

---

### DELETE /user/:id
Elimina un usuario (soft delete o hard delete segun configuracion).

**Request:**
```http
DELETE /user/5
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "message": "Usuario eliminado exitosamente"
}
```

---

## Endpoints de Roles

### GET /rol
Obtiene la lista de todos los roles.

**Request:**
```http
GET /rol
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "data": [
    {
      "rolID": 1,
      "name": "Administrador",
      "isActive": true,
      "createdAt": "2024-01-01T00:00:00.000Z",
      "_count": {
        "User": 5
      }
    },
    {
      "rolID": 2,
      "name": "Usuario",
      "isActive": true,
      "createdAt": "2024-01-01T00:00:00.000Z",
      "_count": {
        "User": 20
      }
    }
  ]
}
```

---

### GET /rol/:id
Obtiene un rol por su ID.

**Request:**
```http
GET /rol/1
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "data": {
    "rolID": 1,
    "name": "Administrador",
    "isActive": true,
    "createdAt": "2024-01-01T00:00:00.000Z",
    "rol_dashboard_path": [
      {
        "roldashboardpathID": 1,
        "dashboard_paths": {
          "dashboarpathID": 1,
          "path": "/dashboard",
          "name": "Dashboard",
          "icon": "LayoutDashboard"
        }
      }
    ]
  }
}
```

---

### POST /rol
Crea un nuevo rol.

**Request:**
```http
POST /rol
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "name": "Supervisor"
}
```

**Response (201):**
```json
{
  "message": "Rol creado exitosamente",
  "data": {
    "rolID": 4,
    "name": "Supervisor",
    "isActive": true,
    "createdAt": "2024-01-20T15:00:00.000Z"
  }
}
```

**Response (409) - Nombre duplicado:**
```json
{
  "success": false,
  "message": "Ya existe un rol con ese nombre",
  "statusCode": 409
}
```

---

### PATCH /rol/:id
Actualiza un rol existente.

**Request:**
```http
PATCH /rol/4
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "name": "Supervisor Senior"
}
```

**Response (200):**
```json
{
  "message": "Rol actualizado exitosamente",
  "data": {
    "rolID": 4,
    "name": "Supervisor Senior",
    "isActive": true
  }
}
```

---

### PATCH /rol/:id/updateRoleStatus
Cambia el estado activo/inactivo de un rol.

**Request:**
```http
PATCH /rol/4/updateRoleStatus
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "isActive": false
}
```

**Response (200):**
```json
{
  "message": "Estado del rol actualizado",
  "data": {
    "rolID": 4,
    "isActive": false
  }
}
```

---

### DELETE /rol/:id
Elimina un rol.

**Request:**
```http
DELETE /rol/4
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "message": "Rol eliminado exitosamente"
}
```

**Response (400) - Rol con usuarios:**
```json
{
  "success": false,
  "message": "No se puede eliminar el rol porque tiene usuarios asignados",
  "statusCode": 400
}
```

---

## Endpoints de Permisos

### GET /permission
Obtiene la lista de todos los permisos (rol-ruta).

**Request:**
```http
GET /permission
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "data": [
    {
      "roldashboardpathID": 1,
      "rolID": 1,
      "dashboarpathID": 1,
      "rol": {
        "rolID": 1,
        "name": "Administrador"
      },
      "dashboard_paths": {
        "dashboarpathID": 1,
        "path": "/dashboard",
        "name": "Dashboard"
      }
    }
  ]
}
```

---

### GET /permission/:useremail
Obtiene los permisos de un usuario especifico.

**Request:**
```http
GET /permission/usuario@empresa.com
Authorization: Bearer {token}
user-email: usuario@empresa.com
```

**Response (200):**
```json
{
  "data": [
    {
      "dashboarpathID": 1,
      "path": "/dashboard",
      "name": "Dashboard",
      "icon": "LayoutDashboard"
    },
    {
      "dashboarpathID": 2,
      "path": "/usuarios",
      "name": "Usuarios",
      "icon": "Users"
    },
    {
      "dashboarpathID": 3,
      "path": "/roles",
      "name": "Roles",
      "icon": "Shield"
    }
  ]
}
```

---

### POST /permission
Asigna un permiso a un rol.

**Request:**
```http
POST /permission
Content-Type: application/json
Authorization: Bearer {token}
user-email: admin@empresa.com

{
  "rolID": 2,
  "dashboarpathID": 5
}
```

**Response (201):**
```json
{
  "message": "Permiso asignado exitosamente",
  "data": {
    "roldashboardpathID": 15,
    "rolID": 2,
    "dashboarpathID": 5
  }
}
```

**Response (409) - Permiso ya existe:**
```json
{
  "success": false,
  "message": "El permiso ya esta asignado a este rol",
  "statusCode": 409
}
```

---

### DELETE /permission/:id
Elimina un permiso.

**Request:**
```http
DELETE /permission/15
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "message": "Permiso eliminado exitosamente"
}
```

---

## Endpoints de Rutas del Dashboard

### GET /dashboard-path
Obtiene todas las rutas disponibles del dashboard.

**Request:**
```http
GET /dashboard-path
Authorization: Bearer {token}
user-email: admin@empresa.com
```

**Response (200):**
```json
{
  "data": [
    {
      "dashboarpathID": 1,
      "path": "/dashboard",
      "name": "Dashboard",
      "icon": "LayoutDashboard"
    },
    {
      "dashboarpathID": 2,
      "path": "/usuarios",
      "name": "Usuarios",
      "icon": "Users"
    },
    {
      "dashboarpathID": 3,
      "path": "/roles",
      "name": "Roles",
      "icon": "Shield"
    },
    {
      "dashboarpathID": 4,
      "path": "/permisos",
      "name": "Permisos",
      "icon": "Key"
    },
    {
      "dashboarpathID": 5,
      "path": "/puertos-origen",
      "name": "Puertos Origen",
      "icon": "Anchor"
    }
  ]
}
```

---

## Codigos de Estado HTTP

| Codigo | Significado |
|--------|-------------|
| 200 | OK - Operacion exitosa |
| 201 | Created - Recurso creado |
| 400 | Bad Request - Error de validacion |
| 401 | Unauthorized - Token invalido o expirado |
| 403 | Forbidden - Sin permisos |
| 404 | Not Found - Recurso no encontrado |
| 409 | Conflict - Conflicto (duplicado) |
| 500 | Internal Server Error - Error del servidor |

---

## DTOs (Data Transfer Objects)

### CreateUserDto
```typescript
{
  Email: string;      // @IsEmail()
  Name: string;       // @IsNotEmpty()
  FirstName?: string; // @IsOptional()
  LastName?: string;  // @IsOptional()
  Department?: string;// @IsOptional()
  SiteID?: number;    // @IsOptional(), @IsNumber()
  rolD?: number;      // @IsOptional(), @IsNumber()
}
```

### UpdateUserDto
```typescript
{
  Name?: string;      // @IsOptional()
  FirstName?: string; // @IsOptional()
  LastName?: string;  // @IsOptional()
  Department?: string;// @IsOptional()
  SiteID?: number;    // @IsOptional(), @IsNumber()
  rolD?: number;      // @IsOptional(), @IsNumber()
  isActive?: boolean; // @IsOptional(), @IsBoolean()
}
```

### CreateRolDto
```typescript
{
  name: string;       // @IsNotEmpty(), @IsString()
}
```

### CreatePermissionDto
```typescript
{
  rolID: number;          // @IsNumber()
  dashboarpathID: number; // @IsNumber()
}
```

---

## Ejemplos con cURL

### Login y obtener usuarios
```bash
# Obtener lista de usuarios
curl -X GET "http://localhost:3001/user" \
  -H "Authorization: Bearer eyJhbG..." \
  -H "user-email: admin@empresa.com"
```

### Crear usuario
```bash
curl -X POST "http://localhost:3001/user" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbG..." \
  -H "user-email: admin@empresa.com" \
  -d '{
    "Email": "nuevo@empresa.com",
    "Name": "Nuevo Usuario",
    "rolD": 2
  }'
```

### Verificar usuario
```bash
curl -X GET "http://localhost:3001/user/verify/usuario@empresa.com" \
  -H "Authorization: Bearer eyJhbG..." \
  -H "user-email: usuario@empresa.com"
```

### Obtener permisos de usuario
```bash
curl -X GET "http://localhost:3001/permission/usuario@empresa.com" \
  -H "Authorization: Bearer eyJhbG..." \
  -H "user-email: usuario@empresa.com"
```
