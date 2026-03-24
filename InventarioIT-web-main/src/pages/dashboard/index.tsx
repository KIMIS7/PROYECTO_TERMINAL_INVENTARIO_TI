import { MainLayout } from "@/components/MainLayout";
import { requireAuthGSSP } from "@/lib/requireAuthGSSP";
import { useSession } from "next-auth/react";
import { useUserData } from "@/hooks/dashboard/useUserData";
import { useAlert } from "@/hooks/useAlert";
import { useEffect, useState, useMemo, useCallback } from "react";
import api from "@/lib/api";
import { Skeleton } from "@/components/ui/skeleton";
import { Badge } from "@/components/ui/badge";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  BarChart3,
  Shield,
  AlertTriangle,
  Clock,
  MapPin,
  RefreshCw,
  ShieldCheck,
  TrendingUp,
  Search,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";

interface DashboardStats {
  summary: {
    totalAssets: number;
    assignedAssets: number;
    inactiveAssets: number;
    obsoleteCount: number;
    warrantyExpiringCount: number;
    reassignments: number;
    activeWarrantyCount: number;
  };
  kpis: {
    utilizationRate: number;
    inactiveRate: number;
    obsolescenceRate: number;
    warrantyCoverageRate: number;
    warrantyExpiringCount: number;
    reassignments: number;
    avgAgeByType: { type: string; avgYears: number; count: number }[];
  };
  distributions: {
    bySite: { site: string; count: number }[];
    byState: { state: string; count: number }[];
  };
  assetsTable: {
    assetID: number;
    name: string;
    state: string;
    site: string;
    productType: string;
    group: string;
    warrantyExpiry: string | null;
    acquisitionDate: string | null;
    hasActiveWarranty: boolean;
    isObsolete: boolean;
  }[];
}

// KPI Card Component
function KpiCard({
  title,
  subtitle,
  value,
  suffix,
  icon: Icon,
  level,
  color,
}: {
  title: string;
  subtitle: string;
  value: number | string;
  suffix?: string;
  icon: React.ElementType;
  level: "Operativo" | "Estratégico";
  color: "blue" | "amber" | "red" | "green" | "purple" | "emerald";
}) {
  const colorMap = {
    blue: { bg: "bg-blue-50", icon: "text-blue-600", border: "border-blue-200", bar: "bg-blue-500" },
    amber: { bg: "bg-amber-50", icon: "text-amber-600", border: "border-amber-200", bar: "bg-amber-500" },
    red: { bg: "bg-red-50", icon: "text-red-600", border: "border-red-200", bar: "bg-red-500" },
    green: { bg: "bg-green-50", icon: "text-green-600", border: "border-green-200", bar: "bg-green-500" },
    purple: { bg: "bg-purple-50", icon: "text-purple-600", border: "border-purple-200", bar: "bg-purple-500" },
    emerald: { bg: "bg-emerald-50", icon: "text-emerald-600", border: "border-emerald-200", bar: "bg-emerald-500" },
  };
  const c = colorMap[color];

  return (
    <div className={`rounded-xl border ${c.border} ${c.bg} p-4 flex flex-col gap-3 transition-shadow hover:shadow-md`}>
      <div className="flex items-start justify-between">
        <div className="flex items-center gap-2">
          <div className={`rounded-lg p-2 ${c.bg}`}>
            <Icon className={`h-5 w-5 ${c.icon}`} />
          </div>
          <div>
            <p className="text-sm font-semibold text-gray-800">{title}</p>
            <p className="text-xs text-gray-500">{subtitle}</p>
          </div>
        </div>
        <Badge
          className={
            level === "Operativo"
              ? "bg-green-100 text-green-700 border-green-300 text-[10px]"
              : "bg-blue-100 text-blue-700 border-blue-300 text-[10px]"
          }
        >
          {level}
        </Badge>
      </div>
      <div className="flex items-end gap-1">
        <span className="text-3xl font-bold text-gray-900">{value}</span>
        {suffix && <span className="text-sm text-gray-500 mb-1">{suffix}</span>}
      </div>
      {typeof value === "number" && suffix === "%" && (
        <div className="w-full bg-gray-200 rounded-full h-1.5">
          <div
            className={`${c.bar} h-1.5 rounded-full transition-all duration-500`}
            style={{ width: `${Math.min(value as number, 100)}%` }}
          />
        </div>
      )}
    </div>
  );
}

