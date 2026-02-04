import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState, useMemo } from "react";
import { ProductType, Vendor, AssetState, Company, Site, Asset } from "@/types";
import api from "@/lib/api";
import { ColumnDef } from "@tanstack/react-table";
import { Badge } from "@/components/ui/badge";
import { DataTable } from "@/components/data-table";
import { AssetManagementPanel } from "@/components/AssetManagementPanel";
import { CreateAssetModal } from "@/components/CreateAssetModal";
import { Checkbox } from "@/components/ui/checkbox";
import { Settings, Paperclip } from "lucide-react";
import { cn } from "@/lib/utils";

// Función para obtener el color del estado
const getStateColor = (state: string) => {
  const lowerState = state.toLowerCase();
  if (lowerState.includes("assigned") || lowerState.includes("asignado")) {
    return "text-blue-600 bg-blue-50";
  }
  if (lowerState.includes("in use") || lowerState.includes("en uso") || lowerState.includes("uso")) {
    return "text-green-600 bg-green-50";
  }
  if (lowerState.includes("in shop") || lowerState.includes("disponible") || lowerState.includes("almacen")) {
    return "text-orange-600 bg-orange-50";
  }
  if (lowerState.includes("repair") || lowerState.includes("reparacion")) {
    return "text-yellow-600 bg-yellow-50";
  }
  if (lowerState.includes("retired") || lowerState.includes("retirado") || lowerState.includes("baja")) {
    return "text-gray-600 bg-gray-50";
  }
  return "text-gray-600 bg-gray-50";
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
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);

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

  // Handlers
  const handleRefresh = () => {
    loadAssets();
  };

  const handleCreateAsset = () => {
    setIsCreateModalOpen(true);
  };

  const handleCreateSuccess = () => {
    loadAssets();
  };

  const handleSearch = (query: string) => {
    if (!query.trim()) {
      applyFilters(selectedCategory, assets);
      return;
    }

    const filtered = assets.filter(
      (asset) =>
        asset.name.toLowerCase().includes(query.toLowerCase()) ||
        asset.assetDetail?.serialNum?.toLowerCase().includes(query.toLowerCase()) ||
        asset.assetDetail?.assetTAG?.toLowerCase().includes(query.toLowerCase()) ||
        asset.user?.name?.toLowerCase().includes(query.toLowerCase())
    );
    setFilteredAssets(filtered);
  };

  const handleFilterByCategory = (category: string | null) => {
    setSelectedCategory(category);
    applyFilters(category, assets);
  };

  const applyFilters = (category: string | null, assetList: Asset[]) => {
    if (!category) {
      setFilteredAssets(assetList);
      return;
    }

    const filtered = assetList.filter(
      (asset) => asset.productType?.category === category
    );
    setFilteredAssets(filtered);
  };

  // Columnas de la tabla estilo imagen
  const columns: ColumnDef<Asset>[] = useMemo(
    () => [
      {
        id: "actions",
        header: "",
        cell: () => (
          <div className="flex items-center gap-1">
            <button className="p-1 hover:bg-gray-100 rounded">
              <Settings className="h-4 w-4 text-gray-400" />
            </button>
            <button className="p-1 hover:bg-gray-100 rounded">
              <Paperclip className="h-4 w-4 text-gray-400" />
            </button>
          </div>
        ),
        enableSorting: false,
        size: 70,
      },
      {
        accessorKey: "name",
        header: "Name",
        cell: ({ row }) => {
          const asset = row.original;
          return (
            <span className="font-medium text-gray-900 truncate max-w-[250px]" title={asset.name}>
              {asset.name}
            </span>
          );
        },
      },
      {
        id: "user",
        header: "User",
        cell: ({ row }) => {
          const user = row.original.user;
          return (
            <span className="text-gray-600">
              {user?.name || "-"}
            </span>
          );
        },
      },
      {
        id: "department",
        header: "Department",
        cell: ({ row }) => {
          const user = row.original.user;
          return (
            <span className="text-gray-600">
              {user?.department || "-"}
            </span>
          );
        },
      },
      {
        id: "associatedTo",
        header: "Associated To",
        cell: ({ row }) => {
          const site = row.original.site;
          return (
            <span className="text-gray-600">
              {site?.name || "-"}
            </span>
          );
        },
      },
      {
        id: "product",
        header: "Product",
        cell: ({ row }) => {
          const detail = row.original.assetDetail;
          const vendor = row.original.vendor;
          const productName = detail?.model || row.original.name;
          const fullName = vendor ? `${vendor.name} ${productName}` : productName;
          return (
            <span className="text-gray-600 truncate max-w-[180px]" title={fullName}>
              {fullName}
            </span>
          );
        },
      },
      {
        id: "productType",
        header: "Product Type",
        cell: ({ row }) => {
          const productType = row.original.productType;
          return (
            <span className="text-gray-600">
              {productType?.subCategory || productType?.name || "-"}
            </span>
          );
        },
      },
      {
        id: "state",
        header: "State",
        cell: ({ row }) => {
          const stateInfo = row.original.assetStateInfo;
          const stateName = stateInfo?.name || "Unknown";
          return (
            <Badge
              variant="outline"
              className={cn("font-normal", getStateColor(stateName))}
            >
              {stateName}
            </Badge>
          );
        },
      },
      {
        id: "assetTag",
        header: "AssetTag",
        cell: ({ row }) => {
          const detail = row.original.assetDetail;
          return (
            <span className="text-gray-600 font-mono text-xs">
              {detail?.assetTAG || "-"}
            </span>
          );
        },
      },
    ],
    []
  );

  return (
    <MainLayout
      breadcrumb={{ title: "Altas", subtitle: "Registro de activos TI" }}
    >
      {() => (
        <div className="flex flex-1 flex-col gap-4 p-4 pt-4">
          {/* Panel de Gestión con Mini Menú de Categorías */}
          <AssetManagementPanel
            totalAssets={assets.length}
            productTypes={productTypes}
            selectedCategory={selectedCategory}
            onRefresh={handleRefresh}
            onCreateAsset={handleCreateAsset}
            onSearch={handleSearch}
            onFilterByCategory={handleFilterByCategory}
          />

          {/* Tabla de Activos */}
          <div className="-mx-4 flex-1 overflow-auto px-4 py-1 lg:flex-row lg:space-x-12 lg:space-y-0">
            <DataTable columns={columns} data={filteredAssets} loading={isLoading} />
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
