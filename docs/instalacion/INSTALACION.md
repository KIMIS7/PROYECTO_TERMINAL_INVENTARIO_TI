# Manual de Instalacion y Configuracion

## Requisitos Previos

### Software Requerido

| Software | Version Minima | Proposito |
|----------|---------------|-----------|
| Node.js | 18.x LTS | Runtime de JavaScript |
| npm | 9.x | Gestor de paquetes |
| SQL Server | 2019+ | Base de datos |
| Git | 2.x | Control de versiones |

### Requisitos de Azure AD

Para la autenticacion, necesitas acceso a un tenant de Azure Active Directory con permisos para:
- Crear App Registrations
- Configurar permisos de API
- Generar Client Secrets

---

## Instalacion Paso a Paso

### 1. Clonar el Repositorio

```bash
# Clonar el repositorio
git clone [URL_DEL_REPOSITORIO]
cd PROYECTO_TERMINAL_INVENTARIO_TI
```

### 2. Restaurar la Base de Datos

#### Opcion A: Usando SQL Server Management Studio (SSMS)

1. Abrir SSMS y conectarse al servidor
2. Click derecho en "Databases" > "Restore Database..."
3. Seleccionar "Device" y buscar el archivo `BASE_DATOS/InventarioIT2.bak`
4. Configurar el nombre de la base de datos como `InventarioIT`
5. Click en "OK" para restaurar

#### Opcion B: Usando T-SQL

```sql
-- Restaurar base de datos desde backup
RESTORE DATABASE InventarioIT
FROM DISK = 'C:\ruta\a\InventarioIT2.bak'
WITH REPLACE,
MOVE 'InventarioIT_Data' TO 'C:\SQLData\InventarioIT.mdf',
MOVE 'InventarioIT_Log' TO 'C:\SQLData\InventarioIT.ldf';
GO
```

### 3. Configurar el Backend (NestJS)

```bash
# Navegar a la carpeta del backend
cd InventarioIT-API-icel

# Instalar dependencias
npm install

# Crear archivo de configuracion
cp .env.example .env
```

#### Configurar variables de entorno (.env)

```bash
# Configuracion de Base de Datos
# Formato: sqlserver://[servidor]:[puerto];database=[nombre];user=[usuario];password=[contraseña];encrypt=true;trustServerCertificate=true
DATABASE_URL="sqlserver://localhost:1433;database=InventarioIT;user=sa;password=TuPassword123;encrypt=true;trustServerCertificate=true"

# Configuracion del Servidor
API_PORT=3001
NODE_ENV=development

# Prefijo de API (opcional)
# API_PREFIX=/api
```

#### Generar Cliente de Prisma

```bash
# Sincronizar schema con la base de datos existente
npm run db:pull

# Generar cliente de Prisma
npm run db:generate
```

#### Iniciar el Backend

```bash
# Modo desarrollo (con hot reload)
npm run start:dev

# Modo produccion
npm run build
npm run start:prod
```

**Verificar que funciona:**
```bash
# El servidor debe responder en http://localhost:3001
curl http://localhost:3001/user
```

### 4. Configurar Azure Active Directory

#### 4.1 Crear App Registration