// Section Header Component
function SectionHeader({ title }: { title: string }) {
  return (
    <div className="flex items-center gap-2 mt-2">
      <div className="h-px flex-1 bg-gray-200" />
      <h3 className="text-xs font-semibold text-gray-500 uppercase tracking-wider whitespace-nowrap">
        {title}
      </h3>
      <div className="h-px flex-1 bg-gray-200" />
    </div>
  );
}

// Mini distribution bar
function DistributionBar({ items, colorFn }: { items: { label: string; count: number }[]; colorFn: (i: number) => string }) {
  const total = items.reduce((sum, item) => sum + item.count, 0);
  if (total === 0) return null;

  return (
    <div className="space-y-2">
      {items.slice(0, 6).map((item, i) => (
        <div key={item.label} className="flex items-center gap-2">
          <span className="text-xs text-gray-600 w-28 truncate" title={item.label}>{item.label}</span>
          <div className="flex-1 bg-gray-100 rounded-full h-2">
            <div
              className={`h-2 rounded-full ${colorFn(i)}`}
              style={{ width: `${(item.count / total) * 100}%` }}
            />
          </div>
          <span className="text-xs font-medium text-gray-700 w-8 text-right">{item.count}</span>
        </div>
      ))}
    </div>
  );
}

export const getServerSideProps = requireAuthGSSP(async () => {
  return { props: {} };
});

