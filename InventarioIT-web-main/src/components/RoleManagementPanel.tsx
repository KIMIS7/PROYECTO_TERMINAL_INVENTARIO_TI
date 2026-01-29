import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { RefreshCw, Search, Plus } from "lucide-react";
import { Role } from "@/types";

interface RoleManagementPanelProps {
  roles: Role[];
  onRefresh: () => void;
  onCreateRole: () => void;
  onSearch: (searchTerm: string) => void;
  onFilterByStatus: (status: string) => void;
}

export const RoleManagementPanel = ({
  roles,
  onRefresh,
  onCreateRole,
  onSearch,
  onFilterByStatus,
}: RoleManagementPanelProps) => {
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");

  const activeRoles = roles.filter((role) => role.isActive).length;
  const inactiveRoles = roles.filter((role) => !role.isActive).length;

  const handleSearchChange = (value: string) => {
    setSearchTerm(value);
    onSearch(value);
  };

  const handleStatusFilterChange = (value: string) => {
    setStatusFilter(value);
    onFilterByStatus(value);
  };

  return (
    <div className="bg-white rounded-lg shadow p-6 mb-6">
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        {/* Estadísticas */}
        <div className="flex flex-wrap gap-4">
          <div className="text-center">
            <div className="text-2xl font-bold text-blue-600">{roles.length}</div>
            <div className="text-sm text-gray-600">Total de Roles</div>
          </div>
          <div className="text-center">
            <div className="text-2xl font-bold text-green-600">{activeRoles}</div>
            <div className="text-sm text-gray-600">Roles Activos</div>
          </div>
          <div className="text-center">
            <div className="text-2xl font-bold text-gray-600">{inactiveRoles}</div>
            <div className="text-sm text-gray-600">Roles Inactivos</div>
          </div>
        </div>

        {/* Acciones */}
        <div className="flex flex-col sm:flex-row gap-2">
          <Button onClick={onCreateRole} className="flex items-center gap-2">
            <Plus className="h-4 w-4" />
            Nuevo Rol
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
              placeholder="Buscar roles..."
              value={searchTerm}
              onChange={(e) => handleSearchChange(e.target.value)}
              className="pl-10"
            />
          </div>
        </div>
        <div className="w-full sm:w-[200px]">
          <Select value={statusFilter} onValueChange={handleStatusFilterChange}>
            <SelectTrigger>
              <SelectValue placeholder="Filtrar por estado" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos los estados</SelectItem>
              <SelectItem value="active">Solo activos</SelectItem>
              <SelectItem value="inactive">Solo inactivos</SelectItem>
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
      </div>
    </div>
  );
};
