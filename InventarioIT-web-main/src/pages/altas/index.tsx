import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import { ProductType, Vendor, AssetState, Company, Site, Asset } from "@/types";
import api from "@/lib/api";
import { CreateAssetModal } from "@/components/CreateAssetModal";
import { EditAssetModal } from "@/components/EditAssetModal";
import { AssetDetailModal } from "@/components/AssetDetailModal";
import {
  OmniboxFilter,
  type FilterChip,
  type Facet,
} from "@/components/OmniboxFilter";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
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

const ASSET_CATEGORIES = ["Equipo", "Accesorio", "Componente", "Otro"] as const;

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

  // Estados para filtros y selección
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [selectedAssets, setSelectedAssets] = useState<Set<number>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");
  const [filterChips, setFilterChips] = useState<FilterChip[]>([]);

  // Estados para paginación y vista
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(10);

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

  // Tipos de activo filtrados por categoría seleccionada
  const filteredProductTypes = useMemo(() => {
    if (selectedCategory) {
      return productTypes.filter((pt) => pt.category === selectedCategory);
    }
    return productTypes;
  }, [productTypes, selectedCategory]);

  // Definir facetas para el omnibox
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

  // Aplicar filtros cuando cambien
  useEffect(() => {
    let result = [...assets];

    // Filtrar por categoría (botones)
    if (selectedCategory) {
      result = result.filter(
        (asset) => asset.productType?.category === selectedCategory
      );
    }

    // Aplicar chips: AND entre facetas distintas, OR dentro de la misma faceta
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

    // Filtrar por búsqueda de texto libre
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(
        (asset) =>
          asset.name.toLowerCase().includes(query) ||
          asset.assetDetail?.serialNum?.toLowerCase().includes(query) ||
          asset.assetDetail?.assetTAG?.toLowerCase().includes(query) ||
          asset.user?.name?.toLowerCase().includes(query) ||
          asset.user?.department?.toLowerCase().includes(query) ||
          asset.vendor?.name?.toLowerCase().includes(query) ||
          asset.productType?.name?.toLowerCase().includes(query)
      );
    }

    setFilteredAssets(result);
    setCurrentPage(1);
  }, [assets, selectedCategory, filterChips, searchQuery]);

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
    setEditingAsset(asset);
    setIsEditModalOpen(true);
  };

  const handleDirectEdit = (asset: Asset) => {
    setEditingAsset(asset);
    setIsEditModalOpen(true);
  };

  const handleDelete = async () => {
    if (selectedAssets.size === 0) return;

    const confirmed = window.confirm(
      `¿Está seguro de eliminar ${selectedAssets.size} activo(s)?`
    );
    if (!confirmed) return;

    try {
      await Promise.all(Array.from(selectedAssets).map((id) => api.asset.delete(id)));
      toast.success(`${selectedAssets.size} activo(s) eliminado(s)`);
      setSelectedAssets(new Set());
      loadAssets();
    } catch (error) {
      console.error("Error deleting assets:", error);
      toast.error("Error al eliminar activos");
    }
  };

  const handleExport = () => {
    toast.info("Funcionalidad de exportación en desarrollo");
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
          {/* Header - Botones de categoría */}
          <div className="px-4 py-3 border-b">
            <div className="flex items-center gap-2">
              <Button
                variant={selectedCategory === null ? "default" : "outline"}
                size="sm"
                onClick={() => setSelectedCategory(null)}
                className="h-9 text-sm font-medium"
              >
                Todos
              </Button>
              {ASSET_CATEGORIES.map((category) => (
                <Button
                  key={category}
                  variant={selectedCategory === category ? "default" : "outline"}
                  size="sm"
                  onClick={() => {
                    setSelectedCategory(
                      selectedCategory === category ? null : category
                    );
                    // Limpiar chips de tipo de activo al cambiar categoría
                    setFilterChips((prev) =>
                      prev.filter((c) => c.facet !== "tipo")
                    );
                  }}
                  className="h-9 text-sm font-medium"
                >
                  {category}
                </Button>
              ))}
            </div>
          </div>

          {/* Toolbar con omnibox y acciones */}
          <div className="flex items-center gap-3 px-4 py-2 border-b bg-gray-50">
            {/* Omnibox */}
            <OmniboxFilter
              facets={facets}
              chips={filterChips}
              onChipsChange={setFilterChips}
              searchQuery={searchQuery}
              onSearchQueryChange={setSearchQuery}
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

              <Button
                variant="outline"
                size="sm"
                onClick={handleDelete}
                disabled={selectedAssets.size === 0}
                className="h-8 text-sm font-normal"
              >
                Eliminar
              </Button>

              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="sm" className="h-8 text-sm font-normal">
                    Acciones
                    <ChevronDown className="h-4 w-4 ml-1" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={handleExport}>
                    <Download className="h-4 w-4 mr-2" />
                    Export to CSV
                  </DropdownMenuItem>
                  <DropdownMenuItem onClick={() => toast.info("Export PDF en desarrollo")}>
                    <FileText className="h-4 w-4 mr-2" />
                    Export to PDF
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
              <Table>
                <TableHeader className="bg-gray-50 sticky top-0">
                  <TableRow>
                    <TableHead className="w-10">
                      <Checkbox
                        checked={isAllSelected}
                        onCheckedChange={handleSelectAll}
                      />
                    </TableHead>
                    <TableHead className="w-16"></TableHead>
                    <TableHead className="font-semibold text-gray-700">NOMBRE</TableHead>
                    <TableHead className="font-semibold text-gray-700">COMPAÑIA</TableHead>
                    <TableHead className="font-semibold text-gray-700">SITE</TableHead>
                    <TableHead className="font-semibold text-gray-700">SERIAL</TableHead>
                    <TableHead className="font-semibold text-gray-700">MODELO</TableHead>
                    <TableHead className="font-semibold text-gray-700">ESTADO</TableHead>
                    <TableHead className="font-semibold text-gray-700">TIPO</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {paginatedAssets.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={9} className="h-24 text-center text-gray-500">
                        No se encontraron activos
                      </TableCell>
                    </TableRow>
                  ) : (
                    paginatedAssets.map((asset) => (
                      <TableRow
                        key={asset.assetID}
                        className={cn(
                          "hover:bg-gray-50",
                          selectedAssets.has(asset.assetID) && "bg-blue-50"
                        )}
                      >
                        <TableCell>
                          <Checkbox
                            checked={selectedAssets.has(asset.assetID)}
                            onCheckedChange={(checked) =>
                              handleSelectAsset(asset.assetID, !!checked)
                            }
                          />
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-1">
                            <button
                              className="p-1 hover:bg-amber-50 rounded transition-colors"
                              title="Editar activo"
                              onClick={(e) => {
                                e.stopPropagation();
                                handleDirectEdit(asset);
                              }}
                            >
                              <Pencil className="h-4 w-4 text-gray-400 hover:text-amber-600" />
                            </button>
                          </div>
                        </TableCell>
                        <TableCell className="max-w-[250px]">
                          <button
                            className="font-medium text-blue-600 hover:text-blue-800 hover:underline truncate block text-left max-w-full"
                            title="Ver ficha tecnica"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleOpenDetail(asset.assetID);
                            }}
                          >
                            {asset.name}
                          </button>
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.company?.description || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.site?.name || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.assetDetail?.serialNum || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.assetDetail?.model || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.assetStateInfo?.name || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.productType?.name || "-"}
                        </TableCell>
                      </TableRow>
                    ))
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
            />
          )}
        </div>
      )}
    </MainLayout>
  );
}
