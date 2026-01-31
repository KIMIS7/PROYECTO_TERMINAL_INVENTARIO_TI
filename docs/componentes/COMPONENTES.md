# Documentacion de Componentes Frontend

## Descripcion General

El frontend esta construido con **React 19** y **Next.js 15**, utilizando **TypeScript** para tipado estatico. Los componentes de UI estan basados en **Radix UI** con estilos de **Tailwind CSS**.

## Estructura de Componentes

```
src/components/
├── ui/                         # Componentes base (Radix UI + Tailwind)
│   ├── badge.tsx
│   ├── button.tsx
│   ├── checkbox.tsx
│   ├── dialog.tsx
│   ├── dropdown-menu.tsx
│   ├── input.tsx
│   ├── label.tsx
│   ├── select.tsx
│   ├── separator.tsx
│   ├── toast.tsx
│   └── ...
├── MainLayout.tsx              # Layout principal
├── AppSidebar.tsx              # Barra lateral de navegacion
├── PermissionBasedNav.tsx      # Navegacion basada en permisos
├── UserVerification.tsx        # Verificacion de usuario
├── DataTable.tsx               # Tabla de datos reutilizable
├── CreateUserModal.tsx         # Modal para crear usuario
├── EditUserModal.tsx           # Modal para editar usuario
├── UserManagementPanel.tsx     # Panel de gestion de usuarios
├── CreateRoleModal.tsx         # Modal para crear rol
├── EditRoleModal.tsx           # Modal para editar rol
├── RoleManagementPanel.tsx     # Panel de gestion de roles
├── AssignPermissionModal.tsx   # Modal para asignar permisos
├── PermissionManagementPanel.tsx # Panel de gestion de permisos
└── ActionCell.tsx              # Celda de acciones para tablas
```

---

## Componentes de Layout

### MainLayout

Componente principal que envuelve todas las paginas del dashboard.

```typescript
// src/components/MainLayout.tsx

interface MainLayoutProps {
  children: React.ReactNode;
}

const MainLayout: React.FC<MainLayoutProps> = ({ children }) => {
  return (
    <SidebarProvider>
      <div className="flex min-h-screen w-full">
        <AppSidebar />
        <main className="flex-1 overflow-auto">
          <header className="border-b p-4">
            <Breadcrumb />
          </header>
          <div className="p-6">
            {children}
          </div>
        </main>
      </div>
    </SidebarProvider>
  );
};
```

**Caracteristicas:**
- Sidebar colapsable
- Breadcrumbs automaticos
- Area de contenido responsive
- Soporte para tema oscuro

---

### AppSidebar

Barra lateral de navegacion con menu dinamico basado en permisos.

```typescript
// src/components/AppSidebar.tsx

const AppSidebar: React.FC = () => {
  const { permissions } = usePermissions();
  const { data: session } = useSession();

  return (
    <Sidebar>
      <SidebarHeader>
        <Logo />
        <UserInfo user={session?.user} />
      </SidebarHeader>

      <SidebarContent>
        <PermissionBasedNav permissions={permissions} />
      </SidebarContent>

      <SidebarFooter>
        <LogoutButton />
        <AppVersion />
      </SidebarFooter>
    </Sidebar>
  );
};
```

**Caracteristicas:**
- Logo de la empresa
- Informacion del usuario
- Navegacion dinamica
- Boton de logout
- Version de la aplicacion

---

### PermissionBasedNav

Renderiza la navegacion segun los permisos del usuario.

```typescript
// src/components/PermissionBasedNav.tsx

interface Permission {
  path: string;
  name: string;
  icon: string;
}

interface PermissionBasedNavProps {
  permissions: Permission[];
}

const PermissionBasedNav: React.FC<PermissionBasedNavProps> = ({ permissions }) => {
  const router = useRouter();

  const iconMap: Record<string, LucideIcon> = {
    LayoutDashboard,
    Users,
    Shield,
    Key,
    Anchor,
    // ...
  };

  return (
    <nav>
      {permissions.map((permission) => {
        const Icon = iconMap[permission.icon] || Circle;
        const isActive = router.pathname === permission.path;

        return (
          <Link
            key={permission.path}
            href={permission.path}
            className={cn(
              "flex items-center gap-3 px-3 py-2 rounded-md",
              isActive && "bg-primary text-primary-foreground"
            )}
          >
            <Icon className="h-5 w-5" />
            <span>{permission.name}</span>
          </Link>
        );
      })}
    </nav>
  );
};
```

