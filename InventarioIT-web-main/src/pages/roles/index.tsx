import { MainLayout } from "@/components/MainLayout";
import { useState, useEffect, useMemo, useCallback } from "react";
import { DataTable } from "@/components/data-table";
import { createColumns } from "@/components/roles-columns";
import { Role } from "@/types";
import api from "@/lib/api";
import { RoleManagementPanel } from "@/components/RoleManagementPanel";
import { CreateRoleModal } from "@/components/CreateRoleModal";
import { useNotifications } from "@/hooks/useNotifications";

export default function RolesPage() {
  const { showError } = useNotifications();
  const [roles, setRoles] = useState<Role[]>([]);
  const [filteredRoles, setFilteredRoles] = useState<Role[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);

  const fetchRoles = useCallback(async () => {
    try {
      setIsLoading(true);
      const data = await api.role.getAll();
      // Transformar los datos para incluir el campo power si no existe
      const transformedData = data.map(role => ({
        ...role,
        power: (role as unknown as { power?: number }).power || 0
      }));
      setRoles(transformedData);
      setFilteredRoles(transformedData);
    } catch (error: unknown) {
      console.error("Error al cargar roles:", error);
      showError("Error al cargar los roles");
    } finally {
      setIsLoading(false);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []); // Remover showError de las dependencias para evitar ciclos infinitos

  useEffect(() => {
    fetchRoles();
  }, [fetchRoles]);

  const handleRefresh = () => {
    fetchRoles();
  };

  const handleCreateRole = () => {
    setIsCreateModalOpen(true);
  };

  const handleCreateSuccess = () => {
    fetchRoles();
  };

  const handleSearch = (searchTerm: string) => {
    if (!searchTerm.trim()) {
      setFilteredRoles(roles);
      return;
    }

    const filtered = roles.filter((role) =>
      role.name.toLowerCase().includes(searchTerm.toLowerCase())
    );
    setFilteredRoles(filtered);
  };

  const handleFilterByStatus = (status: string) => {
    if (status === "all") {
      setFilteredRoles(roles);
      return;
    }

    const isActive = status === "active";
    const filtered = roles.filter((role) => role.isActive === isActive);
    setFilteredRoles(filtered);
  };

  // Los setters de useState son estables y no necesitan estar en las dependencias
  const columns = useMemo(() => createColumns({ setRoles, setFilteredRoles }), []);

  return (
    <MainLayout breadcrumb={{ title: "Roles", subtitle: "Gestión de roles" }}>
      {() => (
        <div className="flex flex-1 flex-col gap-4 p-4 pt-4">
          <RoleManagementPanel
            roles={roles}
            onRefresh={handleRefresh}
            onCreateRole={handleCreateRole}
            onSearch={handleSearch}
            onFilterByStatus={handleFilterByStatus}
          />

          <div className="-mx-4 flex-1 overflow-auto px-4 py-1 lg:flex-row lg:space-x-12 lg:space-y-0">
            <DataTable
              columns={columns}
              data={filteredRoles}
              loading={isLoading}
            />
          </div>

          <CreateRoleModal
            isOpen={isCreateModalOpen}
            onClose={() => setIsCreateModalOpen(false)}
            onSuccess={handleCreateSuccess}
          />
        </div>
      )}
    </MainLayout>
  );
}
