import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Role, DashboardPath } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import { AxiosError } from "axios";

interface AssignPermissionModalProps {
  roles: Role[];
  dashboardPaths: DashboardPath[];
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const AssignPermissionModal = ({ 
  roles, 
  dashboardPaths, 
  isOpen, 
  onClose, 
  onSuccess 
}: AssignPermissionModalProps) => {
  const { showSuccess, showError } = useNotifications();
  const [formData, setFormData] = useState({
    rolID: 0,
    dashboarpathID: 0,
  });
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const handleInputChange = (field: string, value: string) => {
    const numValue = parseInt(value);
    setFormData((prev) => ({ ...prev, [field]: numValue }));
    // Limpiar error del campo cuando el usuario empiece a escribir
    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: "" }));
    }
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.rolID) {
      newErrors.rolID = "Debe seleccionar un rol";
    }

    if (!formData.dashboarpathID) {
      newErrors.dashboarpathID = "Debe seleccionar una ruta";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm()) return;

    try {
      setIsLoading(true);
      console.log("Intentando asignar permiso:", formData);
      await api.permission.assign(formData);
      
      // Reset form
      setFormData({
        rolID: 0,
        dashboarpathID: 0,
      });
      setErrors({});
      
      showSuccess("Permiso asignado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al asignar permiso:", error);
      console.error("Tipo de error:", typeof error);
      console.error("Es AxiosError?", error instanceof AxiosError);
      
      // Manejo específico de errores usando AxiosError
      if (error instanceof AxiosError) {
        const status = error.response?.status;
        const message = error.response?.data?.message || error.response?.data?.error || 'Error desconocido';
        
        console.log("Status:", status);
        console.log("Message:", message);
        console.log("Response data:", error.response?.data);
        
        if (status === 409) {
          // Conflicto - permiso ya existe
          showError("Este permiso ya está asignado al rol seleccionado");
        } else if (status === 400) {
          // Bad request - datos inválidos
          showError(`Error de validación: ${message}`);
        } else if (status === 500) {
          // Error del servidor - verificar si es por permiso duplicado
          if (message.includes("ya está asignado") || message.includes("ya existe")) {
            showError("Este permiso ya está asignado al rol seleccionado");
          } else {
            showError("Error interno del servidor. Por favor, intenta más tarde.");
          }
        } else {
          showError(`Error: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        // Error de red
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else if (error && typeof error === 'object' && 'message' in error) {
        // Error con mensaje
        const errorMessage = (error as { message: string }).message;
        console.log("Error message:", errorMessage);
        showError(`Error: ${errorMessage}`);
      } else {
        // Error desconocido
        console.error("Error desconocido:", error);
        showError("Error inesperado. Por favor, intenta más tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleClose = () => {
    if (!isLoading) {
      setFormData({
        rolID: 0,
        dashboarpathID: 0,
      });
      setErrors({});
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-full max-w-md mx-4">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">Asignar Permiso</h2>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleClose}
            disabled={isLoading}
            className="h-6 w-6"
            aria-label="Cerrar modal"
          >
            ×
          </Button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Label htmlFor="assign-role" className="block text-left mb-2">
              Rol
            </Label>
            <Select 
              value={formData.rolID ? formData.rolID.toString() : "none"} 
              onValueChange={(value) => handleInputChange("rolID", value)}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder="Seleccionar rol" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar rol</SelectItem>
                {roles.map((role) => (
                  <SelectItem key={role.rolID} value={role.rolID.toString()}>
                    {role.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {errors.rolID && (
              <p className="text-red-500 text-sm mt-1">
                {errors.rolID}
              </p>
            )}
          </div>

          <div>
            <Label htmlFor="assign-path" className="block text-left mb-2">
              Módulo/Ruta
            </Label>
            <Select 
              value={formData.dashboarpathID ? formData.dashboarpathID.toString() : "none"} 
              onValueChange={(value) => handleInputChange("dashboarpathID", value)}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder="Seleccionar módulo" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar módulo</SelectItem>
                {dashboardPaths.map((path) => (
                  <SelectItem key={path.dashboarpathID} value={path.dashboarpathID.toString()}>
                    {path.name} ({path.path})
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {errors.dashboarpathID && (
              <p className="text-red-500 text-sm mt-1">
                {errors.dashboarpathID}
              </p>
            )}
          </div>

          <div className="flex gap-2 pt-4">
            <Button
              type="button"
              variant="outline"
              onClick={handleClose}
              disabled={isLoading}
              className="flex-1"
            >
              Cancelar
            </Button>
            <Button type="submit" disabled={isLoading} className="flex-1">
              {isLoading ? "Asignando..." : "Asignar Permiso"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
};