---

### UserVerification

Componente que verifica el usuario en la base de datos local.

```typescript
// src/components/UserVerification.tsx

interface UserVerificationProps {
  children: React.ReactNode;
}

const UserVerification: React.FC<UserVerificationProps> = ({ children }) => {
  const { data: session, status } = useSession();
  const [isVerified, setIsVerified] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (status === 'authenticated' && session?.user?.email) {
      verifyUser(session.user.email);
    } else if (status === 'unauthenticated') {
      setIsLoading(false);
    }
  }, [session, status]);

  const verifyUser = async (email: string) => {
    try {
      const response = await api.user.verify(email);

      if (response.success) {
        setIsVerified(true);
      } else {
        showError(response.errorType);
        await signOut({ callbackUrl: '/' });
      }
    } catch (error) {
      console.error('Error verificando usuario:', error);
      await signOut({ callbackUrl: '/' });
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return <LoadingSpinner />;
  }

  if (!isVerified) {
    return null;
  }

  return <>{children}</>;
};
```

---

## Componentes de Datos

### DataTable

Tabla de datos reutilizable con TanStack React Table.

```typescript
// src/components/DataTable.tsx

interface DataTableProps<TData, TValue> {
  columns: ColumnDef<TData, TValue>[];
  data: TData[];
  searchKey?: string;
  searchPlaceholder?: string;
  pageSize?: number;
}

function DataTable<TData, TValue>({
  columns,
  data,
  searchKey,
  searchPlaceholder = "Buscar...",
  pageSize = 10,
}: DataTableProps<TData, TValue>) {
  const [sorting, setSorting] = useState<SortingState>([]);
  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);
  const [globalFilter, setGlobalFilter] = useState("");

  const table = useReactTable({
    data,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    onSortingChange: setSorting,
    onColumnFiltersChange: setColumnFilters,
    onGlobalFilterChange: setGlobalFilter,
    state: {
      sorting,
      columnFilters,
      globalFilter,
    },
    initialState: {
      pagination: {
        pageSize,
      },
    },
  });

  return (
    <div>
      {/* Barra de busqueda */}
      <div className="flex items-center py-4">
        <Input
          placeholder={searchPlaceholder}
          value={globalFilter ?? ""}
          onChange={(e) => setGlobalFilter(e.target.value)}
          className="max-w-sm"
        />
      </div>

      {/* Tabla */}
      <div className="rounded-md border">
        <Table>
          <TableHeader>
            {table.getHeaderGroups().map((headerGroup) => (
              <TableRow key={headerGroup.id}>
                {headerGroup.headers.map((header) => (
                  <TableHead key={header.id}>
                    {flexRender(
                      header.column.columnDef.header,
                      header.getContext()
                    )}
                  </TableHead>
                ))}
              </TableRow>
            ))}
          </TableHeader>
          <TableBody>
            {table.getRowModel().rows.map((row) => (
              <TableRow key={row.id}>
                {row.getVisibleCells().map((cell) => (
                  <TableCell key={cell.id}>
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>

      {/* Paginacion */}
      <div className="flex items-center justify-between py-4">
        <span className="text-sm text-muted-foreground">
          Pagina {table.getState().pagination.pageIndex + 1} de{" "}
          {table.getPageCount()}
        </span>
        <div className="flex gap-2">
          <Button
            variant="outline"
            size="sm"
            onClick={() => table.previousPage()}
            disabled={!table.getCanPreviousPage()}
          >
            Anterior
          </Button>
          <Button
            variant="outline"
            size="sm"
            onClick={() => table.nextPage()}
            disabled={!table.getCanNextPage()}
          >
            Siguiente
          </Button>
        </div>
      </div>
    </div>
  );
}
```

**Caracteristicas:**
- Ordenamiento por columnas
- Busqueda global
- Filtros por columna
- Paginacion
- Seleccion de filas
- Columnas personalizables

---

### ActionCell

Celda de acciones para tablas (editar, eliminar, etc.).

