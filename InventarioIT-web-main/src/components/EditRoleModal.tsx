import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Role } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";

interface EditRoleModalProps {
  role: Role;
  isOpen: boolean;
  onClose: () => void;
  onSave: (updatedRole: Role) => void;
}

export const EditRoleModal = ({ role, isOpen, onClose, onSave }: EditRoleModalProps) => {
  const { showSuccess, showError } = useNotifications();
  const [formData, setFormData] = useState({
    name: "",
  });
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  useEffect(() => {
    if (role) {
      setFormData({
        name: role.name || "",
      });
      setErrors({});
    }
  }, [role]);

  const handleInputChange = (field: string, value: string) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
    // Limpiar error del campo cuando el usuario empiece a escribir
    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: "" }));
    }
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.name.trim()) {
      newErrors.name = "El nombre del rol es requerido";
    } else if (formData.name.trim().length < 2) {
      newErrors.name = "El nombre debe tener al menos 2 caracteres";
    } else if (formData.name.trim().length > 100) {
      newErrors.name = "El nombre no puede exceder 100 caracteres";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm() || !role) return;

    try {
      setIsLoading(true);
      await api.role.update(role.rolID, formData);
      
      // Actualizar el rol en la lista
      const updatedRole: Role = {
        ...role,
        name: formData.name,
      };
      
      showSuccess("Rol actualizado exitosamente");
      onSave(updatedRole);
      onClose();
    } catch (error: unknown) {
      console.error("Error al actualizar rol:", error);
      
      // Manejo específico de errores
      if (error && typeof error === 'object' && 'response' in error) {
        const response = (error as { response: { status: number; data?: { message?: string; error?: string } } }).response;
        const status = response.status;
        const message = response.data?.message || response.data?.error || 'Error desconocido';
        
        if (status === 409) {
          // Conflicto - nombre duplicado
          setErrors({ name: "Este nombre de rol ya existe" });
          showError("Este nombre de rol ya existe en el sistema");
        } else if (status === 400) {
          // Bad request - datos inválidos
          showError(`Error de validación: ${message}`);
        } else if (status === 404) {
          // Rol no encontrado
          showError("El rol no existe o ha sido eliminado.");
          onClose();
        } else if (status >= 500) {
          // Error del servidor
          showError("Error interno del servidor. Por favor, intenta más tarde.");
        } else {
          showError(`Error: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        // Error de red
        showError("Error de conexión. Verifica tu internet y vuelve a intentar.");
      } else {
        // Error desconocido
        showError("Error inesperado. Por favor, intenta más tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleClose = () => {
    if (!isLoading) {
      onClose();
    }
  };

  if (!isOpen || !role) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-full max-w-md mx-4">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">Editar Rol</h2>
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
            <Label htmlFor="edit-role-name" className="block text-left mb-2">
              Nombre del Rol
            </Label>
            <Input
              id="edit-role-name"
              type="text"
              value={formData.name}
              onChange={(e) => handleInputChange("name", e.target.value)}
              className={errors.name ? "border-red-500" : ""}
              aria-describedby={errors.name ? "edit-role-name-error" : undefined}
              disabled={isLoading}
              placeholder="Ej: Administrador"
            />
            {errors.name && (
              <p id="edit-role-name-error" className="text-red-500 text-sm mt-1">
                {errors.name}
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
              {isLoading ? "Guardando..." : "Guardar Cambios"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
};
