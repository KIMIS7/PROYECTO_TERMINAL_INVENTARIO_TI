import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { ProductType, Vendor, AssetState, Company, Site } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import {
  Monitor,
  Laptop,
  Server,
  Smartphone,
  Printer,
  HardDrive,
  Wifi,
  Package,
  ChevronDown,
  ChevronUp
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
}

// Iconos por categoría
const categoryIcons: Record<string, React.ReactNode> = {
  "Computadoras": <Monitor className="h-5 w-5" />,
  "Laptops": <Laptop className="h-5 w-5" />,
  "Servidores": <Server className="h-5 w-5" />,
  "Dispositivos Móviles": <Smartphone className="h-5 w-5" />,
  "Impresoras": <Printer className="h-5 w-5" />,
  "Almacenamiento": <HardDrive className="h-5 w-5" />,
  "Red": <Wifi className="h-5 w-5" />,
};

export const CreateAssetModal = ({
  productTypes,
  vendors,
  assetStates,
  companies,
  sites,
  isOpen,
  onClose,
  onSuccess,
}: CreateAssetModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();

  // Estado del formulario
  const [formData, setFormData] = useState({
    // Datos básicos
    name: "",
    vendorID: 0,
    productTypeID: 0,
    assetState: 0,
    companyID: 0,
    siteID: 0,
    // Detalles técnicos
    serialNum: "",
    assetTAG: "",
    model: "",
    productManuf: "",
    // Detalles de red
    ipAddress: "",
    macAddress: "",
    domain: "",
    // Detalles de hardware
    processor: "",
    ram: "",
    hddCapacity: "",
    operatingSystem: "",
    // Fechas
    purchaseDate: "",
    warrantyExpiryDate: "",
  });

  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [filteredSites, setFilteredSites] = useState<Site[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [showTechnical, setShowTechnical] = useState(false);
  const [showDates, setShowDates] = useState(false);

  // Obtener categorías únicas
  const uniqueCategories = Array.from(new Set(productTypes.map(pt => pt.category))).filter(Boolean);

  // Filtrar tipos de productos por categoría seleccionada
  const filteredProductTypes = selectedCategory
    ? productTypes.filter(pt => pt.category === selectedCategory)
    : productTypes;

  // Filtrar sitios cuando cambia la compañía
  useEffect(() => {
    if (formData.companyID) {
      const filtered = sites.filter(site => site.companyID === formData.companyID);
      setFilteredSites(filtered);
      // Reset siteID si no está en los sitios filtrados
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

  const handleCategorySelect = (category: string) => {
    setSelectedCategory(category);
    // Reset productTypeID cuando cambia la categoría
    setFormData(prev => ({ ...prev, productTypeID: 0 }));
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

      const assetData = {
        name: formData.name,
        vendorID: formData.vendorID,
        productTypeID: formData.productTypeID,
        assetState: formData.assetState,
        companyID: formData.companyID,
        siteID: formData.siteID,
        detail: {
          serialNum: formData.serialNum || undefined,
          assetTAG: formData.assetTAG || undefined,
          model: formData.model || undefined,
          productManuf: formData.productManuf || undefined,
          ipAddress: formData.ipAddress || undefined,
          macAddress: formData.macAddress || undefined,
          domain: formData.domain || undefined,
          processor: formData.processor || undefined,
          ram: formData.ram || undefined,
          hddCapacity: formData.hddCapacity || undefined,
          operatingSystem: formData.operatingSystem || undefined,
          purchaseDate: formData.purchaseDate || undefined,
          warrantyExpiryDate: formData.warrantyExpiryDate || undefined,
        },
      };

      await api.asset.create(assetData);

      // Reset form
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
          showError(`Error de validación: ${message}`);
        } else {
          showError(`Error: ${message}`);
        }
      } else {
        showError("Error inesperado. Por favor, intenta más tarde.");
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
      ram: "",
      hddCapacity: "",
      operatingSystem: "",
      purchaseDate: "",
      warrantyExpiryDate: "",
    });
    setSelectedCategory(null);
    setErrors({});
    setShowTechnical(false);
    setShowDates(false);
  };

  const handleClose = () => {
    if (!isLoading) {
      resetForm();
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
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
            ×
          </Button>
        </div>

        {/* Mini Menú de Categorías */}
        <div className="p-4 bg-gray-50 border-b">
          <p className="text-sm text-gray-600 mb-3 font-medium">Selecciona el tipo de activo:</p>
          <div className="flex flex-wrap gap-2">
            {uniqueCategories.map((category) => (
              <Button
                key={category}
                type="button"
                variant={selectedCategory === category ? "default" : "outline"}
                size="sm"
                onClick={() => handleCategorySelect(category)}
                className="flex items-center gap-2"
                disabled={isLoading}
              >
                {categoryIcons[category] || <Package className="h-4 w-4" />}
                {category}
              </Button>
            ))}
          </div>
        </div>

        {/* Formulario */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-4">
          {/* Información Básica */}
          <div className="mb-6">
            <h3 className="text-sm font-semibold text-gray-700 mb-4 pb-2 border-b">
              Información Básica
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

              {/* Tipo de Producto */}
              <div>
                <Label htmlFor="productTypeID" className="text-sm font-medium">
                  Tipo de Activo *
                </Label>
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
                    {filteredProductTypes.map((pt) => (
                      <SelectItem key={pt.productTypeID} value={pt.productTypeID.toString()}>
                        {pt.name} ({pt.group})
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                {errors.productTypeID && <p className="text-red-500 text-xs mt-1">{errors.productTypeID}</p>}
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
                  Sitio/Ubicación *
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

          {/* Detalles Técnicos (Colapsable) */}
          <div className="mb-6">
            <button
              type="button"
              onClick={() => setShowTechnical(!showTechnical)}
              className="flex items-center justify-between w-full text-sm font-semibold text-gray-700 mb-4 pb-2 border-b hover:text-blue-600"
            >
              <span>Detalles Técnicos (Opcional)</span>
              {showTechnical ? <ChevronUp className="h-4 w-4" /> : <ChevronDown className="h-4 w-4" />}
            </button>

            {showTechnical && (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {/* Número de Serie */}
                <div>
                  <Label htmlFor="serialNum" className="text-sm font-medium">
                    Número de Serie
                  </Label>
                  <Input
                    id="serialNum"
                    value={formData.serialNum}
                    onChange={(e) => handleInputChange("serialNum", e.target.value)}
                    placeholder="Ej: SN123456789"
                    disabled={isLoading}
                  />
                </div>

                {/* Asset TAG */}
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

                {/* Modelo */}
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

                {/* Fabricante */}
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

                {/* IP Address */}
                <div>
                  <Label htmlFor="ipAddress" className="text-sm font-medium">
                    Dirección IP
                  </Label>
                  <Input
                    id="ipAddress"
                    value={formData.ipAddress}
                    onChange={(e) => handleInputChange("ipAddress", e.target.value)}
                    placeholder="Ej: 192.168.1.100"
                    disabled={isLoading}
                  />
                </div>

                {/* MAC Address */}
                <div>
                  <Label htmlFor="macAddress" className="text-sm font-medium">
                    Dirección MAC
                  </Label>
                  <Input
                    id="macAddress"
                    value={formData.macAddress}
                    onChange={(e) => handleInputChange("macAddress", e.target.value)}
                    placeholder="Ej: AA:BB:CC:DD:EE:FF"
                    disabled={isLoading}
                  />
                </div>

                {/* Dominio */}
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

                {/* Procesador */}
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

                {/* RAM */}
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

                {/* Capacidad HDD */}
                <div>
                  <Label htmlFor="hddCapacity" className="text-sm font-medium">
                    Capacidad Almacenamiento
                  </Label>
                  <Input
                    id="hddCapacity"
                    value={formData.hddCapacity}
                    onChange={(e) => handleInputChange("hddCapacity", e.target.value)}
                    placeholder="Ej: 512 GB SSD"
                    disabled={isLoading}
                  />
                </div>

                {/* Sistema Operativo */}
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
              </div>
            )}
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
                {/* Fecha de Compra */}
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

                {/* Fecha de Vencimiento de Garantía */}
                <div>
                  <Label htmlFor="warrantyExpiryDate" className="text-sm font-medium">
                    Vencimiento de Garantía
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
  );
};
