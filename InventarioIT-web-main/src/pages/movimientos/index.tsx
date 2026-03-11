import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import { Asset, Movement, MOVEMENT_TYPES, MOVEMENT_TYPE_LABELS, MovementType } from "@/types";
import api from "@/lib/api";
import { CreateMovementModal } from "@/components/CreateMovementModal";
import { MovementHistoryTable } from "@/components/MovementHistoryTable";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  ChevronLeft,
  ChevronRight,
  Plus,
  Search,
  RefreshCw,
  X,
  ArrowRightLeft,
  ArrowUpCircle,
  ArrowDownCircle,
  HandCoins,
  Eye,
} from "lucide-react";
import { toast } from "sonner";

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

export default function Movimientos() {
  const [assets, setAssets] = useState<Asset[]>([]);
  const [movements, setMovements] = useState<Movement[]>([]);
  const [filteredMovements, setFilteredMovements] = useState<Movement[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);

  // Filtros
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const [selectedType, setSelectedType] = useState<string | null>(null);

  // Paginacion
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(10);

  // Detalle de activo
  const [selectedAssetID, setSelectedAssetID] = useState<number | null>(null);
  const [refreshTrigger, setRefreshTrigger] = useState(0);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setIsLoading(true);
      const [assetsRes, movementsRes] = await Promise.all([
        api.asset.getAll().catch(() => []),
        api.movement.getAll().catch(() => []),
      ]);
      setAssets(assetsRes as Asset[]);
      setMovements(movementsRes);
      setFilteredMovements(movementsRes);
    } catch (error) {
      console.error("Error loading data:", error);
    } finally {
      setIsLoading(false);
    }
  };

  // Filtros
  useEffect(() => {
    let result = [...movements];

    if (selectedType) {
      result = result.filter((m) => m.movementType === selectedType);
    }

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(
        (m) =>
          m.assetName?.toLowerCase().includes(query) ||
          m.description?.toLowerCase().includes(query) ||
          m.responsible?.toLowerCase().includes(query) ||
          m.createdBy?.toLowerCase().includes(query)
      );
    }

    setFilteredMovements(result);
    setCurrentPage(1);
  }, [movements, selectedType, searchQuery]);

  // Paginacion
  const paginatedMovements = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredMovements.slice(start, start + pageSize);
  }, [filteredMovements, currentPage, pageSize]);

  const totalPages = Math.ceil(filteredMovements.length / pageSize);
  const startItem =
    filteredMovements.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endItem = Math.min(
    currentPage * pageSize,
    filteredMovements.length
  );

  const handleRefresh = () => {
    loadData();
    setRefreshTrigger((prev) => prev + 1);
    toast.success("Lista actualizada");
  };

  const handleCreateSuccess = () => {
    loadData();
    setRefreshTrigger((prev) => prev + 1);
  };

  return (
    <MainLayout
      breadcrumb={{
        title: "Movimientos",
        subtitle: "Control de movimientos de activos TI",
      }}
    >
      {() => (
        <div className="flex flex-col h-full bg-white">
          {/* Header */}
          <div className="px-4 py-3 border-b">
            <div className="text-xs text-gray-500 mb-1">
              Inventario / Movimientos
            </div>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <ArrowRightLeft className="h-5 w-5 text-blue-600" />
                <h1 className="text-xl font-semibold text-gray-900">
                  Control de Movimientos
                </h1>
                <span className="ml-2 px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-600 rounded-full">
                  {filteredMovements.length}
                </span>
              </div>
            </div>
          </div>

          {/* Toolbar */}
          <div className="flex items-center justify-between px-4 py-2 border-b bg-gray-50">
            <div className="flex items-center gap-2">
              {/* Busqueda */}
              {isSearchOpen ? (
                <div className="flex items-center">
                  <Input
                    placeholder="Buscar por activo, responsable..."
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    className="h-8 w-64 text-sm"
                    autoFocus
                  />
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8"
                    onClick={() => {
                      setIsSearchOpen(false);
                      setSearchQuery("");
                    }}
                  >
                    <X className="h-4 w-4" />
                  </Button>
                </div>
              ) : (
                <Button
                  variant="ghost"
                  size="icon"
                  className="h-8 w-8"
                  onClick={() => setIsSearchOpen(true)}
                >
                  <Search className="h-4 w-4 text-gray-500" />
                </Button>
              )}

              <div className="h-6 w-px bg-gray-300 mx-1" />

              {/* Filtro por tipo */}
              <Select
                value={selectedType || "all"}
                onValueChange={(value) =>
                  setSelectedType(value === "all" ? null : value)
                }
              >
                <SelectTrigger className="h-8 w-44 text-sm">
                  <SelectValue placeholder="Todos los tipos" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">Todos los tipos</SelectItem>
                  {MOVEMENT_TYPES.map((type) => (
                    <SelectItem key={type} value={type}>
                      {MOVEMENT_TYPE_LABELS[type]}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>

              <div className="h-6 w-px bg-gray-300 mx-1" />

              <Button
                variant="outline"
                size="sm"
                onClick={() => setIsCreateModalOpen(true)}
                className="h-8 text-sm font-normal"
              >
                <Plus className="h-4 w-4 mr-1" />
                Nuevo Movimiento
              </Button>

              <Button
                variant="outline"
                size="sm"
                onClick={handleRefresh}
                className="h-8 text-sm font-normal"
              >
                <RefreshCw className="h-4 w-4 mr-1" />
                Actualizar
              </Button>
            </div>

            {/* Paginacion */}
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <span>
                {startItem} - {endItem} de {filteredMovements.length}
              </span>
              <Button
                variant="ghost"
                size="icon"
                className="h-7 w-7"
                onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
                disabled={currentPage <= 1}
              >
                <ChevronLeft className="h-4 w-4" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="h-7 w-7"
                onClick={() =>
                  setCurrentPage((p) => Math.min(totalPages, p + 1))
                }
                disabled={currentPage >= totalPages}
              >
                <ChevronRight className="h-4 w-4" />
              </Button>
            </div>
          </div>

          {/* Contenido principal */}
          <div className="flex flex-1 overflow-hidden">
            {/* Tabla de movimientos */}
            <div
              className={`flex-1 overflow-auto ${selectedAssetID ? "border-r" : ""}`}
            >
              {isLoading ? (
                <div className="flex items-center justify-center h-64">
                  <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
                </div>
              ) : (
                <Table>
                  <TableHeader className="bg-gray-50 sticky top-0">
                    <TableRow>
                      <TableHead className="font-semibold text-gray-700 w-36">
                        Tipo
                      </TableHead>
                      <TableHead className="font-semibold text-gray-700">
                        Activo
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
                      <TableHead className="font-semibold text-gray-700 w-20">
                        Detalle
                      </TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {paginatedMovements.length === 0 ? (
                      <TableRow>
                        <TableCell
                          colSpan={7}
                          className="h-24 text-center text-gray-500"
                        >
                          No se encontraron movimientos
                        </TableCell>
                      </TableRow>
                    ) : (
                      paginatedMovements.map((movement) => {
                        const config =
                          movementTypeConfig[movement.movementType] ||
                          movementTypeConfig.ALTA;
                        return (
                          <TableRow
                            key={movement.movementID}
                            className={`hover:bg-gray-50 ${
                              selectedAssetID === movement.assetID
                                ? "bg-blue-50"
                                : ""
                            }`}
                          >
                            <TableCell>
                              <span
                                className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium ${config.bgColor} ${config.color}`}
                              >
                                {config.icon}
                                {MOVEMENT_TYPE_LABELS[
                                  movement.movementType
                                ] || movement.movementType}
                              </span>
                            </TableCell>
                            <TableCell className="font-medium text-gray-900">
                              {movement.assetName}
                            </TableCell>
                            <TableCell className="text-gray-600 text-sm max-w-[250px] truncate">
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
                            <TableCell>
                              <Button
                                variant="ghost"
                                size="icon"
                                className="h-7 w-7"
                                onClick={() =>
                                  setSelectedAssetID(
                                    selectedAssetID ===
                                      movement.assetID
                                      ? null
                                      : movement.assetID
                                  )
                                }
                              >
                                <Eye className="h-4 w-4 text-gray-500" />
                              </Button>
                            </TableCell>
                          </TableRow>
                        );
                      })
                    )}
                  </TableBody>
                </Table>
              )}
            </div>

            {/* Panel lateral: Historial del activo seleccionado */}
            {selectedAssetID && (
              <div className="w-[420px] overflow-auto bg-gray-50 p-4">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-sm font-semibold text-gray-700">
                    Historial del Activo
                  </h3>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-6 w-6"
                    onClick={() => setSelectedAssetID(null)}
                  >
                    <X className="h-4 w-4" />
                  </Button>
                </div>
                <MovementHistoryTable
                  assetID={selectedAssetID}
                  refreshTrigger={refreshTrigger}
                  onMovementUpdated={() => loadData()}
                />
              </div>
            )}
          </div>

          {/* Modal de Crear Movimiento */}
          <CreateMovementModal
            assets={assets}
            isOpen={isCreateModalOpen}
            onClose={() => setIsCreateModalOpen(false)}
            onSuccess={handleCreateSuccess}
          />
        </div>
      )}
    </MainLayout>
  );
}
