import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Asset, ProductType, Vendor, AssetState, Company, Site } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import { ProductGroup } from "./CreateProductTypeModal";
import { Pencil, ChevronDown, ChevronUp } from "lucide-react";

interface EditAssetModalProps {
  asset: Asset;
  productTypes: ProductType[];
  vendors: Vendor[];
  assetStates: AssetState[];
  companies: Company[];
  sites: Site[];
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const EditAssetModal = ({
  asset,
  productTypes,
  vendors,
  assetStates,
  companies,
  sites,
  isOpen,
  onClose,
  onSuccess,
}: EditAssetModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();

  const [formData, setFormData] = useState({
    name: "",
    vendorID: 0,
    productTypeID: 0,
    assetState: 0,
    companyID: 0,
    siteID: 0,
    serialNum: "",
    assetTAG: "",
    model: "",
    productManuf: "",
    ipAddress: "",
    macAddress: "",
    domain: "",
    processor: "",
    processorInfo: "",
    ram: "",
    physicalMemory: "",
    hddModel: "",
    hddCapacity: "",
    operatingSystem: "",
    hddSerial: "",
    imei: "",
    platform: "",
    osName: "",
    osVersion: "",
    purchaseDate: "",
    warrantyExpiryDate: "",
  });

  const [filteredSites, setFilteredSites] = useState<Site[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isLoadingAsset, setIsLoadingAsset] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [showTechnical, setShowTechnical] = useState(true);
  const [showDates, setShowDates] = useState(false);

  // Cargar datos completos del activo al abrir el modal
  useEffect(() => {
    if (isOpen && asset) {
      loadAssetDetails();
    }
  }, [isOpen, asset]);

  const loadAssetDetails = async () => {
    try {
      setIsLoadingAsset(true);
      const fullAsset = await api.asset.getById(asset.assetID);
      const data = fullAsset.data || fullAsset;

      const detail = data.assetDetail || {};
      setFormData({
        name: data.name || "",
        vendorID: data.vendorID || 0,
        productTypeID: data.productTypeID || 0,
        assetState: data.assetState || 0,
        companyID: data.companyID || 0,
        siteID: data.siteID || 0,
        serialNum: detail.serialNum || "",
        assetTAG: detail.assetTAG || "",
        model: detail.model || "",
        productManuf: detail.productManuf || "",
        ipAddress: detail.ipAddress || "",
        macAddress: detail.macAddress || "",
        domain: detail.domain || "",
        processor: detail.processor || "",
        processorInfo: detail.processorInfo || "",
        ram: detail.ram || "",
        physicalMemory: detail.physicalMemory || "",
        hddModel: detail.hddModel || "",
        hddCapacity: detail.hddCapacity || "",
        operatingSystem: detail.operatingSystem || "",
        hddSerial: detail.hddSerial || "",
        imei: detail.imei || "",
        platform: detail.platform || "",
        osName: detail.osName || "",
        osVersion: detail.osVersion || "",
        purchaseDate: detail.purchaseDate ? detail.purchaseDate.split("T")[0] : "",
        warrantyExpiryDate: detail.warrantyExpiryDate ? detail.warrantyExpiryDate.split("T")[0] : "",
      });

      if (detail.purchaseDate || detail.warrantyExpiryDate) {
        setShowDates(true);
      }
    } catch (error) {
      console.error("Error al cargar detalles del activo:", error);
      showError("Error al cargar los datos del activo");
    } finally {
      setIsLoadingAsset(false);
    }
  };

  const selectedProductType = productTypes.find(pt => pt.productTypeID === formData.productTypeID);
  const productTypeGroup = selectedProductType?.group as ProductGroup | undefined;

  // Filtrar sitios cuando cambia la compania
  useEffect(() => {
    if (formData.companyID) {
      const filtered = sites.filter(site => site.companyID === formData.companyID);
      setFilteredSites(filtered);
    } else {
      setFilteredSites(sites);
    }
  }, [formData.companyID, sites]);

  const handleInputChange = (field: string, value: string | number) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: "" }));
    }
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.name.trim()) {
      newErrors.name = "El nombre es requerido";
    }
    if (!formData.productTypeID) {
      newErrors.productTypeID = "El tipo de activo es requerido";
    }
    if (!formData.vendorID) {
      newErrors.vendorID = "El proveedor es requerido";
    }
    if (!formData.companyID) {
      newErrors.companyID = "La empresa es requerida";
    }
    if (!formData.siteID) {
      newErrors.siteID = "El sitio es requerido";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      showWarning("Por favor completa los campos requeridos");
      return;
    }

    try {
      setIsLoading(true);

      const detail: Record<string, string | undefined> = {
        serialNum: formData.serialNum || undefined,
        assetTAG: formData.assetTAG || undefined,
        model: formData.model || undefined,
        productManuf: formData.productManuf || undefined,
        purchaseDate: formData.purchaseDate || undefined,
        warrantyExpiryDate: formData.warrantyExpiryDate || undefined,
      };

      if (productTypeGroup === "Equipo" || productTypeGroup === "Otros") {
        detail.ipAddress = formData.ipAddress || undefined;
        detail.macAddress = formData.macAddress || undefined;
        detail.domain = formData.domain || undefined;
        detail.processor = formData.processor || undefined;
        detail.processorInfo = formData.processorInfo || undefined;
        detail.ram = formData.ram || undefined;
        detail.physicalMemory = formData.physicalMemory || undefined;
        detail.hddModel = formData.hddModel || undefined;
        detail.hddCapacity = formData.hddCapacity || undefined;
        detail.operatingSystem = formData.operatingSystem || undefined;
      }

      if (productTypeGroup === "Componente" || productTypeGroup === "Otros") {
        if (!detail.physicalMemory) detail.physicalMemory = formData.physicalMemory || undefined;
        if (!detail.hddModel) detail.hddModel = formData.hddModel || undefined;
        detail.hddSerial = formData.hddSerial || undefined;
      }

      if (productTypeGroup === "Otros") {
        detail.imei = formData.imei || undefined;
        detail.platform = formData.platform || undefined;
        detail.osName = formData.osName || undefined;
        detail.osVersion = formData.osVersion || undefined;
      }

      const assetData = {
        name: formData.name,
        vendorID: formData.vendorID,
        productTypeID: formData.productTypeID,
        assetState: formData.assetState,
        companyID: formData.companyID,
        siteID: formData.siteID,
        detail,
      };

      await api.asset.update(asset.assetID, assetData);

      showSuccess("Activo actualizado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al actualizar activo:", error);

      if (error && typeof error === "object" && "response" in error) {
        const axiosError = error as { response: { status: number; data: { message?: string } } };
        const status = axiosError.response.status;
        const message = axiosError.response.data?.message || "Error desconocido";

        if (status === 409) {
          showWarning("Conflicto al actualizar el activo");
        } else if (status === 400) {
          showError(`Error de validacion: ${message}`);
        } else if (status === 404) {
          showError("El activo no fue encontrado");
        } else {
          showError(`Error: ${message}`);
        }
      } else {
        showError("Error inesperado. Por favor, intenta mas tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleClose = () => {
    if (!isLoading) {
      setErrors({});
      onClose();
    }
  };

  const renderTechnicalFields = () => {
    if (!productTypeGroup) {
      return (
        <p className="text-sm text-gray-500 italic">
          Selecciona un tipo de activo para ver los campos disponibles
        </p>
      );
    }

    return (
      <div className="space-y-5">
        {/* 1. Identificacion */}
        <div>
          <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
            Identificacion
          </h4>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <Label htmlFor="productManuf" className="text-sm font-medium">Fabricante</Label>
              <Input id="productManuf" value={formData.productManuf} onChange={(e) => handleInputChange("productManuf", e.target.value)} placeholder="Ej: Dell, HP, Lenovo" disabled={isLoading} />
            </div>
            <div>
              <Label htmlFor="model" className="text-sm font-medium">Modelo</Label>
              <Input id="model" value={formData.model} onChange={(e) => handleInputChange("model", e.target.value)} placeholder="Ej: Dell Latitude 5520" disabled={isLoading} />
            </div>
            <div>
              <Label htmlFor="serialNum" className="text-sm font-medium">Numero de Serie</Label>
              <Input id="serialNum" value={formData.serialNum} onChange={(e) => handleInputChange("serialNum", e.target.value)} placeholder="Ej: SN123456789" disabled={isLoading} />
            </div>
            <div>
              <Label htmlFor="assetTAG" className="text-sm font-medium">Asset TAG</Label>
              <Input id="assetTAG" value={formData.assetTAG} onChange={(e) => handleInputChange("assetTAG", e.target.value)} placeholder="Ej: TAG-001" disabled={isLoading} />
            </div>
          </div>
        </div>

        {(productTypeGroup === "Equipo" || productTypeGroup === "Otros") && (
          <>
            {/* 2. Red y Acceso */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Red y Acceso
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="ipAddress" className="text-sm font-medium">Direccion IP</Label>
                  <Input id="ipAddress" value={formData.ipAddress} onChange={(e) => handleInputChange("ipAddress", e.target.value)} placeholder="Ej: 192.168.1.100" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="macAddress" className="text-sm font-medium">Direccion MAC</Label>
                  <Input id="macAddress" value={formData.macAddress} onChange={(e) => handleInputChange("macAddress", e.target.value)} placeholder="Ej: AA:BB:CC:DD:EE:FF" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="domain" className="text-sm font-medium">Dominio</Label>
                  <Input id="domain" value={formData.domain} onChange={(e) => handleInputChange("domain", e.target.value)} placeholder="Ej: empresa.local" disabled={isLoading} />
                </div>
              </div>
            </div>

            {/* 3. Procesamiento */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Procesamiento
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="processor" className="text-sm font-medium">Procesador</Label>
                  <Input id="processor" value={formData.processor} onChange={(e) => handleInputChange("processor", e.target.value)} placeholder="Ej: Intel Core i7-1185G7" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="processorInfo" className="text-sm font-medium">Velocidad del Procesador</Label>
                  <Input id="processorInfo" value={formData.processorInfo} onChange={(e) => handleInputChange("processorInfo", e.target.value)} placeholder="Ej: 3.5 GHz" disabled={isLoading} />
                </div>
              </div>
            </div>

            {/* 4. Memoria */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Memoria
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="ram" className="text-sm font-medium">Memoria RAM</Label>
                  <Input id="ram" value={formData.ram} onChange={(e) => handleInputChange("ram", e.target.value)} placeholder="Ej: 16 GB" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="physicalMemory" className="text-sm font-medium">Tipo de Memoria</Label>
                  <Select
                    value={formData.physicalMemory || "none"}
                    onValueChange={(value) => handleInputChange("physicalMemory", value === "none" ? "" : value)}
                    disabled={isLoading}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar tipo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar tipo</SelectItem>
                      <SelectItem value="DDR3">DDR3</SelectItem>
                      <SelectItem value="DDR4">DDR4</SelectItem>
                      <SelectItem value="DDR5">DDR5</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>

            {/* 5. Almacenamiento */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Almacenamiento
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="hddCapacity" className="text-sm font-medium">Capacidad de Disco</Label>
                  <Input id="hddCapacity" value={formData.hddCapacity} onChange={(e) => handleInputChange("hddCapacity", e.target.value)} placeholder="Ej: 512 GB" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="hddModel" className="text-sm font-medium">Tipo de Disco</Label>
                  <Select
                    value={formData.hddModel || "none"}
                    onValueChange={(value) => handleInputChange("hddModel", value === "none" ? "" : value)}
                    disabled={isLoading}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar tipo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar tipo</SelectItem>
                      <SelectItem value="HDD">HDD</SelectItem>
                      <SelectItem value="SSD">SSD</SelectItem>
                      <SelectItem value="NVME">NVME</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>

            {/* 6. Software */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Software
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="operatingSystem" className="text-sm font-medium">Sistema Operativo</Label>
                  <Select
                    value={formData.operatingSystem || "none"}
                    onValueChange={(value) => handleInputChange("operatingSystem", value === "none" ? "" : value)}
                    disabled={isLoading} 
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar tipo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar tipo</SelectItem>
                      <SelectItem value="Windows 7">Windows 7</SelectItem>
                      <SelectItem value="Windows 8">Windows 8</SelectItem>
                      <SelectItem value="Windows 10">Windows 10</SelectItem>
                      <SelectItem value="Windows 11">Windows 11</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>
          </>
        )}

        {(productTypeGroup === "Componente" || productTypeGroup === "Otros") && (
          <>
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Componentes
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="ram" className="text-sm font-medium">Memoria RAM</Label>
                  <Input id="ram" value={formData.ram} onChange={(e) => handleInputChange("ram", e.target.value)} placeholder="Ej: 16 GB" disabled={isLoading} />
                </div>
                
                <div>
                  <Label htmlFor="physicalMemory" className="text-sm font-medium">Tipo de Memoria</Label>
                  <Select
                    value={formData.physicalMemory || "none"}
                    onValueChange={(value) => handleInputChange("physicalMemory", value === "none" ? "" : value)}
                    disabled={isLoading}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar tipo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar tipo</SelectItem>
                      <SelectItem value="DDR3">DDR3</SelectItem>
                      <SelectItem value="DDR4">DDR4</SelectItem>
                      <SelectItem value="DDR5">DDR5</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <Label htmlFor="hddCapacity" className="text-sm font-medium">Capacidad de Disco</Label>
                  <Input id="hddCapacity" value={formData.hddCapacity} onChange={(e) => handleInputChange("hddCapacity", e.target.value)} placeholder="Ej: 512 GB" disabled={isLoading} />
                </div>

                <div>
                  <Label htmlFor="hddModel" className="text-sm font-medium">Tipo de Disco</Label>
                  <Select
                    value={formData.hddModel || "none"}
                    onValueChange={(value) => handleInputChange("hddModel", value === "none" ? "" : value)}
                    disabled={isLoading}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar tipo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar tipo</SelectItem>
                      <SelectItem value="HDD">HDD</SelectItem>
                      <SelectItem value="SSD">SSD</SelectItem>
                      <SelectItem value="NVME">NVME</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="hddSerial" className="text-sm font-medium">Serial HDD/SSD</Label>
                  <Input id="hddSerial" value={formData.hddSerial} onChange={(e) => handleInputChange("hddSerial", e.target.value)} placeholder="Ej: S4EVNX0N123456" disabled={isLoading} />
                </div>
              </div>
            </div>
          </>
        )}

        {productTypeGroup === "Otros" && (
          <>
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Informacion Movil
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="imei" className="text-sm font-medium">IMEI</Label>
                  <Input id="imei" value={formData.imei} onChange={(e) => handleInputChange("imei", e.target.value)} placeholder="Ej: 353456789012345" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="platform" className="text-sm font-medium">Plataforma</Label>
                  <Input id="platform" value={formData.platform} onChange={(e) => handleInputChange("platform", e.target.value)} placeholder="Ej: Android, iOS" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="osName" className="text-sm font-medium">Nombre SO</Label>
                  <Input id="osName" value={formData.osName} onChange={(e) => handleInputChange("osName", e.target.value)} placeholder="Ej: Android" disabled={isLoading} />
                </div>
                <div>
                  <Label htmlFor="osVersion" className="text-sm font-medium">Version SO</Label>
                  <Input id="osVersion" value={formData.osVersion} onChange={(e) => handleInputChange("osVersion", e.target.value)} placeholder="Ej: 13.0" disabled={isLoading} />
                </div>
              </div>
            </div>
          </>
        )}
      </div>
    );
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-3xl max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b">
          <div className="flex items-center gap-2">
            <Pencil className="h-5 w-5 text-amber-600" />
            <h2 className="text-lg font-semibold">Editar Activo</h2>
            <span className="text-sm text-gray-500">#{asset.assetID}</span>
          </div>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleClose}
            disabled={isLoading}
            className="h-8 w-8"
          >
            X
          </Button>
        </div>

        {isLoadingAsset ? (
          <div className="flex items-center justify-center h-64">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
          </div>
        ) : (
          <>
            {/* Formulario */}
            <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-4">
              {/* Informacion Basica */}
              <div className="mb-6">
                <h3 className="text-sm font-semibold text-gray-700 mb-4 pb-2 border-b">
                  Informacion Basica
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <Label htmlFor="name" className="text-sm font-medium">Nombre del Activo *</Label>
                    <Input
                      id="name"
                      value={formData.name}
                      onChange={(e) => handleInputChange("name", e.target.value)}
                      className={errors.name ? "border-red-500" : ""}
                      placeholder="Ej: PC-001, Laptop-HR-01"
                      disabled={isLoading}
                    />
                    {errors.name && <p className="text-red-500 text-xs mt-1">{errors.name}</p>}
                  </div>

                  <div>
                    <Label htmlFor="productTypeID" className="text-sm font-medium">Tipo de Activo *</Label>
                    <Select
                      value={formData.productTypeID ? formData.productTypeID.toString() : "none"}
                      onValueChange={(value) => handleInputChange("productTypeID", value === "none" ? 0 : Number(value))}
                      disabled={isLoading}
                    >
                      <SelectTrigger className={errors.productTypeID ? "border-red-500" : ""}>
                        <SelectValue placeholder="Seleccionar tipo" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="none">Seleccionar tipo</SelectItem>
                        {productTypes.map((pt) => (
                          <SelectItem key={pt.productTypeID} value={pt.productTypeID.toString()}>
                            {pt.name} ({pt.group} - {pt.category})
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    {errors.productTypeID && <p className="text-red-500 text-xs mt-1">{errors.productTypeID}</p>}
                  </div>

                  <div>
                    <Label htmlFor="vendorID" className="text-sm font-medium">Proveedor *</Label>
                    <Select
                      value={formData.vendorID ? formData.vendorID.toString() : "none"}
                      onValueChange={(value) => handleInputChange("vendorID", value === "none" ? 0 : Number(value))}
                      disabled={isLoading}
                    >
                      <SelectTrigger className={errors.vendorID ? "border-red-500" : ""}>
                        <SelectValue placeholder="Seleccionar proveedor" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="none">Seleccionar proveedor</SelectItem>
                        {vendors.map((vendor) => (
                          <SelectItem key={vendor.vendorID} value={vendor.vendorID.toString()}>
                            {vendor.name}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    {errors.vendorID && <p className="text-red-500 text-xs mt-1">{errors.vendorID}</p>}
                  </div>

                  <div>
                    <Label htmlFor="assetState" className="text-sm font-medium">Estado</Label>
                    <div className="flex items-center h-10 px-3 rounded-md border bg-gray-100 text-sm text-gray-600">
                      {assetStates.find(s => s.assetStateID === formData.assetState)?.name || "Sin estado"}
                    </div>
                    <p className="text-xs text-gray-400 mt-1">Se modifica mediante movimientos</p>
                  </div>
                </div>
              </div>

              {/* Detalles Tecnicos */}
              <div className="mb-6">
                <button
                  type="button"
                  onClick={() => setShowTechnical(!showTechnical)}
                  className="flex items-center justify-between w-full text-sm font-semibold text-gray-700 mb-4 pb-2 border-b hover:text-blue-600"
                >
                  <span>
                    Detalles Tecnicos
                    {productTypeGroup && (
                      <span className="ml-2 text-xs font-normal text-blue-600">
                        (Plantilla: {productTypeGroup})
                      </span>
                    )}
                  </span>
                  {showTechnical ? <ChevronUp className="h-4 w-4" /> : <ChevronDown className="h-4 w-4" />}
                </button>
                {showTechnical && renderTechnicalFields()}
              </div>

              {/* Fechas */}
              <div className="mb-6">
                <button
                  type="button"
                  onClick={() => setShowDates(!showDates)}
                  className="flex items-center justify-between w-full text-sm font-semibold text-gray-700 mb-4 pb-2 border-b hover:text-blue-600"
                >
                  <span>Fechas (Opcional)</span>
                  {showDates ? <ChevronUp className="h-4 w-4" /> : <ChevronDown className="h-4 w-4" />}
                </button>
                {showDates && (
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="purchaseDate" className="text-sm font-medium">Fecha de Compra</Label>
                      <Input id="purchaseDate" type="date" value={formData.purchaseDate} onChange={(e) => handleInputChange("purchaseDate", e.target.value)} disabled={isLoading} />
                    </div>
                    <div>
                      <Label htmlFor="warrantyExpiryDate" className="text-sm font-medium">Vencimiento de Garantia</Label>
                      <Input id="warrantyExpiryDate" type="date" value={formData.warrantyExpiryDate} onChange={(e) => handleInputChange("warrantyExpiryDate", e.target.value)} disabled={isLoading} />
                    </div>
                  </div>
                )}
              </div>
            </form>

            {/* Footer */}
            <div className="flex gap-2 p-4 border-t bg-gray-50">
              <Button
                type="button"
                variant="outline"
                onClick={handleClose}
                disabled={isLoading}
                className="flex-1"
              >
                Cancelar
              </Button>
              <Button
                type="submit"
                onClick={handleSubmit}
                disabled={isLoading}
                className="flex-1 bg-amber-600 hover:bg-amber-700"
              >
                {isLoading ? "Guardando..." : "Guardar Cambios"}
              </Button>
            </div>
          </>
        )}
      </div>
    </div>
  );
};
