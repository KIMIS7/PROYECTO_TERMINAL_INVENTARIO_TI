import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo, useRef, useCallback } from "react";
import { ProductType, Vendor, AssetState, Company, Site, Asset } from "@/types";
import api from "@/lib/api";
import { CreateAssetModal } from "@/components/CreateAssetModal";
import { EditAssetModal } from "@/components/EditAssetModal";
import { AssetDetailModal } from "@/components/AssetDetailModal";
import { AssetAssignmentModal } from "@/components/AssetAssignmentModal";
import { DeliveryReportModal } from "@/components/DeliveryReportModal";
import {
  OmniboxFilter,
  type FilterChip,
  type Facet,
} from "@/components/OmniboxFilter";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  Download,
  FileText,
  Pencil,
  RefreshCw,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { toast } from "sonner";

const ASSET_GROUPS = ["Equipo", "Accesorio", "Componente", "Otro"] as const;

const INITIAL_COL_WIDTHS: Record<string, number> = {
  checkbox: 36,
  actions: 36,
  name: 180,
  company: 140,
  site: 140,
  department: 160,
  user: 150,
  type: 130,
  brand: 130,
  model: 140,
  serial: 150,
  state: 110,
};

export default function Altas() {
  // Estados para los catálogos
  const [productTypes, setProductTypes] = useState<ProductType[]>([]);
  const [vendors, setVendors] = useState<Vendor[]>([]);
  const [assetStates, setAssetStates] = useState<AssetState[]>([]);
  const [companies, setCompanies] = useState<Company[]>([]);
  const [sites, setSites] = useState<Site[]>([]);

  // Estados para los activos
  const [assets, setAssets] = useState<Asset[]>([]);
  const [filteredAssets, setFilteredAssets] = useState<Asset[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingAsset, setEditingAsset] = useState<Asset | null>(null);
  const [isDetailModalOpen, setIsDetailModalOpen] = useState(false);
  const [detailAssetID, setDetailAssetID] = useState<number | null>(null);
  const [isAssignmentModalOpen, setIsAssignmentModalOpen] = useState(false);
  const [assignmentAssetID, setAssignmentAssetID] = useState<number | null>(null);
  const [isDeliveryModalOpen, setIsDeliveryModalOpen] = useState(false);
  const [deliveryAssetID, setDeliveryAssetID] = useState<number | null>(null);
  const [isExporting, setIsExporting] = useState(false);

  // Estados para filtros y selección
  const [selectedAssets, setSelectedAssets] = useState<Set<number>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");
  const [filterChips, setFilterChips] = useState<FilterChip[]>([]);
  const [isSearchPinned, setIsSearchPinned] = useState(false);

  // Estados para paginación y vista
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(20);

  // Column resize state
  const [colWidths, setColWidths] = useState<Record<string, number>>(INITIAL_COL_WIDTHS);
  const resizingCol = useRef<string | null>(null);
  const resizeStartX = useRef(0);
  const resizeStartW = useRef(0);

  const onResizeStart = useCallback(
    (col: string) => (e: React.MouseEvent) => {
      e.preventDefault();
      resizingCol.current = col;
      resizeStartX.current = e.clientX;
      resizeStartW.current = colWidths[col];

      const onMouseMove = (ev: MouseEvent) => {
        if (!resizingCol.current) return;
        const diff = ev.clientX - resizeStartX.current;
        const newW = Math.min(600, Math.max(50, resizeStartW.current + diff));
        setColWidths((prev) => ({ ...prev, [resizingCol.current!]: newW }));
      };

      const onMouseUp = () => {
        resizingCol.current = null;
        document.removeEventListener("mousemove", onMouseMove);
        document.removeEventListener("mouseup", onMouseUp);
      };

      document.addEventListener("mousemove", onMouseMove);
      document.addEventListener("mouseup", onMouseUp);
    },
    [colWidths]
  );

  // Cargar catálogos al montar el componente
  useEffect(() => {
    const loadCatalogs = async () => {
      try {
        const [
          productTypesRes,
          vendorsRes,
          assetStatesRes,
          companiesRes,
          sitesRes,
        ] = await Promise.all([
          api.productType.getAll().catch(() => []),
          api.vendor.getAll().catch(() => []),
          api.assetState.getAll().catch(() => []),
          api.company.getAll().catch(() => []),
          api.site.getAll().catch(() => []),
        ]);

        setProductTypes(productTypesRes);
        setVendors(vendorsRes);
        setAssetStates(assetStatesRes);
        setCompanies(companiesRes);
        setSites(sitesRes);
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

  // Obtener usuarios únicos de los activos
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

  // Tipos de activo disponibles para filtros
  const filteredProductTypes = productTypes;

  // Extraer valores únicos de componentes desde los activos
  const uniqueRAM = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.ram) values.add(a.assetDetail.ram); });
    return Array.from(values).sort();
  }, [assets]);

  const uniqueHddCapacity = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.hddCapacity) values.add(a.assetDetail.hddCapacity); });
    return Array.from(values).sort();
  }, [assets]);

  const uniqueHddModel = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.hddModel) values.add(a.assetDetail.hddModel); });
    return Array.from(values).sort();
  }, [assets]);

  const uniqueOS = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.operatingSystem) values.add(a.assetDetail.operatingSystem); });
    return Array.from(values).sort();
  }, [assets]);

  const uniqueMemoryType = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.physicalMemory) values.add(a.assetDetail.physicalMemory); });
    return Array.from(values).sort();
  }, [assets]);

  const uniqueSites = useMemo(() => {
    const siteMap = new Map<number, { siteID: number; name: string }>();
    assets.forEach((a) => {
      if (a.site && a.site.siteID && a.site.name) {
        siteMap.set(a.site.siteID, { siteID: a.site.siteID, name: a.site.name });
      }
    });
    return Array.from(siteMap.values()).sort((a, b) => a.name.localeCompare(b.name));
  }, [assets]);

  const uniqueDepartments = useMemo(() => {
    const deptMap = new Map<number, { departID: number; name: string }>();
    assets.forEach((a) => {
      if (a.depart && a.depart.departID && a.depart.Name) {
        deptMap.set(a.depart.departID, { departID: a.depart.departID, name: a.depart.Name });
      }
    });
    return Array.from(deptMap.values()).sort((a, b) => a.name.localeCompare(b.name));
  }, [assets]);

  const uniqueProcessors = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.processor) values.add(a.assetDetail.processor); });
    return Array.from(values).sort();
  }, [assets]);

  const uniqueManufacturers = useMemo(() => {
    const values = new Set<string>();
    assets.forEach((a) => { if (a.assetDetail?.productManuf) values.add(a.assetDetail.productManuf); });
    return Array.from(values).sort();
  }, [assets]);

  // Determinar grupo activo desde los chips de filtro
  const activeGroup = useMemo(() => {
    const grupoChips = filterChips.filter((c) => c.facet === "grupo");
    if (grupoChips.length === 1) return grupoChips[0].value;
    return null; // Ninguno o múltiples grupos → mostrar todos los filtros
  }, [filterChips]);

  // Filtros técnicos por grupo:
  // Equipo: RAM, Tipo Memoria, Capacidad Disco, Tipo Disco, SO, Procesador
  // Componente: RAM, Tipo Memoria, Capacidad Disco, Tipo Disco
  // Otro: SO, RAM, Capacidad Disco
  // Accesorio: ninguno técnico
  // null (todos): todos disponibles
  const TECH_FILTERS_BY_GROUP: Record<string, string[]> = {
    Equipo: ["ram", "memoria_tipo", "disco_cap", "disco_tipo", "so", "procesador"],
    Componente: ["ram", "memoria_tipo", "disco_cap", "disco_tipo"],
    Otro: ["so", "ram", "disco_cap"],
    Accesorio: [],
  };

  const allowedTechFilters = useMemo(() => {
    if (!activeGroup) return null; // null = mostrar todos
    return new Set(TECH_FILTERS_BY_GROUP[activeGroup] || []);
  }, [activeGroup]);

  const TECH_FILTER_KEYS = new Set(["ram", "memoria_tipo", "disco_cap", "disco_tipo", "so", "procesador"]);

  // Definir facetas para el omnibox
  const facets: Facet[] = useMemo(
    () => {
      const allFacets: Facet[] = [
        {
          key: "grupo",
          label: "Grupo",
          color: "slate",
          options: ASSET_GROUPS.map((g) => ({ value: g, label: g })),
        },
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
          key: "site",
          label: "Site",
          color: "sky",
          options: uniqueSites.map((s) => ({
            value: String(s.siteID),
            label: s.name,
          })),
        },
        {
          key: "departamento",
          label: "Departamento",
          color: "lime",
          options: uniqueDepartments.map((d) => ({
            value: String(d.departID),
            label: d.name,
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
        {
          key: "proveedor",
          label: "Proveedor",
          color: "violet",
          options: vendors.map((v) => ({
            value: String(v.vendorID),
            label: v.name,
          })),
        },
        {
          key: "fabricante",
          label: "Fabricante",
          color: "stone",
          options: uniqueManufacturers.map((v) => ({ value: v, label: v })),
        },
        // Filtros técnicos (condicionales según grupo)
        {
          key: "ram",
          label: "RAM",
          color: "cyan",
          options: uniqueRAM.map((v) => ({ value: v, label: v })),
        },
        {
          key: "memoria_tipo",
          label: "Tipo Memoria",
          color: "teal",
          options: uniqueMemoryType.map((v) => ({ value: v, label: v })),
        },
        {
          key: "disco_cap",
          label: "Capacidad Disco",
          color: "orange",
          options: uniqueHddCapacity.map((v) => ({ value: v, label: v })),
        },
        {
          key: "disco_tipo",
          label: "Tipo Disco",
          color: "rose",
          options: uniqueHddModel.map((v) => ({ value: v, label: v })),
        },
        {
          key: "so",
          label: "Sistema Operativo",
          color: "indigo",
          options: uniqueOS.map((v) => ({ value: v, label: v })),
        },
        {
          key: "procesador",
          label: "Procesador",
          color: "fuchsia",
          options: uniqueProcessors.map((v) => ({ value: v, label: v })),
        },
      ];

      // Filtrar facetas técnicas según el grupo seleccionado
      if (allowedTechFilters === null) return allFacets; // Sin grupo → todos
      return allFacets.filter((f) => !TECH_FILTER_KEYS.has(f.key) || allowedTechFilters.has(f.key));
    },
    [companies, uniqueUsers, assetStates, filteredProductTypes, vendors, uniqueRAM, uniqueHddCapacity, uniqueHddModel, uniqueOS, uniqueMemoryType, uniqueSites, uniqueDepartments, uniqueProcessors, uniqueManufacturers, allowedTechFilters]
  );

  // Limpiar chips de filtros técnicos que ya no son visibles al cambiar de grupo
  useEffect(() => {
    if (allowedTechFilters === null) return; // Sin grupo → no limpiar
    setFilterChips((prev) =>
      prev.filter((c) => !TECH_FILTER_KEYS.has(c.facet) || allowedTechFilters.has(c.facet))
    );
  }, [allowedTechFilters]);

  // Aplicar filtros cuando cambien
  useEffect(() => {
    let result = [...assets];

    // Aplicar chips: AND entre facetas distintas, OR dentro de la misma faceta
    const chipsByFacet = new Map<string, Set<string>>();
    filterChips.forEach((chip) => {
      if (!chipsByFacet.has(chip.facet)) {
        chipsByFacet.set(chip.facet, new Set());
      }
      chipsByFacet.get(chip.facet)!.add(chip.value);
    });

    if (chipsByFacet.has("grupo")) {
      const values = chipsByFacet.get("grupo")!;
      result = result.filter((a) => a.productType?.group && values.has(a.productType.group));
    }
    if (chipsByFacet.has("empresa")) {
      const values = chipsByFacet.get("empresa")!;
      result = result.filter((a) => values.has(String(a.companyID)));
    }
    if (chipsByFacet.has("site")) {
      const values = chipsByFacet.get("site")!;
      result = result.filter((a) => values.has(String(a.siteID)));
    }
    if (chipsByFacet.has("departamento")) {
      const values = chipsByFacet.get("departamento")!;
      result = result.filter((a) => a.depart && values.has(String(a.depart.departID)));
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
    if (chipsByFacet.has("proveedor")) {
      const values = chipsByFacet.get("proveedor")!;
      result = result.filter((a) => values.has(String(a.vendorID)));
    }
    if (chipsByFacet.has("ram")) {
      const values = chipsByFacet.get("ram")!;
      result = result.filter((a) => a.assetDetail?.ram && values.has(a.assetDetail.ram));
    }
    if (chipsByFacet.has("disco_cap")) {
      const values = chipsByFacet.get("disco_cap")!;
      result = result.filter((a) => a.assetDetail?.hddCapacity && values.has(a.assetDetail.hddCapacity));
    }
    if (chipsByFacet.has("disco_tipo")) {
      const values = chipsByFacet.get("disco_tipo")!;
      result = result.filter((a) => a.assetDetail?.hddModel && values.has(a.assetDetail.hddModel));
    }
    if (chipsByFacet.has("so")) {
      const values = chipsByFacet.get("so")!;
      result = result.filter((a) => a.assetDetail?.operatingSystem && values.has(a.assetDetail.operatingSystem));
    }
    if (chipsByFacet.has("memoria_tipo")) {
      const values = chipsByFacet.get("memoria_tipo")!;
      result = result.filter((a) => a.assetDetail?.physicalMemory && values.has(a.assetDetail.physicalMemory));
    }
    if (chipsByFacet.has("procesador")) {
      const values = chipsByFacet.get("procesador")!;
      result = result.filter((a) => a.assetDetail?.processor && values.has(a.assetDetail.processor));
    }
    if (chipsByFacet.has("fabricante")) {
      const values = chipsByFacet.get("fabricante")!;
      result = result.filter((a) => a.assetDetail?.productManuf && values.has(a.assetDetail.productManuf));
    }

    // Filtrar por búsqueda de texto libre
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
  }, [assets, filterChips, searchQuery]);

  // Paginación
  const paginatedAssets = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredAssets.slice(start, start + pageSize);
  }, [filteredAssets, currentPage, pageSize]);

  const totalPages = Math.ceil(filteredAssets.length / pageSize);
  const startItem = filteredAssets.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endItem = Math.min(currentPage * pageSize, filteredAssets.length);

  // Handlers
  const handleRefresh = () => {
    loadAssets();
    toast.success("Lista actualizada");
  };

  const handleCreateAsset = () => {
    setIsCreateModalOpen(true);
  };

  const handleCreateSuccess = () => {
    loadAssets();
    toast.success("Activo creado exitosamente");
  };

  const handleProductTypeCreated = async () => {
    try {
      const productTypesRes = await api.productType.getAll().catch(() => []);
      setProductTypes(productTypesRes);
    } catch (error) {
      console.error("Error reloading product types:", error);
    }
  };

  const handleSelectAll = (checked: boolean) => {
    if (checked) {
      setSelectedAssets(new Set(paginatedAssets.map((a) => a.assetID)));
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

  const handleEditSuccess = () => {
    loadAssets();
    setSelectedAssets(new Set());
  };

  const handleOpenDetail = (assetID: number) => {
    setDetailAssetID(assetID);
    setIsDetailModalOpen(true);
  };

  const handleDetailToEdit = (asset: Asset) => {
    if (asset.assetStateInfo?.name === "Baja") {
      toast.error("No se puede editar un activo dado de baja");
      return;
    }
    setEditingAsset(asset);
    setIsEditModalOpen(true);
  };

  const handleDirectEdit = (asset: Asset) => {
    if (asset.assetStateInfo?.name === "Baja") {
      toast.error("No se puede editar un activo dado de baja");
      return;
    }
    setEditingAsset(asset);
    setIsEditModalOpen(true);
  };

  const handleOpenAssignment = (assetID: number) => {
    setAssignmentAssetID(assetID);
    setIsAssignmentModalOpen(true);
  };

  const triggerDownload = (blob: Blob, filename: string) => {
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    window.URL.revokeObjectURL(url);
    document.body.removeChild(a);
  };

  const handleExportCsv = async () => {
    try {
      setIsExporting(true);
      const filters: { group?: string } = {};
      if (activeGroup) filters.group = activeGroup;
      const blob = await api.report.downloadAssetsCsv(filters);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(new Blob([blob], { type: "text/csv" }), `inventario_${dateStr}.csv`);
      toast.success("CSV exportado exitosamente");
    } catch (error) {
      console.error("Error exporting CSV:", error);
      toast.error("Error al exportar CSV");
    } finally {
      setIsExporting(false);
    }
  };

  const handleExportExcel = async () => {
    try {
      setIsExporting(true);
      const filters: { group?: string } = {};
      if (activeGroup) filters.group = activeGroup;
      const blob = await api.report.downloadAssetsExcel(filters);
      const dateStr = new Date().toISOString().split("T")[0];
      triggerDownload(
        new Blob([blob], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
        `inventario_${dateStr}.xlsx`
      );
      toast.success("Excel exportado exitosamente");
    } catch (error) {
      console.error("Error exporting Excel:", error);
      toast.error("Error al exportar Excel");
    } finally {
      setIsExporting(false);
    }
  };

  const handleOpenDeliveryReport = (assetID: number) => {
    setDeliveryAssetID(assetID);
    setIsDeliveryModalOpen(true);
  };

  const handleImportCSV = () => {
    toast.info("Funcionalidad de importación en desarrollo");
  };

  const isAllSelected = paginatedAssets.length > 0 &&
    paginatedAssets.every((a) => selectedAssets.has(a.assetID));

  return (
    <MainLayout
      breadcrumb={{ title: "Altas", subtitle: "Registro de activos TI" }}
    >
      {() => (
        <div className="flex flex-col h-full bg-white">
          {/* Toolbar con omnibox y acciones */}
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
                variant="outline"
                size="sm"
                onClick={handleCreateAsset}
                className="h-8 text-sm font-normal"
              >
                Nuevo
              </Button>

              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="sm" className="h-8 text-sm font-normal">
                    Acciones
                    <ChevronDown className="h-4 w-4 ml-1" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={handleExportCsv} disabled={isExporting}>
                    <Download className="h-4 w-4 mr-2" />
                    Exportar a CSV
                  </DropdownMenuItem>
                  <DropdownMenuItem onClick={handleExportExcel} disabled={isExporting}>
                    <FileText className="h-4 w-4 mr-2" />
                    Exportar a Excel
                  </DropdownMenuItem>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem onClick={handleImportCSV}>
                    <FileText className="h-4 w-4 mr-2" />
                    Import from CSV
                  </DropdownMenuItem>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem onClick={handleRefresh}>
                    <RefreshCw className="h-4 w-4 mr-2" />
                    Refresh
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </div>

            {/* Paginación */}
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
                onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
                disabled={currentPage >= totalPages}
              >
                <ChevronRight className="h-4 w-4" />
              </Button>
            </div>
          </div>

          {/* Tabla */}
          <div className="flex-1 overflow-auto">
            {isLoading ? (
              <div className="flex items-center justify-center h-64">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
              </div>
            ) : (
              <Table style={{ tableLayout: "fixed", width: Object.values(colWidths).reduce((a, b) => a + b, 0) }}>
                <colgroup>
                  {Object.entries(colWidths).map(([key, w]) => (
                    <col key={key} style={{ width: w }} />
                  ))}
                </colgroup>
                <TableHeader className="bg-gray-50 sticky top-0 z-10">
                  <TableRow>
                    {[
                      { key: "checkbox", label: "" },
                      { key: "actions", label: "" },
                      { key: "name", label: "NOMBRE" },
                      { key: "company", label: "COMPAÑIA" },
                      { key: "site", label: "SITE" },
                      { key: "department", label: "DEPARTAMENTO" },
                      { key: "user", label: "USUARIO" },
                      { key: "type", label: "TIPO" },
                      { key: "brand", label: "MARCA" },
                      { key: "model", label: "MODELO" },
                      { key: "serial", label: "SERIE" },
                      { key: "state", label: "ESTADO" },
                    ].map((col) => (
                      <TableHead
                        key={col.key}
                        className="font-semibold text-gray-700 relative select-none overflow-hidden text-ellipsis whitespace-nowrap"
                        style={{ width: colWidths[col.key] }}
                      >
                        {col.label}
                        {col.label && (
                          <span
                            onMouseDown={onResizeStart(col.key)}
                            className="absolute right-0 top-0 bottom-0 w-1.5 cursor-col-resize hover:bg-blue-400 active:bg-blue-500"
                          />
                        )}
                      </TableHead>
                    ))}
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {paginatedAssets.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={12} className="h-24 text-center text-gray-500">
                        No se encontraron activos
                      </TableCell>
                    </TableRow>
                  ) : (
                    paginatedAssets.map((asset) => {
                      const isBaja = asset.assetStateInfo?.name === "Baja";
                      return (
                      <TableRow
                        key={asset.assetID}
                        className={cn(
                          "hover:bg-gray-50",
                          selectedAssets.has(asset.assetID) && "bg-blue-50",
                          isBaja && "opacity-60 bg-red-50/50"
                        )}
                      >
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap">

                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap">
                          <div className="flex items-center gap-1">
                            <button
                              className={cn(
                                "p-1 rounded transition-colors",
                                isBaja ? "cursor-not-allowed opacity-50" : "hover:bg-amber-50"
                              )}
                              title={isBaja ? "Activo dado de baja - no se permite editar" : "Editar activo"}
                              disabled={isBaja}
                              onClick={(e) => {
                                e.stopPropagation();
                                if (!isBaja) handleDirectEdit(asset);
                              }}
                            >
                              <Pencil className={cn("h-4 w-4", isBaja ? "text-gray-300" : "text-gray-400 hover:text-amber-600")} />
                            </button>
                          </div>
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap">
                          <button
                            className="font-medium text-blue-600 hover:underline truncate block text-left max-w-full"
                            title={asset.name}
                            onClick={(e) => {
                              e.stopPropagation();
                              handleOpenDetail(asset.assetID);
                            }}
                          >
                            {asset.name}
                          </button>
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.company?.description || ""}>
                          {asset.company?.description || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.site?.name || ""}>
                          {asset.site?.name || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.depart?.Name || ""}>
                          {asset.depart?.Name || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.user?.name || ""}>
                          {asset.user?.name || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.productType?.name || ""}>
                          {asset.productType?.name || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.assetDetail?.productManuf || ""}>
                          {asset.assetDetail?.productManuf || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.assetDetail?.model || ""}>
                          {asset.assetDetail?.model || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap" title={asset.assetDetail?.serialNum || ""}>
                          {asset.assetDetail?.serialNum || "-"}
                        </TableCell>
                        <TableCell className="overflow-hidden text-ellipsis whitespace-nowrap">
                          <span className={cn(isBaja && "text-red-600 font-semibold")}>
                            {asset.assetStateInfo?.name || "-"}
                          </span>
                        </TableCell>
                      </TableRow>
                      );
                    })
                  )}
                </TableBody>
              </Table>
            )}
          </div>

          {/* Modal de Crear Activo */}
          <CreateAssetModal
            productTypes={productTypes}
            vendors={vendors}
            assetStates={assetStates}
            companies={companies}
            sites={sites}
            isOpen={isCreateModalOpen}
            onClose={() => setIsCreateModalOpen(false)}
            onSuccess={handleCreateSuccess}
            onProductTypeCreated={handleProductTypeCreated}
          />

          {/* Modal de Editar Activo */}
          {editingAsset && (
            <EditAssetModal
              asset={editingAsset}
              productTypes={productTypes}
              vendors={vendors}
              assetStates={assetStates}
              companies={companies}
              sites={sites}
              isOpen={isEditModalOpen}
              onClose={() => {
                setIsEditModalOpen(false);
                setEditingAsset(null);
              }}
              onSuccess={handleEditSuccess}
              onOpenAssignment={handleOpenAssignment}
            />
          )}

          {/* Modal de Ficha Tecnica */}
          {detailAssetID && (
            <AssetDetailModal
              assetID={detailAssetID}
              isOpen={isDetailModalOpen}
              onClose={() => {
                setIsDetailModalOpen(false);
                setDetailAssetID(null);
              }}
              onEdit={handleDetailToEdit}
              onOpenAssignment={handleOpenAssignment}
              onOpenDeliveryReport={handleOpenDeliveryReport}
            />
          )}

          {/* Modal de Asignacion */}
          {assignmentAssetID && (
            <AssetAssignmentModal
              assetID={assignmentAssetID}
              isOpen={isAssignmentModalOpen}
              onClose={() => {
                setIsAssignmentModalOpen(false);
                setAssignmentAssetID(null);
              }}
              onSuccess={loadAssets}
            />
          )}

          {/* Modal de Reporte de Entrega */}
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
