import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import api from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
  Tag,
} from "lucide-react";
import { toast } from "sonner";
import { OmniboxFilter, Facet, FilterChip } from "@/components/OmniboxFilter";

interface HistoryRecord {
  historyID: number;
  assetID: number;
  assetName: string;
  assetTAG?: string | null;
  productTypeName?: string | null;
  productTypeGroup?: string | null;
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

  // Filtros (mismas primitivas que Inventario/Movimientos/Reportes)
  const [searchQuery, setSearchQuery] = useState("");
  const [filterChips, setFilterChips] = useState<FilterChip[]>([]);
  const [isSearchPinned, setIsSearchPinned] = useState(false);

  // Filtros de fecha (especificos de Historial)
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

  // Opciones derivadas para las facetas del omnibox
  const uniqueOperations = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.operation && set.add(r.operation));
    return Array.from(set).sort();
  }, [records]);

  const uniqueGroups = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.productTypeGroup && set.add(r.productTypeGroup));
    return Array.from(set).sort();
  }, [records]);

  const uniqueProductTypes = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.productTypeName && set.add(r.productTypeName));
    return Array.from(set).sort();
  }, [records]);

  const uniqueCompanies = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.company && set.add(r.company));
    return Array.from(set).sort();
  }, [records]);

  const uniqueSites = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.site && set.add(r.site));
    return Array.from(set).sort();
  }, [records]);

  const uniqueDepartments = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.department && set.add(r.department));
    return Array.from(set).sort();
  }, [records]);

  const uniqueUsers = useMemo(() => {
    const set = new Set<string>();
    records.forEach((r) => r.assignedUser && set.add(r.assignedUser));
    records.forEach((r) => r.performedBy && set.add(r.performedBy));
    return Array.from(set).sort();
  }, [records]);

  // Facetas (mismo patron que Inventario/Movimientos/Reportes)
  const facets: Facet[] = useMemo(
    () => {
      const result: Facet[] = [];
      if (uniqueOperations.length > 0) {
        result.push({
          key: "operacion",
          label: "Operación",
          color: "purple",
          options: uniqueOperations.map((op) => ({
            value: op,
            label: operationConfig[op]?.label || op,
          })),
        });
      }
      if (uniqueGroups.length > 0) {
        result.push({
          key: "grupo",
          label: "Grupo",
          color: "slate",
          options: uniqueGroups.map((g) => ({ value: g, label: g })),
        });
      }
      if (uniqueProductTypes.length > 0) {
        result.push({
          key: "tipo",
          label: "Tipo",
          color: "purple",
          options: uniqueProductTypes.map((t) => ({ value: t, label: t })),
        });
      }
      if (uniqueCompanies.length > 0) {
        result.push({
          key: "empresa",
          label: "Empresa",
          color: "blue",
          options: uniqueCompanies.map((c) => ({ value: c, label: c })),
        });
      }
      if (uniqueSites.length > 0) {
        result.push({
          key: "site",
          label: "Site",
          color: "sky",
          options: uniqueSites.map((s) => ({ value: s, label: s })),
        });
      }
      if (uniqueDepartments.length > 0) {
        result.push({
          key: "departamento",
          label: "Departamento",
          color: "lime",
          options: uniqueDepartments.map((d) => ({ value: d, label: d })),
        });
      }
      if (uniqueUsers.length > 0) {
        result.push({
          key: "usuario",
          label: "Usuario",
          color: "emerald",
          options: uniqueUsers.map((u) => ({ value: u, label: u })),
        });
      }
      return result;
    },
    [
      uniqueOperations,
      uniqueGroups,
      uniqueProductTypes,
      uniqueCompanies,
      uniqueSites,
      uniqueDepartments,
      uniqueUsers,
    ]
  );

  // Filtrado (mismo patron: AND entre facetas, OR dentro de una faceta)
  const filteredRecords = useMemo(() => {
    let result = [...records];

    const chipsByFacet = new Map<string, Set<string>>();
    filterChips.forEach((chip) => {
      if (!chipsByFacet.has(chip.facet)) {
        chipsByFacet.set(chip.facet, new Set());
      }
      chipsByFacet.get(chip.facet)!.add(chip.value);
    });

    if (chipsByFacet.has("operacion")) {
      const values = chipsByFacet.get("operacion")!;
      result = result.filter((r) => values.has(r.operation));
    }
    if (chipsByFacet.has("grupo")) {
      const values = chipsByFacet.get("grupo")!;
      result = result.filter((r) => r.productTypeGroup && values.has(r.productTypeGroup));
    }
    if (chipsByFacet.has("tipo")) {
      const values = chipsByFacet.get("tipo")!;
      result = result.filter((r) => r.productTypeName && values.has(r.productTypeName));
    }
    if (chipsByFacet.has("empresa")) {
      const values = chipsByFacet.get("empresa")!;
      result = result.filter((r) => r.company && values.has(r.company));
    }
    if (chipsByFacet.has("site")) {
      const values = chipsByFacet.get("site")!;
      result = result.filter((r) => r.site && values.has(r.site));
    }
    if (chipsByFacet.has("departamento")) {
      const values = chipsByFacet.get("departamento")!;
      result = result.filter((r) => r.department && values.has(r.department));
    }
    if (chipsByFacet.has("usuario")) {
      const values = chipsByFacet.get("usuario")!;
      result = result.filter(
        (r) =>
          (r.assignedUser && values.has(r.assignedUser)) ||
          (r.performedBy && values.has(r.performedBy))
      );
    }

    // Busqueda libre: incluye assetTAG (nuevo) para unificar con el resto
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(
        (r) =>
          r.assetName?.toLowerCase().includes(query) ||
          r.assetTAG?.toLowerCase().includes(query) ||
          r.productTypeName?.toLowerCase().includes(query) ||
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
  }, [records, filterChips, searchQuery, dateFrom, dateTo]);

  // Reset page when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [filterChips, searchQuery, dateFrom, dateTo]);

  // Pagination
  const paginatedRecords = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredRecords.slice(start, start + pageSize);
  }, [filteredRecords, currentPage, pageSize]);

  const totalPages = Math.ceil(filteredRecords.length / pageSize);
  const startItem = filteredRecords.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endItem = Math.min(currentPage * pageSize, filteredRecords.length);

  // Stats por operacion, click en chip agrega/quita filtro
  const stats = useMemo(() => {
    const counts: Record<string, number> = {};
    for (const r of records) {
      counts[r.operation] = (counts[r.operation] || 0) + 1;
    }
    return counts;
  }, [records]);

  const selectedOperationSet = useMemo(() => {
    const s = new Set<string>();
    filterChips.forEach((c) => {
      if (c.facet === "operacion") s.add(c.value);
    });
    return s;
  }, [filterChips]);

  const toggleOperationChip = (op: string) => {
    if (selectedOperationSet.has(op)) {
      setFilterChips((prev) => prev.filter((c) => !(c.facet === "operacion" && c.value === op)));
    } else {
      setFilterChips((prev) => [
        ...prev,
        {
          id: `operacion-${op}`,
          facet: "operacion",
          facetLabel: "Operación",
          value: op,
          valueLabel: operationConfig[op]?.label || op,
        },
      ]);
    }
  };

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

  const clearDates = () => {
    setDateFrom("");
    setDateTo("");
  };

  const hasDateFilters = dateFrom || dateTo;

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

          {/* Stats bar: chips rapidos por operacion */}
          <div className="flex items-center gap-2 px-4 py-2 border-b bg-gray-50/50 overflow-x-auto">
            {OPERATION_TYPES.map((op) => {
              const config = operationConfig[op];
              const count = stats[op] || 0;
              if (count === 0) return null;
              const selected = selectedOperationSet.has(op);
              return (
                <button
                  key={op}
                  onClick={() => toggleOperationChip(op)}
                  className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium transition-all shrink-0 ${
                    selected
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

          {/* Toolbar (mismo componente OmniboxFilter que Inventario/Movimientos/Reportes) */}
          <div className="flex items-center gap-3 px-4 py-2 border-b bg-gray-50">
            <OmniboxFilter
              facets={facets}
              chips={filterChips}
              onChipsChange={setFilterChips}
              searchQuery={searchQuery}
              onSearchQueryChange={setSearchQuery}
              pinned={isSearchPinned}
              onPinnedChange={setIsSearchPinned}
              placeholder="Buscar por activo, AssetTag, descripción..."
            />

            <div className="h-6 w-px bg-gray-300" />

            {/* Rango de fechas (especifico de historial) */}
            <div className="flex items-center gap-1 shrink-0">
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
              {hasDateFilters && (
                <Button
                  variant="ghost"
                  size="icon"
                  className="h-7 w-7"
                  onClick={clearDates}
                  title="Limpiar fechas"
                >
                  <X className="h-3.5 w-3.5" />
                </Button>
              )}
            </div>

            <div className="flex items-center gap-1 shrink-0 ml-auto">
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
                <RefreshCw className="h-4 w-4" />
              </Button>
            </div>

            {/* Paginacion */}
            <div className="flex items-center gap-2 text-sm text-gray-600 shrink-0">
              <span className="whitespace-nowrap">
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
                    <TableHead className="font-semibold text-gray-700 w-40">
                      Activo
                    </TableHead>
                    <TableHead className="font-semibold text-gray-700 w-32">
                      Asset TAG
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
                        colSpan={8}
                        className="h-24 text-center text-gray-500"
                      >
                        {filterChips.length > 0 || searchQuery || hasDateFilters
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
                          <TableCell className="text-sm">
                            {record.assetTAG ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-slate-100 text-slate-700 text-xs font-mono">
                                <Tag className="h-3 w-3" />
                                {record.assetTAG}
                              </span>
                            ) : (
                              <span className="text-gray-400">-</span>
                            )}
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
                            {record.department || record.site ? (
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
