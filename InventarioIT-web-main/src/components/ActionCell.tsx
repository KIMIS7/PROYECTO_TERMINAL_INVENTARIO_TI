import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
import { Edit, Trash2, UserCheck, UserX } from "lucide-react";
import { User, Role, Department } from "@/types";
import api from "@/lib/api";
import { EditUserModal } from "./EditUserModal";
import { ConfirmDialog } from "./ConfirmDialog";
import { useNotifications } from "@/hooks/useNotifications";

interface ActionCellProps {
  row: {
    original: User;
  };
  roles: Role[];
  departments: Department[];
  setUsers: React.Dispatch<React.SetStateAction<User[]>>;
}

export const ActionCell = ({ row, roles, departments, setUsers }: ActionCellProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const [isLoading, setIsLoading] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [isDeleteDialogOpen, setIsDeleteDialogOpen] = useState(false);
  const user = row.original;

  const handleEdit = () => {
    setIsEditModalOpen(true);
  };

  const handleEditSave = (updatedUser: User) => {
    setUsers((prevUsers) =>
      prevUsers.map((u) => (u.userID === updatedUser.userID ? updatedUser : u))
    );
  };

  const handleDelete = () => {
    setIsDeleteDialogOpen(true);
  };

  const confirmDelete = async () => {
    try {
      setIsLoading(true);
      await api.user.delete(user.userID);
      
      // Actualizar la lista de usuarios
      setUsers((prevUsers) => prevUsers.filter((u) => u.userID !== user.userID));
      showSuccess("Usuario eliminado exitosamente");
      setIsDeleteDialogOpen(false);
    } catch (error: unknown) {
      console.error("Error al eliminar usuario:", error);
      
      // Manejo específico de errores
      if (error && typeof error === 'object' && 'response' in error) {
        const response = (error as { response: { status: number; data?: { message?: string; error?: string } } }).response;
        const status = response.status;
        const message = response.data?.message || response.data?.error || 'Error desconocido';
        
        if (status === 404) {
          showWarning("El usuario no existe o ya ha sido eliminado.");
          // Refrescar la lista para mantener sincronización
          setUsers((prevUsers) => prevUsers.filter((u) => u.userID !== user.userID));
        } else if (status === 403) {
          showError("No tienes permisos para eliminar este usuario.");
        } else if (status >= 500) {
          showError("Error interno del servidor. Por favor, intenta más tarde.");
        } else {
          showError(`Error al eliminar usuario: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else {
        showError("Error inesperado al eliminar el usuario.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleToggleStatus = async () => {
    try {
      setIsLoading(true);
      await api.user.updateStatus(user.userID, !user.isActive);
      
      // Actualizar la lista de usuarios
      setUsers((prevUsers) =>
        prevUsers.map((u) =>
          u.userID === user.userID ? { ...u, isActive: !u.isActive } : u
        )
      );
      showSuccess(`Usuario ${!user.isActive ? 'habilitado' : 'deshabilitado'} exitosamente`);
    } catch (error: unknown) {
      console.error("Error al cambiar estado del usuario:", error);
      
      // Manejo específico de errores
      if (error && typeof error === 'object' && 'response' in error) {
        const response = (error as { response: { status: number; data?: { message?: string; error?: string } } }).response;
        const status = response.status;
        const message = response.data?.message || response.data?.error || 'Error desconocido';
        
        if (status === 404) {
          showWarning("El usuario no existe o ha sido eliminado.");
        } else if (status === 403) {
          showError("No tienes permisos para cambiar el estado de este usuario.");
        } else if (status >= 500) {
          showError("Error interno del servidor. Por favor, intenta más tarde.");
        } else {
          showError(`Error al cambiar estado: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else {
        showError("Error inesperado al cambiar el estado del usuario.");
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
              aria-label="Editar usuario"
            >
              <Edit className="h-4 w-4" />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Editar usuario</p>
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
              aria-label={user.isActive ? "Deshabilitar usuario" : "Habilitar usuario"}
            >
              {user.isActive ? (
                <UserX className="h-4 w-4 text-orange-500" />
              ) : (
                <UserCheck className="h-4 w-4 text-green-500" />
              )}
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>{user.isActive ? "Deshabilitar usuario" : "Habilitar usuario"}</p>
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
              aria-label="Eliminar usuario"
            >
              <Trash2 className="h-4 w-4 text-red-500" />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Eliminar usuario</p>
          </TooltipContent>
        </Tooltip>
      </div>

      <EditUserModal
        user={user}
        roles={roles}
        departments={departments}
        isOpen={isEditModalOpen}
        onClose={() => setIsEditModalOpen(false)}
        onSave={handleEditSave}
      />

      <ConfirmDialog
        isOpen={isDeleteDialogOpen}
        onClose={() => setIsDeleteDialogOpen(false)}
        onConfirm={confirmDelete}
        title="Eliminar Usuario"
        description={`¿Estás seguro de que quieres eliminar al usuario "${user.name}"? Esta acción no se puede deshacer.`}
        confirmText="Eliminar"
        cancelText="Cancelar"
        variant="destructive"
        isLoading={isLoading}
      />
    </>
  );
};