export default function Dashboard() {
  const { data: session } = useSession();
  const { usuario } = useUserData();
  const userEmail = session?.user?.preferred_username || "";
  const { AlertDialog } = useAlert();

  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);

  // Table state
  const [search, setSearch] = useState("");
  const [filterState, setFilterState] = useState("all");
  const [filterSite, setFilterSite] = useState("all");
  const [filterGroup, setFilterGroup] = useState("all");
  const [filterWarranty, setFilterWarranty] = useState("all");
  const [sortField, setSortField] = useState<string>("assetID");
  const [sortDir, setSortDir] = useState<"asc" | "desc">("desc");
  const [page, setPage] = useState(1);
  const pageSize = 15;

  const fetchStats = useCallback(async () => {
    try {
      setLoading(true);
      const data = await api.statistics.getDashboard();
      setStats(data);
    } catch (err) {
      console.error("Error fetching dashboard stats:", err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchStats();
  }, [fetchStats]);

  // Derived filter options
  const uniqueStates = useMemo(() => {
    if (!stats) return [];
    return [...new Set(stats.assetsTable.map((a) => a.state))].sort();
  }, [stats]);

  const uniqueSites = useMemo(() => {
    if (!stats) return [];
    return [...new Set(stats.assetsTable.map((a) => a.site))].sort();
  }, [stats]);

  const uniqueGroups = useMemo(() => {
    if (!stats) return [];
    return [...new Set(stats.assetsTable.map((a) => a.group))].sort();
  }, [stats]);

  // Filtered & sorted table data
  const filteredAssets = useMemo(() => {
    if (!stats) return [];
    let data = stats.assetsTable;

    if (search) {
      const q = search.toLowerCase();
      data = data.filter(
        (a) =>
          a.name.toLowerCase().includes(q) ||
          a.productType.toLowerCase().includes(q) ||
          a.assetID.toString().includes(q)
      );
    }
    if (filterState !== "all") data = data.filter((a) => a.state === filterState);
    if (filterSite !== "all") data = data.filter((a) => a.site === filterSite);
    if (filterGroup !== "all") data = data.filter((a) => a.group === filterGroup);
    if (filterWarranty === "active") data = data.filter((a) => a.hasActiveWarranty);
    if (filterWarranty === "expired") data = data.filter((a) => !a.hasActiveWarranty && a.warrantyExpiry);
    if (filterWarranty === "obsolete") data = data.filter((a) => a.isObsolete);

    // Sort
    data = [...data].sort((a, b) => {
      const aVal = a[sortField as keyof typeof a];
      const bVal = b[sortField as keyof typeof b];
      if (aVal == null && bVal == null) return 0;
      if (aVal == null) return 1;
      if (bVal == null) return -1;
      if (typeof aVal === "number" && typeof bVal === "number") {
        return sortDir === "asc" ? aVal - bVal : bVal - aVal;
      }
      return sortDir === "asc"
        ? String(aVal).localeCompare(String(bVal))
        : String(bVal).localeCompare(String(aVal));
    });

    return data;
  }, [stats, search, filterState, filterSite, filterGroup, filterWarranty, sortField, sortDir]);

  const totalPages = Math.ceil(filteredAssets.length / pageSize);
  const paginatedAssets = filteredAssets.slice((page - 1) * pageSize, page * pageSize);

  const handleSort = (field: string) => {
    if (sortField === field) {
      setSortDir(sortDir === "asc" ? "desc" : "asc");
    } else {
      setSortField(field);
      setSortDir("asc");
    }
    setPage(1);
  };

  // Reset page when filters change
  useEffect(() => {
    setPage(1);
  }, [search, filterState, filterSite, filterGroup, filterWarranty]);

  const siteColors = ["bg-blue-500", "bg-indigo-500", "bg-purple-500", "bg-cyan-500", "bg-teal-500", "bg-sky-500"];
  const stateColors = ["bg-green-500", "bg-amber-500", "bg-red-500", "bg-blue-500", "bg-gray-500", "bg-purple-500"];

  return (
    <>
      <AlertDialog />
      <MainLayout breadcrumb={{ title: "Dashboard", subtitle: "KPIs e Indicadores" }}>
        {() => (
          <div className="flex flex-1 flex-col gap-4 p-4 pt-4 overflow-auto">
            {/* Header */}
            <div className="flex items-center justify-between">
              <div>
                <h1 className="text-2xl font-bold text-gray-900">Dashboard de Inventario TI</h1>
                <p className="text-sm text-gray-500">
                  Bienvenido, {usuario || userEmail}
                </p>
              </div>
              <button
                onClick={fetchStats}
                disabled={loading}
                className="flex items-center gap-2 px-3 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50"
              >
                <RefreshCw className={`h-4 w-4 ${loading ? "animate-spin" : ""}`} />
                Actualizar
              </button>
            </div>

            {/* Legend */}
            <div className="flex items-center gap-4 text-xs">
              <div className="flex items-center gap-1">
                <span className="inline-block w-2 h-2 rounded-full bg-green-500" />
                <span className="text-gray-600"><strong>Operativo</strong> - Monitoreo diario/semanal del area de TI</span>
              </div>
              <div className="flex items-center gap-1">
                <span className="inline-block w-2 h-2 rounded-full bg-blue-500" />
                <span className="text-gray-600"><strong>Estrategico</strong> - Decisiones de gerencia y presupuesto</span>
              </div>
            </div>

            {loading ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                {Array.from({ length: 8 }).map((_, i) => (
                  <Skeleton key={i} className="h-36 rounded-xl" />
                ))}
              </div>
            ) : stats ? (
              <>
                {/* ========== SECCIÓN 1: UTILIZACIÓN Y DISPONIBILIDAD ========== */}
                <SectionHeader title="Utilización y Disponibilidad" />
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <KpiCard
                    title="Tasa de utilización de activos"
                    subtitle="Activos asignados / total de activos"
                    value={stats.kpis.utilizationRate}
                    suffix="%"
                    icon={TrendingUp}
                    level="Estratégico"
                    color="blue"
                  />
                  <KpiCard
                    title="Equipos inactivos o en reparación"
                    subtitle="Baja + Mantenimiento + Resguardo"
                    value={stats.kpis.inactiveRate}
                    suffix="%"
                    icon={AlertTriangle}
                    level="Operativo"
                    color="amber"
                  />
                </div>

                {/* ========== SECCIÓN 2: CICLO DE VIDA Y OBSOLESCENCIA ========== */}
                <SectionHeader title="Ciclo de Vida y Obsolescencia" />
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <KpiCard
                    title="Índice de obsolescencia"
                    subtitle="Activos con más de 4 años"
                    value={stats.kpis.obsolescenceRate}
                    suffix="%"
                    icon={Clock}
                    level="Estratégico"
                    color="red"
                  />
                  <KpiCard
                    title="Próximos a vencer garantía"
                    subtitle="Garantía vence en los próximos 90 días"
                    value={stats.kpis.warrantyExpiringCount}
                    suffix="activos"
                    icon={Shield}
                    level="Operativo"
                    color="purple"
                  />
                  <div className="rounded-xl border border-gray-200 bg-white p-4">
                    <div className="flex items-center justify-between mb-3">
                      <div>
                        <p className="text-sm font-semibold text-gray-800">Antigüedad promedio por tipo</p>
                        <p className="text-xs text-gray-500">Promedio de años desde adquisición</p>
                      </div>
                      <Badge className="bg-blue-100 text-blue-700 border-blue-300 text-[10px]">
                        Estratégico
                      </Badge>
                    </div>
                    <div className="space-y-2 max-h-32 overflow-y-auto">
                      {stats.kpis.avgAgeByType.slice(0, 5).map((item) => (
                        <div key={item.type} className="flex items-center justify-between text-xs">
                          <span className="text-gray-600 truncate max-w-[140px]" title={item.type}>{item.type}</span>
                          <div className="flex items-center gap-2">
                            <span className="text-gray-500">{item.count} equipo{item.count !== 1 ? "s" : ""}</span>
                            <span className={`font-bold ${item.avgYears > 4 ? "text-red-600" : item.avgYears > 2 ? "text-amber-600" : "text-green-600"}`}>
                              {item.avgYears} años
                            </span>
                          </div>
                        </div>
                      ))}
                      {stats.kpis.avgAgeByType.length === 0 && (
                        <p className="text-xs text-gray-400 italic">Sin datos de adquisición</p>
                      )}
                    </div>
                  </div>
                </div>

                {/* ========== SECCIÓN 3: DISTRIBUCIÓN Y TRAZABILIDAD ========== */}
                <SectionHeader title="Distribución y Trazabilidad" />
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div className="rounded-xl border border-gray-200 bg-white p-4">
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-2">
                        <MapPin className="h-5 w-5 text-blue-600" />
                        <div>
                          <p className="text-sm font-semibold text-gray-800">Distribución por sede</p>
                          <p className="text-xs text-gray-500">Activos agrupados por SiteID</p>
                        </div>
                      </div>
                      <Badge className="bg-blue-100 text-blue-700 border-blue-300 text-[10px]">Estratégico</Badge>
                    </div>
                    <DistributionBar
                      items={stats.distributions.bySite.map((s) => ({ label: s.site, count: s.count }))}
                      colorFn={(i) => siteColors[i % siteColors.length]}
                    />
                  </div>

                  <KpiCard
                    title="Frecuencia de reasignaciones"
                    subtitle="Total de movimientos REASIGNACIÓN"
                    value={stats.kpis.reassignments}
                    suffix="movimientos"
                    icon={RefreshCw}
                    level="Operativo"
                    color="emerald"
                  />

                  <KpiCard
                    title="Cobertura de garantía activa"
                    subtitle="Activos con garantía vigente"
                    value={stats.kpis.warrantyCoverageRate}
                    suffix="%"
                    icon={ShieldCheck}
                    level="Estratégico"
                    color="green"
                  />
                </div>

                {/* Distribution by state mini chart */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="rounded-xl border border-gray-200 bg-white p-4">
                    <div className="flex items-center gap-2 mb-3">
                      <BarChart3 className="h-5 w-5 text-indigo-600" />
                      <div>
                        <p className="text-sm font-semibold text-gray-800">Distribución por estado</p>
                        <p className="text-xs text-gray-500">Estado actual de todos los activos</p>
                      </div>
                    </div>
                    <DistributionBar
                      items={stats.distributions.byState.map((s) => ({ label: s.state, count: s.count }))}
                      colorFn={(i) => stateColors[i % stateColors.length]}
                    />
                  </div>
                  <div className="rounded-xl border border-gray-200 bg-white p-4">
                    <div className="flex items-center gap-2 mb-3">
                      <BarChart3 className="h-5 w-5 text-indigo-600" />
                      <div>
                        <p className="text-sm font-semibold text-gray-800">Resumen general</p>
                        <p className="text-xs text-gray-500">Cifras clave del inventario</p>
                      </div>
                    </div>
                    <div className="grid grid-cols-2 gap-3">
                      <div className="text-center p-2 rounded-lg bg-blue-50">
                        <p className="text-2xl font-bold text-blue-700">{stats.summary.totalAssets}</p>
                        <p className="text-xs text-gray-600">Total activos</p>
                      </div>
                      <div className="text-center p-2 rounded-lg bg-green-50">
                        <p className="text-2xl font-bold text-green-700">{stats.summary.assignedAssets}</p>
                        <p className="text-xs text-gray-600">Asignados</p>
                      </div>
                      <div className="text-center p-2 rounded-lg bg-amber-50">
                        <p className="text-2xl font-bold text-amber-700">{stats.summary.inactiveAssets}</p>
                        <p className="text-xs text-gray-600">Inactivos</p>
                      </div>
                      <div className="text-center p-2 rounded-lg bg-purple-50">
                        <p className="text-2xl font-bold text-purple-700">{stats.summary.activeWarrantyCount}</p>
                        <p className="text-xs text-gray-600">Con garantía</p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* ========== TABLA DINÁMICA ========== */}
                <SectionHeader title="Tabla Dinámica de Activos" />
                <div className="rounded-xl border border-gray-200 bg-white p-4 space-y-3">
                  {/* Filters */}
                  <div className="flex flex-wrap items-center gap-3">
                    <div className="relative flex-1 min-w-[200px] max-w-sm">
                      <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                      <input
                        type="text"
                        placeholder="Buscar por nombre, tipo o ID..."
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                        className="w-full pl-9 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                      />
                    </div>
                    <Select value={filterState} onValueChange={setFilterState}>
                      <SelectTrigger className="w-[140px] text-xs">
                        <SelectValue placeholder="Estado" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">Todos los estados</SelectItem>
                        {uniqueStates.map((s) => (
                          <SelectItem key={s} value={s}>{s}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <Select value={filterSite} onValueChange={setFilterSite}>
                      <SelectTrigger className="w-[140px] text-xs">
                        <SelectValue placeholder="Sede" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">Todas las sedes</SelectItem>
                        {uniqueSites.map((s) => (
                          <SelectItem key={s} value={s}>{s}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <Select value={filterGroup} onValueChange={setFilterGroup}>
                      <SelectTrigger className="w-[140px] text-xs">
                        <SelectValue placeholder="Grupo" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">Todos los grupos</SelectItem>
                        {uniqueGroups.map((g) => (
                          <SelectItem key={g} value={g}>{g}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <Select value={filterWarranty} onValueChange={setFilterWarranty}>
                      <SelectTrigger className="w-[160px] text-xs">
                        <SelectValue placeholder="Garantía" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">Todas</SelectItem>
                        <SelectItem value="active">Garantía activa</SelectItem>
                        <SelectItem value="expired">Garantía vencida</SelectItem>
                        <SelectItem value="obsolete">Obsoletos (+4 años)</SelectItem>
                      </SelectContent>
                    </Select>
                    <span className="text-xs text-gray-500 ml-auto">
                      {filteredAssets.length} resultado{filteredAssets.length !== 1 ? "s" : ""}
                    </span>
                  </div>

                  {/* Table */}
                  <div className="overflow-x-auto">
                    <Table>
                      <TableHeader>
                        <TableRow className="bg-gray-50">
                          {[
                            { key: "assetID", label: "ID" },
                            { key: "name", label: "Nombre" },
                            { key: "productType", label: "Tipo" },
                            { key: "group", label: "Grupo" },
                            { key: "state", label: "Estado" },
                            { key: "site", label: "Sede" },
                            { key: "warrantyExpiry", label: "Venc. Garantía" },
                            { key: "acquisitionDate", label: "Adquisición" },
                            { key: "status", label: "Indicadores" },
                          ].map((col) => (
                            <TableHead
                              key={col.key}
                              className={`text-xs font-semibold ${col.key !== "status" ? "cursor-pointer hover:text-blue-600 select-none" : ""}`}
                              onClick={col.key !== "status" ? () => handleSort(col.key) : undefined}
                            >
                              <div className="flex items-center gap-1">
                                {col.label}
                                {sortField === col.key && (
                                  <span className="text-blue-600">{sortDir === "asc" ? "↑" : "↓"}</span>
                                )}
                              </div>
                            </TableHead>
                          ))}
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {paginatedAssets.length === 0 ? (
                          <TableRow>
                            <TableCell colSpan={9} className="text-center text-gray-400 py-8">
                              No se encontraron activos con los filtros seleccionados
                            </TableCell>
                          </TableRow>
                        ) : (
                          paginatedAssets.map((asset) => (
                            <TableRow key={asset.assetID} className="hover:bg-gray-50">
                              <TableCell className="text-xs font-mono text-gray-500">{asset.assetID}</TableCell>
                              <TableCell className="text-xs font-medium text-gray-900 max-w-[200px] truncate">{asset.name}</TableCell>
                              <TableCell className="text-xs text-gray-600">{asset.productType}</TableCell>
                              <TableCell>
                                <Badge variant="outline" className="text-[10px]">{asset.group}</Badge>
                              </TableCell>
                              <TableCell>
                                <Badge
                                  className={`text-[10px] ${
                                    asset.state === "Baja" ? "bg-red-100 text-red-700 border-red-300" :
                                    asset.state === "Stock" ? "bg-gray-100 text-gray-700 border-gray-300" :
                                    asset.state === "Asignado" ? "bg-green-100 text-green-700 border-green-300" :
                                    asset.state === "Mantenimiento" ? "bg-amber-100 text-amber-700 border-amber-300" :
                                    asset.state === "Resguardo" ? "bg-purple-100 text-purple-700 border-purple-300" :
                                    "bg-gray-100 text-gray-700 border-gray-300"
                                  }`}
                                >
                                  {asset.state}
                                </Badge>
                              </TableCell>
                              <TableCell className="text-xs text-gray-600">{asset.site}</TableCell>
                              <TableCell className="text-xs text-gray-600">
                                {asset.warrantyExpiry
                                  ? new Date(asset.warrantyExpiry).toLocaleDateString("es-MX")
                                  : "—"}
                              </TableCell>
                              <TableCell className="text-xs text-gray-600">
                                {asset.acquisitionDate
                                  ? new Date(asset.acquisitionDate).toLocaleDateString("es-MX")
                                  : "—"}
                              </TableCell>
                              <TableCell>
                                <div className="flex gap-1">
                                  {asset.hasActiveWarranty && (
                                    <span title="Garantía activa" className="inline-flex items-center justify-center h-5 w-5 rounded-full bg-green-100">
                                      <ShieldCheck className="h-3 w-3 text-green-600" />
                                    </span>
                                  )}
                                  {asset.isObsolete && (
                                    <span title="Obsoleto (+4 años)" className="inline-flex items-center justify-center h-5 w-5 rounded-full bg-red-100">
                                      <Clock className="h-3 w-3 text-red-600" />
                                    </span>
                                  )}
                                  {!asset.hasActiveWarranty && asset.warrantyExpiry && (
                                    <span title="Garantía vencida" className="inline-flex items-center justify-center h-5 w-5 rounded-full bg-amber-100">
                                      <AlertTriangle className="h-3 w-3 text-amber-600" />
                                    </span>
                                  )}
                                </div>
                              </TableCell>
                            </TableRow>
                          ))
                        )}
                      </TableBody>
                    </Table>
                  </div>

                  {/* Pagination */}
                  {totalPages > 1 && (
                    <div className="flex items-center justify-between pt-2">
                      <span className="text-xs text-gray-500">
                        Página {page} de {totalPages}
                      </span>
                      <div className="flex items-center gap-1">
                        <button
                          onClick={() => setPage((p) => Math.max(1, p - 1))}
                          disabled={page === 1}
                          className="p-1.5 rounded-lg border border-gray-300 hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed"
                        >
                          <ChevronLeft className="h-4 w-4" />
                        </button>
                        {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                          let pageNum: number;
                          if (totalPages <= 5) {
                            pageNum = i + 1;
                          } else if (page <= 3) {
                            pageNum = i + 1;
                          } else if (page >= totalPages - 2) {
                            pageNum = totalPages - 4 + i;
                          } else {
                            pageNum = page - 2 + i;
                          }
                          return (
                            <button
                              key={pageNum}
                              onClick={() => setPage(pageNum)}
                              className={`px-2.5 py-1 text-xs rounded-lg border ${
                                page === pageNum
                                  ? "bg-blue-600 text-white border-blue-600"
                                  : "border-gray-300 hover:bg-gray-50"
                              }`}
                            >
                              {pageNum}
                            </button>
                          );
                        })}
                        <button
                          onClick={() => setPage((p) => Math.min(totalPages, p + 1))}
                          disabled={page === totalPages}
                          className="p-1.5 rounded-lg border border-gray-300 hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed"
                        >
                          <ChevronRight className="h-4 w-4" />
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              </>
            ) : (
              <div className="text-center py-12 text-gray-500">
                <p>No se pudieron cargar las estadísticas</p>
                <button onClick={fetchStats} className="mt-2 text-blue-600 hover:underline text-sm">
                  Reintentar
                </button>
              </div>
            )}
          </div>
        )}
      </MainLayout>
    </>
  );
}