```typescript
// src/components/ActionCell.tsx

interface ActionCellProps<T> {
  row: T;
  onEdit?: (row: T) => void;
  onDelete?: (row: T) => void;
  onToggleStatus?: (row: T) => void;
  isActive?: boolean;
}

function ActionCell<T>({
  row,
  onEdit,
  onDelete,
  onToggleStatus,
  isActive,
}: ActionCellProps<T>) {
  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" className="h-8 w-8 p-0">
          <MoreHorizontal className="h-4 w-4" />
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        {onEdit && (
          <DropdownMenuItem onClick={() => onEdit(row)}>
            <Edit className="mr-2 h-4 w-4" />
            Editar
          </DropdownMenuItem>
        )}
        {onToggleStatus && (
          <DropdownMenuItem onClick={() => onToggleStatus(row)}>
            {isActive ? (
              <>
                <XCircle className="mr-2 h-4 w-4" />
                Desactivar
              </>
            ) : (
              <>
                <CheckCircle className="mr-2 h-4 w-4" />
                Activar
              </>
            )}
          </DropdownMenuItem>
        )}
        {onDelete && (
          <DropdownMenuItem
            onClick={() => onDelete(row)}
            className="text-red-600"
          >
            <Trash className="mr-2 h-4 w-4" />
            Eliminar
          </DropdownMenuItem>
        )}
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
```

---

## Componentes de Formulario

### CreateUserModal

Modal para crear un nuevo usuario.

```typescript
// src/components/CreateUserModal.tsx

interface CreateUserModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  roles: Rol[];
}

const CreateUserModal: React.FC<CreateUserModalProps> = ({
  isOpen,
  onClose,
  onSuccess,
  roles,
}) => {
  const [formData, setFormData] = useState({
    Email: "",
    Name: "",
    FirstName: "",
    LastName: "",
    Department: "",
    rolD: undefined as number | undefined,
  });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);

  const validateEmail = (email: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrors({});

    // Validacion
    const newErrors: Record<string, string> = {};

    if (!formData.Email) {
      newErrors.Email = "El email es requerido";
    } else if (!validateEmail(formData.Email)) {
      newErrors.Email = "El email no es valido";
    }

    if (!formData.Name) {
      newErrors.Name = "El nombre es requerido";
    }

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }

    setIsSubmitting(true);

    try {
      await api.user.create(formData);
      toast.success("Usuario creado exitosamente");
      onSuccess();
      onClose();
      resetForm();
    } catch (error: any) {
      if (error.response?.status === 409) {
        setErrors({ Email: "El email ya esta registrado" });
      } else {
        toast.error("Error al crear usuario");
      }
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Crear Nuevo Usuario</DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Label htmlFor="email">Email *</Label>
            <Input
              id="email"
              type="email"
              value={formData.Email}
              onChange={(e) =>
                setFormData({ ...formData, Email: e.target.value })
              }
              className={errors.Email ? "border-red-500" : ""}
            />
            {errors.Email && (
              <span className="text-sm text-red-500">{errors.Email}</span>
            )}
          </div>

          <div>
            <Label htmlFor="name">Nombre Completo *</Label>
            <Input
              id="name"
              value={formData.Name}
              onChange={(e) =>
                setFormData({ ...formData, Name: e.target.value })
              }
              className={errors.Name ? "border-red-500" : ""}
            />
            {errors.Name && (
              <span className="text-sm text-red-500">{errors.Name}</span>
            )}
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="firstName">Nombre</Label>
              <Input
                id="firstName"
                value={formData.FirstName}
                onChange={(e) =>
                  setFormData({ ...formData, FirstName: e.target.value })
                }
              />
            </div>
            <div>
              <Label htmlFor="lastName">Apellido</Label>
              <Input
                id="lastName"
                value={formData.LastName}
                onChange={(e) =>
                  setFormData({ ...formData, LastName: e.target.value })
                }
              />
            </div>
          </div>

          <div>
            <Label htmlFor="department">Departamento</Label>
            <Input
              id="department"
              value={formData.Department}
              onChange={(e) =>
                setFormData({ ...formData, Department: e.target.value })
              }
            />
          </div>

          <div>
            <Label htmlFor="rol">Rol</Label>
            <Select
              value={formData.rolD?.toString()}
              onValueChange={(value) =>
                setFormData({ ...formData, rolD: parseInt(value) })
              }
            >
              <SelectTrigger>
                <SelectValue placeholder="Seleccionar rol" />
              </SelectTrigger>
              <SelectContent>
                {roles
                  .filter((rol) => rol.isActive)
                  .map((rol) => (
                    <SelectItem key={rol.rolID} value={rol.rolID.toString()}>
                      {rol.name}
                    </SelectItem>
                  ))}
              </SelectContent>
            </Select>
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={onClose}>
              Cancelar
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting ? "Guardando..." : "Guardar"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
};
```

