import { useState, useEffect, useRef, useCallback } from "react";
import { useSession } from "next-auth/react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Asset, Company, Site, Department, MOVEMENT_TYPES, MOVEMENT_TYPE_LABELS, MovementType } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import {
  ArrowRightLeft,
  ChevronDown,
  ChevronUp,
  Search,
  User,
  Mail,
  Building2,
  MapPin,
  X,
} from "lucide-react";

interface UserSearchResult {
  userID: number;
  email: string;
  name: string;
  firstName: string;
  lastName: string;
  departmentID: number;
  departmentName: string;
  siteID: number;
  rolName: string;
}

interface CreateMovementModalProps {
  assets: Asset[];
  preselectedAssetID?: number;
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const CreateMovementModal = ({
  assets,
  preselectedAssetID,
  isOpen,
  onClose,
  onSuccess,
}: CreateMovementModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const { data: session } = useSession();

  const userName = session?.user?.name || "";

  const [formData, setFormData] = useState({
    assetID: preselectedAssetID || 0,
    movementType: "" as MovementType | "",
    description: "",
    responsible: userName,
  });

  // Company/Site state (for ASIGNACION)
  const [companies, setCompanies] = useState<Company[]>([]);
  const [sites, setSites] = useState<Site[]>([]);
  const [filteredSites, setFilteredSites] = useState<Site[]>([]);
  const [companyID, setCompanyID] = useState<number>(0);
  const [siteID, setSiteID] = useState<number>(0);

  // User assignment state
  const [selectedUser, setSelectedUser] = useState<UserSearchResult | null>(null);
  const [userSectionOpen, setUserSectionOpen] = useState(false);
  const [userSearchQuery, setUserSearchQuery] = useState("");
  const [userSearchResults, setUserSearchResults] = useState<UserSearchResult[]>([]);
  const [isSearchingUsers, setIsSearchingUsers] = useState(false);
  const [departments, setDepartments] = useState<Department[]>([]);
  const [selectedDepartmentID, setSelectedDepartmentID] = useState<number | null>(null);
  const [activeFilter, setActiveFilter] = useState<"correo" | "departamento" | null>(null);
  const searchTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    if (userName) {
      setFormData((prev) => ({ ...prev, responsible: userName }));
    }
  }, [userName]);

  // Load catalogs when modal opens
  useEffect(() => {
    if (!isOpen) return;
    Promise.all([
      api.user.getDepartments().catch(() => []),
      api.company.getAll().catch(() => []),
      api.site.getAll().catch(() => []),
    ]).then(([depts, comps, sts]) => {
      setDepartments(depts);
      setCompanies(comps);
      setSites(sts);
    });
  }, [isOpen]);

  // Filter sites by company
  useEffect(() => {
    if (companyID) {
      setFilteredSites(sites.filter((s) => s.companyID === companyID));
      setSiteID(0);
    } else {
      setFilteredSites([]);
      setSiteID(0);
    }
  }, [companyID, sites]);

  // Auto-open user section when ASIGNACION is selected
  useEffect(() => {
    if (formData.movementType === "ASIGNACION") {
      setUserSectionOpen(true);
    }
  }, [formData.movementType]);

  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const handleInputChange = (field: string, value: string | number) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: "" }));
    }
  };

  // Clear selected user when site changes
  useEffect(() => {
    setSelectedUser(null);
    setUserSearchQuery("");
    setUserSearchResults([]);
    setSelectedDepartmentID(null);
    setActiveFilter(null);
  }, [siteID]);

  // User search with debounce — filters by siteID when selected
  const searchUsers = useCallback(async (query: string, departmentID?: number | null, currentSiteID?: number) => {
    if (!query.trim() && !departmentID && !currentSiteID) {
      setUserSearchResults([]);
      return;
    }
    setIsSearchingUsers(true);
    try {
      const params: { q?: string; departmentID?: number; siteID?: number } = {};
      if (query.trim()) params.q = query;
      if (departmentID) params.departmentID = departmentID;
      if (currentSiteID) params.siteID = currentSiteID;
      const results = await api.user.search(params);
      setUserSearchResults(results);
    } catch (error) {
      console.error("Error searching users:", error);
      setUserSearchResults([]);
    } finally {
      setIsSearchingUsers(false);
    }
  }, []);

  useEffect(() => {
    if (searchTimeoutRef.current) clearTimeout(searchTimeoutRef.current);
    if (!userSearchQuery.trim() && !selectedDepartmentID && !siteID) {
      setUserSearchResults([]);
      return;
    }
    searchTimeoutRef.current = setTimeout(() => {
      searchUsers(userSearchQuery, selectedDepartmentID, siteID || undefined);
    }, 300);
    return () => {
      if (searchTimeoutRef.current) clearTimeout(searchTimeoutRef.current);
    };
  }, [userSearchQuery, selectedDepartmentID, siteID, searchUsers]);

  const isAsignacion = formData.movementType === "ASIGNACION";

  const validateForm = () => {
    const newErrors: Record<string, string> = {};

    if (!formData.assetID) {
      newErrors.assetID = "El activo es requerido";
    }

    if (!formData.movementType) {
      newErrors.movementType = "El tipo de movimiento es requerido";
    }

    if (isAsignacion) {
      if (!selectedUser) {
        newErrors.user = "Debe asignar un usuario para el movimiento de asignación";
      }
      if (!companyID) {
        newErrors.companyID = "La empresa es requerida para asignación";
      }
      if (!siteID) {
        newErrors.siteID = "El sitio es requerido para asignación";
      }
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

      await api.movement.create({
        assetID: formData.assetID,
        movementType: formData.movementType as MovementType,
        userID: selectedUser?.userID,
        companyID: companyID || undefined,
        siteID: siteID || undefined,
        description: formData.description || undefined,
        responsible: formData.responsible || undefined,
      });

      resetForm();
      showSuccess("Movimiento registrado exitosamente");
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al registrar movimiento:", error);

      if (error && typeof error === "object" && "response" in error) {
        const axiosError = error as {
          response: { status: number; data: { message?: string } };
        };
        const message =
          axiosError.response.data?.message || "Error desconocido";
        showError(`Error: ${message}`);
      } else {
        showError("Error inesperado. Por favor, intenta mas tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const resetForm = () => {
    setFormData({
      assetID: preselectedAssetID || 0,
      movementType: "",
      description: "",
      responsible: userName,
    });
    setSelectedUser(null);
    setUserSectionOpen(false);
    setUserSearchQuery("");
    setUserSearchResults([]);
    setSelectedDepartmentID(null);
    setActiveFilter(null);
    setCompanyID(0);
    setSiteID(0);
    setErrors({});
  };

  const handleClose = () => {
    if (!isLoading) {
      resetForm();
      onClose();
    }
  };

  const getMovementTypeDescription = (type: MovementType): string => {
    const descriptions: Record<MovementType, string> = {
      ALTA: "Registra el activo como activo en el sistema",
      BAJA: "Marca el activo como inactivo/dado de baja",
      ASIGNACION: "Asigna el activo a un usuario, empresa y sitio (status: Asignado)",
      RESGUARDO: "Registra un resguardo del activo (status: Stock)",
    };
    return descriptions[type];
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-lg max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b">
          <div className="flex items-center gap-2">
            <ArrowRightLeft className="h-5 w-5 text-blue-600" />
            <h2 className="text-lg font-semibold">Registrar Movimiento</h2>
          </div>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleClose}
            disabled={isLoading}
            className="h-8 w-8"
          >
            <X className="h-4 w-4" />
          </Button>
        </div>

        {/* Formulario */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-4">
          <div className="space-y-4">
            {/* Activo */}
            <div>
              <Label htmlFor="assetID" className="text-sm font-medium">
                Activo *
              </Label>
              <Select
                value={formData.assetID ? formData.assetID.toString() : "none"}
                onValueChange={(value) =>
                  handleInputChange(
                    "assetID",
                    value === "none" ? 0 : Number(value)
                  )
                }
                disabled={isLoading || !!preselectedAssetID}
              >
                <SelectTrigger
                  className={errors.assetID ? "border-red-500" : ""}
                >
                  <SelectValue placeholder="Seleccionar activo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="none">Seleccionar activo</SelectItem>
                  {assets.map((asset) => (
                    <SelectItem
                      key={asset.assetID}
                      value={asset.assetID.toString()}
                    >
                      {asset.name}{" "}
                      {asset.assetDetail?.serialNum
                        ? `(${asset.assetDetail.serialNum})`
                        : ""}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              {errors.assetID && (
                <p className="text-red-500 text-xs mt-1">{errors.assetID}</p>
              )}
            </div>

            {/* Tipo de Movimiento */}
            <div>
              <Label htmlFor="movementType" className="text-sm font-medium">
                Tipo de Movimiento *
              </Label>
              <Select
                value={formData.movementType || "none"}
                onValueChange={(value) =>
                  handleInputChange(
                    "movementType",
                    value === "none" ? "" : value
                  )
                }
                disabled={isLoading}
              >
                <SelectTrigger
                  className={errors.movementType ? "border-red-500" : ""}
                >
                  <SelectValue placeholder="Seleccionar tipo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="none">Seleccionar tipo</SelectItem>
                  {MOVEMENT_TYPES.map((type) => (
                    <SelectItem key={type} value={type}>
                      {MOVEMENT_TYPE_LABELS[type]}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              {errors.movementType && (
                <p className="text-red-500 text-xs mt-1">
                  {errors.movementType}
                </p>
              )}
              {formData.movementType && (
                <p className="text-xs text-gray-500 mt-1">
                  {getMovementTypeDescription(
                    formData.movementType as MovementType
                  )}
                </p>
              )}
            </div>

            {/* Empresa y Site (visible para ASIGNACION) */}
            {isAsignacion && (
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label className="text-sm font-medium flex items-center gap-1">
                    <Building2 className="h-3.5 w-3.5" />
                    Empresa *
                  </Label>
                  <Select
                    value={companyID ? companyID.toString() : "none"}
                    onValueChange={(value) => {
                      setCompanyID(value === "none" ? 0 : Number(value));
                      if (errors.companyID) setErrors((prev) => ({ ...prev, companyID: "" }));
                    }}
                    disabled={isLoading}
                  >
                    <SelectTrigger className={errors.companyID ? "border-red-500" : ""}>
                      <SelectValue placeholder="Seleccionar empresa" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar empresa</SelectItem>
                      {companies.map((c) => (
                        <SelectItem key={c.companyID} value={c.companyID.toString()}>
                          {c.description}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.companyID && <p className="text-red-500 text-xs mt-1">{errors.companyID}</p>}
                </div>

                <div>
                  <Label className="text-sm font-medium flex items-center gap-1">
                    <MapPin className="h-3.5 w-3.5" />
                    Site *
                  </Label>
                  <Select
                    value={siteID ? siteID.toString() : "none"}
                    onValueChange={(value) => {
                      setSiteID(value === "none" ? 0 : Number(value));
                      if (errors.siteID) setErrors((prev) => ({ ...prev, siteID: "" }));
                    }}
                    disabled={isLoading || !companyID}
                  >
                    <SelectTrigger className={errors.siteID ? "border-red-500" : ""}>
                      <SelectValue placeholder={companyID ? "Seleccionar sitio" : "Primero selecciona empresa"} />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">Seleccionar sitio</SelectItem>
                      {filteredSites.map((s) => (
                        <SelectItem key={s.siteID} value={s.siteID.toString()}>
                          {s.name}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.siteID && <p className="text-red-500 text-xs mt-1">{errors.siteID}</p>}
                </div>
              </div>
            )}

            {/* Asignar Usuario (collapsible) */}
            <div className="border rounded-lg">
              <button
                type="button"
                onClick={() => setUserSectionOpen(!userSectionOpen)}
                className="w-full flex items-center justify-between p-3 hover:bg-gray-50 transition-colors"
              >
                <div className="flex items-center gap-2 text-sm font-medium text-gray-700">
                  <User className="h-4 w-4" />
                  Asignar Usuario
                  {isAsignacion && (
                    <span className="text-red-500 text-xs">*</span>
                  )}
                  {selectedUser && (
                    <span className="px-2 py-0.5 rounded-full text-xs bg-green-100 text-green-700">
                      {selectedUser.name}
                    </span>
                  )}
                </div>
                {userSectionOpen ? (
                  <ChevronUp className="h-4 w-4 text-gray-400" />
                ) : (
                  <ChevronDown className="h-4 w-4 text-gray-400" />
                )}
              </button>

              {userSectionOpen && (
                <div className="px-3 pb-3 space-y-2">
                  {/* Selected user display */}
                  {selectedUser && (
                    <div className="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded-lg">
                      <div>
                        <p className="text-sm font-medium text-gray-900">{selectedUser.name}</p>
                        <p className="text-xs text-gray-500">{selectedUser.email} - {selectedUser.departmentName}</p>
                      </div>
                      <Button
                        type="button"
                        variant="ghost"
                        size="icon"
                        className="h-6 w-6"
                        onClick={() => {
                          setSelectedUser(null);
                          setUserSearchQuery("");
                          setUserSearchResults([]);
                          setSelectedDepartmentID(null);
                          setActiveFilter(null);
                        }}
                      >
                        <X className="h-3 w-3" />
                      </Button>
                    </div>
                  )}

                  {/* Search and filters */}
                  {!selectedUser && (
                    <>
                      {/* Search input */}
                      <div className="relative">
                        <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                        <Input
                          value={userSearchQuery}
                          onChange={(e) => setUserSearchQuery(e.target.value)}
                          placeholder="Buscar usuario por filtros..."
                          className="pl-8 h-9 text-sm"
                          disabled={isLoading}
                        />
                      </div>

                      {/* Filter options */}
                      <div className="border rounded-lg overflow-hidden">
                        <p className="text-[10px] font-semibold text-gray-400 uppercase tracking-wider px-3 pt-2 pb-1">
                          Filtrar por
                        </p>

                        {/* Correo filter */}
                        <button
                          type="button"
                          onClick={() => setActiveFilter(activeFilter === "correo" ? null : "correo")}
                          className="w-full flex items-center justify-between px-3 py-2 hover:bg-gray-50 border-t"
                        >
                          <div className="flex items-center gap-2">
                            <span className="px-2 py-0.5 rounded text-xs font-medium bg-blue-100 text-blue-700">
                              Correo
                            </span>
                            <span className="text-xs text-gray-400">texto libre</span>
                          </div>
                          {activeFilter === "correo" ? (
                            <ChevronUp className="h-3.5 w-3.5 text-gray-400" />
                          ) : (
                            <ChevronDown className="h-3.5 w-3.5 text-gray-400" />
                          )}
                        </button>
                        {activeFilter === "correo" && (
                          <div className="px-3 pb-2">
                            <div className="relative">
                              <Mail className="absolute left-2.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-gray-400" />
                              <Input
                                value={userSearchQuery}
                                onChange={(e) => setUserSearchQuery(e.target.value)}
                                placeholder="Escribir correo..."
                                className="pl-8 h-8 text-xs"
                                disabled={isLoading}
                              />
                            </div>
                          </div>
                        )}

                        {/* Departamento filter */}
                        <button
                          type="button"
                          onClick={() => setActiveFilter(activeFilter === "departamento" ? null : "departamento")}
                          className="w-full flex items-center justify-between px-3 py-2 hover:bg-gray-50 border-t"
                        >
                          <div className="flex items-center gap-2">
                            <span className="px-2 py-0.5 rounded text-xs font-medium bg-green-100 text-green-700">
                              Departamento
                            </span>
                            <span className="text-xs text-gray-400">{departments.length} opciones</span>
                          </div>
                          {activeFilter === "departamento" ? (
                            <ChevronUp className="h-3.5 w-3.5 text-gray-400" />
                          ) : (
                            <ChevronDown className="h-3.5 w-3.5 text-gray-400" />
                          )}
                        </button>
                        {activeFilter === "departamento" && (
                          <div className="px-3 pb-2">
                            <Select
                              value={selectedDepartmentID ? selectedDepartmentID.toString() : "none"}
                              onValueChange={(value) =>
                                setSelectedDepartmentID(value === "none" ? null : Number(value))
                              }
                            >
                              <SelectTrigger className="h-8 text-xs">
                                <Building2 className="h-3.5 w-3.5 mr-1 text-gray-400" />
                                <SelectValue placeholder="Seleccionar departamento" />
                              </SelectTrigger>
                              <SelectContent>
                                <SelectItem value="none">Todos</SelectItem>
                                {departments.map((dept) => (
                                  <SelectItem key={dept.departID} value={dept.departID.toString()}>
                                    {dept.name}
                                  </SelectItem>
                                ))}
                              </SelectContent>
                            </Select>
                          </div>
                        )}
                      </div>

                      {/* Search results */}
                      {(userSearchResults.length > 0 || isSearchingUsers) && (
                        <div className="border rounded-lg max-h-40 overflow-y-auto">
                          {isSearchingUsers ? (
                            <div className="p-3 text-center text-sm text-gray-500">Buscando...</div>
                          ) : (
                            userSearchResults.map((user) => (
                              <button
                                key={user.userID}
                                type="button"
                                onClick={() => {
                                  setSelectedUser(user);
                                  setUserSearchQuery("");
                                  setUserSearchResults([]);
                                  setActiveFilter(null);
                                  if (errors.user) setErrors((prev) => ({ ...prev, user: "" }));
                                }}
                                className="w-full px-3 py-2 text-left hover:bg-gray-50 border-b last:border-b-0"
                              >
                                <p className="text-sm font-medium text-gray-900">{user.name}</p>
                                <p className="text-xs text-gray-500">{user.email} - {user.departmentName}</p>
                              </button>
                            ))
                          )}
                        </div>
                      )}
                    </>
                  )}
                  {errors.user && (
                    <p className="text-red-500 text-xs">{errors.user}</p>
                  )}
                </div>
              )}
            </div>

            {/* Responsable */}
            <div>
              <Label htmlFor="responsible" className="text-sm font-medium">
                Responsable
              </Label>
              <Input
                id="responsible"
                value={formData.responsible}
                readOnly
                className="bg-gray-100 cursor-not-allowed"
              />
            </div>

            {/* Descripcion */}
            <div>
              <Label htmlFor="description" className="text-sm font-medium">
                Descripcion
              </Label>
              <Textarea
                id="description"
                value={formData.description}
                onChange={(e) =>
                  handleInputChange("description", e.target.value)
                }
                placeholder="Descripcion o motivo del movimiento"
                disabled={isLoading}
                rows={3}
              />
            </div>
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
            {isLoading ? "Registrando..." : "Registrar Movimiento"}
          </Button>
        </div>
      </div>
    </div>
  );
};
