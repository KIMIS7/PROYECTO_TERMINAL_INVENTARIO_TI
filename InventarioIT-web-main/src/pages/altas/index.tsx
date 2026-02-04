import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import { ProductType, Vendor, AssetState, Company, Site, Asset } from "@/types";
import api from "@/lib/api";
import { CreateAssetModal } from "@/components/CreateAssetModal";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
  List,
  LayoutGrid,
  Pencil,
  Plus,
  Search,
  Settings,
  Trash2,
  Upload,
  UserPlus,
  Paperclip,
  RefreshCw,
  X,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { toast } from "sonner";

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

  // Estados para filtros y selección
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [selectedAssets, setSelectedAssets] = useState<Set<number>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearchOpen, setIsSearchOpen] = useState(false);

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
      setFilteredAssets(response as Asset[]);
    } catch (error) {
      console.error("Error fetching assets:", error);
    } finally {
      setIsLoading(false);
    }
  };

  // Aplicar filtros cuando cambien
  useEffect(() => {
    let result = [...assets];

    // Filtrar por categoría
    if (selectedCategory) {
      result = result.filter(
        (asset) => asset.productType?.category === selectedCategory
      );
    }

    // Filtrar por búsqueda
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
  }, [assets, selectedCategory, searchQuery]);

  // Paginación
  const paginatedAssets = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredAssets.slice(start, start + pageSize);
  }, [filteredAssets, currentPage, pageSize]);

  const totalPages = Math.ceil(filteredAssets.length / pageSize);
  const startItem = filteredAssets.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endItem = Math.min(currentPage * pageSize, filteredAssets.length);

  // Obtener categorías únicas
  const uniqueCategories = useMemo(() => {
    return Array.from(new Set(productTypes.map((pt) => pt.category))).filter(Boolean);
  }, [productTypes]);

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

  const handleEdit = () => {
    if (selectedAssets.size === 1) {
      toast.info("Funcionalidad de edición en desarrollo");
    }
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

  const handleAssignUsers = () => {
    if (selectedAssets.size === 0) {
      toast.warning("Seleccione al menos un activo");
      return;
    }
    toast.info("Funcionalidad de asignación en desarrollo");
  };

  const getFilterTitle = () => {
    if (!selectedCategory) return "All Assets";
    return selectedCategory;
  };

  const isAllSelected = paginatedAssets.length > 0 &&
    paginatedAssets.every((a) => selectedAssets.has(a.assetID));

  return (
    <MainLayout
      breadcrumb={{ title: "Altas", subtitle: "Registro de activos TI" }}
    >
      {() => (
        <div className="flex flex-col h-full bg-white">
          {/* Header */}
          <div className="px-4 py-3 border-b">
            {/* Breadcrumb */}
            <div className="text-xs text-gray-500 mb-1">All Assets</div>

            {/* Título con dropdown y vista toggle */}
            <div className="flex items-center justify-between">
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <button className="flex items-center gap-1 text-xl font-semibold text-gray-900 hover:text-gray-700">
                    {getFilterTitle()}
                    <ChevronDown className="h-5 w-5" />
                  </button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                  <DropdownMenuItem onClick={() => setSelectedCategory(null)}>
                    All Assets
                  </DropdownMenuItem>
                  <DropdownMenuSeparator />
                  {uniqueCategories.map((category) => (
                    <DropdownMenuItem
                      key={category}
                      onClick={() => setSelectedCategory(category)}
                    >
                      {category}
                    </DropdownMenuItem>
                  ))}
                </DropdownMenuContent>
              </DropdownMenu>

              {/* Vista toggle */}
              <div className="flex items-center border rounded overflow-hidden">
                <Button
                  variant={currentView === "list" ? "secondary" : "ghost"}
                  size="icon"
                  className="h-8 w-8 rounded-none"
                  onClick={() => setCurrentView("list")}
                >
                  <List className="h-4 w-4" />
                </Button>
                <Button
                  variant={currentView === "grid" ? "secondary" : "ghost"}
                  size="icon"
                  className="h-8 w-8 rounded-none"
                  onClick={() => setCurrentView("grid")}
                >
                  <LayoutGrid className="h-4 w-4" />
                </Button>
              </div>
            </div>
          </div>

          {/* Toolbar */}
          <div className="flex items-center justify-between px-4 py-2 border-b bg-gray-50">
            {/* Acciones izquierda */}
            <div className="flex items-center gap-1">
              <Button variant="ghost" size="icon" className="h-8 w-8">
                <FileText className="h-4 w-4 text-gray-500" />
              </Button>

              {/* Búsqueda */}
              {isSearchOpen ? (
                <div className="flex items-center">
                  <Input
                    placeholder="Buscar activos..."
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

              <Button
                variant="outline"
                size="sm"
                onClick={handleCreateAsset}
                className="h-8 text-sm font-normal"
              >
                New
              </Button>

              <Button
                variant="outline"
                size="sm"
                onClick={handleEdit}
                disabled={selectedAssets.size !== 1}
                className="h-8 text-sm font-normal"
              >
                Edit
              </Button>

              <Button
                variant="outline"
                size="sm"
                onClick={handleDelete}
                disabled={selectedAssets.size === 0}
                className="h-8 text-sm font-normal"
              >
                Delete
              </Button>

              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="sm" className="h-8 text-sm font-normal">
                    Actions
                    <ChevronDown className="h-4 w-4 ml-1" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                  <DropdownMenuItem onClick={handleExport}>
                    <Download className="h-4 w-4 mr-2" />
                    Export to CSV
                  </DropdownMenuItem>
                  <DropdownMenuItem onClick={() => toast.info("Export PDF en desarrollo")}>
                    <FileText className="h-4 w-4 mr-2" />
                    Export to PDF
                  </DropdownMenuItem>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem onClick={handleRefresh}>
                    <RefreshCw className="h-4 w-4 mr-2" />
                    Refresh
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>

              <div className="h-6 w-px bg-gray-300 mx-1" />

              <Button
                variant="outline"
                size="sm"
                onClick={handleImportCSV}
                className="h-8 text-sm font-normal"
              >
                Import from CSV
              </Button>

              <Button
                variant="outline"
                size="sm"
                onClick={handleAssignUsers}
                className="h-8 text-sm font-normal"
              >
                Assign Users
              </Button>
            </div>

            {/* Paginación derecha */}
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <span>
                {startItem} - {endItem} of {filteredAssets.length}
              </span>
              <span className="text-gray-400">...</span>
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
              <Button variant="ghost" size="icon" className="h-7 w-7" onClick={handleExport}>
                <Download className="h-4 w-4" />
              </Button>
              <Button variant="ghost" size="icon" className="h-7 w-7">
                <Settings className="h-4 w-4" />
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
                    <TableHead className="font-semibold text-gray-700">Name ↓</TableHead>
                    <TableHead className="font-semibold text-gray-700">User</TableHead>
                    <TableHead className="font-semibold text-gray-700">Department</TableHead>
                    <TableHead className="font-semibold text-gray-700">Associated To</TableHead>
                    <TableHead className="font-semibold text-gray-700">Product</TableHead>
                    <TableHead className="font-semibold text-gray-700">Product Type</TableHead>
                    <TableHead className="font-semibold text-gray-700">State</TableHead>
                    <TableHead className="font-semibold text-gray-700">AssetTag</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {paginatedAssets.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={10} className="h-24 text-center text-gray-500">
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
                            <button className="p-1 hover:bg-gray-100 rounded">
                              <Settings className="h-4 w-4 text-gray-400" />
                            </button>
                            {asset.user && (
                              <Paperclip className="h-4 w-4 text-gray-400" />
                            )}
                          </div>
                        </TableCell>
                        <TableCell className="font-medium text-gray-900 max-w-[250px] truncate">
                          {asset.name}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.user?.name || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.user?.department || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.site?.name || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600 max-w-[180px] truncate">
                          {asset.vendor?.name && asset.assetDetail?.model
                            ? `${asset.vendor.name} ${asset.assetDetail.model}`
                            : asset.vendor?.name || asset.assetDetail?.model || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.productType?.subCategory || asset.productType?.name || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600">
                          {asset.assetStateInfo?.name || "-"}
                        </TableCell>
                        <TableCell className="text-gray-600 font-mono text-xs">
                          {asset.assetDetail?.assetTAG || "-"}
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
          />
        </div>
      )}
    </MainLayout>
  );
}
