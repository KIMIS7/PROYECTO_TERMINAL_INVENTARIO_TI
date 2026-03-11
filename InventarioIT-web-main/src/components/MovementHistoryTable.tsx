import { useEffect, useState } from "react";
import { Movement, MOVEMENT_TYPE_LABELS, MovementType } from "@/types";
import api from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  ArrowUpCircle,
  ArrowDownCircle,
  RefreshCw,
  HandCoins,
  Pencil,
  Check,
  X,
  Clock,
  User,
  FileText,
  Mail,
} from "lucide-react";
import { toast } from "sonner";

interface MovementHistoryTableProps {
  assetID: number;
  refreshTrigger?: number;
  onMovementUpdated?: () => void;
}

const movementTypeConfig: Record<
  MovementType,
  { color: string; bgColor: string; borderColor: string; icon: React.ReactNode }
> = {
  ALTA: {
    color: "text-green-700",
    bgColor: "bg-green-50",
    borderColor: "border-green-200",
    icon: <ArrowUpCircle className="h-4 w-4" />,
  },
  BAJA: {
    color: "text-red-700",
    bgColor: "bg-red-50",
    borderColor: "border-red-200",
    icon: <ArrowDownCircle className="h-4 w-4" />,
  },
  REASIGNACION: {
    color: "text-blue-700",
    bgColor: "bg-blue-50",
    borderColor: "border-blue-200",
    icon: <RefreshCw className="h-4 w-4" />,
  },
  PRESTAMO: {
    color: "text-amber-700",
    bgColor: "bg-amber-50",
    borderColor: "border-amber-200",
    icon: <HandCoins className="h-4 w-4" />,
  },
};

function formatDate(dateStr: string): string {
  const date = new Date(dateStr);
  return date.toLocaleDateString("es-MX", {
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export const MovementHistoryTable = ({
  assetID,
  refreshTrigger,
  onMovementUpdated,
}: MovementHistoryTableProps) => {
  const [movements, setMovements] = useState<Movement[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [editingID, setEditingID] = useState<number | null>(null);
  const [editDescription, setEditDescription] = useState("");
  const [editResponsible, setEditResponsible] = useState("");
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    if (assetID) {
      loadMovements();
    }
  }, [assetID, refreshTrigger]);

  const loadMovements = async () => {
    try {
      setIsLoading(true);
      const data = await api.movement.getByAssetId(assetID);
      setMovements(data);
    } catch (error) {
      console.error("Error loading movements:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleStartEdit = (movement: Movement) => {
    setEditingID(movement.movementID);
    setEditDescription(movement.description || "");
    setEditResponsible(movement.responsible || "");
  };

  const handleCancelEdit = () => {
    setEditingID(null);
    setEditDescription("");
    setEditResponsible("");
  };

  const handleSaveEdit = async () => {
    if (editingID === null) return;
    try {
      setIsSaving(true);
      await api.movement.update(editingID, {
        description: editDescription,
        responsible: editResponsible,
      });
      toast.success("Movimiento actualizado");
      setEditingID(null);
      loadMovements();
      onMovementUpdated?.();
    } catch (error) {
      console.error("Error updating movement:", error);
      toast.error("Error al actualizar el movimiento");
    } finally {
      setIsSaving(false);
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-32">
        <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  if (movements.length === 0) {
    return (
      <div className="text-center py-8 text-gray-500 text-sm">
        No hay movimientos registrados para este activo.
      </div>
    );
  }

  return (
    <div className="space-y-3">
      {movements.map((movement) => {
        const config =
          movementTypeConfig[movement.movementType] ||
          movementTypeConfig.ALTA;
        const isEditing = editingID === movement.movementID;

        return (
          <div
            key={movement.movementID}
            className={`border rounded-lg overflow-hidden ${config.borderColor}`}
          >
            {/* Header del movimiento */}
            <div
              className={`flex items-center justify-between px-3 py-2 ${config.bgColor}`}
            >
              <span
                className={`inline-flex items-center gap-1.5 text-xs font-semibold ${config.color}`}
              >
                {config.icon}
                {MOVEMENT_TYPE_LABELS[movement.movementType] ||
                  movement.movementType}
              </span>
              <div className="flex items-center gap-1">
                {isEditing ? (
                  <>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-6 w-6"
                      onClick={handleSaveEdit}
                      disabled={isSaving}
                      title="Guardar"
                    >
                      <Check className="h-3.5 w-3.5 text-green-600" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-6 w-6"
                      onClick={handleCancelEdit}
                      disabled={isSaving}
                      title="Cancelar"
                    >
                      <X className="h-3.5 w-3.5 text-red-600" />
                    </Button>
                  </>
                ) : (
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-6 w-6"
                    onClick={() => handleStartEdit(movement)}
                    title="Editar movimiento"
                  >
                    <Pencil className="h-3.5 w-3.5 text-gray-500 hover:text-blue-600" />
                  </Button>
                )}
              </div>
            </div>

            {/* Detalles del movimiento */}
            <div className="bg-white px-3 py-2 space-y-2">
              {/* Descripción */}
              <div className="flex items-start gap-2">
                <FileText className="h-3.5 w-3.5 text-gray-400 mt-0.5 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-[10px] font-medium text-gray-400 uppercase tracking-wide">
                    Descripción
                  </p>
                  {isEditing ? (
                    <Input
                      value={editDescription}
                      onChange={(e) => setEditDescription(e.target.value)}
                      className="h-7 text-xs mt-0.5"
                      placeholder="Descripción del movimiento"
                    />
                  ) : (
                    <p className="text-sm text-gray-700 break-words">
                      {movement.description || "-"}
                    </p>
                  )}
                </div>
              </div>

              {/* Responsable */}
              <div className="flex items-start gap-2">
                <User className="h-3.5 w-3.5 text-gray-400 mt-0.5 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-[10px] font-medium text-gray-400 uppercase tracking-wide">
                    Responsable
                  </p>
                  {isEditing ? (
                    <Input
                      value={editResponsible}
                      onChange={(e) => setEditResponsible(e.target.value)}
                      className="h-7 text-xs mt-0.5"
                      placeholder="Nombre del responsable"
                    />
                  ) : (
                    <p className="text-sm text-gray-700">
                      {movement.responsible || "-"}
                    </p>
                  )}
                </div>
              </div>

              {/* Registrado por */}
              <div className="flex items-start gap-2">
                <Mail className="h-3.5 w-3.5 text-gray-400 mt-0.5 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-[10px] font-medium text-gray-400 uppercase tracking-wide">
                    Registrado por
                  </p>
                  <p className="text-sm text-gray-700">
                    {movement.createdBy || "-"}
                  </p>
                </div>
              </div>

              {/* Fecha */}
              <div className="flex items-start gap-2">
                <Clock className="h-3.5 w-3.5 text-gray-400 mt-0.5 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-[10px] font-medium text-gray-400 uppercase tracking-wide">
                    Fecha
                  </p>
                  <p className="text-sm text-gray-600 font-mono">
                    {formatDate(movement.createdTime)}
                  </p>
                </div>
              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
};
