import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import { ProductType, AssetState, Company, Asset } from "@/types";
import api from "@/lib/api";
import { BulkMovementModal, MovementResult } from "@/components/BulkMovementModal";
import { MovementHistoryTable } from "@/components/MovementHistoryTable";
import { DeliveryReportModal } from "@/components/DeliveryReportModal";
import {
  OmniboxFilter,
  type FilterChip,
  type Facet,
} from "@/components/OmniboxFilter";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
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
  ArrowRightLeft,
  X,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { toast } from "sonner";

const ASSET_GROUPS = ["Equipo", "Accesorio", "Componente", "Otro"] as const;

export default function Movimientos() {
  // Catalogos
  const [productTypes, setProductTypes] = useState<ProductType[]>([]);
  const [assetStates, setAssetStates] = useState<AssetState[]>([]);
  const [companies, setCompanies] = useState<Company[]>([]);

  // Activos
  const [assets, setAssets] = useState<Asset[]>([]);
  const [filteredAssets, setFilteredAssets] = useState<Asset[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isBulkMovementModalOpen, setIsBulkMovementModalOpen] = useState(false);

  // Filtros y seleccion
  const [selectedGroup, setSelectedGroup] = useState<string | null>(null);
  const [selectedAssets, setSelectedAssets] = useState<Set<number>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");
  const [filterChips, setFilterChips] = useState<FilterChip[]>([]);
  const [isSearchPinned, setIsSearchPinned] = useState(false);

  // Paginacion
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(20);

  // Panel lateral de historial
  const [selectedAssetID, setSelectedAssetID] = useState<number | null>(null);
  const [refreshTrigger, setRefreshTrigger] = useState(0);

  // Report modal after movement
  const [isReportModalOpen, setIsReportModalOpen] = useState(false);
  const [reportConfig, setReportConfig] = useState<{
    assetID?: number;
    assetIDs?: number[];
    availableAssets?: { assetID: number; name: string; vendor: string; model: string; serialNum: string }[];
    format: "entrega_software" | "entrega_multiitem";
    title: string;
    prefillDepartment?: string;
    prefillSite?: string;
    prefillReceiverName?: string;
  } | null>(null);

  // Cargar catalogos
  useEffect(() => {
    const loadCatalogs = async () => {
      try {
        const [productTypesRes, assetStatesRes, companiesRes] =
          await Promise.all([
            api.productType.getAll().catch(() => []),
            api.assetState.getAll().catch(() => []),
            api.company.getAll().catch(() => []),
          ]);
        setProductTypes(productTypesRes);
        setAssetStates(assetStatesRes);
        setCompanies(companiesRes);
      } catch (error) {
        console.error("Error loading catalogs:", error);
      }
    };
    loadCatalogs();
  }, []);

  // Cargar activos
  useEffect(() => {
    loadAssets();
  }, []);

  const loadAssets = async () => {
    try {
      setIsLoading(true);
      const response = await api.asset.getAll().catch(() => []);
      setAssets(response as Asset[]);
      setFilteredAssets(response as Asset[]);
    } catch (error) {
      console.error("Error fetching assets:", error);
    } finally {
      setIsLoading(false);
    }
  };

  // Usuarios unicos
  const uniqueUsers = useMemo(() => {
    const userMap = new Map<number, { userID: number; name: string }>();
    assets.forEach((asset) => {
      if (asset.user && asset.user.userID && asset.user.name) {
        userMap.set(asset.user.userID, {
          userID: asset.user.userID,
          name: asset.user.name,
        });
      }
    });
    return Array.from(userMap.values()).sort((a, b) =>
      a.name.localeCompare(b.name)
    );
  }, [assets]);

  // Tipos filtrados por grupo
  const filteredProductTypes = useMemo(() => {
    if (selectedGroup) {
      return productTypes.filter((pt) => pt.group === selectedGroup);
    }
    return productTypes;
  }, [productTypes, selectedGroup]);

  // Facetas para omnibox
  const facets: Facet[] = useMemo(
    () => [
      {
        key: "empresa",
        label: "Empresa",
        color: "blue",
        options: companies.map((c) => ({
          value: String(c.companyID),
          label: c.description,
        })),
      },
      {
        key: "usuario",
        label: "Usuario",
        color: "emerald",
        options: uniqueUsers.map((u) => ({
          value: String(u.userID),
          label: u.name,
        })),
      },
      {
        key: "estado",
        label: "Estado",
        color: "amber",
        options: assetStates.map((s) => ({
          value: String(s.assetStateID),
          label: s.name,
        })),
      },
      {
        key: "tipo",
        label: "Tipo",
        color: "purple",
        options: filteredProductTypes.map((pt) => ({
          value: String(pt.productTypeID),
          label: pt.name,
        })),
      },
    ],
    [companies, uniqueUsers, assetStates, filteredProductTypes]
  );

  // Aplicar filtros
  useEffect(() => {
    let result = [...assets];

    if (selectedGroup) {
      result = result.filter(
        (asset) => asset.productType?.group === selectedGroup
      );
    }

    const chipsByFacet = new Map<string, Set<string>>();
    filterChips.forEach((chip) => {
      if (!chipsByFacet.has(chip.facet)) {
        chipsByFacet.set(chip.facet, new Set());
      }
      chipsByFacet.get(chip.facet)!.add(chip.value);
    });

    if (chipsByFacet.has("empresa")) {
      const values = chipsByFacet.get("empresa")!;
      result = result.filter((a) => values.has(String(a.companyID)));
    }
    if (chipsByFacet.has("usuario")) {
      const values = chipsByFacet.get("usuario")!;
      result = result.filter((a) => values.has(String(a.userID)));
    }
    if (chipsByFacet.has("estado")) {
      const values = chipsByFacet.get("estado")!;
      result = result.filter((a) => values.has(String(a.assetState)));
    }
    if (chipsByFacet.has("tipo")) {
      const values = chipsByFacet.get("tipo")!;
      result = result.filter((a) => values.has(String(a.productTypeID)));
    }

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(
        (asset) =>
          asset.name.toLowerCase().includes(query) ||
          asset.assetDetail?.serialNum?.toLowerCase().includes(query) ||
          asset.assetDetail?.assetTAG?.toLowerCase().includes(query) ||
          asset.user?.name?.toLowerCase().includes(query) ||
          asset.depart?.Name?.toLowerCase().includes(query) ||
          asset.vendor?.name?.toLowerCase().includes(query) ||
          asset.productType?.name?.toLowerCase().includes(query)
      );
    }

    setFilteredAssets(result);
    setCurrentPage(1);
  }, [assets, selectedGroup, filterChips, searchQuery]);

  // Paginacion
  const paginatedAssets = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredAssets.slice(start, start + pageSize);
  }, [filteredAssets, currentPage, pageSize]);

  const totalPages = Math.ceil(filteredAssets.length / pageSize);
  const startItem =
    filteredAssets.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endItem = Math.min(currentPage * pageSize, filteredAssets.length);

  // Handlers
  const handleRefresh = () => {
    loadAssets();
    setRefreshTrigger((prev) => prev + 1);
    toast.success("Lista actualizada");
  };

  const isAssetBaja = (asset: Asset) => asset.assetStateInfo?.name === "Baja";

  const handleSelectAll = (checked: boolean) => {
    if (checked) {
      setSelectedAssets(new Set(paginatedAssets.filter((a) => !isAssetBaja(a)).map((a) => a.assetID)));
    } else {
      setSelectedAssets(new Set());
    }
  };

  const handleSelectAsset = (assetID: number, checked: boolean) => {
    const newSelected = new Set(selectedAssets);
    if (checked) {
      newSelected.add(assetID);
    } else {
      newSelected.delete(assetID);
    }
    setSelectedAssets(newSelected);
  };

  const handleBulkMovement = () => {
    if (selectedAssets.size === 0) {
      toast.warning("Selecciona al menos un activo");
      return;
    }
    setIsBulkMovementModalOpen(true);
  };

  const handleBulkMovementSuccess = (result: MovementResult) => {
    loadAssets();
    setSelectedAssets(new Set());
    setRefreshTrigger((prev) => prev + 1);

    // Determine report format and title based on movement type
    const { movementType, assetIDs, assets: movedAssets } = result;

    const MOVEMENT_TITLES: Record<string, string> = {
      REASIGNACION: "Entrega de Equipo",
      RESGUARDO: "Resguardo de Equipo",
      REPARACION: "Reparación de Equipo",
      BAJA: "Baja de Equipo",
    };

    // Build available assets for multi-item selector
    const reportAvailableAssets = movedAssets.map((a) => ({
      assetID: a.assetID,
      name: a.name,
      vendor: a.vendor?.name || "",
      model: a.assetDetail?.model || "",
      serialNum: a.assetDetail?.serialNum || "",
    }));

    // Find department and site names for prefill
    const findDepartmentName = () => {
      if (result.departID) {
        for (const a of movedAssets) {
          if (a.depart?.departID === result.departID) return a.depart.Name;
        }
      }
      return undefined;
    };

    const findSiteName = () => {
      if (result.siteID) {
        for (const a of movedAssets) {
          if (a.site?.siteID === result.siteID) return a.site.name;
        }
      }
      return undefined;
    };

    if (movementType === "REASIGNACION") {
      // Check if single equipment-type asset → entrega_software
      const isOnlyOneEquipo =
        assetIDs.length === 1 &&
        movedAssets.length === 1 &&
        movedAssets[0].productType?.group === "Equipo";

      if (isOnlyOneEquipo) {
        setReportConfig({
          assetID: assetIDs[0],
          assetIDs,
          availableAssets: reportAvailableAssets,
          format: "entrega_software",
          title: MOVEMENT_TITLES.REASIGNACION,
          prefillDepartment: findDepartmentName(),
          prefillSite: findSiteName(),
          prefillReceiverName: result.userName,
        });
      } else {
        // Multiple items or non-equipment → multi-item
        setReportConfig({
          assetID: assetIDs[0],
          assetIDs,
          availableAssets: reportAvailableAssets,
          format: "entrega_multiitem",
          title: MOVEMENT_TITLES.REASIGNACION,
          prefillDepartment: findDepartmentName(),
          prefillSite: findSiteName(),
          prefillReceiverName: result.userName,
        });
      }
    } else {
      // RESGUARDO, REPARACION, BAJA → always multi-item
      setReportConfig({
        assetID: assetIDs[0],
        assetIDs,
        availableAssets: reportAvailableAssets,
        format: "entrega_multiitem",
        title: MOVEMENT_TITLES[movementType] || "Reporte de Movimiento",
        prefillDepartment: findDepartmentName(),
        prefillSite: findSiteName(),
        prefillReceiverName: result.userName,
      });
    }

    setIsReportModalOpen(true);
  };

  const handleViewHistory = (assetID: number) => {
    setSelectedAssetID(selectedAssetID === assetID ? null : assetID);
  };

  const isAllSelected =
    paginatedAssets.length > 0 &&
    paginatedAssets.every((a) => selectedAssets.has(a.assetID));

  return (
    <MainLayout
      breadcrumb={{
        title: "Movimientos",
        subtitle: "Gestión de movimientos de activos TI",
      }}
    >
      {() => (
        <div className="flex flex-col h-full bg-white">
          {/* Header - Botones de grupo */}
          <div className="px-4 py-3 border-b">
            <div className="flex items-center gap-2">
              <Button
                variant={selectedGroup === null ? "default" : "outline"}
                size="sm"
                onClick={() => setSelectedGroup(null)}
                className="h-9 text-sm font-medium"
              >
                Todos
              </Button>
              {ASSET_GROUPS.map((group) => (
                <Button
                  key={group}
                  variant={selectedGroup === group ? "default" : "outline"}
                  size="sm"
                  onClick={() => {
                    setSelectedGroup(
                      selectedGroup === group ? null : group
                    );
                    setFilterChips((prev) =>
                      prev.filter((c) => c.facet !== "tipo")
                    );
                  }}
                  className="h-9 text-sm font-medium"
                >
                  {group}
                </Button>
              ))}
            </div>
          </div>

          {/* Toolbar */}
          <div className="flex items-center gap-3 px-4 py-2 border-b bg-gray-50">
            {/* Omnibox */}
            <OmniboxFilter
              facets={facets}
              chips={filterChips}
              onChipsChange={setFilterChips}
              searchQuery={searchQuery}
              onSearchQueryChange={setSearchQuery}
              pinned={isSearchPinned}
              onPinnedChange={setIsSearchPinned}
            />

            {/* Acciones */}
            <div className="flex items-center gap-1 shrink-0">
              <Button
                variant="default"
                size="sm"
                onClick={handleBulkMovement}
                disabled={selectedAssets.size === 0}
                className="h-8 text-sm font-normal bg-blue-600 hover:bg-blue-700"
              >
                <ArrowRightLeft className="h-4 w-4 mr-1" />
                Generar Movimiento
                {selectedAssets.size > 0 && (
                  <span className="ml-1 px-1.5 py-0.5 text-xs bg-white/20 rounded-full">
                    {selectedAssets.size}
                  </span>
                )}
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
            <div className="flex items-center gap-1.5 text-sm text-gray-600 shrink-0">
              <select
                value={pageSize}
                onChange={(e) => {
                  setPageSize(Number(e.target.value));
                  setCurrentPage(1);
                }}
                className="h-7 rounded border border-gray-300 bg-white px-1 text-sm text-gray-600"
              >
                {[20, 50, 100].map((size) => (
                  <option key={size} value={size}>
                    {size}
                  </option>
                ))}
              </select>
              <span className="whitespace-nowrap">
                {startItem}-{endItem} de {filteredAssets.length}
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
            {/* Tabla de activos */}
            <div
              className={`flex-1 overflow-auto ${selectedAssetID ? "border-r" : ""}`}
            >
              {isLoading ? (
                <div className="flex items-center justify-center h-64">
                  <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
                </div>
              ) : (
                <Table className="table-fixed w-full">
                  <TableHeader className="bg-gray-50 sticky top-0">
                    <TableRow>
                      <TableHead className="w-5">
                        <Checkbox
                          checked={isAllSelected}
                          onCheckedChange={handleSelectAll}
                        />
                      </TableHead>
                      <TableHead className="w-18 font-semibold text-gray-700">
                        NOMBRE
                      </TableHead>
                      <TableHead className="w-20 font-semibold text-gray-700">
                        COMPAÑIA
                      </TableHead>
                      <TableHead className="w-20 font-semibold text-gray-700">
                        SITE
                      </TableHead>
                      <TableHead className="w-25 font-semibold text-gray-700">
                        DEPARTAMENTO
                      </TableHead>
                      <TableHead className="w-20 font-semibold text-gray-700">
                        USUARIO
                      </TableHead>
                      <TableHead className="w-18 font-semibold text-gray-700">
                        TIPO
                      </TableHead>
                      <TableHead className="w-20 font-semibold text-gray-700">
                        MARCA
                      </TableHead>
                      <TableHead className="w-20 font-semibold text-gray-700">
                        SERIE
                      </TableHead>
                      <TableHead className="w-20 font-semibold text-gray-700">
                        ESTADO
                      </TableHead>
                      <TableHead className="w-12 font-semibold text-gray-700">
                        HIST.
                      </TableHead>
                    </TableRow>
                  </TableHeader>

                  <TableBody>
                    {paginatedAssets.length === 0 ? (
                      <TableRow>
                        <TableCell
                          colSpan={11}
                          className="h-24 text-center text-gray-500"
                        >
                          No se encontraron activos
                        </TableCell>
                      </TableRow>
                    ) : (
                      paginatedAssets.map((asset) => {
                        const isBaja = isAssetBaja(asset);
                        return (
                        <TableRow
                          key={asset.assetID}
                          className={cn(
                            "hover:bg-gray-50",
                            selectedAssets.has(asset.assetID) && "bg-blue-50",
                            selectedAssetID === asset.assetID && "bg-amber-50",
                            isBaja && "opacity-60 bg-red-50/50"
                          )}
                        >
                          <TableCell>
                            <Checkbox
                              checked={selectedAssets.has(asset.assetID)}
                              onCheckedChange={(checked) =>
                                handleSelectAsset(asset.assetID, !!checked)
                              }
                              disabled={isBaja}
                              title={isBaja ? "Activo dado de baja - no se permiten movimientos" : undefined}
                            />
                          </TableCell>
                          <TableCell>
                            <span className="font-medium text-gray-900 truncate block">
                              {asset.name}
                            </span>
                          </TableCell>
                          <TableCell>
                            {asset.company?.description || "-"}
                          </TableCell>
                          <TableCell>{asset.site?.name || "-"}</TableCell>
                          <TableCell>
                            {asset.depart?.Name || "-"}
                          </TableCell>
                          <TableCell>{asset.user?.name || "-"}</TableCell>
                          <TableCell>
                            {asset.productType?.name || "-"}
                          </TableCell>
                          <TableCell>
                            {asset.assetDetail?.productManuf || "-"}
                          </TableCell>
                          <TableCell>
                            {asset.assetDetail?.serialNum || "-"}
                          </TableCell>
                          <TableCell>
                            <span className={cn(
                              isBaja && "text-red-600 font-semibold"
                            )}>
                              {asset.assetStateInfo?.name || "-"}
                            </span>
                          </TableCell>
                          <TableCell>
                            <Button
                              variant="ghost"
                              size="icon"
                              className="h-7 w-7"
                              title="Ver historial"
                              onClick={() => handleViewHistory(asset.assetID)}
                            >
                              <ArrowRightLeft className="h-4 w-4 text-gray-500" />
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
                  onMovementUpdated={() => loadAssets()}
                />
              </div>
            )}
          </div>

          {/* Modal de Movimiento Masivo */}
          <BulkMovementModal
            assets={assets}
            selectedAssetIDs={Array.from(selectedAssets)}
            isOpen={isBulkMovementModalOpen}
            onClose={() => setIsBulkMovementModalOpen(false)}
            onSuccess={handleBulkMovementSuccess}
          />

          {/* Modal de Reporte automático después del movimiento */}
          {reportConfig && (
            <DeliveryReportModal
              assetID={reportConfig.assetID}
              assetIDs={reportConfig.assetIDs}
              availableAssets={reportConfig.availableAssets}
              format={reportConfig.format}
              title={reportConfig.title}
              prefillDepartment={reportConfig.prefillDepartment}
              prefillSite={reportConfig.prefillSite}
              prefillReceiverName={reportConfig.prefillReceiverName}
              isOpen={isReportModalOpen}
              onClose={() => {
                setIsReportModalOpen(false);
                setReportConfig(null);
              }}
            />
          )}
        </div>
      )}
    </MainLayout>
  );
}
