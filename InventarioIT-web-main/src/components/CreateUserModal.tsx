import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Role, Department } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";

interface CreateUserModalProps {
  roles: Role[];
  departments: Department[];
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const CreateUserModal = ({ roles, departments, isOpen, onClose, onSuccess }: CreateUserModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    rolID: 0,
    DepartmentID: 0,
  });
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const handleInputChange = (field: string, value: string | number) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: "" }));
    }
  };

  // Función mejorada para validar email
  const validateEmail = (email: string): string | null => {
    if (!email.trim()) {
      return "El email es requerido";
    }

    // Expresión regular más robusta para validar email
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    
    if (!emailRegex.test(email)) {
      return "El formato del email no es válido";
    }

    // Validaciones adicionales
    if (email.length > 254) {
      return "El email es demasiado largo";
    }

    if (email.includes("..") || email.includes("--")) {
      return "El email contiene caracteres inválidos";
    }

    // Validar que no empiece o termine con punto
    if (email.startsWith(".") || email.endsWith(".")) {
      return "El email no puede empezar o terminar con punto";
    }

    return null;
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.name.trim()) {
      newErrors.name = "El nombre es requerido";
    }

    // Usar la nueva función de validación de email
    const emailError = validateEmail(formData.email);
    if (emailError) {
      newErrors.email = emailError;
    }

    if (!formData.rolID) {
      newErrors.rolID = "El rol es requerido";
    }

    if (!formData.DepartmentID) {
      newErrors.DepartmentID = "El departamento es requerido";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) return;

    try {
      setIsLoading(true);
      await api.user.create(formData);
      
      // Reset form
      setFormData({
        name: "",
        email: "",
        rolID: 0,
        DepartmentID: 0,
      });
      setErrors({});
      
      showSuccess("Usuario creado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al crear usuario:", error);
      
      // Manejo específico de errores
      if (error && typeof error === 'object' && 'response' in error) {
        const axiosError = error as { response: { status: number; data: { message?: string; error?: string } } };
        const status = axiosError.response.status;
        const message = axiosError.response.data?.message || axiosError.response.data?.error || 'Error desconocido';
        
        if (status === 409) {
          // Conflicto - email duplicado
          setErrors({ email: "Este email ya está registrado" });
          showWarning("Este email ya está registrado en el sistema");
        } else if (status === 400) {
          // Bad request - datos inválidos
          showError(`Error de validación: ${message}`);
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
      setFormData({
        name: "",
        email: "",
        rolID: 0,
        DepartmentID: 0,
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
          <h2 className="text-lg font-semibold">Crear Nuevo Usuario</h2>
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
            <Label htmlFor="create-name" className="block text-left mb-2">Nombre</Label>
            <Input
              id="create-name"
              type="text"
              value={formData.name}
              onChange={(e) => handleInputChange("name", e.target.value)}
              className={errors.name ? "border-red-500" : ""}
              aria-describedby={errors.name ? "create-name-error" : undefined}
              disabled={isLoading}
            />
            {errors.name && (
              <p id="create-name-error" className="text-red-500 text-sm mt-1">
                {errors.name}
              </p>
            )}
          </div>

          <div>
            <Label htmlFor="create-email" className="block text-left mb-2">Email</Label>
            <Input
              id="create-email"
              type="email"
              value={formData.email}
              onChange={(e) => handleInputChange("email", e.target.value)}
              className={errors.email ? "border-red-500" : ""}
              aria-describedby={errors.email ? "create-email-error" : undefined}
              disabled={isLoading}
              placeholder="ejemplo@correo.com"
            />
            {errors.email && (
              <p id="create-email-error" className="text-red-500 text-sm mt-1">
                {errors.email}
              </p>
            )}
          </div>

          <div>
            <Label htmlFor="create-rolID" className="block text-left mb-2">Rol</Label>
            <Select
              value={formData.rolID ? formData.rolID.toString() : "none"}
              onValueChange={(value) => handleInputChange("rolID", value === "none" ? 0 : Number(value))}
              disabled={isLoading}
            >
              <SelectTrigger className={`w-full ${errors.rolID ? "border-red-500" : ""}`}>
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
              <p id="create-rolID-error" className="text-red-500 text-sm mt-1">
                {errors.rolID}
              </p>
            )}
          </div>

          <div>
            <Label htmlFor="create-departmentID" className="block text-left mb-2">Departamento</Label>
            <Select
              value={formData.DepartmentID ? formData.DepartmentID.toString() : "none"}
              onValueChange={(value) => handleInputChange("DepartmentID", value === "none" ? 0 : Number(value))}
              disabled={isLoading}
            >
              <SelectTrigger className={`w-full ${errors.DepartmentID ? "border-red-500" : ""}`}>
                <SelectValue placeholder="Seleccionar departamento" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar departamento</SelectItem>
                {departments.map((dept) => (
                  <SelectItem key={dept.departID} value={dept.departID.toString()}>
                    {dept.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {errors.DepartmentID && (
              <p id="create-departmentID-error" className="text-red-500 text-sm mt-1">
                {errors.DepartmentID}
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
            <Button
              type="submit"
              disabled={isLoading}
              className="flex-1"
            >
              {isLoading ? "Creando..." : "Crear Usuario"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
};
