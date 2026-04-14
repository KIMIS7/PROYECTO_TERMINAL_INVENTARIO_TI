import { MainLayout } from "@/components/MainLayout";
import { requireAuthGSSP } from "@/lib/requireAuthGSSP";
import { useSession } from "next-auth/react";
import { useUserData } from "@/hooks/dashboard/useUserData";
import { useAlert } from "@/hooks/useAlert";
import { useEffect, useState, useCallback, useRef } from "react";
import api from "@/lib/api";
import { Skeleton } from "@/components/ui/skeleton";
import { Badge } from "@/components/ui/badge";
import { RefreshCw, ChevronDown, X, Filter, AlertTriangle, Shield } from "lucide-react";

interface FilterOptions {
  sites: { siteID: number; name: string }[];
  groups: string[];
  states: { stateID: number; name: string }[];
}

interface DashboardFilters {
  siteID?: number;
  group?: string;
  stateID?: number;
}

interface DashboardStats {
  summary: {
    totalAssets: number;
    assignedAssets: number;
    inactiveAssets: number;
    obsoleteCount: number;
    warrantyExpiringCount: number;
    reassignments: number;
    activeWarrantyCount: number;
    newAssetsThisMonth: number;
    unassignedCount: number;
    warrantyExpiringPercent: number;
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
  movementsByMonth: { month: string; count: number }[];
  warrantyAlerts: { name: string; site: string; daysUntilExpiry: number }[];
  recentMovements: { assetName: string; operation: string; user: string; date: string }[];
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
  filterOptions?: FilterOptions;
  dataCompleteness?: {
    noSiteCount: number;
    noUserCount: number;
    noAcqDateCount: number;
    noWarrantyCount: number;
    completenessPercent: number;
  };
  siteRiskRanking?: {
    siteID: number;
    name: string;
    total: number;
    obsolete: number;
    noWarranty: number;
    noUser: number;
    riskScore: number;
    level: 'green' | 'yellow' | 'red';
  }[];
  warrantyTimeline?: { period: string; count: number }[];
}

// Donut chart SVG component
function DonutChart({
  items,
}: {
  items: { label: string; count: number; color: string }[];
}) {
  const total = items.reduce((s, i) => s + i.count, 0);
  if (total === 0) return null;

  const radius = 60;
  const strokeWidth = 20;
  const circumference = 2 * Math.PI * radius;
  let offset = 0;

  return (
    <div className="flex items-center gap-6">
      <svg width="160" height="160" viewBox="0 0 160 160" className="flex-shrink-0">
        {items.map((item, i) => {
          const pct = item.count / total;
          const dash = pct * circumference;
          const currentOffset = offset;
          offset += dash;
          return (
            <circle
              key={i}
              cx="80"
              cy="80"
              r={radius}
              fill="none"
              stroke={item.color}
              strokeWidth={strokeWidth}
              strokeDasharray={`${dash} ${circumference - dash}`}
              strokeDashoffset={-currentOffset}
              transform="rotate(-90 80 80)"
            />
          );
        })}
      </svg>
      <div className="space-y-2">
        {items.map((item, i) => {
          const pct = Math.round((item.count / total) * 100);
          return (
            <div key={i} className="flex items-center gap-2 text-sm">
              <span
                className="w-3 h-3 rounded-sm flex-shrink-0"
                style={{ backgroundColor: item.color }}
              />
              <span className="text-gray-700">
                {item.label} — {pct}%
              </span>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// Card wrapper
function DashCard({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <div
      className={`rounded-xl border border-gray-200 bg-white p-5 shadow-sm ${className}`}
    >
      {children}
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
  const [filters, setFilters] = useState<DashboardFilters>({});
  const [filterOptions, setFilterOptions] = useState<FilterOptions>({ sites: [], groups: [], states: [] });
  const initialLoad = useRef(true);

  const fetchStats = useCallback(async (f?: DashboardFilters) => {
    try {
      setLoading(true);
      const activeFilters = f ?? filters;
      const data = await api.statistics.getDashboard(activeFilters);
      setStats(data);
      if (data.filterOptions) {
        setFilterOptions(data.filterOptions);
      }
    } catch (err) {
      console.error("Error fetching dashboard stats:", err);
    } finally {
      setLoading(false);
    }
  }, [filters]);

  useEffect(() => {
    if (initialLoad.current) {
      initialLoad.current = false;
      fetchStats({});
      return;
    }
    fetchStats();
  }, [fetchStats]);

  const updateFilter = (key: keyof DashboardFilters, value: number | string | undefined) => {
    setFilters((prev) => {
      const next = { ...prev };
      if (value === undefined) {
        delete next[key];
      } else {
        (next as Record<string, unknown>)[key] = value;
      }
      return next;
    });
  };

  const clearFilters = () => setFilters({});
  const hasActiveFilters = filters.siteID || filters.group || filters.stateID;

  // State colors for donut chart
  const stateColorMap: Record<string, string> = {
    Asignado: "#22c55e",
    Stock: "#f59e0b",
    Mantenimiento: "#ef4444",
    Resguardo: "#3b82f6",
    Baja: "#9ca3af",
  };

  // Bar colors for age by type
  const ageBarColors = ["#ef4444", "#f59e0b", "#f97316", "#22c55e", "#3b82f6", "#8b5cf6"];

  // Operation badge styles
  const operationStyles: Record<string, string> = {
    CREATE: "bg-green-100 text-green-700",
    Alta: "bg-green-100 text-green-700",
    REASIGNACION: "bg-blue-100 text-blue-700",
    Reasig: "bg-blue-100 text-blue-700",
    UPDATE: "bg-amber-100 text-amber-700",
    BAJA: "bg-red-100 text-red-700",
    Baja: "bg-red-100 text-red-700",
    RESGUARDO: "bg-purple-100 text-purple-700",
    REPARACION: "bg-orange-100 text-orange-700",
  };

  const getOperationLabel = (op: string) => {
    const labels: Record<string, string> = {
      CREATE: "Alta",
      REASIGNACION: "Reasig.",
      UPDATE: "Actualiz.",
      BAJA: "Baja",
      RESGUARDO: "Resg.",
      REPARACION: "Repar.",
    };
    return labels[op] || op;
  };

  const formatShortDate = (dateStr: string) => {
    const d = new Date(dateStr);
    const day = d.getDate();
    const months = ["ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic"];
    return `${day} ${months[d.getMonth()]}`;
  };

  return (
    <>
      <AlertDialog />
      <MainLayout breadcrumb={{ title: "Dashboard", subtitle: "KPIs e Indicadores" }}>
        {() => (
          <div className="flex flex-1 flex-col gap-5 p-5 overflow-auto bg-[#f5f3ef]">
            {/* Header */}
            <div className="flex items-center justify-between">
              <div>
                <h1 className="text-2xl font-bold text-gray-900">
                  Dashboard de Inventario TI
                </h1>
                <p className="text-sm text-gray-500">
                  Bienvenido, {usuario || userEmail}
                </p>
              </div>
              <button
                onClick={() => fetchStats()}
                disabled={loading}
                className="flex items-center gap-2 px-3 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50"
              >
                <RefreshCw className={`h-4 w-4 ${loading ? "animate-spin" : ""}`} />
                Actualizar
              </button>
            </div>

            {/* Filters */}
            <div className="flex flex-wrap items-center gap-3 rounded-xl border border-gray-200 bg-white px-4 py-3 shadow-sm">
              <Filter className="h-4 w-4 text-gray-400 shrink-0" />

              {/* Site / Hotel */}
              <select
                value={filters.siteID ?? ""}
                onChange={(e) => updateFilter("siteID", e.target.value ? Number(e.target.value) : undefined)}
                className="h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700"
              >
                <option value="">Todos los sites</option>
                {filterOptions.sites.map((s) => (
                  <option key={s.siteID} value={s.siteID}>{s.name}</option>
                ))}
              </select>

              {/* Group */}
              <select
                value={filters.group ?? ""}
                onChange={(e) => updateFilter("group", e.target.value || undefined)}
                className="h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700"
              >
                <option value="">Todos los grupos</option>
                {filterOptions.groups.map((g) => (
                  <option key={g} value={g}>{g}</option>
                ))}
              </select>

              {/* State */}
              <select
                value={filters.stateID ?? ""}
                onChange={(e) => updateFilter("stateID", e.target.value ? Number(e.target.value) : undefined)}
                className="h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700"
              >
                <option value="">Todos los estados</option>
                {filterOptions.states.map((s) => (
                  <option key={s.stateID} value={s.stateID}>{s.name}</option>
                ))}
              </select>

              {hasActiveFilters && (
                <button
                  onClick={clearFilters}
                  className="flex items-center gap-1 h-8 px-2 text-sm text-red-600 hover:bg-red-50 rounded-md transition-colors"
                >
                  <X className="h-3.5 w-3.5" />
                  Limpiar
                </button>
              )}
            </div>

            {loading ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                {Array.from({ length: 8 }).map((_, i) => (
                  <Skeleton key={i} className="h-28 rounded-xl" />
                ))}
              </div>
            ) : stats ? (
              <>
                {/* ==================== ROW 1: KPI CARDS ==================== */}
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                  {/* Total de activos */}
                  <DashCard>
                    <p className="text-xs text-gray-500 font-medium">Total de activos</p>
                    <p className="text-3xl font-bold text-gray-900 mt-1">
                      {stats.summary.totalAssets.toLocaleString()}
                    </p>
                    {stats.summary.newAssetsThisMonth > 0 && (
                      <p className="text-xs text-green-600 font-medium mt-1">
                        +{stats.summary.newAssetsThisMonth} este mes
                      </p>
                    )}
                  </DashCard>

                  {/* Tasa de utilización */}
                  <DashCard>
                    <p className="text-xs text-gray-500 font-medium">Tasa de utilización</p>
                    <p className="text-3xl font-bold text-gray-900 mt-1">
                      {stats.kpis.utilizationRate}%
                    </p>
                    <p className="text-xs text-gray-500 mt-1">
                      {stats.summary.unassignedCount} equipos sin asignar
                    </p>
                  </DashCard>

                  {/* Índice de obsolescencia */}
                  <DashCard>
                    <p className="text-xs text-gray-500 font-medium">Índice de obsolescencia</p>
                    <p className="text-3xl font-bold text-gray-900 mt-1">
                      {stats.kpis.obsolescenceRate}%
                    </p>
                    <p className="text-xs text-amber-600 italic mt-1">
                      {stats.summary.obsoleteCount} equipos &gt;4 años
                    </p>
                  </DashCard>

                  {/* Garantías por vencer */}
                  <DashCard>
                    <p className="text-xs text-gray-500 font-medium">Garantías por vencer (90 días)</p>
                    <p className="text-3xl font-bold text-gray-900 mt-1">
                      {stats.summary.warrantyExpiringCount}
                    </p>
                    <p className="text-xs text-gray-500 mt-1">
                      {stats.summary.warrantyExpiringPercent}% del inventario
                    </p>
                  </DashCard>
                </div>

                {/* ==================== ROW 2: SITE DISTRIBUTION + STATE DONUT ==================== */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                  {/* Activos por sede */}
                  <DashCard>
                    <h3 className="text-sm font-bold text-gray-900">Activos por sede</h3>
                    <p className="text-xs text-gray-500 mb-4">
                      Permite detectar sobreasignación o desabasto por hotel
                    </p>
                    <div className="space-y-3">
                      {(() => {
                        const otherCount = stats.distributions.bySite.slice(5).reduce((s, i) => s + i.count, 0);
                        const maxCount = Math.max(stats.distributions.bySite[0]?.count || 1, otherCount);
                        const colors = ["#2563eb", "#3b82f6", "#60a5fa", "#93c5fd", "#bfdbfe"];
                        return (
                          <>
                            {stats.distributions.bySite.slice(0, 5).map((s, i) => (
                              <div key={s.site} className="flex items-center gap-3">
                                <span className="text-xs text-gray-600 w-32 truncate text-right" title={s.site}>
                                  {s.site}
                                </span>
                                <div className="flex-1 bg-gray-100 rounded-full h-4">
                                  <div
                                    className="h-4 rounded-full transition-all duration-500"
                                    style={{
                                      width: `${(s.count / maxCount) * 100}%`,
                                      backgroundColor: colors[i % colors.length],
                                    }}
                                  />
                                </div>
                                <span className="text-sm font-semibold text-gray-700 w-10 text-right">
                                  {s.count}
                                </span>
                              </div>
                            ))}
                            {stats.distributions.bySite.length > 5 && (
                              <div className="flex items-center gap-3">
                                <span className="text-xs text-gray-600 w-32 truncate text-right">
                                  Otras sedes
                                </span>
                                <div className="flex-1 bg-gray-100 rounded-full h-4">
                                  <div
                                    className="h-4 rounded-full bg-blue-200 transition-all duration-500"
                                    style={{
                                      width: `${(otherCount / maxCount) * 100}%`,
                                    }}
                                  />
                                </div>
                                <span className="text-sm font-semibold text-gray-700 w-10 text-right">
                                  {otherCount}
                                </span>
                              </div>
                            )}
                          </>
                        );
                      })()}
                    </div>
                  </DashCard>

                  {/* Estado del inventario - Donut */}
                  <DashCard>
                    <h3 className="text-sm font-bold text-gray-900">Estado del inventario</h3>
                    <p className="text-xs text-gray-500 mb-4">
                      Muestra cuántos equipos están operativos, en reparación o dados de baja
                    </p>
                    <div className="flex justify-center">
                      <DonutChart
                        items={stats.distributions.byState.map((s) => ({
                          label: s.state,
                          count: s.count,
                          color: stateColorMap[s.state] || "#6b7280",
                        }))}
                      />
                    </div>
                  </DashCard>
                </div>

                {/* ==================== ROW 3: MOVEMENTS CHART + AGE BY TYPE ==================== */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                  {/* Movimientos registrados */}
                  <DashCard>
                    <h3 className="text-sm font-bold text-gray-900">Movimientos registrados</h3>
                    <p className="text-xs text-gray-500 mb-4">
                      Altas, bajas y reasignaciones por mes — detecta picos de actividad
                    </p>
                    <div className="flex items-end gap-3 h-40">
                      {stats.movementsByMonth.map((m, i) => {
                        const maxCount = Math.max(...stats.movementsByMonth.map((x) => x.count), 1);
                        const heightPct = (m.count / maxCount) * 100;
                        return (
                          <div key={i} className="flex-1 flex flex-col items-center gap-1">
                            <span className="text-xs text-gray-500 font-medium">{m.count || ""}</span>
                            <div className="w-full flex justify-center">
                              <div className="flex gap-0.5 items-end" style={{ height: "120px" }}>
                                <div
                                  className="w-3 rounded-t bg-blue-300 transition-all duration-500"
                                  style={{ height: `${heightPct * 0.7}%` }}
                                />
                                <div
                                  className="w-3 rounded-t bg-blue-500 transition-all duration-500"
                                  style={{ height: `${heightPct}%` }}
                                />
                                <div
                                  className="w-3 rounded-t bg-blue-700 transition-all duration-500"
                                  style={{ height: `${heightPct * 0.5}%` }}
                                />
                              </div>
                            </div>
                            <span className="text-xs text-gray-500">{m.month}</span>
                          </div>
                        );
                      })}
                    </div>
                  </DashCard>

                  {/* Antigüedad promedio por tipo */}
                  <DashCard>
                    <h3 className="text-sm font-bold text-gray-900">Antigüedad promedio por tipo</h3>
                    <p className="text-xs text-gray-500 mb-4">
                      Identifica qué categoría de equipo requiere renovación más urgente
                    </p>
                    <div className="space-y-3">
                      {stats.kpis.avgAgeByType.slice(0, 6).map((item, i) => {
                        const maxYears = Math.max(...stats.kpis.avgAgeByType.map((x) => x.avgYears), 1);
                        return (
                          <div key={item.type} className="flex items-center gap-3">
                            <span className="text-xs text-gray-600 w-24 truncate text-right" title={item.type}>
                              {item.type}
                            </span>
                            <div className="flex-1 bg-gray-100 rounded-full h-4">
                              <div
                                className="h-4 rounded-full transition-all duration-500"
                                style={{
                                  width: `${(item.avgYears / maxYears) * 100}%`,
                                  backgroundColor: ageBarColors[i % ageBarColors.length],
                                }}
                              />
                            </div>
                            <span className="text-sm font-semibold text-gray-700 w-10 text-right">
                              {item.avgYears} a
                            </span>
                          </div>
                        );
                      })}
                      {stats.kpis.avgAgeByType.length === 0 && (
                        <p className="text-xs text-gray-400 italic">Sin datos de adquisición</p>
                      )}
                    </div>
                  </DashCard>
                </div>

                {/* ==================== ROW 4: WARRANTY ALERTS + RECENT MOVEMENTS ==================== */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                  {/* Alertas de garantía próximas */}
                  <DashCard>
                    <h3 className="text-sm font-bold text-gray-900">Alertas de garantía próximas</h3>
                    <p className="text-xs text-gray-500 mb-3">
                      Equipos cuya garantía vence en los próximos 90 días
                    </p>
                    {stats.warrantyAlerts.length > 0 ? (
                      <div className="overflow-x-auto">
                        <table className="w-full text-xs">
                          <thead>
                            <tr className="text-left text-gray-500 border-b border-gray-100">
                              <th className="pb-2 font-medium">Activo</th>
                              <th className="pb-2 font-medium">Sede</th>
                              <th className="pb-2 font-medium">Vence en</th>
                              <th className="pb-2 font-medium">Estado</th>
                            </tr>
                          </thead>
                          <tbody>
                            {stats.warrantyAlerts.slice(0, 5).map((alert, i) => (
                              <tr key={i} className="border-b border-gray-50">
                                <td className="py-2 font-medium text-gray-800 max-w-[160px] truncate">
                                  {alert.name}
                                </td>
                                <td className="py-2 text-gray-600">{alert.site}</td>
                                <td className="py-2 text-gray-600">{alert.daysUntilExpiry} días</td>
                                <td className="py-2">
                                  <Badge
                                    className={`text-[10px] ${
                                      alert.daysUntilExpiry <= 30
                                        ? "bg-red-100 text-red-700 border-red-200"
                                        : "bg-amber-100 text-amber-700 border-amber-200"
                                    }`}
                                  >
                                    {alert.daysUntilExpiry <= 30 ? "Urgente" : "Próximo"}
                                  </Badge>
                                </td>
                              </tr>
                            ))}
                          </tbody>
                        </table>
                      </div>
                    ) : (
                      <p className="text-xs text-gray-400 italic py-4 text-center">
                        No hay garantías próximas a vencer
                      </p>
                    )}
                    {stats.warrantyAlerts.length > 5 && (
                      <div className="flex justify-center mt-3">
                        <ChevronDown className="h-4 w-4 text-gray-400" />
                      </div>
                    )}
                  </DashCard>

                  {/* Últimos movimientos registrados */}
                  <DashCard>
                    <h3 className="text-sm font-bold text-gray-900">Últimos movimientos registrados</h3>
                    <p className="text-xs text-gray-500 mb-3">
                      Trazabilidad en tiempo real de cambios en el inventario
                    </p>
                    {stats.recentMovements.length > 0 ? (
                      <div className="overflow-x-auto">
                        <table className="w-full text-xs">
                          <thead>
                            <tr className="text-left text-gray-500 border-b border-gray-100">
                              <th className="pb-2 font-medium">Activo</th>
                              <th className="pb-2 font-medium">Operación</th>
                              <th className="pb-2 font-medium">Usuario</th>
                              <th className="pb-2 font-medium">Fecha</th>
                            </tr>
                          </thead>
                          <tbody>
                            {stats.recentMovements.slice(0, 5).map((mov, i) => (
                              <tr key={i} className="border-b border-gray-50">
                                <td className="py-2 font-medium text-gray-800 max-w-[160px] truncate">
                                  {mov.assetName}
                                </td>
                                <td className="py-2">
                                  <Badge
                                    className={`text-[10px] ${
                                      operationStyles[mov.operation] || "bg-gray-100 text-gray-700"
                                    }`}
                                  >
                                    {getOperationLabel(mov.operation)}
                                  </Badge>
                                </td>
                                <td className="py-2 text-gray-600">{mov.user}</td>
                                <td className="py-2 text-gray-600">{formatShortDate(mov.date)}</td>
                              </tr>
                            ))}
                          </tbody>
                        </table>
                      </div>
                    ) : (
                      <p className="text-xs text-gray-400 italic py-4 text-center">
                        No hay movimientos recientes
                      </p>
                    )}
                    {stats.recentMovements.length > 5 && (
                      <div className="flex justify-center mt-3">
                        <ChevronDown className="h-4 w-4 text-gray-400" />
                      </div>
                    )}
                  </DashCard>
                </div>

                {/* ==================== ROW 5: SITE RISK RANKING + DATA COMPLETENESS ==================== */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                  {/* Ranking de hoteles por riesgo TI */}
                  {stats.siteRiskRanking && stats.siteRiskRanking.length > 0 && (
                    <DashCard>
                      <div className="flex items-center gap-2 mb-1">
                        <Shield className="h-4 w-4 text-gray-600" />
                        <h3 className="text-sm font-bold text-gray-900">Ranking por riesgo TI</h3>
                      </div>
                      <p className="text-xs text-gray-500 mb-4">
                        Combina obsolescencia + sin garantía + sin usuario asignado
                      </p>
                      <div className="space-y-2.5">
                        {stats.siteRiskRanking.slice(0, 8).map((site) => {
                          const colors = {
                            green: { bg: "bg-green-100", text: "text-green-700", bar: "#22c55e", label: "Bajo" },
                            yellow: { bg: "bg-amber-100", text: "text-amber-700", bar: "#f59e0b", label: "Medio" },
                            red: { bg: "bg-red-100", text: "text-red-700", bar: "#ef4444", label: "Alto" },
                          }[site.level];
                          return (
                            <div key={site.name} className="flex items-center gap-2">
                              <span className="text-xs text-gray-600 w-28 truncate text-right" title={site.name}>
                                {site.name}
                              </span>
                              <div className="flex-1 bg-gray-100 rounded-full h-4">
                                <div
                                  className="h-4 rounded-full transition-all duration-500"
                                  style={{ width: `${site.riskScore}%`, backgroundColor: colors.bar }}
                                />
                              </div>
                              <Badge className={`text-[10px] ${colors.bg} ${colors.text} border-0 w-14 justify-center`}>
                                {colors.label}
                              </Badge>
                              <span className="text-xs text-gray-500 w-6 text-right">{site.total}</span>
                            </div>
                          );
                        })}
                      </div>
                    </DashCard>
                  )}

                  {/* Garantías por vencer */}
                  <div className="flex flex-col gap-4">
                    {/* Timeline de garantías */}
                    {stats.warrantyTimeline && (
                      <DashCard>
                        <div className="flex items-center gap-2 mb-1">
                          <AlertTriangle className="h-4 w-4 text-gray-600" />
                          <h3 className="text-sm font-bold text-gray-900">Garantías por vencer</h3>
                        </div>
                        <div className="flex items-end gap-4 mt-3">
                          {stats.warrantyTimeline.map((item) => (
                            <div key={item.period} className="flex-1 text-center">
                              <p className="text-2xl font-bold text-gray-900">{item.count}</p>
                              <p className="text-xs text-gray-500 mt-1">{item.period}</p>
                            </div>
                          ))}
                        </div>
                      </DashCard>
                    )}
                  </div>
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
