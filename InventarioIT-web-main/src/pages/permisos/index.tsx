import { MainLayout } from "@/components/MainLayout";
import { useState, useEffect, useMemo, useCallback } from "react";
import { DataTable } from "@/components/data-table";
import { createPermissionColumns } from "@/components/permisos-columns";
import { Role, DashboardPath, RolePermission } from "@/types";
import api from "@/lib/api";
import { PermissionManagementPanel } from "@/components/PermissionManagementPanel";
import { AssignPermissionModal } from "@/components/AssignPermissionModal";
import { CreateModuleModal } from "@/components/CreateModuleModal";
import { useNotifications } from "@/hooks/useNotifications";

export default function PermisosPage() {
  const { showError } = useNotifications();
  const [roles, setRoles] = useState<Role[]>([]);
  const [dashboardPaths, setDashboardPaths] = useState<DashboardPath[]>([]);
  const [permissions, setPermissions] = useState<RolePermission[]>([]);
  const [filteredPermissions, setFilteredPermissions] = useState<RolePermission[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isAssignModalOpen, setIsAssignModalOpen] = useState(false);
  const [isModuleModalOpen, setIsModuleModalOpen] = useState(false);

  const fetchData = useCallback(async () => {
    try {
      setIsLoading(true);
      const [rolesData, pathsData, permissionsData] = await Promise.all([
        api.role.getAll(),
        api.dashboardPath.getAll(),
        api.permission.getAll()
      ]);

      // Transformar roles para incluir power
      const transformedRoles = rolesData.map(role => ({
        ...role,
        power: (role as unknown as { power?: number }).power || 0
      }));

      setRoles(transformedRoles);
      setDashboardPaths(pathsData);
      setPermissions(permissionsData);
      setFilteredPermissions(permissionsData);
    } catch (error: unknown) {
      console.error("Error al cargar datos:", error);
      showError("Error al cargar los datos");
    } finally {
      setIsLoading(false);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []); // Remover showError de las dependencias para evitar ciclos infinitos

  useEffect(() => {
    fetchData();
  }, [fetchData]); 

  const handleRefresh = () => {
    fetchData();
  };

  const handleAssignPermission = () => {
    setIsAssignModalOpen(true);
  };

  const handleAddModule = () => {
    setIsModuleModalOpen(true);
  };

  const handleAssignSuccess = () => {
    fetchData();
  };

  const handleModuleSuccess = () => {
    fetchData();
  };

  const handleSearch = (searchTerm: string) => {
    if (!searchTerm.trim()) {
      setFilteredPermissions(permissions);
      return;
    }

    const filtered = permissions.filter((permission) =>
      permission.roleName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      permission.pathName.toLowerCase().includes(searchTerm.toLowerCase())
    );
    setFilteredPermissions(filtered);
  };

  const handleFilterByRole = (roleId: number | null) => {
    if (roleId === null) {
      setFilteredPermissions(permissions);
      return;
    }

    const filtered = permissions.filter((permission) => permission.rolID === roleId);
    setFilteredPermissions(filtered);
  };

  const handleFilterByPath = (pathId: number | null) => {
    if (pathId === null) {
      setFilteredPermissions(permissions);
      return;
    }

    const filtered = permissions.filter((permission) => permission.dashboarpathID === pathId);
    setFilteredPermissions(filtered);
  };

  const columns = useMemo(() => 
    createPermissionColumns({ 
      setPermissions, 
      setFilteredPermissions,
      roles,
      dashboardPaths 
    }), 
    [setPermissions, setFilteredPermissions, roles, dashboardPaths]
  );

  return (
    <MainLayout breadcrumb={{ title: "Permisos", subtitle: "Gestión de permisos por rol" }}>
      {() => (
        <div className="flex flex-1 flex-col gap-4 p-4 pt-4">
          <PermissionManagementPanel
            permissions={permissions}
            roles={roles}
            dashboardPaths={dashboardPaths}
            onRefresh={handleRefresh}
            onAssignPermission={handleAssignPermission}
            onAddModule={handleAddModule}
            onSearch={handleSearch}
            onFilterByRole={handleFilterByRole}
            onFilterByPath={handleFilterByPath}
          />

          <div className="-mx-4 flex-1 overflow-auto px-4 py-1 lg:flex-row lg:space-x-12 lg:space-y-0">
            <DataTable
              columns={columns}
              data={filteredPermissions}
              loading={isLoading}
            />
          </div>

          <AssignPermissionModal
            roles={roles}
            dashboardPaths={dashboardPaths}
            isOpen={isAssignModalOpen}
            onClose={() => setIsAssignModalOpen(false)}
            onSuccess={handleAssignSuccess}
          />

          <CreateModuleModal
            isOpen={isModuleModalOpen}
            onClose={() => setIsModuleModalOpen(false)}
            onSuccess={handleModuleSuccess}
          />
        </div>
      )}
    </MainLayout>
  );
}
