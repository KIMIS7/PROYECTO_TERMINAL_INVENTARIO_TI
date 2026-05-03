import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { User, Role, Department, Company, Site } from "@/types";
import api from "@/lib/api";
import { useNotifications } from "@/hooks/useNotifications";

interface EditUserModalProps {
  user: User | null;
  roles: Role[];
  departments: Department[];
  isOpen: boolean;
  onClose: () => void;
  onSave: (updatedUser: User) => void;
}

export const EditUserModal = ({ user, roles, departments, isOpen, onClose, onSave }: EditUserModalProps) => {
  const { showSuccess, showError, showWarning } = useNotifications();
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    rolID: 0,
    SiteID: 0,
    DepartmentID: 0,
  });
  const [isLoading, setIsLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const [companies, setCompanies] = useState<Company[]>([]);
  const [selectedCompanyID, setSelectedCompanyID] = useState<number>(0);
  const [sites, setSites] = useState<Site[]>([]);
  const [filteredDepartments, setFilteredDepartments] = useState<Department[]>([]);
  const [isLoadingSites, setIsLoadingSites] = useState(false);
  const [isLoadingDepts, setIsLoadingDepts] = useState(false);
  const [isInitializing, setIsInitializing] = useState(false);

  useEffect(() => {
    if (!isOpen || !user) return;

    setErrors({});
    setIsInitializing(true);

    const initForm = async () => {
      try {
        const companiesData = await api.company.getAll();
        setCompanies(companiesData);

        if (user.siteID) {
          const allSites = await api.site.getAll();
          const userSite = allSites.find(s => s.siteID === user.siteID);

          if (userSite) {
            setSelectedCompanyID(userSite.companyID);

            const companySites = await api.site.getByCompany(userSite.companyID);
            setSites(companySites);

            const depts = await api.user.getDepartmentsBySite(user.siteID);
            setFilteredDepartments(depts);
          }
        } else {
          setSelectedCompanyID(0);
          setSites([]);
          setFilteredDepartments(departments);
        }

        setFormData({
          name: user.name,
          email: user.email,
          rolID: user.rolID,
          SiteID: user.siteID || 0,
          DepartmentID: user.departmentID || 0,
        });
      } catch {
        setCompanies([]);
      } finally {
        setIsInitializing(false);
      }
    };

    initForm();
  }, [isOpen, user, departments]);

  useEffect(() => {
    if (isInitializing) return;
    if (!selectedCompanyID) {
      setSites([]);
      setFormData(prev => ({ ...prev, SiteID: 0, DepartmentID: 0 }));
      setFilteredDepartments([]);
      return;
    }
    setIsLoadingSites(true);
    setFormData(prev => ({ ...prev, SiteID: 0, DepartmentID: 0 }));
    setFilteredDepartments([]);
    api.site.getByCompany(selectedCompanyID)
      .then(setSites)
      .catch(() => setSites([]))
      .finally(() => setIsLoadingSites(false));
  }, [selectedCompanyID, isInitializing]);

  useEffect(() => {
    if (isInitializing) return;
    if (!formData.SiteID) {
      setFilteredDepartments([]);
      setFormData(prev => ({ ...prev, DepartmentID: 0 }));
      return;
    }
    setIsLoadingDepts(true);
    setFormData(prev => ({ ...prev, DepartmentID: 0 }));
    api.user.getDepartmentsBySite(formData.SiteID)
      .then(setFilteredDepartments)
      .catch(() => setFilteredDepartments([]))
      .finally(() => setIsLoadingDepts(false));
  }, [formData.SiteID, isInitializing]);

  const handleInputChange = (field: string, value: string | number) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: "" }));
    }
  };

  const validateEmail = (email: string): string | null => {
    if (!email.trim()) return "El email es requerido";
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(email)) return "El formato del email no es valido";
    if (email.length > 254) return "El email es demasiado largo";
    if (email.includes("..") || email.includes("--")) return "El email contiene caracteres invalidos";
    if (email.startsWith(".") || email.endsWith(".")) return "El email no puede empezar o terminar con punto";
    return null;
  };

  const validateForm = () => {
    const newErrors: Record<string, string> = {};
    if (!formData.name.trim()) newErrors.name = "El nombre es requerido";
    const emailError = validateEmail(formData.email);
    if (emailError) newErrors.email = emailError;
    if (!formData.rolID) newErrors.rolID = "El rol es requerido";
    if (!formData.SiteID) newErrors.SiteID = "El sitio es requerido";
    if (!formData.DepartmentID) newErrors.DepartmentID = "El departamento es requerido";
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateForm() || !user) return;

    try {
      setIsLoading(true);
      await api.user.update(user.userID, formData);

      const updatedUser: User = {
        ...user,
        name: formData.name,
        email: formData.email,
        rolID: formData.rolID,
        rolName: roles.find(r => r.rolID === formData.rolID)?.name || "",
        departmentID: formData.DepartmentID,
        departmentName: filteredDepartments.find(d => d.departID === formData.DepartmentID)?.name || "",
        siteID: formData.SiteID || null,
      };

      showSuccess("Usuario actualizado exitosamente");
      onSave(updatedUser);
      onClose();
    } catch (error: unknown) {
      console.error("Error al actualizar usuario:", error);
      if (error && typeof error === 'object' && 'response' in error) {
        const response = (error as { response: { status: number; data?: { message?: string; error?: string } } }).response;
        const status = response.status;
        const message = response.data?.message || response.data?.error || 'Error desconocido';
        if (status === 409) {
          setErrors({ email: "Este email ya esta registrado" });
          showWarning("Este email ya esta registrado en el sistema");
        } else if (status === 400) {
          showError(`Error de validacion: ${message}`);
        } else if (status === 404) {
          showError("El usuario no existe o ha sido eliminado.");
          onClose();
        } else if (status >= 500) {
          showError("Error interno del servidor. Por favor, intenta mas tarde.");
        } else {
          showError(`Error: ${message}`);
        }
      } else if (error && typeof error === 'object' && 'request' in error) {
        showError("Error de conexion. Verifica tu internet y vuelve a intentar.");
      } else {
        showError("Error inesperado. Por favor, intenta mas tarde.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  if (!isOpen || !user) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-full max-w-md mx-4 max-h-[90vh] overflow-y-auto">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">Editar Usuario</h2>
          <Button
            variant="ghost"
            size="icon"
            onClick={onClose}
            className="h-6 w-6"
            aria-label="Cerrar modal"
          >
            x
          </Button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Label htmlFor="edit-name" className="block text-left mb-2">Nombre</Label>
            <Input
              id="edit-name"
              type="text"
              value={formData.name}
              onChange={(e) => handleInputChange("name", e.target.value)}
              className={errors.name ? "border-red-500" : ""}
              aria-describedby={errors.name ? "edit-name-error" : undefined}
              disabled={isLoading}
            />
            {errors.name && (
              <p id="edit-name-error" className="text-red-500 text-sm mt-1">{errors.name}</p>
            )}
          </div>

          <div>
            <Label htmlFor="edit-email" className="block text-left mb-2">Email</Label>
            <Input
              id="edit-email"
              type="email"
              value={formData.email}
              onChange={(e) => handleInputChange("email", e.target.value)}
              className={errors.email ? "border-red-500" : ""}
              aria-describedby={errors.email ? "edit-email-error" : undefined}
              disabled={isLoading}
              placeholder="ejemplo@correo.com"
            />
            {errors.email && (
              <p id="edit-email-error" className="text-red-500 text-sm mt-1">{errors.email}</p>
            )}
          </div>

          <div>
            <Label htmlFor="edit-rolID" className="block text-left mb-2">Rol</Label>
            <Select
              value={formData.rolID ? formData.rolID.toString() : "none"}
              onValueChange={(value) => handleInputChange("rolID", value === "none" ? 0 : Number(value))}
              disabled={isLoading}
            >
              <SelectTrigger className={`w-full ${errors.rolID ? "border-red-500" : ""}`}>
                <SelectValue placeholder="Seleccionar rol" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar rol</SelectItem>
                {roles.map((role) => (
                  <SelectItem key={role.rolID} value={role.rolID.toString()}>
                    {role.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {errors.rolID && (
              <p id="edit-rolID-error" className="text-red-500 text-sm mt-1">{errors.rolID}</p>
            )}
          </div>

          <div>
            <Label htmlFor="edit-companyID" className="block text-left mb-2">Company</Label>
            <Select
              value={selectedCompanyID ? selectedCompanyID.toString() : "none"}
              onValueChange={(value) => setSelectedCompanyID(value === "none" ? 0 : Number(value))}
              disabled={isLoading || isInitializing}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder={isInitializing ? "Cargando..." : "Seleccionar company"} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar company</SelectItem>
                {companies.map((company) => (
                  <SelectItem key={company.companyID} value={company.companyID.toString()}>
                    {company.description}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div>
            <Label htmlFor="edit-siteID" className="block text-left mb-2">Site</Label>
            <Select
              value={formData.SiteID ? formData.SiteID.toString() : "none"}
              onValueChange={(value) => handleInputChange("SiteID", value === "none" ? 0 : Number(value))}
              disabled={isLoading || !selectedCompanyID || isLoadingSites || isInitializing}
            >
              <SelectTrigger className={`w-full ${errors.SiteID ? "border-red-500" : ""}`}>
                <SelectValue placeholder={
                  isInitializing
                    ? "Cargando..."
                    : !selectedCompanyID
                    ? "Primero selecciona una company"
                    : isLoadingSites
                    ? "Cargando sitios..."
                    : "Seleccionar sitio"
                } />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar sitio</SelectItem>
                {sites.map((site) => (
                  <SelectItem key={site.siteID} value={site.siteID.toString()}>
                    {site.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {errors.SiteID && (
              <p id="edit-siteID-error" className="text-red-500 text-sm mt-1">{errors.SiteID}</p>
            )}
          </div>

          <div>
            <Label htmlFor="edit-departmentID" className="block text-left mb-2">Departamento</Label>
            <Select
              value={formData.DepartmentID ? formData.DepartmentID.toString() : "none"}
              onValueChange={(value) => handleInputChange("DepartmentID", value === "none" ? 0 : Number(value))}
              disabled={isLoading || !formData.SiteID || isLoadingDepts || isInitializing}
            >
              <SelectTrigger className={`w-full ${errors.DepartmentID ? "border-red-500" : ""}`}>
                <SelectValue placeholder={
                  isInitializing
                    ? "Cargando..."
                    : !formData.SiteID
                    ? "Primero selecciona un sitio"
                    : isLoadingDepts
                    ? "Cargando departamentos..."
                    : "Seleccionar departamento"
                } />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Seleccionar departamento</SelectItem>
                {filteredDepartments.map((dept) => (
                  <SelectItem key={dept.departID} value={dept.departID.toString()}>
                    {dept.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {errors.DepartmentID && (
              <p id="edit-departmentID-error" className="text-red-500 text-sm mt-1">{errors.DepartmentID}</p>
            )}
          </div>

          <div className="flex gap-2 pt-4">
            <Button
              type="button"
              variant="outline"
              onClick={onClose}
              disabled={isLoading}
              className="flex-1"
            >
              Cancelar
            </Button>
            <Button
              type="submit"
              disabled={isLoading || isInitializing}
              className="flex-1"
            >
              {isLoading ? "Guardando..." : "Guardar"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
};
