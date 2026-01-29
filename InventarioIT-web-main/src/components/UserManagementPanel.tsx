import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { 
  Plus, 
  Search, 
  Filter, 
  Download, 
  Upload, 
  RefreshCw,
  Users,
  UserCheck,
  UserX
} from "lucide-react";
import { User, Role } from "@/types";

interface UserManagementPanelProps {
  users: User[];
  roles: Role[];
  onRefresh: () => void;
  onCreateUser: () => void;
  onSearch: (query: string) => void;
  onFilterByRole: (roleId: number | null) => void;
  onFilterByStatus: (status: boolean | null) => void;
}

export const UserManagementPanel = ({
  users,
  roles,
  onRefresh,
  onCreateUser,
  onSearch,
  onFilterByRole,
  onFilterByStatus,
}: UserManagementPanelProps) => {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedRole, setSelectedRole] = useState<number | null>(null);
  const [selectedStatus, setSelectedStatus] = useState<boolean | null>(null);

  const handleSearch = (value: string) => {
    setSearchQuery(value);
    onSearch(value);
  };

  const handleRoleFilter = (roleId: number | null) => {
    setSelectedRole(roleId);
    onFilterByRole(roleId);
  };

  const handleStatusFilter = (status: boolean | null) => {
    setSelectedStatus(status);
    onFilterByStatus(status);
  };

  const activeUsers = users.filter(user => user.isActive).length;
  const inactiveUsers = users.filter(user => !user.isActive).length;
  const totalUsers = users.length;

  return (
    <div className="bg-white rounded-lg border p-4 mb-6">
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        {/* Estadísticas */}
        <div className="flex items-center gap-6">
          <div className="flex items-center gap-2">
            <Users className="h-5 w-5 text-blue-500" />
            <span className="text-sm font-medium">Total:</span>
            <Badge variant="secondary">{totalUsers}</Badge>
          </div>
          <div className="flex items-center gap-2">
            <UserCheck className="h-5 w-5 text-green-500" />
            <span className="text-sm font-medium">Activos:</span>
            <Badge variant="outline" className="text-green-600 border-green-200">
              {activeUsers}
            </Badge>
          </div>
          <div className="flex items-center gap-2">
            <UserX className="h-5 w-5 text-red-500" />
            <span className="text-sm font-medium">Inactivos:</span>
            <Badge variant="outline" className="text-red-600 border-red-200">
              {inactiveUsers}
            </Badge>
          </div>
        </div>

        {/* Acciones */}
        <div className="flex flex-col sm:flex-row gap-2">
          <Button
            onClick={onCreateUser}
            className="flex items-center gap-2"
            size="sm"
          >
            <Plus className="h-4 w-4" />
            Nuevo Usuario
          </Button>
          <Button
            variant="outline"
            onClick={onRefresh}
            className="flex items-center gap-2"
            size="sm"
          >
            <RefreshCw className="h-4 w-4" />
            Actualizar
          </Button>
        </div>
      </div>

      {/* Filtros y Búsqueda */}
      <div className="flex flex-col lg:flex-row gap-4 mt-4 pt-4 border-t">
        {/* Búsqueda */}
        <div className="flex-1">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
            <Input
              placeholder="Buscar usuarios..."
              value={searchQuery}
              onChange={(e) => handleSearch(e.target.value)}
              className="pl-10"
            />
          </div>
        </div>

        {/* Filtro por Rol */}
        <div className="flex items-center gap-2">
          <Filter className="h-4 w-4 text-gray-500" />
          <Select
            value={selectedRole?.toString() || "all"}
            onValueChange={(value) => handleRoleFilter(value === "all" ? null : Number(value))}
          >
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Todos los roles" />
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

        {/* Filtro por Estado */}
        <div className="flex items-center gap-2">
          <Select
            value={selectedStatus === null ? "all" : selectedStatus.toString()}
            onValueChange={(value) => handleStatusFilter(value === "all" ? null : value === "true")}
          >
            <SelectTrigger className="w-[150px]">
              <SelectValue placeholder="Todos los estados" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos los estados</SelectItem>
              <SelectItem value="true">Activos</SelectItem>
              <SelectItem value="false">Inactivos</SelectItem>
            </SelectContent>
          </Select>
        </div>

        {/* Acciones adicionales */}
        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            className="flex items-center gap-2"
            onClick={() => {
              // TODO: Implementar exportación
              console.log("Exportar usuarios");
            }}
          >
            <Download className="h-4 w-4" />
            Exportar
          </Button>
          <Button
            variant="outline"
            size="sm"
            className="flex items-center gap-2"
            onClick={() => {
              // TODO: Implementar importación
              console.log("Importar usuarios");
            }}
          >
            <Upload className="h-4 w-4" />
            Importar
          </Button>
        </div>
      </div>
    </div>
  );
};
