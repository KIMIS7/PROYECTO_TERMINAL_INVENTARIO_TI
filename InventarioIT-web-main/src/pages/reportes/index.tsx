import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState } from "react";
import { Asset, Company, AssetState } from "@/types";
import api from "@/lib/api";
import { DeliveryReportModal } from "@/components/DeliveryReportModal";
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
  Download,
  FileText,
  FileSpreadsheet,
  Loader2,
  ClipboardList,
  Users,
  History,
  Package,
} from "lucide-react";
import { toast } from "sonner";

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

type ReportType = "inventory" | "delivery" | "history" | "user-assets";

export default function Reportes() {
  const [assets, setAssets] = useState<Asset[]>([]);
  const [companies, setCompanies] = useState<Company[]>([]);
  const [assetStates, setAssetStates] = useState<AssetState[]>([]);
  const [users, setUsers] = useState<{ userID: number; name: string; email: string }[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isExporting, setIsExporting] = useState<string | null>(null);

  // Filters
  const [selectedCompany, setSelectedCompany] = useState<number | undefined>();
  const [selectedState, setSelectedState] = useState<number | undefined>();
  const [selectedGroup, setSelectedGroup] = useState<string | undefined>();

  // Delivery modal
  const [deliveryAssetID, setDeliveryAssetID] = useState<number | null>(null);
  const [isDeliveryModalOpen, setIsDeliveryModalOpen] = useState(false);

  // Active report tab
  const [activeReport, setActiveReport] = useState<ReportType>("inventory");

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setIsLoading(true);
      const [assetsRes, companiesRes, statesRes, usersRes] = await Promise.all([
        api.asset.getAll().catch(() => []),
        api.company.getAll().catch(() => []),
        api.assetState.getAll().catch(() => []),
        api.user.getAll().catch(() => []),
      ]);
      setAssets(assetsRes as Asset[]);
      setCompanies(companiesRes);
      setAssetStates(statesRes);
      // Extraer usuarios únicos de los activos
      const uniqueUsers = new Map<number, { userID: number; name: string; email: string }>();
      (assetsRes as Asset[]).forEach((a) => {
        if (a.user?.userID) {
          uniqueUsers.set(a.user.userID, {
            userID: a.user.userID,
            name: a.user.name || "",
            email: a.user.email || "",
          });
        }
      });
      setUsers(Array.from(uniqueUsers.values()).sort((a, b) => a.name.localeCompare(b.name)));
    } catch (error) {
      console.error("Error loading report data:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleExportInventoryExcel = async () => {
    try {
      setIsExporting("inventory-excel");
      const filters: { group?: string; companyID?: number; assetState?: number } = {};
      if (selectedGroup) filters.group = selectedGroup;
      if (selectedCompany) filters.companyID = selectedCompany;
      if (selectedState) filters.assetState = selectedState;

      const blob = await api.report.downloadAssetsExcel(filters);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(
        new Blob([blob], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
        `inventario_${dateStr}.xlsx`
      );
      toast.success("Reporte de inventario exportado");
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al exportar inventario");
    } finally {
      setIsExporting(null);
    }
  };

  const handleExportInventoryCsv = async () => {
    try {
      setIsExporting("inventory-csv");
      const filters: { group?: string; companyID?: number; assetState?: number } = {};
      if (selectedGroup) filters.group = selectedGroup;
      if (selectedCompany) filters.companyID = selectedCompany;
      if (selectedState) filters.assetState = selectedState;

      const blob = await api.report.downloadAssetsCsv(filters);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(new Blob([blob], { type: "text/csv" }), `inventario_${dateStr}.csv`);
      toast.success("CSV exportado");
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al exportar CSV");
    } finally {
      setIsExporting(null);
    }
  };

  const handleExportHistoryExcel = async () => {
    try {
      setIsExporting("history");
      const blob = await api.report.downloadHistoryExcel();
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(
        new Blob([blob], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
        `historial_movimientos_${dateStr}.xlsx`
      );
      toast.success("Historial exportado");
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al exportar historial");
    } finally {
      setIsExporting(null);
    }
  };

  const handleExportUserAssets = async (userId: number, userName: string) => {
    try {
      setIsExporting(`user-${userId}`);
      const blob = await api.report.downloadUserAssetsExcel(userId);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(
        new Blob([blob], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
        `resguardo_${userName.replace(/\s+/g, "_")}_${dateStr}.xlsx`
      );
      toast.success(`Resguardo de ${userName} exportado`);
    } catch (error) {
      console.error("Error:", error);
      toast.error("Error al exportar resguardo");
    } finally {
      setIsExporting(null);
    }
  };

  // Get equipos for delivery report
  const equipos = assets.filter(
    (a) => a.productType?.group === "Equipo" && a.assetStateInfo?.name !== "Baja"
  );

  const reportTabs: { key: ReportType; label: string; icon: React.ReactNode }[] = [
    { key: "inventory", label: "Inventario General", icon: <Package className="h-4 w-4" /> },
    { key: "delivery", label: "Entrega de Equipo", icon: <ClipboardList className="h-4 w-4" /> },
    { key: "history", label: "Historial de Movimientos", icon: <History className="h-4 w-4" /> },
    { key: "user-assets", label: "Resguardo por Usuario", icon: <Users className="h-4 w-4" /> },
  ];

  return (
    <MainLayout
      breadcrumb={{ title: "Reportes", subtitle: "Generacion y exportacion automatica de reportes" }}
    >
      {() => (
        <div className="flex flex-col h-full bg-white">
          {/* Report Tabs */}
          <div className="px-4 py-3 border-b">
            <div className="flex items-center gap-2">
              {reportTabs.map((tab) => (
                <Button
                  key={tab.key}
                  variant={activeReport === tab.key ? "default" : "outline"}
                  size="sm"
                  onClick={() => setActiveReport(tab.key)}
                  className="h-9 text-sm font-medium flex items-center gap-2"
                >
                  {tab.icon}
                  {tab.label}
                </Button>
              ))}
            </div>
          </div>

          {/* Report Content */}
          <div className="flex-1 overflow-auto p-6">
            {isLoading ? (
              <div className="flex items-center justify-center h-48">
                <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
              </div>
            ) : (
              <>
                {/* ===== INVENTARIO GENERAL ===== */}
                {activeReport === "inventory" && (
                  <div className="space-y-6">
                    <div className="flex items-start justify-between">
                      <div>
                        <h2 className="text-xl font-semibold text-gray-800">Reporte de Inventario General</h2>
                        <p className="text-sm text-gray-500 mt-1">
                          Exporta el inventario completo con todos los detalles tecnicos de cada activo.
                        </p>
                      </div>
                    </div>

                    {/* Filtros */}
                    <div className="flex items-center gap-4 bg-gray-50 rounded-lg p-4">
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-gray-500">Grupo</label>
                        <select
                          value={selectedGroup || ""}
                          onChange={(e) => setSelectedGroup(e.target.value || undefined)}
                          className="border rounded-md px-3 py-1.5 text-sm"
                        >
                          <option value="">Todos</option>
                          <option value="Equipo">Equipo</option>
                          <option value="Componente">Componente</option>
                          <option value="Accesorio">Accesorio</option>
                          <option value="Otro">Otro</option>
                        </select>
                      </div>

                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-gray-500">Empresa</label>
                        <select
                          value={selectedCompany || ""}
                          onChange={(e) => setSelectedCompany(e.target.value ? +e.target.value : undefined)}
                          className="border rounded-md px-3 py-1.5 text-sm"
                        >
                          <option value="">Todas</option>
                          {companies.map((c) => (
                            <option key={c.companyID} value={c.companyID}>
                              {c.description}
                            </option>
                          ))}
                        </select>
                      </div>

                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-gray-500">Estado</label>
                        <select
                          value={selectedState || ""}
                          onChange={(e) => setSelectedState(e.target.value ? +e.target.value : undefined)}
                          className="border rounded-md px-3 py-1.5 text-sm"
                        >
                          <option value="">Todos</option>
                          {assetStates.map((s) => (
                            <option key={s.assetStateID} value={s.assetStateID}>
                              {s.name}
                            </option>
                          ))}
                        </select>
                      </div>
                    </div>

                    {/* Botones de exportación */}
                    <div className="flex gap-3">
                      <Button
                        onClick={handleExportInventoryExcel}
                        disabled={isExporting !== null}
                        className="bg-green-600 hover:bg-green-700 text-white"
                      >
                        {isExporting === "inventory-excel" ? (
                          <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                        ) : (
                          <FileSpreadsheet className="h-4 w-4 mr-2" />
                        )}
                        Exportar a Excel
                      </Button>

                      <Button
                        onClick={handleExportInventoryCsv}
                        disabled={isExporting !== null}
                        variant="outline"
                      >
                        {isExporting === "inventory-csv" ? (
                          <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                        ) : (
                          <Download className="h-4 w-4 mr-2" />
                        )}
                        Exportar a CSV
                      </Button>
                    </div>

                    <div className="text-sm text-gray-400">
                      Total de activos: <span className="font-semibold text-gray-600">{assets.length}</span>
                    </div>
                  </div>
                )}

                {/* ===== ENTREGA DE EQUIPO ===== */}
                {activeReport === "delivery" && (
                  <div className="space-y-6">
                    <div>
                      <h2 className="text-xl font-semibold text-gray-800">Reporte de Entrega de Equipo</h2>
                      <p className="text-sm text-gray-500 mt-1">
                        Genera el formato de entrega de equipo en PDF con checklist de software,
                        datos del equipo y firmas. Selecciona un equipo de la lista.
                      </p>
                    </div>

                    <Table>
                      <TableHeader>
                        <TableRow>
                          <TableHead className="font-semibold">Equipo</TableHead>
                          <TableHead className="font-semibold">No. Serie</TableHead>
                          <TableHead className="font-semibold">Usuario</TableHead>
                          <TableHead className="font-semibold">Departamento</TableHead>
                          <TableHead className="font-semibold w-40">Accion</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {equipos.length === 0 ? (
                          <TableRow>
                            <TableCell colSpan={5} className="text-center text-gray-500 py-8">
                              No hay equipos disponibles
                            </TableCell>
                          </TableRow>
                        ) : (
                          equipos.map((asset) => (
                            <TableRow key={asset.assetID} className="hover:bg-gray-50">
                              <TableCell className="font-medium">{asset.name}</TableCell>
                              <TableCell className="font-mono text-sm">
                                {asset.assetDetail?.serialNum || "N/A"}
                              </TableCell>
                              <TableCell>{asset.user?.name || "-"}</TableCell>
                              <TableCell>{asset.depart?.Name || "-"}</TableCell>
                              <TableCell>
                                <Button
                                  size="sm"
                                  variant="outline"
                                  onClick={() => {
                                    setDeliveryAssetID(asset.assetID);
                                    setIsDeliveryModalOpen(true);
                                  }}
                                  className="text-green-600 border-green-200 hover:bg-green-50"
                                >
                                  <FileText className="h-4 w-4 mr-1" />
                                  Generar PDF
                                </Button>
                              </TableCell>
                            </TableRow>
                          ))
                        )}
                      </TableBody>
                    </Table>
                  </div>
                )}

                {/* ===== HISTORIAL DE MOVIMIENTOS ===== */}
                {activeReport === "history" && (
                  <div className="space-y-6">
                    <div className="flex items-start justify-between">
                      <div>
                        <h2 className="text-xl font-semibold text-gray-800">Historial de Movimientos</h2>
                        <p className="text-sm text-gray-500 mt-1">
                          Exporta el historial completo de todas las operaciones realizadas
                          sobre los activos: altas, bajas, reasignaciones, reparaciones, etc.
                        </p>
                      </div>
                    </div>

                    <Button
                      onClick={handleExportHistoryExcel}
                      disabled={isExporting !== null}
                      className="bg-green-600 hover:bg-green-700 text-white"
                    >
                      {isExporting === "history" ? (
                        <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                      ) : (
                        <FileSpreadsheet className="h-4 w-4 mr-2" />
                      )}
                      Exportar Historial a Excel
                    </Button>
                  </div>
                )}

                {/* ===== RESGUARDO POR USUARIO ===== */}
                {activeReport === "user-assets" && (
                  <div className="space-y-6">
                    <div>
                      <h2 className="text-xl font-semibold text-gray-800">Resguardo por Usuario</h2>
                      <p className="text-sm text-gray-500 mt-1">
                        Genera un reporte de resguardo con todos los equipos asignados a un usuario.
                        Incluye firmas de entrega y recepcion.
                      </p>
                    </div>

                    <Table>
                      <TableHeader>
                        <TableRow>
                          <TableHead className="font-semibold">Usuario</TableHead>
                          <TableHead className="font-semibold">Email</TableHead>
                          <TableHead className="font-semibold">Equipos Asignados</TableHead>
                          <TableHead className="font-semibold w-40">Accion</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {users.length === 0 ? (
                          <TableRow>
                            <TableCell colSpan={4} className="text-center text-gray-500 py-8">
                              No hay usuarios con equipos asignados
                            </TableCell>
                          </TableRow>
                        ) : (
                          users.map((user) => {
                            const userAssetCount = assets.filter(
                              (a) => a.userID === user.userID
                            ).length;
                            return (
                              <TableRow key={user.userID} className="hover:bg-gray-50">
                                <TableCell className="font-medium">{user.name}</TableCell>
                                <TableCell className="text-sm text-gray-500">{user.email}</TableCell>
                                <TableCell>
                                  <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-700">
                                    {userAssetCount} activos
                                  </span>
                                </TableCell>
                                <TableCell>
                                  <Button
                                    size="sm"
                                    variant="outline"
                                    onClick={() => handleExportUserAssets(user.userID, user.name)}
                                    disabled={isExporting === `user-${user.userID}` || userAssetCount === 0}
                                    className="text-green-600 border-green-200 hover:bg-green-50"
                                  >
                                    {isExporting === `user-${user.userID}` ? (
                                      <Loader2 className="h-4 w-4 mr-1 animate-spin" />
                                    ) : (
                                      <FileSpreadsheet className="h-4 w-4 mr-1" />
                                    )}
                                    Resguardo
                                  </Button>
                                </TableCell>
                              </TableRow>
                            );
                          })
                        )}
                      </TableBody>
                    </Table>
                  </div>
                )}
              </>
            )}
          </div>

          {/* Delivery Report Modal */}
          {deliveryAssetID && (
            <DeliveryReportModal
              assetID={deliveryAssetID}
              isOpen={isDeliveryModalOpen}
              onClose={() => {
                setIsDeliveryModalOpen(false);
                setDeliveryAssetID(null);
              }}
            />
          )}
        </div>
      )}
    </MainLayout>
  );
}
