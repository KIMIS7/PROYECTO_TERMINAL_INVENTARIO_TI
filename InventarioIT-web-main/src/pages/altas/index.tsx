import { MainLayout } from "@/components/MainLayout";
import { useEffect, useState } from "react";
import { ProductType, Vendor, AssetState, Company, Site, Asset } from "@/types";
import api from "@/lib/api";
import { ColumnDef } from "@tanstack/react-table";
import { Badge } from "@/components/ui/badge";
import { DataTable } from "@/components/data-table";
import { AssetManagementPanel } from "@/components/AssetManagementPanel";
import { CreateAssetModal } from "@/components/CreateAssetModal";

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
        asset.assetDetail?.assetTAG?.toLowerCase().includes(query.toLowerCase())
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

  // Obtener nombre del proveedor
  const getVendorName = (vendorID: number) => {
    const vendor = vendors.find((v) => v.vendorID === vendorID);
    return vendor?.name || "N/A";
  };

  // Obtener nombre del tipo de producto
  const getProductTypeName = (productTypeID: number) => {
    const pt = productTypes.find((p) => p.productTypeID === productTypeID);
    return pt?.name || "N/A";
  };

  // Obtener nombre del estado
  const getAssetStateName = (assetStateID: number) => {
    const state = assetStates.find((s) => s.assetStateID === assetStateID);
    return state?.name || "N/A";
  };

  // Obtener nombre de la compañía
  const getCompanyName = (companyID: number) => {
    const company = companies.find((c) => c.companyID === companyID);
    return company?.description || "N/A";
  };

  // Obtener nombre del sitio
  const getSiteName = (siteID: number) => {
    const site = sites.find((s) => s.siteID === siteID);
    return site?.name || "N/A";
  };

  // Columnas de la tabla
  const columns: ColumnDef<Asset>[] = [
    {
      accessorKey: "name",
      header: "Nombre del Activo",
      cell: ({ getValue }) => {
        const value = getValue();
        return typeof value === "string" ? value.toUpperCase() : "";
      },
    },
    {
      accessorKey: "productTypeID",
      header: "Tipo",
      cell: ({ row }) => getProductTypeName(row.original.productTypeID),
    },
    {
      accessorKey: "vendorID",
      header: "Proveedor",
      cell: ({ row }) => getVendorName(row.original.vendorID),
    },
    {
      accessorKey: "assetState",
      header: "Estado",
      cell: ({ row }) => {
        const stateName = getAssetStateName(row.original.assetState);
        const isActive = stateName.toLowerCase().includes("activo") ||
                        stateName.toLowerCase().includes("disponible") ||
                        stateName.toLowerCase().includes("uso");
        return (
          <Badge variant="outline" className="text-muted-foreground px-1.5">
            <div className="flex items-center gap-1">
              <div
                className={`w-2 h-2 rounded-full mt-[0.16rem] ${
                  isActive
                    ? "bg-green-500 dark:bg-green-400"
                    : "bg-yellow-500 dark:bg-yellow-400"
                }`}
              ></div>
              {stateName}
            </div>
          </Badge>
        );
      },
    },
    {
      accessorKey: "companyID",
      header: "Empresa",
      cell: ({ row }) => getCompanyName(row.original.companyID),
    },
    {
      accessorKey: "siteID",
      header: "Ubicación",
      cell: ({ row }) => getSiteName(row.original.siteID),
    },
    {
      accessorKey: "assetDetail.serialNum",
      header: "No. Serie",
      cell: ({ row }) => row.original.assetDetail?.serialNum || "—",
    },
    {
      accessorKey: "assetDetail.assetTAG",
      header: "TAG",
      cell: ({ row }) => row.original.assetDetail?.assetTAG || "—",
    },
  ];

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