---

## Componentes de Panel de Gestion

### UserManagementPanel

Panel completo para gestion de usuarios.

```typescript
// src/components/UserManagementPanel.tsx

const UserManagementPanel: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [roles, setRoles] = useState<Rol[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState<User | null>(null);

  // Filtros
  const [searchTerm, setSearchTerm] = useState("");
  const [roleFilter, setRoleFilter] = useState<string>("all");
  const [statusFilter, setStatusFilter] = useState<string>("all");

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const [usersRes, rolesRes] = await Promise.all([
        api.user.getAll(),
        api.rol.getAll(),
      ]);
      setUsers(usersRes.data);
      setRoles(rolesRes.data);
    } catch (error) {
      toast.error("Error al cargar datos");
    } finally {
      setIsLoading(false);
    }
  };

  const filteredUsers = useMemo(() => {
    return users.filter((user) => {
      const matchesSearch =
        user.Name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.Email.toLowerCase().includes(searchTerm.toLowerCase());

      const matchesRole =
        roleFilter === "all" || user.rolD?.toString() === roleFilter;

      const matchesStatus =
        statusFilter === "all" ||
        (statusFilter === "active" && user.isActive) ||
        (statusFilter === "inactive" && !user.isActive);

      return matchesSearch && matchesRole && matchesStatus;
    });
  }, [users, searchTerm, roleFilter, statusFilter]);

  const columns: ColumnDef<User>[] = [
    {
      accessorKey: "Name",
      header: "Nombre",
    },
    {
      accessorKey: "Email",
      header: "Email",
    },
    {
      accessorKey: "rol.name",
      header: "Rol",
      cell: ({ row }) => (
        <Badge variant="outline">{row.original.rol?.name || "Sin rol"}</Badge>
      ),
    },
    {
      accessorKey: "isActive",
      header: "Estado",
      cell: ({ row }) => (
        <Badge variant={row.original.isActive ? "success" : "destructive"}>
          {row.original.isActive ? "Activo" : "Inactivo"}
        </Badge>
      ),
    },
    {
      id: "actions",
      header: "Acciones",
      cell: ({ row }) => (
        <ActionCell
          row={row.original}
          onEdit={setEditingUser}
          onToggleStatus={handleToggleStatus}
          isActive={row.original.isActive}
        />
      ),
    },
  ];

  return (
    <div className="space-y-4">
      {/* Barra de herramientas */}
      <div className="flex justify-between items-center">
        <div className="flex gap-4">
          <Input
            placeholder="Buscar usuarios..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-64"
          />
          <Select value={roleFilter} onValueChange={setRoleFilter}>
            <SelectTrigger className="w-40">
              <SelectValue placeholder="Filtrar por rol" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos los roles</SelectItem>
              {roles.map((rol) => (
                <SelectItem key={rol.rolID} value={rol.rolID.toString()}>
                  {rol.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-40">
              <SelectValue placeholder="Estado" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos</SelectItem>
              <SelectItem value="active">Activos</SelectItem>
              <SelectItem value="inactive">Inactivos</SelectItem>
            </SelectContent>
          </Select>
        </div>
        <Button onClick={() => setIsCreateModalOpen(true)}>
          <Plus className="mr-2 h-4 w-4" />
          Nuevo Usuario
        </Button>
      </div>

      {/* Tabla */}
      {isLoading ? (
        <LoadingSpinner />
      ) : (
        <DataTable columns={columns} data={filteredUsers} />
      )}

      {/* Modales */}
      <CreateUserModal
        isOpen={isCreateModalOpen}
        onClose={() => setIsCreateModalOpen(false)}
        onSuccess={loadData}
        roles={roles}
      />

      {editingUser && (
        <EditUserModal
          isOpen={!!editingUser}
          onClose={() => setEditingUser(null)}
          onSuccess={loadData}
          user={editingUser}
          roles={roles}
        />
      )}
    </div>
  );
};
```

---

## Custom Hooks

### usePermissions

Hook para gestionar permisos del usuario.

