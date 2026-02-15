import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Asset, MOVEMENT_TYPES, MOVEMENT_TYPE_LABELS, MovementType } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import { ArrowRightLeft } from "lucide-react";

interface CreateMovementModalProps {
  assets: Asset[];
  preselectedAssetID?: number;
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const CreateMovementModal = ({
  assets,
  preselectedAssetID,
  isOpen,
  onClose,
  onSuccess,
}: CreateMovementModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();

  const [formData, setFormData] = useState({
    assetID: preselectedAssetID || 0,
    movementType: "" as MovementType | "",
    description: "",
    responsible: "",
  });

  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const handleInputChange = (field: string, value: string | number) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: "" }));
    }
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.assetID) {
      newErrors.assetID = "El activo es requerido";
    }

    if (!formData.movementType) {
      newErrors.movementType = "El tipo de movimiento es requerido";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      showWarning("Por favor completa los campos requeridos");
      return;
    }

    try {
      setIsLoading(true);

      await api.movement.create({
        assetID: formData.assetID,
        movementType: formData.movementType as MovementType,
        description: formData.description || undefined,
        responsible: formData.responsible || undefined,
      });

      resetForm();
      showSuccess("Movimiento registrado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al registrar movimiento:", error);

      if (error && typeof error === "object" && "response" in error) {
        const axiosError = error as {
          response: { status: number; data: { message?: string } };
        };
        const message =
          axiosError.response.data?.message || "Error desconocido";
        showError(`Error: ${message}`);
      } else {
        showError("Error inesperado. Por favor, intenta mas tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const resetForm = () => {
    setFormData({
      assetID: preselectedAssetID || 0,
      movementType: "",
      description: "",
      responsible: "",
    });
    setErrors({});
  };

  const handleClose = () => {
    if (!isLoading) {
      resetForm();
      onClose();
    }
  };

  const getMovementTypeDescription = (type: MovementType): string => {
    const descriptions: Record<MovementType, string> = {
      ALTA: "Registra el activo como activo en el sistema",
      BAJA: "Marca el activo como inactivo/dado de baja",
      REASIGNACION: "Reasigna el activo a otro responsable",
      PRESTAMO: "Registra un prestamo temporal del activo",
    };
    return descriptions[type];
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-lg max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b">
          <div className="flex items-center gap-2">
            <ArrowRightLeft className="h-5 w-5 text-blue-600" />
            <h2 className="text-lg font-semibold">Registrar Movimiento</h2>
          </div>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleClose}
            disabled={isLoading}
            className="h-8 w-8"
          >
            X
          </Button>
        </div>

        {/* Formulario */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-4">
          <div className="space-y-4">
            {/* Activo */}
            <div>
              <Label htmlFor="assetID" className="text-sm font-medium">
                Activo *
              </Label>
              <Select
                value={formData.assetID ? formData.assetID.toString() : "none"}
                onValueChange={(value) =>
                  handleInputChange(
                    "assetID",
                    value === "none" ? 0 : Number(value)
                  )
                }
                disabled={isLoading || !!preselectedAssetID}
              >
                <SelectTrigger
                  className={errors.assetID ? "border-red-500" : ""}
                >
                  <SelectValue placeholder="Seleccionar activo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="none">Seleccionar activo</SelectItem>
                  {assets.map((asset) => (
                    <SelectItem
                      key={asset.assetID}
                      value={asset.assetID.toString()}
                    >
                      {asset.name}{" "}
                      {asset.assetDetail?.serialNum
                        ? `(${asset.assetDetail.serialNum})`
                        : ""}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              {errors.assetID && (
                <p className="text-red-500 text-xs mt-1">{errors.assetID}</p>
              )}
            </div>

            {/* Tipo de Movimiento */}
            <div>
              <Label htmlFor="movementType" className="text-sm font-medium">
                Tipo de Movimiento *
              </Label>
              <Select
                value={formData.movementType || "none"}
                onValueChange={(value) =>
                  handleInputChange(
                    "movementType",
                    value === "none" ? "" : value
                  )
                }
                disabled={isLoading}
              >
                <SelectTrigger
                  className={errors.movementType ? "border-red-500" : ""}
                >
                  <SelectValue placeholder="Seleccionar tipo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="none">Seleccionar tipo</SelectItem>
                  {MOVEMENT_TYPES.map((type) => (
                    <SelectItem key={type} value={type}>
                      {MOVEMENT_TYPE_LABELS[type]}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              {errors.movementType && (
                <p className="text-red-500 text-xs mt-1">
                  {errors.movementType}
                </p>
              )}
              {formData.movementType && (
                <p className="text-xs text-gray-500 mt-1">
                  {getMovementTypeDescription(
                    formData.movementType as MovementType
                  )}
                </p>
              )}
            </div>

            {/* Responsable */}
            <div>
              <Label htmlFor="responsible" className="text-sm font-medium">
                Responsable
              </Label>
              <Input
                id="responsible"
                value={formData.responsible}
                onChange={(e) =>
                  handleInputChange("responsible", e.target.value)
                }
                placeholder="Nombre del responsable del movimiento"
                disabled={isLoading}
              />
            </div>

            {/* Descripcion */}
            <div>
              <Label htmlFor="description" className="text-sm font-medium">
                Descripcion
              </Label>
              <Textarea
                id="description"
                value={formData.description}
                onChange={(e) =>
                  handleInputChange("description", e.target.value)
                }
                placeholder="Descripcion o motivo del movimiento"
                disabled={isLoading}
                rows={3}
              />
            </div>
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
            {isLoading ? "Registrando..." : "Registrar Movimiento"}
          </Button>
        </div>
      </div>
    </div>
  );
};
