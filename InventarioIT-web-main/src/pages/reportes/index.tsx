import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import { Asset, Company, Site, AssetState } from "@/types";
import api from "@/lib/api";
import {
  OmniboxFilter,
  type FilterChip,
  type Facet,
} from "@/components/OmniboxFilter";
import { Button } from "@/components/ui/button";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  FileSpreadsheet,
  FileText,
  Upload,
  Loader2,
  Package,
  Warehouse,
  ShieldAlert,
  ClipboardList,
  Cpu,
  CalendarClock,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import { useRef } from "react";
import { toast } from "sonner";
import { cn } from "@/lib/utils";

function triggerDownload(blob: Blob, filename: string) {
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  window.URL.revokeObjectURL(url);
  document.body.removeChild(a);
}

type SubTab = "administrativo" | "tecnico" | "ciclo-vida";

const PAGE_SIZE = 20;

export default function Reportes() {
  const [assets, setAssets] = useState<Asset[]>([]);
  const [companies, setCompanies] = useState<Company[]>([]);
  const [sites, setSites] = useState<Site[]>([]);
  const [departments, setDepartments] = useState<{ departID: number; name: string }[]>([]);
  const [assetStates, setAssetStates] = useState<AssetState[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isExporting, setIsExporting] = useState<string | null>(null);
  const [isImporting, setIsImporting] = useState(false);
  const csvInputRef = useRef<HTMLInputElement>(null);

  // Omnibox filter state
  const [chips, setChips] = useState<FilterChip[]>([]);
  const [searchQuery, setSearchQuery] = useState("");

  // Active sub-tab
  const [activeTab, setActiveTab] = useState<SubTab>("administrativo");

  // Pagination
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    loadData();
  }, []);

  // Reset page when filters or tab change
  useEffect(() => {
    setCurrentPage(1);
  }, [chips, searchQuery, activeTab]);

  const loadData = async () => {
    try {
      setIsLoading(true);
      const [assetsRes, companiesRes, sitesRes, statesRes, deptsRes] = await Promise.all([
        api.asset.getAll().catch(() => []),
        api.company.getAll().catch(() => []),
        api.site.getAll().catch(() => []),
        api.assetState.getAll().catch(() => []),
        api.user.getDepartments().catch(() => []),
      ]);
      setAssets(assetsRes as Asset[]);
      setCompanies(companiesRes);
      setSites(sitesRes);
      setAssetStates(statesRes);
      setDepartments(deptsRes);
    } catch (error) {
      console.error("Error loading report data:", error);
    } finally {
      setIsLoading(false);
    }
  };

  // Build facets for Omnibox (Empresa, Sitio, Departamento)
  const facets: Facet[] = useMemo(() => {
    const result: Facet[] = [];

    // Empresa
    if (companies.length > 0) {
      result.push({
        key: "empresa",
        label: "Empresa",
        color: "blue",
        options: companies.map((c) => ({
          value: c.companyID.toString(),
          label: c.description,
        })),
      });
    }

    // Sitio (Hotel)
    if (sites.length > 0) {
      result.push({
        key: "site",
        label: "Sitio / Hotel",
        color: "sky",
        options: sites.map((s) => ({
          value: s.siteID.toString(),
          label: s.name,
        })),
      });
    }

    // Departamento
    const uniqueDepts = new Map<string, string>();
    // From departments catalog
    departments.forEach((d) => {
      uniqueDepts.set(d.departID.toString(), d.name);
    });
    // Also from assets' department info
    assets.forEach((a) => {
      if (a.depart?.departID && a.depart?.Name) {
        uniqueDepts.set(a.depart.departID.toString(), a.depart.Name);
      }
    });
    if (uniqueDepts.size > 0) {
      result.push({
        key: "departamento",
        label: "Departamento",
        color: "lime",
        options: Array.from(uniqueDepts.entries())
          .map(([value, label]) => ({ value, label }))
          .sort((a, b) => a.label.localeCompare(b.label)),
      });
    }

    return result;
  }, [companies, sites, departments, assets]);

  // Filter assets based on chips and search query
  const filteredAssets = useMemo(() => {
    let result = [...assets];

    // Group chips by facet
    const chipsByFacet = new Map<string, Set<string>>();
    chips.forEach((chip) => {
      if (!chipsByFacet.has(chip.facet)) {
        chipsByFacet.set(chip.facet, new Set());
      }
      chipsByFacet.get(chip.facet)!.add(chip.value);
    });

    // Filter by Empresa
    if (chipsByFacet.has("empresa")) {
      const values = chipsByFacet.get("empresa")!;
      result = result.filter((a) => values.has(a.companyID?.toString()));
    }

    // Filter by Sitio
    if (chipsByFacet.has("site")) {
      const values = chipsByFacet.get("site")!;
      result = result.filter((a) => values.has(a.siteID?.toString()));
    }

    // Filter by Departamento
    if (chipsByFacet.has("departamento")) {
      const values = chipsByFacet.get("departamento")!;
      result = result.filter((a) => values.has(a.depart?.departID?.toString() || ""));
    }

    // Text search
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter((a) =>
        a.name?.toLowerCase().includes(query) ||
        a.assetDetail?.serialNum?.toLowerCase().includes(query) ||
        a.user?.name?.toLowerCase().includes(query) ||
        a.assetDetail?.ipAddress?.toLowerCase().includes(query) ||
        a.assetDetail?.macAddress?.toLowerCase().includes(query) ||
        a.vendor?.name?.toLowerCase().includes(query) ||
        a.depart?.Name?.toLowerCase().includes(query) ||
        a.site?.name?.toLowerCase().includes(query)
      );
    }

    return result;
  }, [assets, chips, searchQuery]);

  // KPI calculations
  const kpis = useMemo(() => {
    const total = filteredAssets.length;
    const inStock = filteredAssets.filter(
      (a) => a.assetStateInfo?.name === "Stock" || a.assetStateInfo?.name === "En Stock"
    ).length;
    const now = new Date();
    const warrantyExpired = filteredAssets.filter((a) => {
      const expiry = a.assetDetail?.warrantyExpiryDate || a.assetDetail?.warrantyExpiry || a.assetDetail?.assetExpiryDate;
      if (!expiry) return false;
      return new Date(expiry) < now;
    }).length;
    return { total, inStock, warrantyExpired };
  }, [filteredAssets]);

  // Pagination
  const totalPages = Math.max(1, Math.ceil(filteredAssets.length / PAGE_SIZE));
  const paginatedAssets = useMemo(() => {
    const start = (currentPage - 1) * PAGE_SIZE;
    return filteredAssets.slice(start, start + PAGE_SIZE);
  }, [filteredAssets, currentPage]);

  // Import handler
  const handleImportCsv = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    try {
      setIsImporting(true);
      const result = await api.report.importCsv(file);
      toast.success(result.message);
      if (result.errors?.length > 0) {
        toast.warning(`${result.errors.length} errores encontrados`);
      }
      loadData();
    } catch (error: any) {
      console.error("Error:", error);
      toast.error(error?.response?.data?.message || "Error al importar CSV");
    } finally {
      setIsImporting(false);
      if (csvInputRef.current) csvInputRef.current.value = "";
    }
  };

  // Export handlers
  const handleExportCsv = async () => {
    try {
      setIsExporting("csv");
      const filters: { group?: string; companyID?: number; assetState?: number } = {};
      const companyChips = chips.filter((c) => c.facet === "empresa");
      if (companyChips.length === 1) {
        filters.companyID = parseInt(companyChips[0].value);
      }
      const blob = await api.report.downloadAssetsCsv(filters);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(
        new Blob([blob], { type: "text/csv; charset=utf-8" }),
        `inventario_${dateStr}.csv`
      );
      toast.success("Reporte exportado a CSV exitosamente");
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al exportar el reporte");
    } finally {
      setIsExporting(null);
    }
  };

  const handleExportExcel = async () => {
    try {
      setIsExporting("excel");
      const filters: { group?: string; companyID?: number; assetState?: number } = {};
      // Apply company filter if selected
      const companyChips = chips.filter((c) => c.facet === "empresa");
      if (companyChips.length === 1) {
        filters.companyID = parseInt(companyChips[0].value);
      }
      const blob = await api.report.downloadAssetsExcel(filters);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(
        new Blob([blob], {
          type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        }),
        `reporte_inventario_${activeTab}_${dateStr}.xlsx`
      );
      toast.success("Reporte exportado a Excel exitosamente");
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al exportar el reporte");
    } finally {
      setIsExporting(null);
    }
  };

  const handleExportResguardoPdf = async (assetId: number) => {
    try {
      setIsExporting(`pdf-${assetId}`);
      const blob = await api.report.downloadResguardoPdf({
        assetIds: [assetId],
      });
      const dateStr = new Date().toISOString().split("T")[0];
      const asset = assets.find((a) => a.assetID === assetId);
      const name = asset?.name?.replace(/\s+/g, "_") || assetId;
      triggerDownload(
        new Blob([blob], { type: "application/pdf" }),
        `resguardo_${name}_${dateStr}.pdf`
      );
      toast.success("Resguardo PDF generado exitosamente");
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al generar el resguardo PDF");
    } finally {
      setIsExporting(null);
    }
  };

  const formatDate = (dateStr?: string | null) => {
    if (!dateStr) return "-";
    try {
      const d = new Date(dateStr);
      return d.toLocaleDateString("es-MX", {
        year: "numeric",
        month: "short",
        day: "numeric",
      });
    } catch {
      return dateStr;
    }
  };

  const isWarrantyExpired = (dateStr?: string | null) => {
    if (!dateStr) return false;
    return new Date(dateStr) < new Date();
  };

  const subTabs: { key: SubTab; label: string; icon: React.ReactNode; description: string }[] = [
    {
      key: "administrativo",
      label: "Reporte Administrativo",
      icon: <ClipboardList className="h-4 w-4" />,
      description: "Asignación de equipos por usuario y departamento",
    },
    {
      key: "tecnico",
      label: "Reporte Técnico",
      icon: <Cpu className="h-4 w-4" />,
      description: "Infraestructura: IP, MAC, SO, RAM y procesador",
    },
    {
      key: "ciclo-vida",
      label: "Ciclo de Vida",
      icon: <CalendarClock className="h-4 w-4" />,
      description: "Compras, proveedores y vencimiento de garantías",
    },
  ];

  return (
    <MainLayout
      breadcrumb={{
        title: "Reportes",
        subtitle: "Reportes de Inventario de TI",
      }}
    >
      {() => (
        <div className="flex flex-col h-full bg-gray-50/30">
          {/* ===== OMNIBOX FILTER BAR ===== */}
          <div className="px-6 pt-5 pb-3 bg-white border-b">
            <div className="flex items-center gap-3">
              <div className="flex-1">
                <OmniboxFilter
                  facets={facets}
                  chips={chips}
                  onChipsChange={setChips}
                  searchQuery={searchQuery}
                  onSearchQueryChange={setSearchQuery}
                  placeholder="Filtrar por Empresa, Sitio (Hotel), Departamento o buscar..."
                  pinned={true}
                />
              </div>
            </div>
          </div>

          {/* ===== KPI CARDS ===== */}
          <div className="px-6 py-4 bg-white border-b">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {/* Total Equipos */}
              <div className="flex items-center gap-4 p-4 rounded-xl border border-blue-100 bg-gradient-to-br from-blue-50 to-white">
                <div className="flex items-center justify-center h-12 w-12 rounded-lg bg-blue-100">
                  <Package className="h-6 w-6 text-blue-600" />
                </div>
                <div>
                  <p className="text-sm font-medium text-blue-600/80">Total de Equipos</p>
                  <p className="text-2xl font-bold text-blue-700">{kpis.total}</p>
                </div>
              </div>

              {/* En Stock */}
              <div className="flex items-center gap-4 p-4 rounded-xl border border-emerald-100 bg-gradient-to-br from-emerald-50 to-white">
                <div className="flex items-center justify-center h-12 w-12 rounded-lg bg-emerald-100">
                  <Warehouse className="h-6 w-6 text-emerald-600" />
                </div>
                <div>
                  <p className="text-sm font-medium text-emerald-600/80">En Stock</p>
                  <p className="text-2xl font-bold text-emerald-700">{kpis.inStock}</p>
                </div>
              </div>

              {/* Garantía Vencida */}
              <div className="flex items-center gap-4 p-4 rounded-xl border border-red-100 bg-gradient-to-br from-red-50 to-white">
                <div className="flex items-center justify-center h-12 w-12 rounded-lg bg-red-100">
                  <ShieldAlert className="h-6 w-6 text-red-600" />
                </div>
                <div>
                  <p className="text-sm font-medium text-red-600/80">Garantía Vencida</p>
                  <p className="text-2xl font-bold text-red-700">{kpis.warrantyExpired}</p>
                </div>
              </div>
            </div>
          </div>

          {/* ===== SUB-TABS + EXPORT BUTTONS ===== */}
          <div className="px-6 py-3 bg-white border-b flex items-center justify-between">
            <div className="flex items-center gap-1">
              {subTabs.map((tab) => (
                <button
                  key={tab.key}
                  onClick={() => setActiveTab(tab.key)}
                  className={cn(
                    "flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-all",
                    activeTab === tab.key
                      ? "bg-blue-600 text-white shadow-sm"
                      : "text-gray-600 hover:bg-gray-100 hover:text-gray-800"
                  )}
                >
                  {tab.icon}
                  {tab.label}
                </button>
              ))}
            </div>

            <div className="flex items-center gap-2">
              <input
                type="file"
                accept=".csv"
                ref={csvInputRef}
                onChange={handleImportCsv}
                className="hidden"
              />
              <Button
                onClick={() => csvInputRef.current?.click()}
                disabled={isImporting}
                size="sm"
                variant="outline"
                className="border-blue-300 text-blue-700 hover:bg-blue-50"
              >
                {isImporting ? (
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                ) : (
                  <Upload className="h-4 w-4 mr-2" />
                )}
                Importar CSV
              </Button>
              <Button
                onClick={handleExportCsv}
                disabled={isExporting !== null}
                size="sm"
                variant="outline"
                className="border-emerald-300 text-emerald-700 hover:bg-emerald-50"
              >
                {isExporting === "csv" ? (
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                ) : (
                  <FileText className="h-4 w-4 mr-2" />
                )}
                Exportar CSV
              </Button>
              <Button
                onClick={handleExportExcel}
                disabled={isExporting !== null}
                size="sm"
                className="bg-green-600 hover:bg-green-700 text-white"
              >
                {isExporting === "excel" ? (
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                ) : (
                  <FileSpreadsheet className="h-4 w-4 mr-2" />
                )}
                Exportar Excel
              </Button>
            </div>
          </div>

          {/* ===== TABLE CONTENT ===== */}
          <div className="flex-1 overflow-auto px-6 py-4">
            {isLoading ? (
              <div className="flex items-center justify-center h-48">
                <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
              </div>
            ) : (
              <div className="bg-white rounded-lg border shadow-sm">
                {/* Tab description */}
                <div className="px-4 py-3 border-b bg-gray-50/50">
                  <p className="text-sm text-gray-500">
                    {subTabs.find((t) => t.key === activeTab)?.description} — Mostrando{" "}
                    <span className="font-semibold text-gray-700">{filteredAssets.length}</span> registros
                    {chips.length > 0 && " (filtrados)"}
                  </p>
                </div>

                {/* ===== REPORTE ADMINISTRATIVO ===== */}
                {activeTab === "administrativo" && (
                  <Table>
                    <TableHeader>
                      <TableRow className="bg-gray-50">
                        <TableHead className="font-semibold text-gray-700">Nombre del Equipo</TableHead>
                        <TableHead className="font-semibold text-gray-700">No. Serie</TableHead>
                        <TableHead className="font-semibold text-gray-700">Usuario Responsable</TableHead>
                        <TableHead className="font-semibold text-gray-700">Departamento</TableHead>
                        <TableHead className="font-semibold text-gray-700">Empresa</TableHead>
                        <TableHead className="font-semibold text-gray-700">Sitio</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {paginatedAssets.length === 0 ? (
                        <TableRow>
                          <TableCell colSpan={7} className="text-center text-gray-500 py-12">
                            No se encontraron equipos con los filtros aplicados
                          </TableCell>
                        </TableRow>
                      ) : (
                        paginatedAssets.map((asset) => (
                          <TableRow key={asset.assetID} className="hover:bg-blue-50/30">
                            <TableCell className="font-medium text-gray-800">{asset.name}</TableCell>
                            <TableCell className="font-mono text-sm text-gray-600">
                              {asset.assetDetail?.serialNum || "N/A"}
                            </TableCell>
                            <TableCell className="text-gray-700">{asset.user?.name || "-"}</TableCell>
                            <TableCell className="text-gray-700">{asset.depart?.Name || "-"}</TableCell>
                            <TableCell className="text-gray-600 text-sm">{asset.company?.description || "-"}</TableCell>
                            <TableCell className="text-gray-600 text-sm">{asset.site?.name || "-"}</TableCell>
                          </TableRow>
                        ))
                      )}
                    </TableBody>
                  </Table>
                )}

                {/* ===== REPORTE TÉCNICO ===== */}
                {activeTab === "tecnico" && (
                  <Table>
                    <TableHeader>
                      <TableRow className="bg-gray-50">
                        <TableHead className="font-semibold text-gray-700">Nombre del Equipo</TableHead>
                        <TableHead className="font-semibold text-gray-700">Dirección IP</TableHead>
                        <TableHead className="font-semibold text-gray-700">MAC Address</TableHead>
                        <TableHead className="font-semibold text-gray-700">Sistema Operativo</TableHead>
                        <TableHead className="font-semibold text-gray-700">Memoria RAM</TableHead>
                        <TableHead className="font-semibold text-gray-700">Procesador</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {paginatedAssets.length === 0 ? (
                        <TableRow>
                          <TableCell colSpan={6} className="text-center text-gray-500 py-12">
                            No se encontraron equipos con los filtros aplicados
                          </TableCell>
                        </TableRow>
                      ) : (
                        paginatedAssets.map((asset) => (
                          <TableRow key={asset.assetID} className="hover:bg-blue-50/30">
                            <TableCell className="font-medium text-gray-800">{asset.name}</TableCell>
                            <TableCell className="font-mono text-sm text-gray-600">
                              {asset.assetDetail?.ipAddress || "-"}
                            </TableCell>
                            <TableCell className="font-mono text-sm text-gray-600">
                              {asset.assetDetail?.macAddress || "-"}
                            </TableCell>
                            <TableCell className="text-gray-700">
                              {asset.assetDetail?.operatingSystem || asset.assetDetail?.osName || "-"}
                            </TableCell>
                            <TableCell className="text-gray-700">
                              {asset.assetDetail?.ram || asset.assetDetail?.physicalMemory || "-"}
                            </TableCell>
                            <TableCell className="text-gray-700 text-sm">
                              {asset.assetDetail?.processor || asset.assetDetail?.processorInfo || "-"}
                            </TableCell>
                          </TableRow>
                        ))
                      )}
                    </TableBody>
                  </Table>
                )}

                {/* ===== REPORTE CICLO DE VIDA ===== */}
                {activeTab === "ciclo-vida" && (
                  <Table>
                    <TableHeader>
                      <TableRow className="bg-gray-50">
                        <TableHead className="font-semibold text-gray-700">Nombre del Equipo</TableHead>
                        <TableHead className="font-semibold text-gray-700">No. Serie</TableHead>
                        <TableHead className="font-semibold text-gray-700">Proveedor</TableHead>
                        <TableHead className="font-semibold text-gray-700">Fecha de Compra</TableHead>
                        <TableHead className="font-semibold text-gray-700">Vencimiento de Garantía</TableHead>
                        <TableHead className="font-semibold text-gray-700">Estado</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {paginatedAssets.length === 0 ? (
                        <TableRow>
                          <TableCell colSpan={7} className="text-center text-gray-500 py-12">
                            No se encontraron equipos con los filtros aplicados
                          </TableCell>
                        </TableRow>
                      ) : (
                        paginatedAssets.map((asset) => {
                          const warrantyDate =
                            asset.assetDetail?.warrantyExpiryDate ||
                            asset.assetDetail?.warrantyExpiry ||
                            asset.assetDetail?.assetExpiryDate;
                          const purchaseDate =
                            asset.assetDetail?.purchaseDate ||
                            asset.assetDetail?.assetACQDate;
                          const expired = isWarrantyExpired(warrantyDate);

                          return (
                            <TableRow key={asset.assetID} className="hover:bg-blue-50/30">
                              <TableCell className="font-medium text-gray-800">{asset.name}</TableCell>
                              <TableCell className="font-mono text-sm text-gray-600">
                                {asset.assetDetail?.serialNum || "N/A"}
                              </TableCell>
                              <TableCell className="text-gray-700">
                                {asset.vendor?.name || "-"}
                              </TableCell>
                              <TableCell className="text-gray-700 text-sm">
                                {formatDate(purchaseDate)}
                              </TableCell>
                              <TableCell>
                                <span
                                  className={cn(
                                    "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium",
                                    !warrantyDate
                                      ? "bg-gray-100 text-gray-600"
                                      : expired
                                      ? "bg-red-100 text-red-700"
                                      : "bg-green-100 text-green-700"
                                  )}
                                >
                                  {warrantyDate
                                    ? formatDate(warrantyDate)
                                    : "Sin registro"}
                                </span>
                              </TableCell>
                              <TableCell>
                                <span
                                  className={cn(
                                    "inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium",
                                    !warrantyDate
                                      ? "bg-gray-100 text-gray-500"
                                      : expired
                                      ? "bg-red-50 text-red-600 border border-red-200"
                                      : "bg-emerald-50 text-emerald-600 border border-emerald-200"
                                  )}
                                >
                                  {!warrantyDate ? "N/A" : expired ? "Vencida" : "Vigente"}
                                </span>
                              </TableCell>
                            </TableRow>
                          );
                        })
                      )}
                    </TableBody>
                  </Table>
                )}

                {/* ===== PAGINATION ===== */}
                {filteredAssets.length > PAGE_SIZE && (
                  <div className="flex items-center justify-between px-4 py-3 border-t bg-gray-50/50">
                    <p className="text-sm text-gray-500">
                      Mostrando {(currentPage - 1) * PAGE_SIZE + 1} -{" "}
                      {Math.min(currentPage * PAGE_SIZE, filteredAssets.length)} de{" "}
                      {filteredAssets.length}
                    </p>
                    <div className="flex items-center gap-1">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
                        disabled={currentPage === 1}
                        className="h-8 w-8 p-0"
                      >
                        <ChevronLeft className="h-4 w-4" />
                      </Button>
                      {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                        let page: number;
                        if (totalPages <= 5) {
                          page = i + 1;
                        } else if (currentPage <= 3) {
                          page = i + 1;
                        } else if (currentPage >= totalPages - 2) {
                          page = totalPages - 4 + i;
                        } else {
                          page = currentPage - 2 + i;
                        }
                        return (
                          <Button
                            key={page}
                            variant={currentPage === page ? "default" : "outline"}
                            size="sm"
                            onClick={() => setCurrentPage(page)}
                            className="h-8 w-8 p-0 text-xs"
                          >
                            {page}
                          </Button>
                        );
                      })}
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
                        disabled={currentPage === totalPages}
                        className="h-8 w-8 p-0"
                      >
                        <ChevronRight className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      )}
    </MainLayout>
  );
}