1. Ir a [Azure Portal](https://portal.azure.com)
2. Navegar a "Azure Active Directory" > "App registrations"
3. Click en "New registration"
4. Configurar:
   - **Name**: `InventarioIT`
   - **Supported account types**: "Accounts in this organizational directory only"
   - **Redirect URI**:
     - Platform: Web
     - URL: `http://localhost:3000/api/auth/callback/azure-ad` (desarrollo)
5. Click en "Register"

#### 4.2 Configurar Autenticacion

1. En la App Registration, ir a "Authentication"
2. En "Redirect URIs", agregar:
   - `http://localhost:3000/api/auth/callback/azure-ad` (desarrollo)
   - `https://[tu-dominio]/inventarioit/api/auth/callback/azure-ad` (produccion)
3. En "Implicit grant and hybrid flows":
   - Marcar "ID tokens"
4. Click en "Save"

#### 4.3 Crear Client Secret

1. Ir a "Certificates & secrets"
2. Click en "New client secret"
3. Agregar descripcion y seleccionar expiracion
4. Click en "Add"
5. **IMPORTANTE**: Copiar el valor del secret inmediatamente (solo se muestra una vez)

#### 4.4 Configurar API Permissions

1. Ir a "API permissions"
2. Click en "Add a permission"
3. Seleccionar "Microsoft Graph"
4. Seleccionar "Delegated permissions"
5. Agregar:
   - `openid`
   - `email`
   - `profile`
   - `User.Read`
6. Click en "Grant admin consent for [tenant]"

#### 4.5 Obtener IDs necesarios

Anotar los siguientes valores de la App Registration:
- **Application (client) ID**: En "Overview"
- **Directory (tenant) ID**: En "Overview"
- **Client Secret**: El que copiaste en el paso 4.3

### 5. Configurar el Frontend (Next.js)

```bash
# Navegar a la carpeta del frontend
cd ../InventarioIT-web-main

# Instalar dependencias
npm install

# Crear archivo de configuracion
cp .env.example .env.local
```

#### Configurar variables de entorno (.env.local)

```bash
# URL del Backend API
NEXT_PUBLIC_API=http://localhost:3001

# Configuracion de rutas
NEXT_PUBLIC_REDIRECT_URL=/inventarioit
NEXT_BASE_PATH=
NEXT_PUBLIC_APP_VERSION=1.0.0

# NextAuth Configuration
NEXTAUTH_SECRET=tu-secret-muy-largo-de-al-menos-32-caracteres-aqui
NEXTAUTH_URL=http://localhost:3000
NEXT_PUBLIC_AUTH_BASEPATH=/api/auth

# Azure AD Configuration
AZURE_AD_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
AZURE_AD_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
AZURE_AD_TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

#### Generar NEXTAUTH_SECRET

```bash
# En Linux/Mac
openssl rand -base64 32

# En Windows (PowerShell)
[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Maximum 256 }) -as [byte[]])
```

#### Iniciar el Frontend

```bash
# Modo desarrollo (con Turbopack)
npm run dev

# Modo produccion
npm run build
npm run start
```

**Verificar que funciona:**
- Abrir http://localhost:3000 en el navegador
- Deberia mostrarse la pagina de login

---

## Configuracion de Produccion

### Variables de Entorno para Produccion

#### Backend (.env)
```bash
DATABASE_URL="sqlserver://servidor-produccion:1433;database=InventarioIT;user=app_user;password=SecurePassword123!;encrypt=true;trustServerCertificate=false"
API_PORT=3001
NODE_ENV=production
```

#### Frontend (.env.local)
```bash
NEXT_PUBLIC_API=https://api.tudominio.com
NEXT_PUBLIC_REDIRECT_URL=/inventarioit
NEXT_BASE_PATH=/inventarioit
NEXT_PUBLIC_APP_VERSION=1.0.0

NEXTAUTH_SECRET=tu-secret-seguro-de-produccion
NEXTAUTH_URL=https://tudominio.com
NEXT_PUBLIC_AUTH_BASEPATH=/inventarioit/api/auth

AZURE_AD_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
AZURE_AD_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
AZURE_AD_TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

### Build de Produccion

#### Backend
```bash
cd InventarioIT-API-icel
npm run build
npm run start:prod
```

#### Frontend
```bash
cd InventarioIT-web-main
npm run build
npm run start
```

### Despliegue con Docker (Opcional)

#### Dockerfile para Backend
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build
RUN npm run db:generate

EXPOSE 3001

CMD ["npm", "run", "start:prod"]
```

#### Dockerfile para Frontend
```dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:18-alpine AS runner

WORKDIR /app

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["node", "server.js"]
```

#### Docker Compose
```yaml
version: '3.8'

