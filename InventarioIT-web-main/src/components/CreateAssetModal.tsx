import { useState, useEffect, useCallback, useRef, useMemo } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { ProductType, Vendor, AssetState, Company, Site, Department } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import { CreateProductTypeModal, ProductGroup } from "./CreateProductTypeModal";
import { cn } from "@/lib/utils";
import {
  Package,
  ChevronDown,
  ChevronUp,
  ChevronRight,
  Plus,
  Search,
  X,
  User,
  Calendar,
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
    // Documentos
    factura: "",
    ticket: "",
  });

  const [filteredSites, setFilteredSites] = useState<Site[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [showTechnical, setShowTechnical] = useState(true);
  const [showDates, setShowDates] = useState(false);
  const [showUserAssignment, setShowUserAssignment] = useState(true);
  const [isProductTypeModalOpen, setIsProductTypeModalOpen] = useState(false);
  const [localProductTypes, setLocalProductTypes] = useState<ProductType[]>(productTypes);

  // Estado para busqueda de usuarios (omnibox style)
  type UserSearchResult = {
    userID: number;
    email: string;
    name: string;
    firstName: string;
    lastName: string;
    departmentID: number;
    departmentName: string;
    siteID: number;
    rolName: string;
  };
  type OmniboxMode = "facets" | "values" | "results";
  type FacetKey = "correo" | "departamento" | "site";

  const [selectedUser, setSelectedUser] = useState<{
    userID: number;
    email: string;
    name: string;
    departmentName: string;
  } | null>(null);
  const [assignmentToDate, setAssignmentToDate] = useState("");
  const [omniboxInput, setOmniboxInput] = useState("");
  const [omniboxMode, setOmniboxMode] = useState<OmniboxMode>("facets");
  const [omniboxActiveFacet, setOmniboxActiveFacet] = useState<FacetKey | null>(null);
  const [omniboxDropdownOpen, setOmniboxDropdownOpen] = useState(false);
  const [omniboxHighlightIndex, setOmniboxHighlightIndex] = useState(0);
  const [omniboxFilters, setOmniboxFilters] = useState<{ facet: FacetKey; value: string; label: string }[]>([]);
  const [userSearchResults, setUserSearchResults] = useState<UserSearchResult[]>([]);
  const [isSearchingUsers, setIsSearchingUsers] = useState(false);
  const [departments, setDepartments] = useState<Department[]>([]);
  const omniboxInputRef = useRef<HTMLInputElement>(null);
  const omniboxContainerRef = useRef<HTMLDivElement>(null);
  const omniboxDropdownRef = useRef<HTMLDivElement>(null);
  const searchTimeoutRef = useRef<NodeJS.Timeout | null>(null);

  // Actualizar tipos de producto locales cuando cambien los props
  useEffect(() => {
    setLocalProductTypes(productTypes);
  }, [productTypes]);

  // Obtener el grupo del tipo de producto seleccionado
  const selectedProductType = localProductTypes.find(pt => pt.productTypeID === formData.productTypeID);
  const productTypeGroup = selectedProductType?.group as ProductGroup | undefined;

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

  // Cargar departamentos al abrir el modal
  useEffect(() => {
    if (isOpen) {
      api.user.getDepartments().then(setDepartments).catch(console.error);
    }
  }, [isOpen]);

  // Click outside handler para omnibox
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (omniboxContainerRef.current && !omniboxContainerRef.current.contains(e.target as Node)) {
        setOmniboxDropdownOpen(false);
        setOmniboxMode("facets");
        setOmniboxActiveFacet(null);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  // Facets definition
  const FACET_CONFIG: Record<FacetKey, { label: string; color: string; badgeColor: string }> = {
    correo: { label: "Correo", color: "bg-blue-50 text-blue-700 border-blue-200", badgeColor: "bg-blue-100 text-blue-700" },
    departamento: { label: "Departamento", color: "bg-emerald-50 text-emerald-700 border-emerald-200", badgeColor: "bg-emerald-100 text-emerald-700" },
    site: { label: "Site", color: "bg-amber-50 text-amber-700 border-amber-200", badgeColor: "bg-amber-100 text-amber-700" },
  };

  const facetKeys: FacetKey[] = ["correo", "departamento", "site"];

  // Options for the selected facet
  const facetOptions = useMemo(() => {
    if (omniboxActiveFacet === "departamento") {
      return departments.map(d => ({ value: d.departID.toString(), label: d.name }));
    }
    if (omniboxActiveFacet === "site") {
      return sites.map(s => ({ value: s.siteID.toString(), label: s.name }));
    }
    return [];
  }, [omniboxActiveFacet, departments, sites]);

  const filteredFacetOptions = useMemo(() => {
    if (!omniboxInput.trim()) return facetOptions;
    const q = omniboxInput.toLowerCase();
    return facetOptions.filter(o => o.label.toLowerCase().includes(q));
  }, [facetOptions, omniboxInput]);

  // Ejecutar busqueda cuando cambian filtros
  const executeSearch = useCallback(async (filters: typeof omniboxFilters) => {
    const emailFilter = filters.find(f => f.facet === "correo");
    const deptFilter = filters.find(f => f.facet === "departamento");
    const siteFilter = filters.find(f => f.facet === "site");

    if (!emailFilter && !deptFilter && !siteFilter) {
      setUserSearchResults([]);
      return;
    }

    setIsSearchingUsers(true);
    try {
      const results = await api.user.search({
        q: emailFilter?.value || undefined,
        departmentID: deptFilter ? Number(deptFilter.value) : undefined,
        siteID: siteFilter ? Number(siteFilter.value) : undefined,
      });
      setUserSearchResults(results);
      setOmniboxMode("results");
      setOmniboxDropdownOpen(true);
    } catch (error) {
      console.error("Error al buscar usuarios:", error);
      setUserSearchResults([]);
    } finally {
      setIsSearchingUsers(false);
    }
  }, []);

  // Debounce search after adding email filter
  useEffect(() => {
    if (omniboxFilters.length === 0) {
      setUserSearchResults([]);
      return;
    }
    if (searchTimeoutRef.current) clearTimeout(searchTimeoutRef.current);
    searchTimeoutRef.current = setTimeout(() => {
      executeSearch(omniboxFilters);
    }, 300);
    return () => { if (searchTimeoutRef.current) clearTimeout(searchTimeoutRef.current); };
  }, [omniboxFilters, executeSearch]);

  // Reset highlight when options change
  useEffect(() => {
    setOmniboxHighlightIndex(0);
  }, [omniboxMode, filteredFacetOptions.length, userSearchResults.length]);

  // Omnibox handlers
  const handleOmniboxFacetSelect = (facet: FacetKey) => {
    if (facet === "correo") {
      // Correo is free text, go to typing mode
      setOmniboxActiveFacet("correo");
      setOmniboxMode("values");
      setOmniboxInput("");
      omniboxInputRef.current?.focus();
    } else {
      setOmniboxActiveFacet(facet);
      setOmniboxMode("values");
      setOmniboxInput("");
      setOmniboxHighlightIndex(0);
      omniboxInputRef.current?.focus();
    }
  };

  const handleOmniboxValueSelect = (value: string, label: string) => {
    if (!omniboxActiveFacet) return;
    // Remove existing filter for same facet
    const newFilters = [...omniboxFilters.filter(f => f.facet !== omniboxActiveFacet), { facet: omniboxActiveFacet, value, label }];
    setOmniboxFilters(newFilters);
    setOmniboxActiveFacet(null);
    setOmniboxMode("facets");
    setOmniboxInput("");
    omniboxInputRef.current?.focus();
  };

  const handleOmniboxRemoveFilter = (facet: FacetKey) => {
    const newFilters = omniboxFilters.filter(f => f.facet !== facet);
    setOmniboxFilters(newFilters);
    if (newFilters.length === 0) {
      setUserSearchResults([]);
      setOmniboxMode("facets");
    }
    omniboxInputRef.current?.focus();
  };

  const handleOmniboxKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "Escape") {
      setOmniboxDropdownOpen(false);
      setOmniboxMode("facets");
      setOmniboxActiveFacet(null);
      return;
    }

    if (e.key === "Backspace" && omniboxInput === "") {
      if (omniboxActiveFacet) {
        setOmniboxActiveFacet(null);
        setOmniboxMode("facets");
      } else if (omniboxFilters.length > 0) {
        handleOmniboxRemoveFilter(omniboxFilters[omniboxFilters.length - 1].facet);
      }
      return;
    }

    if (e.key === "Enter") {
      e.preventDefault();
      if (omniboxMode === "facets") {
        const availableFacets = facetKeys.filter(k => !omniboxFilters.find(f => f.facet === k));
        if (availableFacets[omniboxHighlightIndex]) {
          handleOmniboxFacetSelect(availableFacets[omniboxHighlightIndex]);
        }
      } else if (omniboxMode === "values") {
        if (omniboxActiveFacet === "correo" && omniboxInput.trim()) {
          handleOmniboxValueSelect(omniboxInput.trim(), omniboxInput.trim());
        } else if (filteredFacetOptions[omniboxHighlightIndex]) {
          handleOmniboxValueSelect(filteredFacetOptions[omniboxHighlightIndex].value, filteredFacetOptions[omniboxHighlightIndex].label);
        }
      } else if (omniboxMode === "results") {
        if (userSearchResults[omniboxHighlightIndex]) {
          handleSelectUserFromResults(userSearchResults[omniboxHighlightIndex]);
        }
      }
      return;
    }

    if (!omniboxDropdownOpen) return;

    let itemCount = 0;
    if (omniboxMode === "facets") itemCount = facetKeys.filter(k => !omniboxFilters.find(f => f.facet === k)).length;
    else if (omniboxMode === "values") itemCount = filteredFacetOptions.length;
    else if (omniboxMode === "results") itemCount = userSearchResults.length;

    if (e.key === "ArrowDown") {
      e.preventDefault();
      setOmniboxHighlightIndex(prev => (prev < itemCount - 1 ? prev + 1 : 0));
    } else if (e.key === "ArrowUp") {
      e.preventDefault();
      setOmniboxHighlightIndex(prev => (prev > 0 ? prev - 1 : Math.max(itemCount - 1, 0)));
    }
  };

  const handleSelectUserFromResults = (user: UserSearchResult) => {
    setSelectedUser({
      userID: user.userID,
      email: user.email,
      name: user.name,
      departmentName: user.departmentName,
    });
    setOmniboxDropdownOpen(false);
    setOmniboxFilters([]);
    setOmniboxInput("");
    setOmniboxMode("facets");
    setOmniboxActiveFacet(null);
    setUserSearchResults([]);
    setAssignmentToDate("");
  };

  // Fecha de asignacion (hoy, solo lectura)
  const todayISO = new Date().toISOString().split("T")[0];

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
        factura: formData.factura || undefined,
        ticket: formData.ticket || undefined,
      };

      // Agregar campos segun la categoria
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

      const assetData: Record<string, unknown> = {
        name: formData.name,
        vendorID: formData.vendorID,
        productTypeID: formData.productTypeID,
        detail,
      };

      await api.asset.create(assetData as Parameters<typeof api.asset.create>[0]);

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
      factura: "",
      ticket: "",
    });
    setErrors({});
    setShowTechnical(true);
    setShowDates(false);
    setShowUserAssignment(true);
    setSelectedUser(null);
    setAssignmentToDate("");
    setOmniboxInput("");
    setOmniboxMode("facets");
    setOmniboxActiveFacet(null);
    setOmniboxDropdownOpen(false);
    setOmniboxFilters([]);
    setUserSearchResults([]);
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
    if (!productTypeGroup) {
      return (
        <p className="text-sm text-gray-500 italic">
          Selecciona un tipo de activo para ver los campos disponibles
        </p>
      );
    }

    return (
      <div className="space-y-5">
        {/* 1. Identificacion - Lo que ves fisicamente sin encender el equipo */}
        <div>
          <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
            Identificacion
          </h4>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
            
          </div>
        </div>

        {/* Campos de Equipo y Otros */}
        {(productTypeGroup === "Equipo" || productTypeGroup === "Otros") && (
          <>
            {/* 2. Red y Acceso */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Red y Acceso
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
              </div>
            </div>

            {/* 3. Procesamiento */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Procesamiento
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
              </div>
            </div>

            {/* 4. Memoria */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Memoria
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
              </div>
            </div>

            {/* 5. Almacenamiento */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Almacenamiento
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">

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
              </div>
            </div>

            {/* 6. Software */}
            <div>
              <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
                Software
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="operatingSystem" className="text-sm font-medium">
                    Sistema Operativo
                  </Label>
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

        {/* Campos de Componente y Otros */}
        {(productTypeGroup === "Componente" || productTypeGroup === "Otros") && (
          <>

          
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
              </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">

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
        {productTypeGroup === "Otros" && (
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
                          {pt.name} ({pt.group})
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

                {/* Estado - Automaticamente "Stock" */}
                <div>
                  <Label htmlFor="assetState" className="text-sm font-medium">
                    Estado
                  </Label>
                  <div className="flex items-center h-10 px-3 w-fit rounded-md border bg-gray-100 text-sm text-gray-600">
                    Stock
                  </div>
                  <p className="text-xs text-gray-400 mt-1">Se asigna automaticamente al crear</p>
                </div>

                <div>
                  <Label htmlFor="factura" className="text-sm font-medium">
                  Factura
                  </Label>
                  <Input className="flex items-center h-10 px-3 w-fit rounded-md border bg-gray-100 text-sm text-gray-600"
                    id="factura"
                    value={formData.factura}
                    onChange={(e) => handleInputChange("factura", e.target.value)}
                    placeholder="Ej: FAC-2024-001"
                    disabled={isLoading}
                  />
                </div>

                <div>
                  <Label htmlFor="ticket" className="text-sm font-medium">
                    Ticket
                  </Label>
                  <Input className="flex items-center h-10 px-3 w-fit rounded-md border bg-gray-100 text-sm text-gray-600"
                    id="ticket"
                    value={formData.ticket}
                    onChange={(e) => handleInputChange("ticket", e.target.value)}
                    placeholder="Ej: TKT-2024-001"
                    disabled={isLoading}
                  />
                </div>
              </div>
            </div>

            {/* Asignar Usuario section removed - handled via Movimientos */}

            {/* HIDDEN_BLOCK_START - remove when cleanup */}
            <div className="hidden">
              <button
                type="button"
                onClick={() => setShowUserAssignment(!showUserAssignment)}
                className="flex items-center justify-between w-full text-sm font-semibold text-gray-700 mb-4 pb-2 border-b hover:text-blue-600"
              >
                <span className="flex items-center gap-2">
                  <User className="h-4 w-4" />
                  Asignar Usuario
                  {selectedUser && (
                    <span className="ml-2 text-xs font-normal text-green-600">
                      ({selectedUser.name})
                    </span>
                  )}
                </span>
                {showUserAssignment ? <ChevronUp className="h-4 w-4" /> : <ChevronDown className="h-4 w-4" />}
              </button>

              {showUserAssignment && (
                <div className="space-y-4">
                  {/* Usuario seleccionado */}
                  {selectedUser && (
                    <div className="space-y-4">
                      <div className="flex items-center justify-between p-3 bg-blue-50 border border-blue-200 rounded-lg">
                        <div>
                          <p className="text-sm font-medium text-blue-900">{selectedUser.name}</p>
                          <p className="text-xs text-blue-700">{selectedUser.email}</p>
                          {selectedUser.departmentName && (
                            <p className="text-xs text-blue-600">{selectedUser.departmentName}</p>
                          )}
                        </div>
                        <Button
                          type="button"
                          variant="ghost"
                          size="icon"
                          onClick={() => setSelectedUser(null)}
                          className="h-7 w-7 text-blue-600 hover:text-red-600 hover:bg-red-50"
                        >
                          <X className="h-4 w-4" />
                        </Button>
                      </div>

                      {/* Fechas de asignacion */}
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                          <Label className="text-sm font-medium flex items-center gap-1.5">
                            <Calendar className="h-3.5 w-3.5" />
                            Fecha de Asignacion
                          </Label>
                          <Input
                            type="date"
                            value={todayISO}
                            disabled
                            className="bg-gray-50 text-gray-600 cursor-not-allowed"
                          />
                          <p className="text-xs text-gray-400 mt-1">Fecha actual (no modificable)</p>
                        </div>
                        <div>
                          <Label className="text-sm font-medium flex items-center gap-1.5">
                            <Calendar className="h-3.5 w-3.5" />
                            Fecha de Devolucion
                          </Label>
                          <Input
                            type="date"
                            value={assignmentToDate}
                            onChange={(e) => setAssignmentToDate(e.target.value)}
                            min={todayISO}
                            disabled={isLoading}
                          />
                        </div>
                      </div>
                    </div>
                  )}

                  {/* Omnibox buscador estilo bloque */}
                  {!selectedUser && (
                    <div ref={omniboxContainerRef} className="relative">
                      {/* Input area con chips */}
                      <div
                        className={cn(
                          "flex items-center flex-wrap gap-1.5 min-h-[40px] pl-3 pr-2 py-1.5 border rounded-lg bg-white transition-all cursor-text",
                          omniboxDropdownOpen
                            ? "border-blue-400 ring-2 ring-blue-50 shadow-sm"
                            : "border-gray-200 hover:border-gray-300"
                        )}
                        onClick={() => omniboxInputRef.current?.focus()}
                      >
                        <Search className="h-4 w-4 text-gray-400 shrink-0" />

                        {/* Chips de filtros activos */}
                        {omniboxFilters.map((filter) => {
                          const config = FACET_CONFIG[filter.facet];
                          return (
                            <span
                              key={filter.facet}
                              className={cn(
                                "inline-flex items-center gap-1 pl-1.5 pr-1 py-0.5 rounded-md text-xs font-medium border shrink-0",
                                config.color
                              )}
                            >
                              <span className="opacity-70 font-semibold">{config.label}:</span>
                              <span>{filter.label}</span>
                              <button
                                type="button"
                                onClick={(e) => { e.stopPropagation(); handleOmniboxRemoveFilter(filter.facet); }}
                                className="ml-0.5 p-0.5 rounded hover:bg-black/10"
                              >
                                <X className="h-3 w-3" />
                              </button>
                            </span>
                          );
                        })}

                        {/* Label del facet activo */}
                        {omniboxActiveFacet && (
                          <span className={cn(
                            "inline-flex items-center px-1.5 py-0.5 rounded-md text-xs font-semibold shrink-0",
                            FACET_CONFIG[omniboxActiveFacet].badgeColor
                          )}>
                            {FACET_CONFIG[omniboxActiveFacet].label}:
                          </span>
                        )}

                        {/* Input de texto */}
                        <input
                          ref={omniboxInputRef}
                          type="text"
                          className="flex-1 min-w-[140px] outline-none text-sm bg-transparent placeholder:text-gray-400"
                          value={omniboxInput}
                          onChange={(e) => {
                            setOmniboxInput(e.target.value);
                            if (!omniboxDropdownOpen) setOmniboxDropdownOpen(true);
                          }}
                          onFocus={() => setOmniboxDropdownOpen(true)}
                          onKeyDown={handleOmniboxKeyDown}
                          placeholder={omniboxFilters.length > 0 || omniboxActiveFacet ? "Escribir valor..." : "Buscar usuario por filtros..."}
                          disabled={isLoading}
                        />

                        {/* Boton limpiar */}
                        {(omniboxFilters.length > 0 || omniboxInput) && (
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              setOmniboxFilters([]);
                              setOmniboxInput("");
                              setOmniboxActiveFacet(null);
                              setOmniboxMode("facets");
                              setUserSearchResults([]);
                              setOmniboxDropdownOpen(false);
                            }}
                            className="shrink-0 p-1 rounded-md text-gray-400 hover:text-gray-600 hover:bg-gray-100"
                          >
                            <X className="h-3.5 w-3.5" />
                          </button>
                        )}
                      </div>

                      {/* Dropdown */}
                      {omniboxDropdownOpen && (
                        <div
                          ref={omniboxDropdownRef}
                          className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-50 max-h-72 overflow-y-auto"
                        >
                          {/* Modo seleccion de facets */}
                          {omniboxMode === "facets" && (
                            <div className="p-1">
                              <div className="px-3 py-1.5 text-[11px] font-semibold text-gray-400 uppercase tracking-wider">
                                Filtrar por
                              </div>
                              {facetKeys
                                .filter(k => !omniboxFilters.find(f => f.facet === k))
                                .map((facetKey, index) => {
                                  const config = FACET_CONFIG[facetKey];
                                  const optCount = facetKey === "correo" ? null : facetKey === "departamento" ? departments.length : sites.length;
                                  return (
                                    <button
                                      key={facetKey}
                                      type="button"
                                      data-index={index}
                                      className={cn(
                                        "flex items-center justify-between w-full px-3 py-2 text-sm rounded-md text-left transition-colors",
                                        index === omniboxHighlightIndex ? "bg-blue-50 text-blue-700" : "text-gray-700 hover:bg-gray-50"
                                      )}
                                      onMouseEnter={() => setOmniboxHighlightIndex(index)}
                                      onClick={() => handleOmniboxFacetSelect(facetKey)}
                                    >
                                      <div className="flex items-center gap-2">
                                        <span className={cn("px-2 py-0.5 rounded text-xs font-semibold", config.badgeColor)}>
                                          {config.label}
                                        </span>
                                        {optCount !== null && (
                                          <span className="text-gray-400 text-xs">{optCount} opciones</span>
                                        )}
                                        {facetKey === "correo" && (
                                          <span className="text-gray-400 text-xs">texto libre</span>
                                        )}
                                      </div>
                                      <ChevronRight className="h-3.5 w-3.5 text-gray-400" />
                                    </button>
                                  );
                                })}
                              {facetKeys.filter(k => !omniboxFilters.find(f => f.facet === k)).length === 0 && (
                                <div className="px-3 py-4 text-sm text-gray-500 text-center">
                                  Todos los filtros aplicados
                                </div>
                              )}
                            </div>
                          )}

                          {/* Modo seleccion de valores */}
                          {omniboxMode === "values" && omniboxActiveFacet && (
                            <div className="p-1">
                              <button
                                type="button"
                                className="flex items-center gap-1.5 px-3 py-1.5 text-[11px] font-semibold text-gray-400 uppercase tracking-wider hover:text-gray-600 w-full text-left"
                                onClick={() => {
                                  setOmniboxActiveFacet(null);
                                  setOmniboxMode("facets");
                                  setOmniboxInput("");
                                }}
                              >
                                <ChevronRight className="h-3 w-3 rotate-180" />
                                {FACET_CONFIG[omniboxActiveFacet].label} — {omniboxActiveFacet === "correo" ? "Escribe y presiona Enter" : "Selecciona un valor"}
                              </button>

                              {omniboxActiveFacet === "correo" ? (
                                <div className="px-3 py-3 text-sm text-gray-500 text-center">
                                  {omniboxInput.trim()
                                    ? <span>Presiona <kbd className="px-1.5 py-0.5 bg-gray-100 rounded text-xs font-mono">Enter</kbd> para buscar por &ldquo;{omniboxInput}&rdquo;</span>
                                    : "Escribe un correo o nombre para buscar"
                                  }
                                </div>
                              ) : (
                                <>
                                  {filteredFacetOptions.length > 0 ? (
                                    filteredFacetOptions.map((option, index) => (
                                      <button
                                        key={option.value}
                                        type="button"
                                        data-index={index}
                                        className={cn(
                                          "flex items-center w-full px-3 py-2 text-sm rounded-md text-left transition-colors",
                                          index === omniboxHighlightIndex ? "bg-blue-50 text-blue-700" : "text-gray-700 hover:bg-gray-50"
                                        )}
                                        onMouseEnter={() => setOmniboxHighlightIndex(index)}
                                        onClick={() => handleOmniboxValueSelect(option.value, option.label)}
                                      >
                                        {option.label}
                                      </button>
                                    ))
                                  ) : (
                                    <div className="px-3 py-4 text-sm text-gray-500 text-center">
                                      No se encontraron opciones
                                    </div>
                                  )}
                                </>
                              )}
                            </div>
                          )}

                          {/* Modo resultados */}
                          {omniboxMode === "results" && (
                            <div className="p-1">
                              <div className="px-3 py-1.5 text-[11px] font-semibold text-gray-400 uppercase tracking-wider">
                                {isSearchingUsers ? "Buscando..." : `${userSearchResults.length} usuario${userSearchResults.length !== 1 ? "s" : ""} encontrado${userSearchResults.length !== 1 ? "s" : ""}`}
                              </div>
                              {userSearchResults.map((user, index) => (
                                <button
                                  key={user.userID}
                                  type="button"
                                  data-index={index}
                                  className={cn(
                                    "flex items-center justify-between w-full px-3 py-2.5 text-sm rounded-md text-left transition-colors",
                                    index === omniboxHighlightIndex ? "bg-blue-50 text-blue-700" : "text-gray-700 hover:bg-gray-50"
                                  )}
                                  onMouseEnter={() => setOmniboxHighlightIndex(index)}
                                  onClick={() => handleSelectUserFromResults(user)}
                                >
                                  <div>
                                    <p className="font-medium">{user.name}</p>
                                    <p className="text-xs text-gray-500">{user.email}</p>
                                  </div>
                                  <div className="text-right">
                                    {user.departmentName && <p className="text-xs text-gray-400">{user.departmentName}</p>}
                                    {user.rolName && <p className="text-xs text-gray-400">{user.rolName}</p>}
                                  </div>
                                </button>
                              ))}
                              {!isSearchingUsers && userSearchResults.length === 0 && (
                                <div className="px-3 py-4 text-sm text-gray-500 text-center">
                                  No se encontraron usuarios con los filtros aplicados
                                </div>
                              )}
                            </div>
                          )}
                        </div>
                      )}
                    </div>
                  )}
                </div>
              )}
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
