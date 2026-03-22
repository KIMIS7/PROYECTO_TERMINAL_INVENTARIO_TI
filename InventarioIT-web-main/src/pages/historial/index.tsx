import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import api from "@/lib/api";
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
  Search,
  RefreshCw,
  X,
  History,
  ArrowDownCircle,
  UserCheck,
  Shield,
  Plus,
  Pencil,
  Calendar,
  FileSpreadsheet,
  Loader2,
  Repeat,
  Wrench,
  User,
  Building2,
  MapPin,
} from "lucide-react";
import { toast } from "sonner";

interface HistoryRecord {
  historyID: number;
  assetID: number;
  assetName: string;
  operation: string;
  description: string;
  performedBy?: string | null;
  createdTime: string;
  assignedUser?: string | null;
  department?: string | null;
  site?: string | null;
  company?: string | null;
}

const OPERATION_TYPES = [
  "CREATE",
  "UPDATE",
  "REASIGNACION",
  "BAJA",
  "RESGUARDO",
  "REPARACION",
] as const;

const operationConfig: Record<
  string,
  { label: string; color: string; bgColor: string; icon: React.ReactNode }
> = {
  CREATE: {
    label: "Creación",
    color: "text-emerald-700",
    bgColor: "bg-emerald-100",
    icon: <Plus className="h-3.5 w-3.5" />,
  },
  UPDATE: {
    label: "Edición",
    color: "text-indigo-700",
    bgColor: "bg-indigo-100",
    icon: <Pencil className="h-3.5 w-3.5" />,
  },
  REASIGNACION: {
    label: "Reasignación",
    color: "text-cyan-700",
    bgColor: "bg-cyan-100",
    icon: <Repeat className="h-3.5 w-3.5" />,
  },
  BAJA: {
    label: "Baja",
    color: "text-red-700",
    bgColor: "bg-red-100",
    icon: <ArrowDownCircle className="h-3.5 w-3.5" />,
  },
  RESGUARDO: {
    label: "Resguardo",
    color: "text-amber-700",
    bgColor: "bg-amber-100",
    icon: <Shield className="h-3.5 w-3.5" />,
  },
  REPARACION: {
    label: "Reparación",
    color: "text-orange-700",
    bgColor: "bg-orange-100",
    icon: <Wrench className="h-3.5 w-3.5" />,
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

export default function Historial() {
  const [records, setRecords] = useState<HistoryRecord[]>([]);
  const [isLoading, setIsLoading] = useState(false);

  // Filters
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const [selectedOperation, setSelectedOperation] = useState<string | null>(null);
  const [dateFrom, setDateFrom] = useState("");
  const [dateTo, setDateTo] = useState("");

  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(15);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setIsLoading(true);
      const data = await api.movement.getHistory();
      setRecords(data);
    } catch (error) {
      console.error("Error loading history:", error);
    } finally {
      setIsLoading(false);
    }
  };

  // Filtered records
  const filteredRecords = useMemo(() => {
    let result = [...records];

    if (selectedOperation) {
      result = result.filter((r) => r.operation === selectedOperation);
    }

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(
        (r) =>
          r.assetName?.toLowerCase().includes(query) ||
          r.description?.toLowerCase().includes(query) ||
          r.performedBy?.toLowerCase().includes(query) ||
          r.assignedUser?.toLowerCase().includes(query) ||
          r.department?.toLowerCase().includes(query) ||
          r.site?.toLowerCase().includes(query) ||
          r.company?.toLowerCase().includes(query)
      );
    }

    if (dateFrom) {
      const from = new Date(dateFrom);
      from.setHours(0, 0, 0, 0);
      result = result.filter((r) => new Date(r.createdTime) >= from);
    }

    if (dateTo) {
      const to = new Date(dateTo);
      to.setHours(23, 59, 59, 999);
      result = result.filter((r) => new Date(r.createdTime) <= to);
    }

    return result;
  }, [records, selectedOperation, searchQuery, dateFrom, dateTo]);

  // Reset page when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [selectedOperation, searchQuery, dateFrom, dateTo]);

  // Pagination
  const paginatedRecords = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredRecords.slice(start, start + pageSize);
  }, [filteredRecords, currentPage, pageSize]);

  const totalPages = Math.ceil(filteredRecords.length / pageSize);
  const startItem = filteredRecords.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endItem = Math.min(currentPage * pageSize, filteredRecords.length);

  // Stats
  const stats = useMemo(() => {
    const counts: Record<string, number> = {};
    for (const r of records) {
      counts[r.operation] = (counts[r.operation] || 0) + 1;
    }
    return counts;
  }, [records]);

  const [isExportingHistory, setIsExportingHistory] = useState(false);

  const handleRefresh = () => {
    loadData();
    toast.success("Historial actualizado");
  };

  const handleExportHistory = async () => {
    try {
      setIsExportingHistory(true);
      const blob = await api.report.downloadHistoryExcel();
      const url = window.URL.createObjectURL(
        new Blob([blob], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" })
      );
      const a = document.createElement("a");
      a.href = url;
      a.download = `historial_movimientos_${new Date().toISOString().split("T")[0]}.xlsx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      toast.success("Historial exportado a Excel");
    } catch (error) {
      console.error("Error exporting history:", error);
      toast.error("Error al exportar historial");
    } finally {
      setIsExportingHistory(false);
    }
  };

  const clearFilters = () => {
    setSearchQuery("");
    setSelectedOperation(null);
    setDateFrom("");
    setDateTo("");
    setIsSearchOpen(false);
  };

  const hasActiveFilters = searchQuery || selectedOperation || dateFrom || dateTo;

  return (
    <MainLayout
      breadcrumb={{
        title: "Historial",
        subtitle: "Registro completo de operaciones del sistema",
      }}
    >
      {() => (
        <div className="flex flex-col h-full bg-white">
          {/* Header */}
          <div className="px-4 py-3 border-b">
            <div className="text-xs text-gray-500 mb-1">
              Inventario / Historial
            </div>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <History className="h-5 w-5 text-purple-600" />
                <h1 className="text-xl font-semibold text-gray-900">
                  Historial de Operaciones
                </h1>
                <span className="ml-2 px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-600 rounded-full">
                  {filteredRecords.length}
                </span>
              </div>
            </div>
          </div>

          {/* Stats bar */}
          <div className="flex items-center gap-2 px-4 py-2 border-b bg-gray-50/50 overflow-x-auto">
            {OPERATION_TYPES.map((op) => {
              const config = operationConfig[op];
              const count = stats[op] || 0;
              if (count === 0) return null;
              return (
                <button
                  key={op}
                  onClick={() =>
                    setSelectedOperation(selectedOperation === op ? null : op)
                  }
                  className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium transition-all shrink-0 ${
                    selectedOperation === op
                      ? `${config.bgColor} ${config.color} ring-2 ring-offset-1 ring-current`
                      : `${config.bgColor} ${config.color} opacity-70 hover:opacity-100`
                  }`}
                >
                  {config.icon}
                  {config.label}
                  <span className="ml-0.5 font-bold">{count}</span>
                </button>
              );
            })}
          </div>

          {/* Toolbar */}
          <div className="flex items-center justify-between px-4 py-2 border-b bg-gray-50">
            <div className="flex items-center gap-2">
              {/* Search */}
              {isSearchOpen ? (
                <div className="flex items-center">
                  <Input
                    placeholder="Buscar por activo, descripción, responsable..."
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

              {/* Operation type filter */}
              <Select
                value={selectedOperation || "all"}
                onValueChange={(value) =>
                  setSelectedOperation(value === "all" ? null : value)
                }
              >
                <SelectTrigger className="h-8 w-44 text-sm">
                  <SelectValue placeholder="Todas las operaciones" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">Todas las operaciones</SelectItem>
                  {OPERATION_TYPES.map((op) => (
                    <SelectItem key={op} value={op}>
                      {operationConfig[op].label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>

              <div className="h-6 w-px bg-gray-300 mx-1" />

              {/* Date filters */}
              <div className="flex items-center gap-1">
                <Calendar className="h-4 w-4 text-gray-400" />
                <Input
                  type="date"
                  value={dateFrom}
                  onChange={(e) => setDateFrom(e.target.value)}
                  className="h-8 w-36 text-xs"
                  placeholder="Desde"
                />
                <span className="text-xs text-gray-400">-</span>
                <Input
                  type="date"
                  value={dateTo}
                  onChange={(e) => setDateTo(e.target.value)}
                  className="h-8 w-36 text-xs"
                  placeholder="Hasta"
                />
              </div>

              {hasActiveFilters && (
                <>
                  <div className="h-6 w-px bg-gray-300 mx-1" />
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={clearFilters}
                    className="h-8 text-xs text-red-600 hover:text-red-700"
                  >
                    <X className="h-3 w-3 mr-1" />
                    Limpiar filtros
                  </Button>
                </>
              )}

              <div className="h-6 w-px bg-gray-300 mx-1" />

              <Button
                variant="outline"
                size="sm"
                onClick={handleExportHistory}
                disabled={isExportingHistory}
                className="h-8 text-sm font-normal"
              >
                {isExportingHistory ? (
                  <Loader2 className="h-4 w-4 mr-1 animate-spin" />
                ) : (
                  <FileSpreadsheet className="h-4 w-4 mr-1" />
                )}
                Exportar Excel
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

            {/* Pagination */}
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <span>
                {startItem} - {endItem} de {filteredRecords.length}
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

          {/* Table */}
          <div className="flex-1 overflow-auto">
            {isLoading ? (
              <div className="flex items-center justify-center h-64">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
              </div>
            ) : (
              <Table>
                <TableHeader className="bg-gray-50 sticky top-0">
                  <TableRow>
                    <TableHead className="font-semibold text-gray-700 w-36">
                      Operación
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700 w-32">
                      Activo
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700">
                      Descripción
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700 w-40">
                      Realizado por
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700 w-36">
                      Asignado a
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700 w-36">
                      Departamento / Sitio
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700 w-44">
                      Fecha
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {paginatedRecords.length === 0 ? (
                    <TableRow>
                      <TableCell
                        colSpan={7}
                        className="h-24 text-center text-gray-500"
                      >
                        {hasActiveFilters
                          ? "No se encontraron registros con los filtros aplicados"
                          : "No hay registros en el historial"}
                      </TableCell>
                    </TableRow>
                  ) : (
                    paginatedRecords.map((record) => {
                      const config =
                        operationConfig[record.operation] || {
                          label: record.operation,
                          color: "text-gray-700",
                          bgColor: "bg-gray-100",
                          icon: <History className="h-3.5 w-3.5" />,
                        };

                      // Build department/site display
                      const locationParts: string[] = [];
                      if (record.department) locationParts.push(record.department);
                      if (record.site) locationParts.push(record.site);

                      return (
                        <TableRow
                          key={record.historyID}
                          className="hover:bg-gray-50"
                        >
                          <TableCell>
                            <span
                              className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium ${config.bgColor} ${config.color}`}
                            >
                              {config.icon}
                              {config.label}
                            </span>
                          </TableCell>
                          <TableCell className="font-medium text-gray-900">
                            {record.assetName}
                          </TableCell>
                          <TableCell className="text-gray-600 text-sm max-w-[250px] truncate">
                            {record.description || "-"}
                          </TableCell>
                          <TableCell className="text-sm">
                            {record.performedBy ? (
                              <div className="flex items-center gap-1.5">
                                <User className="h-3.5 w-3.5 text-gray-400 shrink-0" />
                                <span className="text-gray-700">{record.performedBy}</span>
                              </div>
                            ) : (
                              <span className="text-gray-400">-</span>
                            )}
                          </TableCell>
                          <TableCell className="text-sm">
                            {record.assignedUser ? (
                              <div className="flex items-center gap-1.5">
                                <UserCheck className="h-3.5 w-3.5 text-blue-500 shrink-0" />
                                <span className="text-gray-700">{record.assignedUser}</span>
                              </div>
                            ) : (
                              <span className="text-gray-400">-</span>
                            )}
                          </TableCell>
                          <TableCell className="text-sm">
                            {locationParts.length > 0 ? (
                              <div className="flex flex-col gap-0.5">
                                {record.department && (
                                  <div className="flex items-center gap-1">
                                    <Building2 className="h-3 w-3 text-gray-400 shrink-0" />
                                    <span className="text-gray-600 text-xs">{record.department}</span>
                                  </div>
                                )}
                                {record.site && (
                                  <div className="flex items-center gap-1">
                                    <MapPin className="h-3 w-3 text-gray-400 shrink-0" />
                                    <span className="text-gray-600 text-xs">{record.site}</span>
                                  </div>
                                )}
                              </div>
                            ) : (
                              <span className="text-gray-400">-</span>
                            )}
                          </TableCell>
                          <TableCell className="text-gray-500 text-xs font-mono">
                            {formatDate(record.createdTime)}
                          </TableCell>
                        </TableRow>
                      );
                    })
                  )}
                </TableBody>
              </Table>
            )}
          </div>
        </div>
      )}
    </MainLayout>
  );
}