services:
  frontend:
    build:
      context: ./InventarioIT-web-main
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - NEXT_PUBLIC_API=http://backend:3001
    depends_on:
      - backend

  backend:
    build:
      context: ./InventarioIT-API-icel
      dockerfile: Dockerfile
    ports:
      - "3001:3001"
    environment:
      - DATABASE_URL=sqlserver://db:1433;database=InventarioIT;user=sa;password=YourPassword
    depends_on:
      - db

  db:
    image: mcr.microsoft.com/mssql/server:2019-latest
    ports:
      - "1433:1433"
    environment:
      - ACCEPT_EULA=Y
      - SA_PASSWORD=YourPassword123!
    volumes:
      - sqlserver_data:/var/opt/mssql

volumes:
  sqlserver_data:
```

---

## Verificacion de la Instalacion

### Checklist de Verificacion

- [ ] SQL Server esta corriendo y la BD esta restaurada
- [ ] Backend responde en http://localhost:3001
- [ ] Frontend carga en http://localhost:3000
- [ ] Login con Azure AD funciona
- [ ] Usuario puede acceder al dashboard
- [ ] CRUD de usuarios funciona
- [ ] CRUD de roles funciona
- [ ] Asignacion de permisos funciona

### Pruebas Basicas

```bash
# 1. Verificar Backend
curl http://localhost:3001/rol
# Deberia devolver lista de roles

# 2. Verificar conexion a BD
curl http://localhost:3001/user
# Deberia devolver lista de usuarios

# 3. Verificar Frontend
curl http://localhost:3000
# Deberia devolver HTML de la pagina de login
```

---

## Solucion de Problemas

### Error: "Cannot connect to database"

**Causa**: Conexion a SQL Server fallida

**Solucion**:
1. Verificar que SQL Server esta corriendo
2. Verificar que el puerto 1433 esta abierto
3. Verificar credenciales en DATABASE_URL
4. Si usas Windows Auth, asegurate de usar `integratedSecurity=true`

```bash
# Verificar conexion
telnet localhost 1433
```

### Error: "AZURE_AD_CLIENT_ID is required"

**Causa**: Variables de Azure AD no configuradas

**Solucion**:
1. Verificar que `.env.local` existe
2. Verificar que todas las variables de Azure estan configuradas
3. Reiniciar el servidor de Next.js

### Error: "NextAuth callback URL mismatch"

**Causa**: Redirect URI no coincide con Azure AD

**Solucion**:
1. Verificar Redirect URIs en Azure Portal
2. Asegurarse que coincide exactamente con `NEXTAUTH_URL + /api/auth/callback/azure-ad`
3. En produccion, verificar que se usa HTTPS

### Error: "Prisma Client not generated"

**Causa**: Cliente de Prisma no generado

**Solucion**:
```bash
cd InventarioIT-API-icel
npm run db:generate
```

### Error: "User not found in database"

**Causa**: Usuario de Azure no registrado en BD local

**Solucion**:
1. Agregar el usuario manualmente a la tabla `User`
2. O crear el usuario desde la interfaz de administracion

---

## Scripts Utiles

### Backend

```bash
# Desarrollo con hot reload
npm run start:dev

# Build de produccion
npm run build

# Iniciar produccion
npm run start:prod

# Regenerar cliente Prisma
npm run db:generate

# Sincronizar schema de BD
npm run db:pull

# Ejecutar tests
npm run test

# Ejecutar linter
npm run lint
```

### Frontend

```bash
# Desarrollo con Turbopack
npm run dev

# Build de produccion
npm run build

# Iniciar produccion
npm run start

# Ejecutar tests
npm run test

# Ejecutar linter
npm run lint
```

---

## Contacto y Soporte

Para problemas o preguntas sobre la instalacion:
1. Revisar esta documentacion
2. Revisar los logs del servidor
3. Contactar al equipo de desarrollo
