import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { ProductType, Vendor, AssetState, Company, Site } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import { CreateProductTypeModal, ProductCategory } from "./CreateProductTypeModal";
import {
  Package,
  ChevronDown,
  ChevronUp,
  Plus,
} from "lucide-react";

interface CreateAssetModalProps {
  productTypes: ProductType[];
  vendors: Vendor[];
  assetStates: AssetState[];
  companies: Company[];
  sites: Site[];
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  onProductTypeCreated?: (newProductType: ProductType) => void;
}

export const CreateAssetModal = ({
  productTypes,
  vendors,
  assetStates,
  companies,
  sites,
  isOpen,
  onClose,
  onSuccess,
  onProductTypeCreated,
}: CreateAssetModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();

  // Estado del formulario
  const [formData, setFormData] = useState({
    // Datos basicos
    name: "",
    vendorID: 0,
    productTypeID: 0,
    assetState: 0,
    companyID: 0,
    siteID: 0,
    // Detalles tecnicos basicos
    serialNum: "",
    assetTAG: "",
    model: "",
    productManuf: "",
    // Detalles de red (Equipo)
    ipAddress: "",
    macAddress: "",
    domain: "",
    // Detalles de hardware (Equipo)
    processor: "",
    processorInfo: "",
    ram: "",
    physicalMemory: "",
    hddModel: "",
    hddCapacity: "",
    operatingSystem: "",
    // Detalles adicionales (Componente)
    hddSerial: "",
    // Detalles moviles (Otros)
    imei: "",
    platform: "",
    osName: "",
    osVersion: "",
    // Fechas
    purchaseDate: "",
    warrantyExpiryDate: "",
  });

  const [filteredSites, setFilteredSites] = useState<Site[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [showTechnical, setShowTechnical] = useState(true);
  const [showDates, setShowDates] = useState(false);
  const [isProductTypeModalOpen, setIsProductTypeModalOpen] = useState(false);
  const [localProductTypes, setLocalProductTypes] = useState<ProductType[]>(productTypes);

  // Actualizar tipos de producto locales cuando cambien los props
  useEffect(() => {
    setLocalProductTypes(productTypes);
  }, [productTypes]);

  // Obtener la categoria del tipo de producto seleccionado
  const selectedProductType = localProductTypes.find(pt => pt.productTypeID === formData.productTypeID);
  const productTypeCategory = selectedProductType?.category as ProductCategory | undefined;

  // Filtrar sitios cuando cambia la compania
  useEffect(() => {
    if (formData.companyID) {
      const filtered = sites.filter(site => site.companyID === formData.companyID);
      setFilteredSites(filtered);
      if (!filtered.find(s => s.siteID === formData.siteID)) {
        setFormData(prev => ({ ...prev, siteID: 0 }));
      }
    } else {
      setFilteredSites(sites);
    }
  }, [formData.companyID, sites, formData.siteID]);

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

    if (!formData.assetState) {
      newErrors.assetState = "El estado es requerido";
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

      // Construir objeto de detalles segun la categoria
      const detail: Record<string, string | undefined> = {
        serialNum: formData.serialNum || undefined,
        assetTAG: formData.assetTAG || undefined,
        model: formData.model || undefined,
        productManuf: formData.productManuf || undefined,
        purchaseDate: formData.purchaseDate || undefined,
        warrantyExpiryDate: formData.warrantyExpiryDate || undefined,
      };

      // Agregar campos segun la categoria
      if (productTypeCategory === "Equipo" || productTypeCategory === "Otros") {
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

      if (productTypeCategory === "Componente" || productTypeCategory === "Otros") {
        if (!detail.physicalMemory) detail.physicalMemory = formData.physicalMemory || undefined;
        if (!detail.hddModel) detail.hddModel = formData.hddModel || undefined;
        detail.hddSerial = formData.hddSerial || undefined;
      }

      if (productTypeCategory === "Otros") {
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

      await api.asset.create(assetData);

      resetForm();
      showSuccess("Activo registrado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al crear activo:", error);

      if (error && typeof error === "object" && "response" in error) {
        const axiosError = error as { response: { status: number; data: { message?: string } } };
        const status = axiosError.response.status;
        const message = axiosError.response.data?.message || "Error desconocido";

        if (status === 409) {
          showWarning("Ya existe un activo con estos datos");
        } else if (status === 400) {
          showError(`Error de validacion: ${message}`);
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

  const resetForm = () => {
    setFormData({
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
    setErrors({});
    setShowTechnical(true);
    setShowDates(false);
  };

  const handleClose = () => {
    if (!isLoading) {
      resetForm();
      onClose();
    }
  };

  const handleProductTypeCreated = (newProductType: ProductType) => {
    setLocalProductTypes(prev => [...prev, newProductType]);
    setFormData(prev => ({ ...prev, productTypeID: newProductType.productTypeID }));
    if (onProductTypeCreated) {
      onProductTypeCreated(newProductType);
    }
  };

  // Renderizar campos de detalles tecnicos segun la categoria
  const renderTechnicalFields = () => {
    if (!productTypeCategory) {
      return (
        <p className="text-sm text-gray-500 italic">
          Selecciona un tipo de activo para ver los campos disponibles
        </p>
      );
    }

    return (
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Campos basicos - siempre visibles */}
        <div>
          <Label htmlFor="serialNum" className="text-sm font-medium">
            Numero de Serie
          </Label>
          <Input
            id="serialNum"
            value={formData.serialNum}
            onChange={(e) => handleInputChange("serialNum", e.target.value)}
            placeholder="Ej: SN123456789"
            disabled={isLoading}
          />
        </div>

        <div>
          <Label htmlFor="assetTAG" className="text-sm font-medium">
            Asset TAG
          </Label>
          <Input
            id="assetTAG"
            value={formData.assetTAG}
            onChange={(e) => handleInputChange("assetTAG", e.target.value)}
            placeholder="Ej: TAG-001"
            disabled={isLoading}
          />
        </div>

        <div>
          <Label htmlFor="model" className="text-sm font-medium">
            Modelo
          </Label>
          <Input
            id="model"
            value={formData.model}
            onChange={(e) => handleInputChange("model", e.target.value)}
            placeholder="Ej: Dell Latitude 5520"
            disabled={isLoading}
          />
        </div>

        <div>
          <Label htmlFor="productManuf" className="text-sm font-medium">
            Fabricante
          </Label>
          <Input
            id="productManuf"
            value={formData.productManuf}
            onChange={(e) => handleInputChange("productManuf", e.target.value)}
            placeholder="Ej: Dell, HP, Lenovo"
            disabled={isLoading}
          />
        </div>

        {/* Campos de Equipo y Otros */}
        {(productTypeCategory === "Equipo" || productTypeCategory === "Otros") && (
          <>
            <div>
              <Label htmlFor="ipAddress" className="text-sm font-medium">
                Direccion IP
              </Label>
              <Input
                id="ipAddress"
                value={formData.ipAddress}
                onChange={(e) => handleInputChange("ipAddress", e.target.value)}
                placeholder="Ej: 192.168.1.100"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="macAddress" className="text-sm font-medium">
                Direccion MAC
              </Label>
              <Input
                id="macAddress"
                value={formData.macAddress}
                onChange={(e) => handleInputChange("macAddress", e.target.value)}
                placeholder="Ej: AA:BB:CC:DD:EE:FF"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="domain" className="text-sm font-medium">
                Dominio
              </Label>
              <Input
                id="domain"
                value={formData.domain}
                onChange={(e) => handleInputChange("domain", e.target.value)}
                placeholder="Ej: empresa.local"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="processor" className="text-sm font-medium">
                Procesador
              </Label>
              <Input
                id="processor"
                value={formData.processor}
                onChange={(e) => handleInputChange("processor", e.target.value)}
                placeholder="Ej: Intel Core i7-1185G7"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="processorInfo" className="text-sm font-medium">
                Velocidad del Procesador
              </Label>
              <Input
                id="processorInfo"
                value={formData.processorInfo}
                onChange={(e) => handleInputChange("processorInfo", e.target.value)}
                placeholder="Ej: 3.5 GHz"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="ram" className="text-sm font-medium">
                Memoria RAM
              </Label>
              <Input
                id="ram"
                value={formData.ram}
                onChange={(e) => handleInputChange("ram", e.target.value)}
                placeholder="Ej: 16 GB"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="physicalMemory" className="text-sm font-medium">
                Tipo de Memoria
              </Label>
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
              <Label htmlFor="hddModel" className="text-sm font-medium">
                Tipo de Disco
              </Label>
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
              <Label htmlFor="hddCapacity" className="text-sm font-medium">
                Capacidad de Disco
              </Label>
              <Input
                id="hddCapacity"
                value={formData.hddCapacity}
                onChange={(e) => handleInputChange("hddCapacity", e.target.value)}
                placeholder="Ej: 512 GB"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="operatingSystem" className="text-sm font-medium">
                Sistema Operativo
              </Label>
              <Input
                id="operatingSystem"
                value={formData.operatingSystem}
                onChange={(e) => handleInputChange("operatingSystem", e.target.value)}
                placeholder="Ej: Windows 11 Pro"
                disabled={isLoading}
              />
            </div>
          </>
        )}

        {/* Campos de Componente y Otros */}
        {(productTypeCategory === "Componente" || productTypeCategory === "Otros") && (
          <>
            <div>
              <Label htmlFor="physicalMemory" className="text-sm font-medium">
                Tipo de Memoria
              </Label>
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
              <Label htmlFor="hddModel" className="text-sm font-medium">
                Tipo de Disco
              </Label>
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
              <Label htmlFor="hddSerial" className="text-sm font-medium">
                Serial HDD/SSD
              </Label>
              <Input
                id="hddSerial"
                value={formData.hddSerial}
                onChange={(e) => handleInputChange("hddSerial", e.target.value)}
                placeholder="Ej: S4EVNX0N123456"
                disabled={isLoading}
              />
            </div>
          </>
        )}

        {/* Campos adicionales solo para Otros */}
        {productTypeCategory === "Otros" && (
          <>
            <div>
              <Label htmlFor="imei" className="text-sm font-medium">
                IMEI
              </Label>
              <Input
                id="imei"
                value={formData.imei}
                onChange={(e) => handleInputChange("imei", e.target.value)}
                placeholder="Ej: 353456789012345"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="platform" className="text-sm font-medium">
                Plataforma
              </Label>
              <Input
                id="platform"
                value={formData.platform}
                onChange={(e) => handleInputChange("platform", e.target.value)}
                placeholder="Ej: Android, iOS"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="osName" className="text-sm font-medium">
                Nombre SO
              </Label>
              <Input
                id="osName"
                value={formData.osName}
                onChange={(e) => handleInputChange("osName", e.target.value)}
                placeholder="Ej: Android"
                disabled={isLoading}
              />
            </div>

            <div>
              <Label htmlFor="osVersion" className="text-sm font-medium">
                Version SO
              </Label>
              <Input
                id="osVersion"
                value={formData.osVersion}
                onChange={(e) => handleInputChange("osVersion", e.target.value)}
                placeholder="Ej: 13.0"
                disabled={isLoading}
              />
            </div>
          </>
        )}
      </div>
    );
  };

  if (!isOpen) return null;

  return (
    <>
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
        <div className="bg-white rounded-lg w-full max-w-3xl max-h-[90vh] overflow-hidden flex flex-col">
          {/* Header */}
          <div className="flex items-center justify-between p-4 border-b">
            <div className="flex items-center gap-2">
              <Package className="h-5 w-5 text-blue-600" />
              <h2 className="text-lg font-semibold">Registrar Nuevo Activo</h2>
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

          {/* Formulario */}
          <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-4">
            {/* Informacion Basica */}
            <div className="mb-6">
              <h3 className="text-sm font-semibold text-gray-700 mb-4 pb-2 border-b">
                Informacion Basica
              </h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {/* Nombre del Activo */}
                <div>
                  <Label htmlFor="name" className="text-sm font-medium">
                    Nombre del Activo *
                  </Label>
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

                {/* Tipo de Producto con boton para crear nuevo */}
                <div>
                  <div className="flex items-center justify-between">
                    <Label htmlFor="productTypeID" className="text-sm font-medium">
                      Tipo de Activo *
                    </Label>
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      onClick={() => setIsProductTypeModalOpen(true)}
                      className="h-6 text-xs text-blue-600 hover:text-blue-700"
                    >
                      <Plus className="h-3 w-3 mr-1" />
                      Crear Tipo de Activo
                    </Button>
                  </div>
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
                      {localProductTypes.map((pt) => (
                        <SelectItem key={pt.productTypeID} value={pt.productTypeID.toString()}>
                          {pt.name} ({pt.category} - {pt.subCategory})
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.productTypeID && <p className="text-red-500 text-xs mt-1">{errors.productTypeID}</p>}
                  {localProductTypes.length === 0 && (
                    <p className="text-amber-600 text-xs mt-1">
                      No hay tipos de activo disponibles. Crea uno nuevo.
                    </p>
                  )}
                </div>

                {/* Proveedor */}
                <div>
                  <Label htmlFor="vendorID" className="text-sm font-medium">
                    Proveedor *
                  </Label>
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

                {/* Estado */}
                <div>
                  <Label htmlFor="assetState" className="text-sm font-medium">
                    Estado *
                  </Label>
                  <Select
                    value={formData.assetState ? formData.assetState.toString() : "none"}
                    onValueChange={(value) => handleInputChange("assetState", value === "none" ? 0 : Number(value))}
                    disabled={isLoading}
                  >
                    <SelectTrigger className={errors.assetState ? "border-red-500" : ""}>
                      <SelectValue placeholder="Seleccionar estado" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar estado</SelectItem>
                      {assetStates.map((state) => (
                        <SelectItem key={state.assetStateID} value={state.assetStateID.toString()}>
                          {state.name}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.assetState && <p className="text-red-500 text-xs mt-1">{errors.assetState}</p>}
                </div>

                {/* Empresa */}
                <div>
                  <Label htmlFor="companyID" className="text-sm font-medium">
                    Empresa *
                  </Label>
                  <Select
                    value={formData.companyID ? formData.companyID.toString() : "none"}
                    onValueChange={(value) => handleInputChange("companyID", value === "none" ? 0 : Number(value))}
                    disabled={isLoading}
                  >
                    <SelectTrigger className={errors.companyID ? "border-red-500" : ""}>
                      <SelectValue placeholder="Seleccionar empresa" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar empresa</SelectItem>
                      {companies.map((company) => (
                        <SelectItem key={company.companyID} value={company.companyID.toString()}>
                          {company.description}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.companyID && <p className="text-red-500 text-xs mt-1">{errors.companyID}</p>}
                </div>

                {/* Sitio */}
                <div>
                  <Label htmlFor="siteID" className="text-sm font-medium">
                    Site *
                  </Label>
                  <Select
                    value={formData.siteID ? formData.siteID.toString() : "none"}
                    onValueChange={(value) => handleInputChange("siteID", value === "none" ? 0 : Number(value))}
                    disabled={isLoading || !formData.companyID}
                  >
                    <SelectTrigger className={errors.siteID ? "border-red-500" : ""}>
                      <SelectValue placeholder={formData.companyID ? "Seleccionar sitio" : "Primero selecciona empresa"} />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar sitio</SelectItem>
                      {filteredSites.map((site) => (
                        <SelectItem key={site.siteID} value={site.siteID.toString()}>
                          {site.name}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.siteID && <p className="text-red-500 text-xs mt-1">{errors.siteID}</p>}
                </div>
              </div>
            </div>

            {/* Detalles Tecnicos (Colapsable) */}
            <div className="mb-6">
              <button
                type="button"
                onClick={() => setShowTechnical(!showTechnical)}
                className="flex items-center justify-between w-full text-sm font-semibold text-gray-700 mb-4 pb-2 border-b hover:text-blue-600"
              >
                <span>
                  Detalles Tecnicos
                  {productTypeCategory && (
                    <span className="ml-2 text-xs font-normal text-blue-600">
                      (Plantilla: {productTypeCategory})
                    </span>
                  )}
                </span>
                {showTechnical ? <ChevronUp className="h-4 w-4" /> : <ChevronDown className="h-4 w-4" />}
              </button>

              {showTechnical && renderTechnicalFields()}
            </div>

            {/* Fechas (Colapsable) */}
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
                    <Label htmlFor="purchaseDate" className="text-sm font-medium">
                      Fecha de Compra
                    </Label>
                    <Input
                      id="purchaseDate"
                      type="date"
                      value={formData.purchaseDate}
                      onChange={(e) => handleInputChange("purchaseDate", e.target.value)}
                      disabled={isLoading}
                    />
                  </div>

                  <div>
                    <Label htmlFor="warrantyExpiryDate" className="text-sm font-medium">
                      Vencimiento de Garantia
                    </Label>
                    <Input
                      id="warrantyExpiryDate"
                      type="date"
                      value={formData.warrantyExpiryDate}
                      onChange={(e) => handleInputChange("warrantyExpiryDate", e.target.value)}
                      disabled={isLoading}
                    />
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
              className="flex-1 bg-blue-600 hover:bg-blue-700"
            >
              {isLoading ? "Registrando..." : "Registrar Activo"}
            </Button>
          </div>
        </div>
      </div>

      {/* Modal para crear tipo de producto */}
      <CreateProductTypeModal
        isOpen={isProductTypeModalOpen}
        onClose={() => setIsProductTypeModalOpen(false)}
        onSuccess={handleProductTypeCreated}
      />
    </>
  );
};
