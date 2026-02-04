import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo, useCallback } from "react";
import { ProductType, Vendor, AssetState, Company, Site, Asset } from "@/types";
import api from "@/lib/api";
import { AssetCategorySidebar } from "@/components/AssetCategorySidebar";
import { AssetToolbar } from "@/components/AssetToolbar";
import { AssetDataTable } from "@/components/AssetDataTable";
import { CreateAssetModal } from "@/components/CreateAssetModal";
import { ChevronDown } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { toast } from "sonner";

type FilterType = {
  type: "all" | "category" | "group" | "subCategory" | "productType";
  value: string | null;
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
  const [isLoading, setIsLoading] = useState(false);
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);

  // Estados para filtros y selección
  const [selectedFilter, setSelectedFilter] = useState<FilterType>({
    type: "all",
    value: null,
  });
  const [selectedAssetIds, setSelectedAssetIds] = useState<number[]>([]);
  const [searchQuery, setSearchQuery] = useState("");

  // Estados para paginación y vista
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(10);
  const [currentView, setCurrentView] = useState<"list" | "grid">("list");

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
    } catch (error) {
      console.error("Error fetching assets:", error);
      toast.error("Error al cargar los activos");
    } finally {
      setIsLoading(false);
    }
  };

  // Filtrar activos
  const filteredAssets = useMemo(() => {
    let result = [...assets];

    // Aplicar filtro de categoría
    if (selectedFilter.type !== "all" && selectedFilter.value) {
      switch (selectedFilter.type) {
        case "category":
          result = result.filter(
            (asset) => asset.productType?.category === selectedFilter.value
          );
          break;
        case "group":
          result = result.filter(
            (asset) => asset.productType?.group === selectedFilter.value
          );
          break;
        case "subCategory":
          result = result.filter(
            (asset) => asset.productType?.subCategory === selectedFilter.value
          );
          break;
        case "productType":
          result = result.filter(
            (asset) =>
              asset.productTypeID.toString() === selectedFilter.value
          );
          break;
      }
    }

    // Aplicar búsqueda
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(
        (asset) =>
          asset.name.toLowerCase().includes(query) ||
          asset.assetDetail?.serialNum?.toLowerCase().includes(query) ||
          asset.assetDetail?.assetTAG?.toLowerCase().includes(query) ||
          asset.user?.name?.toLowerCase().includes(query) ||
          asset.vendor?.name?.toLowerCase().includes(query)
      );
    }

    return result;
  }, [assets, selectedFilter, searchQuery]);

  // Obtener el título basado en el filtro
  const getFilterTitle = useCallback(() => {
    if (selectedFilter.type === "all") return "All Assets";
    if (selectedFilter.value) {
      if (selectedFilter.type === "productType") {
        const pt = productTypes.find(
          (p) => p.productTypeID.toString() === selectedFilter.value
        );
        return pt?.name || "Assets";
      }
      return selectedFilter.value;
    }
    return "All Assets";
  }, [selectedFilter, productTypes]);

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

  const handleEdit = () => {
    if (selectedAssetIds.length === 1) {
      const asset = assets.find((a) => a.assetID === selectedAssetIds[0]);
      if (asset) {
        // TODO: Abrir modal de edición
        console.log("Editar activo:", asset);
        toast.info("Funcionalidad de edición en desarrollo");
      }
    }
  };

  const handleDelete = async () => {
    if (selectedAssetIds.length === 0) return;

    const confirmed = window.confirm(
      `¿Está seguro de eliminar ${selectedAssetIds.length} activo(s)?`
    );
    if (!confirmed) return;

    try {
      await Promise.all(selectedAssetIds.map((id) => api.asset.delete(id)));
      toast.success(`${selectedAssetIds.length} activo(s) eliminado(s)`);
      setSelectedAssetIds([]);
      loadAssets();
    } catch (error) {
      console.error("Error deleting assets:", error);
      toast.error("Error al eliminar activos");
    }
  };

  const handleImportCSV = () => {
    toast.info("Funcionalidad de importación en desarrollo");
  };

  const handleAssignUsers = () => {
    if (selectedAssetIds.length === 0) return;
    toast.info("Funcionalidad de asignación en desarrollo");
  };

  const handleExport = () => {
    toast.info("Funcionalidad de exportación en desarrollo");
  };

  const handleRowDoubleClick = (asset: Asset) => {
    console.log("Ver detalles del activo:", asset);
    // TODO: Abrir modal de detalles o navegar a página de detalles
  };

  return (
    <MainLayout
      breadcrumb={{ title: "Altas", subtitle: "Registro de activos TI" }}
    >
      {() => (
        <div className="flex h-[calc(100vh-120px)]">
          {/* Sidebar de Categorías */}
          <div className="w-64 flex-shrink-0 border-r overflow-hidden">
            <AssetCategorySidebar
              productTypes={productTypes}
              selectedFilter={selectedFilter}
              onFilterChange={setSelectedFilter}
            />
          </div>

          {/* Panel Principal */}
          <div className="flex-1 flex flex-col overflow-hidden">
            {/* Encabezado con breadcrumb y título */}
            <div className="px-4 py-3 border-b bg-white">
              {/* Breadcrumb */}
              <div className="text-xs text-gray-500 mb-1">
                All Assets
              </div>

              {/* Título con dropdown */}
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <button className="flex items-center gap-2 text-lg font-semibold text-gray-900 hover:text-gray-700">
                    {getFilterTitle()}
                    <ChevronDown className="h-5 w-5" />
                  </button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                  <DropdownMenuItem onClick={() => setSelectedFilter({ type: "all", value: null })}>
                    All Assets
                  </DropdownMenuItem>
                  {Array.from(new Set(productTypes.map((pt) => pt.category))).map(
                    (category) => (
                      <DropdownMenuItem
                        key={category}
                        onClick={() =>
                          setSelectedFilter({ type: "category", value: category })
                        }
                      >
                        {category}
                      </DropdownMenuItem>
                    )
                  )}
                </DropdownMenuContent>
              </DropdownMenu>
            </div>

            {/* Barra de herramientas */}
            <AssetToolbar
              selectedCount={selectedAssetIds.length}
              totalCount={filteredAssets.length}
              currentPage={currentPage}
              pageSize={pageSize}
              onNew={handleCreateAsset}
              onEdit={handleEdit}
              onDelete={handleDelete}
              onImportCSV={handleImportCSV}
              onAssignUsers={handleAssignUsers}
              onExport={handleExport}
              onRefresh={handleRefresh}
              onPageChange={setCurrentPage}
              onViewChange={setCurrentView}
              currentView={currentView}
            />

            {/* Tabla de activos */}
            <div className="flex-1 overflow-auto p-4">
              <AssetDataTable
                data={filteredAssets}
                loading={isLoading}
                onSelectionChange={setSelectedAssetIds}
                onRowDoubleClick={handleRowDoubleClick}
              />
            </div>
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
          />
        </div>
      )}
    </MainLayout>
  );
}
