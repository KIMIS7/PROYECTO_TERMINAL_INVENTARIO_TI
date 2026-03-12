import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import {
  Monitor,
  Headphones,
  Cpu,
  Package,
  X,
  Layers,
} from "lucide-react";

export const PRODUCT_GROUPS = ["Equipo", "Accesorio", "Componente", "Otros"] as const;
export type ProductGroup = (typeof PRODUCT_GROUPS)[number];

const groupIcons: Record<ProductGroup, React.ReactNode> = {
  "Equipo": <Monitor className="h-5 w-5" />,
  "Accesorio": <Headphones className="h-5 w-5" />,
  "Componente": <Cpu className="h-5 w-5" />,
  "Otros": <Package className="h-5 w-5" />,
};

const groupDescriptions: Record<ProductGroup, string> = {
  "Equipo": "Computadoras, laptops, servidores",
  "Accesorio": "Teclados, mouse, monitores, audifonos, impresoras",
  "Componente": "RAM, discos duros, procesadores",
  "Otros": "Cualquier otro tipo de activo",
};

interface CreateProductTypeModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: (newProductType: {
    productTypeID: number;
    name: string;
    category: string;
    group: string;
    subCategory: string;
  }) => void;
}

export const CreateProductTypeModal = ({
  isOpen,
  onClose,
  onSuccess,
}: CreateProductTypeModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();

  const [formData, setFormData] = useState({
    name: "",
    group: "" as ProductGroup | "",
  });

  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const handleInputChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: "" }));
    }
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.name.trim()) {
      newErrors.name = "El nombre es requerido";
    }

    if (!formData.group) {
      newErrors.group = "El grupo es requerido";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      showWarning("Por favor completa todos los campos requeridos");
      return;
    }

    try {
      setIsLoading(true);

      const response = await api.productType.create({
        name: formData.name,
        group: formData.group,
      });

      showSuccess("Tipo de activo creado exitosamente");
      resetForm();
      onSuccess(response.data);
      onClose();
    } catch (error: unknown) {
      console.error("Error al crear tipo de activo:", error);

      if (error && typeof error === "object" && "response" in error) {
        const axiosError = error as { response: { status: number; data: { message?: string } } };
        const status = axiosError.response.status;
        const message = axiosError.response.data?.message || "Error desconocido";

        if (status === 409) {
          showWarning("Ya existe un tipo de activo con este nombre en esta categoría");
        } else if (status === 400) {
          showError(`Error de validación: ${message}`);
        } else {
          showError(`Error: ${message}`);
        }
      } else {
        showError("Error inesperado. Por favor, intenta más tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const resetForm = () => {
    setFormData({
      name: "",
      group: "",
    });
    setErrors({});
  };

  const handleClose = () => {
    if (!isLoading) {
      resetForm();
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-[60] p-4">
      <div className="bg-white rounded-lg w-full max-w-lg overflow-hidden flex flex-col">
        <div className="flex items-center justify-between p-4 border-b bg-gradient-to-r from-blue-600 to-blue-700">
          <div className="flex items-center gap-2 text-white">
            <Layers className="h-5 w-5" />
            <h2 className="text-lg font-semibold">Crear Tipo de Activo</h2>
          </div>
          <Button variant="ghost" size="icon" onClick={handleClose} disabled={isLoading} className="h-8 w-8 text-white hover:bg-white/20">
            <X className="h-4 w-4" />
          </Button>
        </div>

        <form onSubmit={handleSubmit} className="p-4 space-y-4">
          <div>
            <Label htmlFor="name" className="text-sm font-medium">Nombre del Tipo de Activo *</Label>
            <Input id="name" value={formData.name} onChange={(e) => handleInputChange("name", e.target.value)} className={errors.name ? "border-red-500" : ""} placeholder="Ej: Teclado Mecánico, Laptop Dell, RAM DDR4" disabled={isLoading} />
            {errors.name && <p className="text-red-500 text-xs mt-1">{errors.name}</p>}
          </div>

          <div>
            <Label className="text-sm font-medium">Grupo *</Label>
            {errors.group && <p className="text-red-500 text-xs mt-1 mb-2">{errors.group}</p>}
            <div className="grid grid-cols-2 gap-2">
              {PRODUCT_GROUPS.map((group) => (
                <button
                  key={group} type="button" onClick={() => handleInputChange("group", group)}
                  className={`p-3 rounded-lg border-2 text-left transition-all ${formData.group === group ? "border-blue-500 bg-blue-50" : "border-gray-200 hover:border-gray-300"}`} disabled={isLoading}
                >
                  <div className="flex items-center gap-2">
                    <div className={`${formData.group === group ? "text-blue-600" : "text-gray-500"}`}>{groupIcons[group]}</div>
                    <div>
                      <p className={`text-sm font-medium ${formData.group === group ? "text-blue-700" : "text-gray-700"}`}>{group}</p>
                      <p className="text-xs text-gray-500">{groupDescriptions[group]}</p>
                    </div>
                  </div>
                </button>
              ))}
            </div>
          </div>

        </form>

        <div className="flex gap-2 p-4 border-t bg-gray-50">
          <Button type="button" variant="outline" onClick={handleClose} disabled={isLoading} className="flex-1">Cancelar</Button>
          <Button type="submit" onClick={handleSubmit} disabled={isLoading} className="flex-1 bg-blue-600 hover:bg-blue-700">
            {isLoading ? "Creando..." : "Crear Tipo de Activo"}
          </Button>
        </div>
      </div>
    </div>
  );
};