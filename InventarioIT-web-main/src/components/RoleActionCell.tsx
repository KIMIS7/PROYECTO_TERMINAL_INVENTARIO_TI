import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
import { Edit, Trash2, UserCheck, UserX } from "lucide-react";
import { Role } from "@/types";
import api from "@/lib/api";
import { EditRoleModal } from "./EditRoleModal";
import { ConfirmDialog } from "./ConfirmDialog";
import { useNotifications } from "@/hooks/useNotifications";

interface RoleActionCellProps {
  row: { original: Role };
  setRoles: React.Dispatch<React.SetStateAction<Role[]>>;
  setFilteredRoles: React.Dispatch<React.SetStateAction<Role[]>>;
}

export const RoleActionCell = ({ row, setRoles, setFilteredRoles }: RoleActionCellProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const [isLoading, setIsLoading] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [isDeleteDialogOpen, setIsDeleteDialogOpen] = useState(false);
  const role = row.original;

  const handleEdit = () => {
    setIsEditModalOpen(true);
  };

  const handleEditSave = (updatedRole: Role) => {
    // Actualizar la lista de roles
    setRoles((prevRoles) =>
      prevRoles.map((r) => (r.rolID === updatedRole.rolID ? updatedRole : r))
    );
    setFilteredRoles((prevFilteredRoles) =>
      prevFilteredRoles.map((r) => (r.rolID === updatedRole.rolID ? updatedRole : r))
    );
  };

  const handleDelete = () => {
    setIsDeleteDialogOpen(true);
  };

  const confirmDelete = async () => {
    try {
      setIsLoading(true);
      await api.role.delete(role.rolID);
      
      // Actualizar la lista de roles
      setRoles((prevRoles) => prevRoles.filter((r) => r.rolID !== role.rolID));
      setFilteredRoles((prevFilteredRoles) => prevFilteredRoles.filter((r) => r.rolID !== role.rolID));
      showSuccess("Rol eliminado exitosamente");
      setIsDeleteDialogOpen(false);
    } catch (error: unknown) {
      console.error("Error al eliminar rol:", error);
      
      // Manejo específico de errores
      if (error && typeof error === 'object' && 'response' in error) {
        const response = (error as { response: { status: number; data?: { message?: string; error?: string } } }).response;
        const status = response.status;
        const message = response.data?.message || response.data?.error || 'Error desconocido';
        
        if (status === 404) {
          showWarning("El rol no existe o ya ha sido eliminado.");
        } else if (status === 403) {
          showError("No tienes permisos para eliminar este rol.");
        } else if (status === 409) {
          showError("No se puede eliminar el rol porque tiene usuarios asignados.");
        } else if (status >= 500) {
          showError("Error interno del servidor. Por favor, intenta más tarde.");
        } else {
          showError(`Error al eliminar rol: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else {
        showError("Error inesperado al eliminar el rol.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleToggleStatus = async () => {
    try {
      setIsLoading(true);
      await api.role.updateStatus(role.rolID, !role.isActive);
      
      // Actualizar la lista de roles
      setRoles((prevRoles) =>
        prevRoles.map((r) =>
          r.rolID === role.rolID ? { ...r, isActive: !r.isActive } : r
        )
      );
      setFilteredRoles((prevFilteredRoles) =>
        prevFilteredRoles.map((r) =>
          r.rolID === role.rolID ? { ...r, isActive: !r.isActive } : r
        )
      );
      showSuccess(`Rol ${!role.isActive ? 'habilitado' : 'deshabilitado'} exitosamente`);
    } catch (error: unknown) {
      console.error("Error al cambiar estado del rol:", error);
      
      // Manejo específico de errores
      if (error && typeof error === 'object' && 'response' in error) {
        const response = (error as { response: { status: number; data?: { message?: string; error?: string } } }).response;
        const status = response.status;
        const message = response.data?.message || response.data?.error || 'Error desconocido';
        
        if (status === 404) {
          showWarning("El rol no existe o ha sido eliminado.");
        } else if (status === 403) {
          showError("No tienes permisos para cambiar el estado de este rol.");
        } else if (status >= 500) {
          showError("Error interno del servidor. Por favor, intenta más tarde.");
        } else {
          showError(`Error al cambiar estado: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else {
        showError("Error inesperado al cambiar el estado del rol.");
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
              onClick={handleEdit}
              disabled={isLoading}
              className="h-8 w-8"
              aria-label="Editar rol"
            >
              <Edit className="h-4 w-4" />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Editar rol</p>
          </TooltipContent>
        </Tooltip>

        <Tooltip>
          <TooltipTrigger asChild>
            <Button
              variant="ghost"
              size="icon"
              onClick={handleToggleStatus}
              disabled={isLoading}
              className="h-8 w-8"
              aria-label={role.isActive ? "Deshabilitar rol" : "Habilitar rol"}
            >
              {role.isActive ? (
                <UserX className="h-4 w-4 text-orange-500" />
              ) : (
                <UserCheck className="h-4 w-4 text-green-500" />
              )}
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>{role.isActive ? "Deshabilitar rol" : "Habilitar rol"}</p>
          </TooltipContent>
        </Tooltip>

        <Tooltip>
          <TooltipTrigger asChild>
            <Button
              variant="ghost"
              size="icon"
              onClick={handleDelete}
              disabled={isLoading}
              className="h-8 w-8"
              aria-label="Eliminar rol"
            >
              <Trash2 className="h-4 w-4 text-red-500" />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Eliminar rol</p>
          </TooltipContent>
        </Tooltip>
      </div>

      <EditRoleModal
        role={role}
        isOpen={isEditModalOpen}
        onClose={() => setIsEditModalOpen(false)}
        onSave={handleEditSave}
      />

      <ConfirmDialog
        isOpen={isDeleteDialogOpen}
        onClose={() => setIsDeleteDialogOpen(false)}
        onConfirm={confirmDelete}
        title="Eliminar Rol"
        description={`¿Estás seguro de que quieres eliminar el rol "${role.name}"? Esta acción no se puede deshacer.`}
        confirmText="Eliminar"
        cancelText="Cancelar"
        variant="destructive"
        isLoading={isLoading}
      />
    </>
  );
};
