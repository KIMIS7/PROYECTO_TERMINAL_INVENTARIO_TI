import { useEffect, useState } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Movement, MOVEMENT_TYPE_LABELS, MovementType } from "@/types";
import api from "@/lib/api";
import { ArrowUpCircle, ArrowDownCircle, RefreshCw, HandCoins } from "lucide-react";

interface MovementHistoryTableProps {
  assetID: number;
  refreshTrigger?: number;
}

const movementTypeConfig: Record<
  MovementType,
  { color: string; bgColor: string; icon: React.ReactNode }
> = {
  ALTA: {
    color: "text-green-700",
    bgColor: "bg-green-100",
    icon: <ArrowUpCircle className="h-4 w-4" />,
  },
  BAJA: {
    color: "text-red-700",
    bgColor: "bg-red-100",
    icon: <ArrowDownCircle className="h-4 w-4" />,
  },
  REASIGNACION: {
    color: "text-blue-700",
    bgColor: "bg-blue-100",
    icon: <RefreshCw className="h-4 w-4" />,
  },
  PRESTAMO: {
    color: "text-amber-700",
    bgColor: "bg-amber-100",
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
}: MovementHistoryTableProps) => {
  const [movements, setMovements] = useState<Movement[]>([]);
  const [isLoading, setIsLoading] = useState(false);

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
    <div className="border rounded-lg overflow-hidden">
      <Table>
        <TableHeader className="bg-gray-50">
          <TableRow>
            <TableHead className="font-semibold text-gray-700 w-40">
              Tipo
            </TableHead>
            <TableHead className="font-semibold text-gray-700">
              Descripcion
            </TableHead>
            <TableHead className="font-semibold text-gray-700 w-40">
              Responsable
            </TableHead>
            <TableHead className="font-semibold text-gray-700 w-32">
              Registrado por
            </TableHead>
            <TableHead className="font-semibold text-gray-700 w-44">
              Fecha
            </TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {movements.map((movement) => {
            const config =
              movementTypeConfig[movement.movementType] ||
              movementTypeConfig.ALTA;
            return (
              <TableRow key={movement.movementID} className="hover:bg-gray-50">
                <TableCell>
                  <span
                    className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium ${config.bgColor} ${config.color}`}
                  >
                    {config.icon}
                    {MOVEMENT_TYPE_LABELS[movement.movementType] ||
                      movement.movementType}
                  </span>
                </TableCell>
                <TableCell className="text-gray-600 text-sm">
                  {movement.description || "-"}
                </TableCell>
                <TableCell className="text-gray-600 text-sm">
                  {movement.responsible || "-"}
                </TableCell>
                <TableCell className="text-gray-600 text-sm">
                  {movement.createdBy || "-"}
                </TableCell>
                <TableCell className="text-gray-500 text-xs font-mono">
                  {formatDate(movement.createdTime)}
                </TableCell>
              </TableRow>
            );
          })}
        </TableBody>
      </Table>
    </div>
  );
};
