## Description

[Nest](https://github.com/nestjs/nest) framework TypeScript starter repository.

## 📜 Scripts para crear el schema flow

```sql
CREATE SCHEMA flow;

--query para ver que s ehaya creado el schema flow
SELECT s.name AS SchemaName, u.name AS OwnerName
FROM sys.schemas s
JOIN sys.sysusers u ON u.uid = s.principal_id
WHERE s.name = 'flow';
```

## 📜 Scripts para crear las tablas

```sql
CREATE TABLE flow.rol (
	rolID		INT IDENTITY(1,1) PRIMARY KEY,  -- Clave primaria autoincremental
	[name]		NVARCHAR(100) NOT NULL,         -- Nombre del role
	isActive	BIT DEFAULT 1,                  -- Estado (1=activo, 0=inactivo)
)

CREATE TABLE flow.dashboard_paths (
	dashboarpathID		INT IDENTITY(1,1) PRIMARY KEY, -- Clave primaria autoincremental
	[path]				NVARCHAR(100) NOT NULL UNIQUE, -- ruta
	[name]				NVARCHAR(100) NOT NULL,        -- Nombre de la ruta
	icon				NVARCHAR(MAX) NULL,			   -- icono
)

CREATE TABLE flow.users (
    userID		INT IDENTITY(1,1) PRIMARY KEY,  -- Clave primaria autoincremental
    [name]		NVARCHAR(100) NOT NULL,         -- Nombre del usuario
    email		NVARCHAR(255) NOT NULL UNIQUE,  -- Correo único
    isActive	BIT DEFAULT 1,                  -- Estado (1=activo, 0=inactivo)
	token		NVARCHAR(MAX) NUll,				-- token inicio de sesión
    createdAt	DATETIME DEFAULT GETDATE(),		-- Fecha de registro
	rolID      INT NULL,						-- Relación con rol
    CONSTRAINT FK_users_rol FOREIGN KEY (rolID) REFERENCES flow.rol(rolID)
);

CREATE TABLE flow.rol_dashboard_path (
	roldashboardpathID	INT IDENTITY(1,1) PRIMARY KEY,  -- Clave primaria autoincremental
    rolID				INT NOT NULL,
    dashboarpathID		INT NOT NULL,

    CONSTRAINT FK_rdp_rol  FOREIGN KEY (rolID)
        REFERENCES flow.rol(rolID) ON DELETE CASCADE,
	CONSTRAINT FK_rdp_path FOREIGN KEY (dashboarpathID)
        REFERENCES flow.dashboard_paths(dashboarpathID) ON DELETE CASCADE
);

CREATE TABLE flow.mailbox (
  mailboxID INT IDENTITY(1,1) PRIMARY KEY,
  userName	VARCHAR(255) NOT NULL,
  userEmail VARCHAR(255) NOT NULL UNIQUE,
  isActive	BIT DEFAULT 1,
  createdAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE flow.notification_type (
  notificationtypeID	INT IDENTITY(1,1) PRIMARY KEY,
  code					VARCHAR(50) NOT NULL UNIQUE,
  description			VARCHAR(255) NULL,
  isActive				BIT DEFAULT 1,
);

CREATE TABLE flow.mailbox_notification (
  mailboxnotificationID	INT IDENTITY(1,1) PRIMARY KEY,
  mailboxID				INT NOT NULL,
  notificationtypeID	INT NOT NULL,
  isRecipient			BIT DEFAULT 0,
  isCC					BIT DEFAULT 0,
  isBCC					BIT DEFAULT 0,
  createdAt				DATETIME DEFAULT GETDATE()

  CONSTRAINT FK_mn_mailbox FOREIGN KEY (mailboxID)
    REFERENCES flow.mailbox(mailboxID)
    ON DELETE CASCADE,

  CONSTRAINT FK_mn_notification FOREIGN KEY (notificationtypeID)
    REFERENCES flow.notification_type(notificationtypeID)
    ON DELETE CASCADE
);
```

## Cambiar los createdAt del schema para tomar la fecha del servidor

```prisma
createdAt DateTime? @default(now(), map: "") @db.DateTime //antiguo

createdAt DateTime? @default(dbgenerated("GETDATE()")) @map("createdAt") @db.DateTime //nuevo
```

## Project setup

```bash
$ npm install
```

## Pull tables

```bash
$ npm run db:pull
```

## Generate schema tables

```bash
$ npm run db:generate
```

## Compile and run the project

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Run tests

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```
