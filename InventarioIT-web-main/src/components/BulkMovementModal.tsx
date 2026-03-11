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
import { Asset, Company, Site } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";
import {
  ArrowRightLeft,
  X,
  ChevronDown,
  ChevronUp,
  Search,
  User,
  Building2,
  MapPin,
  Calendar,
  Package,
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

interface BulkMovementModalProps {
  assets: Asset[];
  selectedAssetIDs: number[];
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

const BULK_MOVEMENT_TYPES = [
  { value: "ASIGNACION", label: "Asignación", description: "Asignar los activos a otra empresa, sitio o usuario" },
  { value: "RESGUARDO", label: "Resguardo", description: "Registrar un resguardo de los activos (status: Stock)" },
] as const;

export const BulkMovementModal = ({
  assets,
  selectedAssetIDs,
  isOpen,
  onClose,
  onSuccess,
}: BulkMovementModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const { data: session } = useSession();
  const userName = session?.user?.name || "";

  // Form state
  const [movementType, setMovementType] = useState<"ASIGNACION" | "RESGUARDO" | "">("");
  const [companyID, setCompanyID] = useState<number>(0);
  const [siteID, setSiteID] = useState<number>(0);
  const [selectedUser, setSelectedUser] = useState<UserSearchResult | null>(null);
  const [fromDate, setFromDate] = useState(new Date().toISOString().split("T")[0]);
  const [toDate, setToDate] = useState("");
  const [description, setDescription] = useState("");
  const [responsible, setResponsible] = useState(userName);

  // Catalogs
  const [companies, setCompanies] = useState<Company[]>([]);
  const [sites, setSites] = useState<Site[]>([]);
  const [filteredSites, setFilteredSites] = useState<Site[]>([]);

  // User search
  const [userSearchOpen, setUserSearchOpen] = useState(false);
  const [userSearchQuery, setUserSearchQuery] = useState("");
  const [userSearchResults, setUserSearchResults] = useState<UserSearchResult[]>([]);
  const [isSearchingUsers, setIsSearchingUsers] = useState(false);
  const searchTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  // UI state
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  // Selected assets info
  const selectedAssets = assets.filter((a) => selectedAssetIDs.includes(a.assetID));

  // Load catalogs
  useEffect(() => {
    if (!isOpen) return;
    const loadCatalogs = async () => {
      try {
        const [companiesRes, sitesRes] = await Promise.all([
          api.company.getAll().catch(() => []),
          api.site.getAll().catch(() => []),
        ]);
        setCompanies(companiesRes);
        setSites(sitesRes);
      } catch (error) {
        console.error("Error loading catalogs:", error);
      }
    };
    loadCatalogs();
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

  // Set responsible from session
  useEffect(() => {
    if (userName) setResponsible(userName);
  }, [userName]);

  // User search with debounce
  const searchUsers = useCallback(async (query: string) => {
    if (!query.trim() || query.length < 2) {
      setUserSearchResults([]);
      return;
    }
    setIsSearchingUsers(true);
    try {
      const results = await api.user.search({ q: query });
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
    searchTimeoutRef.current = setTimeout(() => {
      searchUsers(userSearchQuery);
    }, 300);
    return () => {
      if (searchTimeoutRef.current) clearTimeout(searchTimeoutRef.current);
    };
  }, [userSearchQuery, searchUsers]);

  const validateForm = () => {
    const newErrors: Record<string, string> = {};
    if (!movementType) newErrors.movementType = "El tipo de movimiento es requerido";
    if (!companyID) newErrors.companyID = "La empresa es requerida";
    if (!siteID) newErrors.siteID = "El sitio es requerido";
    if (!fromDate) newErrors.fromDate = "La fecha es requerida";
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
      await api.movement.createBulk({
        assetIDs: selectedAssetIDs,
        movementType: movementType as "ASIGNACION" | "RESGUARDO",
        companyID,
        siteID,
        userID: selectedUser?.userID,
        fromDate,
        toDate: toDate || undefined,
        description: description || undefined,
        responsible: responsible || undefined,
      });

      showSuccess(`Movimiento registrado para ${selectedAssetIDs.length} activo(s)`);
      resetForm();
      onSuccess();
      onClose();
    } catch (error: unknown) {
      console.error("Error al registrar movimiento masivo:", error);
      if (error && typeof error === "object" && "response" in error) {
        const axiosError = error as { response: { status: number; data: { message?: string } } };
        const message = axiosError.response.data?.message || "Error desconocido";
        showError(`Error: ${message}`);
      } else {
        showError("Error inesperado. Por favor, intenta mas tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const resetForm = () => {
    setMovementType("");
    setCompanyID(0);
    setSiteID(0);
    setSelectedUser(null);
    setFromDate(new Date().toISOString().split("T")[0]);
    setToDate("");
    setDescription("");
    setResponsible(userName);
    setUserSearchQuery("");
    setUserSearchResults([]);
    setUserSearchOpen(false);
    setErrors({});
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
      <div className="bg-white rounded-lg w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b bg-gradient-to-r from-blue-600 to-blue-700">
          <div className="flex items-center gap-2 text-white">
            <ArrowRightLeft className="h-5 w-5" />
            <h2 className="text-lg font-semibold">Generar Movimiento</h2>
            <span className="ml-2 px-2 py-0.5 text-xs font-medium bg-white/20 rounded-full">
              {selectedAssets.length} activo(s)
            </span>
          </div>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleClose}
            disabled={isLoading}
            className="h-8 w-8 text-white hover:bg-white/20"
          >
            <X className="h-4 w-4" />
          </Button>
        </div>

        {/* Content */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-4 space-y-4">
          {/* Selected assets summary */}
          <div className="bg-gray-50 rounded-lg p-3 border">
            <div className="flex items-center gap-2 text-sm font-medium text-gray-700 mb-2">
              <Package className="h-4 w-4" />
              Activos seleccionados
            </div>
            <div className="flex flex-wrap gap-1.5 max-h-20 overflow-y-auto">
              {selectedAssets.map((asset) => (
                <span
                  key={asset.assetID}
                  className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-700"
                >
                  {asset.name}
                  {asset.assetDetail?.serialNum && (
                    <span className="ml-1 text-blue-500">({asset.assetDetail.serialNum})</span>
                  )}
                </span>
              ))}
            </div>
          </div>

          {/* Movement type */}
          <div>
            <Label className="text-sm font-medium">Tipo de Movimiento *</Label>
            <div className="grid grid-cols-2 gap-2 mt-1">
              {BULK_MOVEMENT_TYPES.map((type) => (
                <button
                  key={type.value}
                  type="button"
                  onClick={() => {
                    setMovementType(type.value);
                    if (errors.movementType) setErrors((prev) => ({ ...prev, movementType: "" }));
                  }}
                  className={`p-3 rounded-lg border-2 text-left transition-all ${
                    movementType === type.value
                      ? "border-blue-500 bg-blue-50"
                      : "border-gray-200 hover:border-gray-300"
                  }`}
                  disabled={isLoading}
                >
                  <p className={`text-sm font-medium ${movementType === type.value ? "text-blue-700" : "text-gray-700"}`}>
                    {type.label}
                  </p>
                  <p className="text-xs text-gray-500 mt-0.5">{type.description}</p>
                </button>
              ))}
            </div>
            {errors.movementType && <p className="text-red-500 text-xs mt-1">{errors.movementType}</p>}
          </div>

          {/* Company and Site */}
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
                  <SelectValue placeholder="Seleccionar sitio" />
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

          {/* User assignment (collapsible) */}
          <div className="border rounded-lg">
            <button
              type="button"
              onClick={() => setUserSearchOpen(!userSearchOpen)}
              className="w-full flex items-center justify-between p-3 hover:bg-gray-50 transition-colors"
            >
              <div className="flex items-center gap-2 text-sm font-medium text-gray-700">
                <User className="h-4 w-4" />
                Asignar Usuario
                {selectedUser && (
                  <span className="px-2 py-0.5 rounded-full text-xs bg-green-100 text-green-700">
                    {selectedUser.name}
                  </span>
                )}
              </div>
              {userSearchOpen ? (
                <ChevronUp className="h-4 w-4 text-gray-400" />
              ) : (
                <ChevronDown className="h-4 w-4 text-gray-400" />
              )}
            </button>

            {userSearchOpen && (
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
                      }}
                    >
                      <X className="h-3 w-3" />
                    </Button>
                  </div>
                )}

                {/* Search input */}
                {!selectedUser && (
                  <div className="relative">
                    <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                      value={userSearchQuery}
                      onChange={(e) => setUserSearchQuery(e.target.value)}
                      placeholder="Buscar usuario por filtros..."
                      className="pl-8 h-9 text-sm"
                      disabled={isLoading}
                    />

                    {/* Search results */}
                    {(userSearchResults.length > 0 || isSearchingUsers) && (
                      <div className="absolute z-10 w-full mt-1 bg-white border rounded-lg shadow-lg max-h-40 overflow-y-auto">
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
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Dates */}
          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="text-sm font-medium flex items-center gap-1">
                <Calendar className="h-3.5 w-3.5" />
                Fecha inicio *
              </Label>
              <Input
                type="date"
                value={fromDate}
                onChange={(e) => {
                  setFromDate(e.target.value);
                  if (errors.fromDate) setErrors((prev) => ({ ...prev, fromDate: "" }));
                }}
                className={errors.fromDate ? "border-red-500" : ""}
                disabled={isLoading}
              />
              {errors.fromDate && <p className="text-red-500 text-xs mt-1">{errors.fromDate}</p>}
            </div>

            <div>
              <Label className="text-sm font-medium flex items-center gap-1">
                <Calendar className="h-3.5 w-3.5" />
                Fecha fin
              </Label>
              <Input
                type="date"
                value={toDate}
                onChange={(e) => setToDate(e.target.value)}
                disabled={isLoading}
              />
            </div>
          </div>

          {/* Description */}
          <div>
            <Label className="text-sm font-medium">Descripcion</Label>
            <Textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="Descripcion o motivo del movimiento"
              disabled={isLoading}
              rows={2}
            />
          </div>

          {/* Responsible (read-only) */}
          <div>
            <Label className="text-sm font-medium">Responsable</Label>
            <Input value={responsible} readOnly className="bg-gray-100 cursor-not-allowed" />
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
            {isLoading
              ? "Registrando..."
              : `Registrar Movimiento (${selectedAssets.length})`}
          </Button>
        </div>
      </div>
    </div>
  );
};
