import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
import { Trash2 } from "lucide-react";
import { RolePermission, Role, DashboardPath } from "@/types";
import api from "@/lib/api";
import { ConfirmDialog } from "./ConfirmDialog";
import { useNotifications } from "@/hooks/useNotifications";
import { AxiosError } from "axios";

interface PermissionActionCellProps {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  row: any;
  setPermissions: React.Dispatch<React.SetStateAction<RolePermission[]>>;
  setFilteredPermissions: React.Dispatch<React.SetStateAction<RolePermission[]>>;
  roles: Role[];
  dashboardPaths: DashboardPath[];
}

// Los permisos del rol administrador estan bloqueados por seguridad.
const isAdminRoleName = (name?: string) => {
  const normalized = name?.trim().toLowerCase();
  return normalized === "administrador" || normalized === "admin";
};

export const PermissionActionCell = ({
  row,
  setPermissions,
  setFilteredPermissions,
  roles,
  dashboardPaths
}: PermissionActionCellProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const [isLoading, setIsLoading] = useState(false);
  const [isDeleteDialogOpen, setIsDeleteDialogOpen] = useState(false);
  const permission = row.original;

  // Nombre del rol: usar el del permiso y, como fallback, buscar en el catalogo.
  const roleName =
    permission.roleName ||
    roles.find((r) => r.rolID === permission.rolID)?.name ||
    "Rol desconocido";
  const pathName =
    dashboardPaths.find((p) => p.dashboarpathID === permission.dashboarpathID)?.name ||
    "Ruta desconocida";
  const isAdmin = isAdminRoleName(roleName);

  const handleDelete = () => {
    if (isAdmin) {
      showWarning("Los permisos del rol Administrador no pueden eliminarse.");
      return;
    }
    setIsDeleteDialogOpen(true);
  };

  const confirmDelete = async () => {
    if (isAdmin) {
      showWarning("Los permisos del rol Administrador no pueden eliminarse.");
      setIsDeleteDialogOpen(false);
      return;
    }
    try {
      setIsLoading(true);
      await api.permission.delete(permission.roldashboardpathID);
      
      // Actualizar la lista de permisos
      setPermissions((prevPermissions) => 
        prevPermissions.filter((p) => p.roldashboardpathID !== permission.roldashboardpathID)
      );
      setFilteredPermissions((prevFilteredPermissions) => 
        prevFilteredPermissions.filter((p) => p.roldashboardpathID !== permission.roldashboardpathID)
      );
      
      showSuccess("Permiso eliminado exitosamente");
      setIsDeleteDialogOpen(false);
    } catch (error: unknown) {
      console.error("Error al eliminar permiso:", error);
      
      // Manejo específico de errores usando AxiosError
      if (error instanceof AxiosError) {
        const status = error.response?.status;
        const message = error.response?.data?.message || error.response?.data?.error || 'Error desconocido';
        
        if (status === 404) {
          showWarning("El permiso no existe o ya ha sido eliminado.");
        } else if (status === 403) {
          showError("No tienes permisos para eliminar este permiso.");
        } else if (status && status >= 500) {
          showError("Error interno del servidor. Por favor, intenta más tarde.");
        } else {
          showError(`Error al eliminar permiso: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else {
        showError("Error inesperado al eliminar el permiso.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <div className="flex items-center justify-center gap-1">
        <Tooltip>
          <TooltipTrigger asChild>
            <Button
              variant="ghost"
              size="icon"
              onClick={handleDelete}
              disabled={isLoading || isAdmin}
              className="h-8 w-8"
              aria-label={
                isAdmin
                  ? "Los permisos del Administrador estan bloqueados"
                  : "Eliminar permiso"
              }
            >
              <Trash2
                className={`h-4 w-4 ${isAdmin ? "text-gray-300" : "text-red-500"}`}
              />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>
              {isAdmin
                ? "Los permisos del Administrador estan bloqueados"
                : "Eliminar permiso"}
            </p>
          </TooltipContent>
        </Tooltip>
      </div>

      <ConfirmDialog
        isOpen={isDeleteDialogOpen}
        onClose={() => setIsDeleteDialogOpen(false)}
        onConfirm={confirmDelete}
        title="Eliminar Permiso"
        description={`¿Estás seguro de que quieres eliminar el permiso del rol "${roleName}" para acceder a "${pathName}"? Esta acción no se puede deshacer.`}
        confirmText="Eliminar"
        cancelText="Cancelar"
        variant="destructive"
        isLoading={isLoading}
      />
    </>
  );
};