```typescript
// src/hooks/usePermissions.ts

interface Permission {
  dashboarpathID: number;
  path: string;
  name: string;
  icon: string;
}

interface UsePermissionsReturn {
  permissions: Permission[];
  isLoading: boolean;
  hasPermission: (path: string) => boolean;
  refetch: () => Promise<void>;
}

export const usePermissions = (): UsePermissionsReturn => {
  const { data: session } = useSession();
  const [permissions, setPermissions] = useState<Permission[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (session?.user?.email) {
      fetchPermissions();
    }
  }, [session]);

  const fetchPermissions = async () => {
    if (!session?.user?.email) return;

    try {
      const response = await api.permission.getByUser(session.user.email);
      setPermissions(response.data);
    } catch (error) {
      console.error("Error fetching permissions:", error);
      setPermissions([]);
    } finally {
      setIsLoading(false);
    }
  };

  const hasPermission = useCallback(
    (path: string): boolean => {
      return permissions.some((p) => p.path === path);
    },
    [permissions]
  );

  return {
    permissions,
    isLoading,
    hasPermission,
    refetch: fetchPermissions,
  };
};
```

---

### useNotifications

Hook para notificaciones toast.

```typescript
// src/hooks/useNotifications.ts

export const useNotifications = () => {
  const success = (message: string) => {
    toast.success(message, {
      duration: 3000,
      position: "top-right",
    });
  };

  const error = (message: string) => {
    toast.error(message, {
      duration: 5000,
      position: "top-right",
    });
  };

  const warning = (message: string) => {
    toast.warning(message, {
      duration: 4000,
      position: "top-right",
    });
  };

  const info = (message: string) => {
    toast.info(message, {
      duration: 3000,
      position: "top-right",
    });
  };

  return { success, error, warning, info };
};
```

---

## Componentes UI Base

Los componentes base estan construidos sobre **Radix UI** con estilos de **Tailwind CSS**:

| Componente | Descripcion | Ubicacion |
|------------|-------------|-----------|
| Button | Boton con variantes | `ui/button.tsx` |
| Input | Campo de texto | `ui/input.tsx` |
| Label | Etiqueta de formulario | `ui/label.tsx` |
| Select | Selector desplegable | `ui/select.tsx` |
| Checkbox | Casilla de verificacion | `ui/checkbox.tsx` |
| Dialog | Modal/dialogo | `ui/dialog.tsx` |
| DropdownMenu | Menu desplegable | `ui/dropdown-menu.tsx` |
| Badge | Insignia/etiqueta | `ui/badge.tsx` |
| Avatar | Avatar de usuario | `ui/avatar.tsx` |
| Separator | Separador visual | `ui/separator.tsx` |
| Toast | Notificacion temporal | `ui/toast.tsx` |
| Tooltip | Tooltip informativo | `ui/tooltip.tsx` |
| Breadcrumb | Migas de pan | `ui/breadcrumb.tsx` |
| ScrollArea | Area con scroll | `ui/scroll-area.tsx` |

### Ejemplo de uso de Button

```typescript
import { Button } from "@/components/ui/button";

// Variantes disponibles
<Button variant="default">Default</Button>
<Button variant="destructive">Eliminar</Button>
<Button variant="outline">Outline</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="ghost">Ghost</Button>
<Button variant="link">Link</Button>

// Tamaños
<Button size="default">Normal</Button>
<Button size="sm">Pequeño</Button>
<Button size="lg">Grande</Button>
<Button size="icon"><Icon /></Button>
```

---

## Patrones y Mejores Practicas

### 1. Composicion de Componentes
```typescript
// Preferir composicion sobre props complejas
<Card>
  <CardHeader>
    <CardTitle>Titulo</CardTitle>
    <CardDescription>Descripcion</CardDescription>
  </CardHeader>
  <CardContent>
    Contenido
  </CardContent>
  <CardFooter>
    <Button>Accion</Button>
  </CardFooter>
</Card>
```

### 2. Manejo de Estado
```typescript
// Usar hooks personalizados para logica compleja
const { data, isLoading, error, refetch } = useUsers();

// Usar useMemo para calculos costosos
const filteredData = useMemo(() =>
  data.filter(item => item.isActive),
  [data]
);
```

### 3. Formularios
```typescript
// Validacion antes de submit
const handleSubmit = async (e: FormEvent) => {
  e.preventDefault();

  const errors = validate(formData);
  if (Object.keys(errors).length > 0) {
    setErrors(errors);
    return;
  }

  await submit(formData);
};
```

### 4. Manejo de Errores
```typescript
// Siempre manejar errores en llamadas API
try {
  const result = await api.user.create(data);
  toast.success("Usuario creado");
} catch (error) {
  if (error.response?.status === 409) {
    toast.error("El email ya existe");
  } else {
    toast.error("Error al crear usuario");
  }
}
```
