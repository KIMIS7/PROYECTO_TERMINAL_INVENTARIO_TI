import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { RefreshCw, Search, Plus, Shield } from "lucide-react";
import { Role, DashboardPath, RolePermission } from "@/types";

interface PermissionManagementPanelProps {
  permissions: RolePermission[];
  roles: Role[];
  dashboardPaths: DashboardPath[];
  onRefresh: () => void;
  onAssignPermission: () => void;
  onSearch: (searchTerm: string) => void;
  onFilterByRole: (roleId: number | null) => void;
  onFilterByPath: (pathId: number | null) => void;
}

export const PermissionManagementPanel = ({
  permissions,
  roles,
  dashboardPaths,
  onRefresh,
  onAssignPermission,
  onSearch,
  onFilterByRole,
  onFilterByPath,
}: PermissionManagementPanelProps) => {
  const [searchTerm, setSearchTerm] = useState("");
  const [roleFilter, setRoleFilter] = useState("all");
  const [pathFilter, setPathFilter] = useState("all");

  const totalPermissions = permissions.length;
  const uniqueRoles = new Set(permissions.map(p => p.rolID)).size;
  const uniquePaths = new Set(permissions.map(p => p.dashboarpathID)).size;

  const handleSearchChange = (value: string) => {
    setSearchTerm(value);
    onSearch(value);
  };

  const handleRoleFilterChange = (value: string) => {
    setRoleFilter(value);
    const roleId = value === "all" ? null : parseInt(value);
    onFilterByRole(roleId);
  };

  const handlePathFilterChange = (value: string) => {
    setPathFilter(value);
    const pathId = value === "all" ? null : parseInt(value);
    onFilterByPath(pathId);
  };

  return (
    <div className="bg-white rounded-lg shadow p-6 mb-6">
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        {/* Estadísticas */}
        <div className="flex flex-wrap gap-4">
          <div className="text-center">
            <div className="text-2xl font-bold text-blue-600">{totalPermissions}</div>
            <div className="text-sm text-gray-600">Total de Permisos</div>
          </div>
          <div className="text-center">
            <div className="text-2xl font-bold text-green-600">{uniqueRoles}</div>
            <div className="text-sm text-gray-600">Roles con Permisos</div>
          </div>
          <div className="text-center">
            <div className="text-2xl font-bold text-purple-600">{uniquePaths}</div>
            <div className="text-sm text-gray-600">Rutas Asignadas</div>
          </div>
        </div>

        {/* Acciones */}
        <div className="flex flex-col sm:flex-row gap-2">
          <Button onClick={onAssignPermission} className="flex items-center gap-2">
            <Plus className="h-4 w-4" />
            Asignar Permiso
          </Button>
          <Button variant="outline" onClick={onRefresh} className="flex items-center gap-2">
            <RefreshCw className="h-4 w-4" />
            Actualizar
          </Button>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex flex-col sm:flex-row gap-4 mt-6">
        <div className="flex-1">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
            <Input
              placeholder="Buscar permisos..."
              value={searchTerm}
              onChange={(e) => handleSearchChange(e.target.value)}
              className="pl-10"
            />
          </div>
        </div>
        <div className="w-full sm:w-[200px]">
          <Select value={roleFilter} onValueChange={handleRoleFilterChange}>
            <SelectTrigger>
              <SelectValue placeholder="Filtrar por rol" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos los roles</SelectItem>
              {roles.map((role) => (
                <SelectItem key={role.rolID} value={role.rolID.toString()}>
                  {role.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div className="w-full sm:w-[200px]">
          <Select value={pathFilter} onValueChange={handlePathFilterChange}>
            <SelectTrigger>
              <SelectValue placeholder="Filtrar por ruta" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todas las rutas</SelectItem>
              {dashboardPaths.map((path) => (
                <SelectItem key={path.dashboarpathID} value={path.dashboarpathID.toString()}>
                  {path.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      {/* Botones adicionales (placeholder) */}
      <div className="flex gap-2 mt-4">
        <Button variant="outline" size="sm" disabled>
          Exportar
        </Button>
        <Button variant="outline" size="sm" disabled>
          Importar
        </Button>
        <Button variant="outline" size="sm" disabled>
          <Shield className="h-4 w-4 mr-2" />
          Ver Logs
        </Button>
      </div>
    </div>
  );
};
