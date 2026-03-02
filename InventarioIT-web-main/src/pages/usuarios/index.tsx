import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState } from "react";
import { Role, User, Department } from "@/types";
import api from "@/lib/api";
import { ColumnDef } from "@tanstack/react-table";
import { Badge } from "@/components/ui/badge";
import { Eye, EyeOff } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { ActionCell } from "@/components/ActionCell";
import { UserManagementPanel } from "@/components/UserManagementPanel";
import { CreateUserModal } from "@/components/CreateUserModal";

export default function Users() {

  const [roles, setRoles] = useState<Role[]>([]);
  const [departments, setDepartments] = useState<Department[]>([]);
  const [users, setUsers] = useState<User[]>([]);
  const [filteredUsers, setFilteredUsers] = useState<User[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [showPin, setShowPin] = useState(false);


  useEffect(() => {
    (async () => {
      try {
        const [rolesRes, departmentsRes] = await Promise.all([
          api.role.getAll(),
          api.user.getDepartments(),
        ]);
        setRoles(rolesRes);
        setDepartments(departmentsRes);
      } catch (error) {
        console.error("Error fetching roles/departments data:", error);
      }
    })();
  }, []);


  useEffect(() => {
    (async () => {
      try {
        setIsLoading(true);
        const response = await api.user.getAll();
        setUsers(response);
        setFilteredUsers(response);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.error("Error fetching users data:", error);
      }
    })();
  }, []);

  // Funciones de gestión
  const handleRefresh = async () => {
    try {
      setIsLoading(true);
      const response = await api.user.getAll();
      setUsers(response);
      setFilteredUsers(response);
      setIsLoading(false);
    } catch (error) {
      setIsLoading(false);
      console.error("Error refreshing users data:", error);
    }
  };

  const handleCreateUser = () => {
    setIsCreateModalOpen(true);
  };

  const handleCreateSuccess = () => {
    handleRefresh();
  };

  const handleSearch = (query: string) => {
    if (!query.trim()) {
      setFilteredUsers(users);
      return;
    }

    const filtered = users.filter(user =>
      user.name.toLowerCase().includes(query.toLowerCase()) ||
      user.email.toLowerCase().includes(query.toLowerCase()) ||
      user.rolName.toLowerCase().includes(query.toLowerCase()) ||
      (user.departmentName && user.departmentName.toLowerCase().includes(query.toLowerCase()))
    );
    setFilteredUsers(filtered);
  };

  const handleFilterByRole = (roleId: number | null) => {
    if (roleId === null) {
      setFilteredUsers(users);
      return;
    }

    const filtered = users.filter(user => user.rolID === roleId);
    setFilteredUsers(filtered);
  };

  const handleFilterByStatus = (status: boolean | null) => {
    if (status === null) {
      setFilteredUsers(users);
      return;
    }

    const filtered = users.filter(user => user.isActive === status);
    setFilteredUsers(filtered);
  };

  const columns: ColumnDef<User>[] = [
    {
      accessorKey: "name",
      header: "Nombre de Usuario",
      cell: ({ getValue }) => {
        const value = getValue();
        return typeof value === "string" ? value.toUpperCase() : "";
      },
    },
    {
      accessorKey: "rolName",
      header: "Rol",
    },
    {
      accessorKey: "departmentName",
      header: "Departamento",
      cell: ({ getValue }) => {
        const value = getValue();
        return typeof value === "string" && value ? value : "Sin asignar";
      },
    },
    {
      accessorKey: "email",
      header: "Correo Empresarial",
    },
    {
      accessorKey: "pin",
      header: () => (
        <div className="flex items-center gap-2">
          PIN
          <button
            type="button"
            onClick={() => setShowPin(!showPin)}
            className="text-gray-500 hover:text-black"
          >
            {showPin ? <Eye size={16} /> : <EyeOff size={16} />}
          </button>
        </div>
      ),
      cell: ({ getValue }) => {
        const value = getValue();
        if (!value) return "—";
        return showPin ? value : "****";
      },
    },
    {
      accessorKey: "isActive",
      header: "Estatus",
      cell: ({ row }) => (
        <Badge variant="outline" className="text-muted-foreground px-1.5">
          <div className="flex items-center gap-1">
            <div
              className={`w-2 h-2 rounded-full mt-[0.16rem] ${row.original.isActive
                  ? "bg-green-500 dark:bg-green-400"
                  : "bg-red-500 dark:bg-red-400"
                }`}
            ></div>
            {row.original.isActive ? "Activo" : "Inactivo"}
          </div>
        </Badge>
      ),
    },
    {
      id: "acciones",
      header: "Acciones",
      meta: {
        className: "text-center",
      },
      cell: ({ row }) => (
        <ActionCell
          row={row}
          roles={roles}
          departments={departments}
          setUsers={(newUsers) => {
            setUsers(newUsers);
            setFilteredUsers(newUsers);
          }}
        />
      ),
    },
  ];



  return (
    <MainLayout
      breadcrumb={{ title: "Usuarios", subtitle: "Gestión de usuarios" }}
    >
      {() => (
        <div className="flex flex-1 flex-col gap-4 p-4 pt-4">
          {/* Panel de Gestión */}
          <UserManagementPanel
            users={users}
            roles={roles}
            onRefresh={handleRefresh}
            onCreateUser={handleCreateUser}
            onSearch={handleSearch}
            onFilterByRole={handleFilterByRole}
            onFilterByStatus={handleFilterByStatus}
          />

          {/* Tabla de Usuarios */}
          <div className="-mx-4 flex-1 overflow-auto px-4 py-1 lg:flex-row lg:space-x-12 lg:space-y-0">
            <DataTable columns={columns} data={filteredUsers} loading={isLoading} />
          </div>

          {/* Modal de Crear Usuario */}
          <CreateUserModal
            roles={roles}
            departments={departments}
            isOpen={isCreateModalOpen}
            onClose={() => setIsCreateModalOpen(false)}
            onSuccess={handleCreateSuccess}
          />
        </div>
      )}
    </MainLayout>
  );
}
