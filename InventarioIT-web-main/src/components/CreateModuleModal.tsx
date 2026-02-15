import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import { AxiosError } from "axios";

interface CreateModuleModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const CreateModuleModal = ({
  isOpen,
  onClose,
  onSuccess,
}: CreateModuleModalProps) => {
  const { showSuccess, showError } = useNotifications();
  const [formData, setFormData] = useState({ path: "", name: "" });
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.name.trim()) {
      newErrors.name = "El nombre es requerido";
    }

    if (!formData.path.trim()) {
      newErrors.path = "La ruta es requerida";
    } else if (!formData.path.startsWith("/")) {
      newErrors.path = "La ruta debe comenzar con /";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) return;

    try {
      setIsLoading(true);
      await api.dashboardPath.create({
        path: formData.path.trim(),
        name: formData.name.trim(),
      });

      setFormData({ path: "", name: "" });
      setErrors({});
      showSuccess("Módulo creado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      if (error instanceof AxiosError) {
        const status = error.response?.status;
        if (status === 409) {
          showError("Ya existe un módulo con esa ruta");
        } else {
          const message =
            error.response?.data?.message || "Error al crear el módulo";
          showError(message);
        }
      } else {
        showError("Error inesperado. Por favor, intenta más tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleClose = () => {
    if (!isLoading) {
      setFormData({ path: "", name: "" });
      setErrors({});
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-full max-w-md mx-4">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">Agregar Módulo</h2>
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
            <Label htmlFor="module-name" className="block text-left mb-2">
              Nombre del módulo
            </Label>
            <Input
              id="module-name"
              placeholder="Ej: Movimientos"
              value={formData.name}
              onChange={(e) => {
                setFormData((prev) => ({ ...prev, name: e.target.value }));
                if (errors.name) setErrors((prev) => ({ ...prev, name: "" }));
              }}
              disabled={isLoading}
            />
            {errors.name && (
              <p className="text-red-500 text-sm mt-1">{errors.name}</p>
            )}
          </div>

          <div>
            <Label htmlFor="module-path" className="block text-left mb-2">
              Ruta
            </Label>
            <Input
              id="module-path"
              placeholder="Ej: /movimientos"
              value={formData.path}
              onChange={(e) => {
                setFormData((prev) => ({ ...prev, path: e.target.value }));
                if (errors.path) setErrors((prev) => ({ ...prev, path: "" }));
              }}
              disabled={isLoading}
            />
            {errors.path && (
              <p className="text-red-500 text-sm mt-1">{errors.path}</p>
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
              {isLoading ? "Creando..." : "Crear Módulo"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
};
