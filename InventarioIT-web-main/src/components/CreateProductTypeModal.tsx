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

// Categorias fijas para tipos de activo
export const PRODUCT_CATEGORIES = ["Equipo", "Accesorio", "Componente", "Otros"] as const;
export type ProductCategory = (typeof PRODUCT_CATEGORIES)[number];

// Iconos por categoria
const categoryIcons: Record<ProductCategory, React.ReactNode> = {
  "Equipo": <Monitor className="h-5 w-5" />,
  "Accesorio": <Headphones className="h-5 w-5" />,
  "Componente": <Cpu className="h-5 w-5" />,
  "Otros": <Package className="h-5 w-5" />,
};

// Descripciones de categorias
const categoryDescriptions: Record<ProductCategory, string> = {
  "Equipo": "Computadoras, laptops, servidores, impresoras",
  "Accesorio": "Teclados, mouse, monitores, audifonos",
  "Componente": "RAM, discos duros, procesadores, tarjetas",
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
    category: "" as ProductCategory | "",
    group: "",
    subCategory: "",
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

    if (!formData.category) {
      newErrors.category = "La categoria es requerida";
    }

    if (!formData.group.trim()) {
      newErrors.group = "El grupo es requerido";
    }

    if (!formData.subCategory.trim()) {
      newErrors.subCategory = "La subcategoria es requerida";
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
        category: formData.category,
        group: formData.group,
        subCategory: formData.subCategory,
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
          showWarning("Ya existe un tipo de activo con este nombre en esta categoria");
        } else if (status === 400) {
          showError(`Error de validacion: ${message}`);
        } else {
          showError(`Error: ${message}`);
        }
      } else {
        showError("Error inesperado. Por favor, intenta mas tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const resetForm = () => {
    setFormData({
      name: "",
      category: "",
      group: "",
      subCategory: "",
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
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b bg-gradient-to-r from-blue-600 to-blue-700">
          <div className="flex items-center gap-2 text-white">
            <Layers className="h-5 w-5" />
            <h2 className="text-lg font-semibold">Crear Tipo de Activo</h2>
          </div>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleClose}
            disabled={isLoading}
            className="h-8 w-8 text-white hover:bg-white/20"
          >
            <X className="h-4 w-4" />
          </Button>
        </div>

        {/* Formulario */}
        <form onSubmit={handleSubmit} className="p-4 space-y-4">
          {/* Nombre del tipo de activo */}
          <div>
            <Label htmlFor="name" className="text-sm font-medium">
              Nombre del Tipo de Activo *
            </Label>
            <Input
              id="name"
              value={formData.name}
              onChange={(e) => handleInputChange("name", e.target.value)}
              className={errors.name ? "border-red-500" : ""}
              placeholder="Ej: Teclado Mecanico, Laptop Dell, RAM DDR4"
              disabled={isLoading}
            />
            {errors.name && <p className="text-red-500 text-xs mt-1">{errors.name}</p>}
          </div>

          {/* Categoria */}
          <div>
            <Label className="text-sm font-medium">
              Categoria *
            </Label>
            {errors.category && <p className="text-red-500 text-xs mt-1 mb-2">{errors.category}</p>}
            <div className="grid grid-cols-2 gap-2">
              {PRODUCT_CATEGORIES.map((category) => (
                <button
                  key={category}
                  type="button"
                  onClick={() => handleInputChange("category", category)}
                  className={`p-3 rounded-lg border-2 text-left transition-all ${
                    formData.category === category
                      ? "border-blue-500 bg-blue-50"
                      : "border-gray-200 hover:border-gray-300"
                  }`}
                  disabled={isLoading}
                >
                  <div className="flex items-center gap-2">
                    <div className={`${formData.category === category ? "text-blue-600" : "text-gray-500"}`}>
                      {categoryIcons[category]}
                    </div>
                    <div>
                      <p className={`text-sm font-medium ${formData.category === category ? "text-blue-700" : "text-gray-700"}`}>
                        {category}
                      </p>
                      <p className="text-xs text-gray-500">{categoryDescriptions[category]}</p>
                    </div>
                  </div>
                </button>
              ))}
            </div>
          </div>

          {/* Grupo */}
          <div>
            <Label htmlFor="group" className="text-sm font-medium">
              Grupo *
            </Label>
            <Input
              id="group"
              value={formData.group}
              onChange={(e) => handleInputChange("group", e.target.value)}
              className={errors.group ? "border-red-500" : ""}
              placeholder="Ej: Teclados Latino, Workstations, Memoria"
              disabled={isLoading}
            />
            {errors.group && <p className="text-red-500 text-xs mt-1">{errors.group}</p>}
            <p className="text-xs text-gray-500 mt-1">
              Agrupa tipos de activos similares (ej: todos los teclados)
            </p>
          </div>

          {/* Subcategoria */}
          <div>
            <Label htmlFor="subCategory" className="text-sm font-medium">
              Subcategoria *
            </Label>
            <Input
              id="subCategory"
              value={formData.subCategory}
              onChange={(e) => handleInputChange("subCategory", e.target.value)}
              className={errors.subCategory ? "border-red-500" : ""}
              placeholder="Ej: Alambrico, Inalambrico, 15 pulgadas"
              disabled={isLoading}
            />
            {errors.subCategory && <p className="text-red-500 text-xs mt-1">{errors.subCategory}</p>}
            <p className="text-xs text-gray-500 mt-1">
              Especifica caracteristicas del tipo (ej: alambrico vs inalambrico)
            </p>
          </div>
        </form>

        {/* Footer */}
        <div className="flex gap-2 p-4 border-t bg-gray-50">
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
            onClick={handleSubmit}
            disabled={isLoading}
            className="flex-1 bg-blue-600 hover:bg-blue-700"
          >
            {isLoading ? "Creando..." : "Crear Tipo de Activo"}
          </Button>
        </div>
      </div>
    </div>
  );
};
