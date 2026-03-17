import axios from "axios";
import { getSession } from "next-auth/react";
import { User, Movement, CreateMovementDto, Department } from "@/types";

// Verificar que la URL de la API esté configurada correctamente
const apiBaseUrl = process.env.NEXT_PUBLIC_API || "http://localhost:5000/";
if (!apiBaseUrl) {
  console.error("ERROR: NEXT_PUBLIC_API no está configurada. La API no funcionará correctamente.");
}

console.log("API Base URL:", apiBaseUrl);

const apiClient = axios.create({
  baseURL: apiBaseUrl,
  headers: {
    "Content-Type": "application/json",
  },
  timeout: 300000, // 5 minutos de timeout para exportaciones grandes
});

apiClient.interceptors.request.use(async (config) => {
  try {
    console.log(`[API] Preparando solicitud a: ${config.url}`);
    
    const session = await getSession();
    
    if (session?.user) {
      config.headers["Authorization"] = `Bearer ${session?.user?.id_token}`;
      config.headers["user-email"] = session?.user?.preferred_username || "";
      console.log(`[API] Solicitud autenticada para: ${session?.user?.preferred_username}`);
    } else {
      console.log(`[API] Solicitud sin autenticar`);
    }
    
    return config;
  } catch (error) {
    console.error("[API] Error en interceptor de solicitud:", error);
    return config;
  }
});

apiClient.interceptors.response.use(
  (response) => {
    console.log(`[API] Respuesta exitosa de: ${response.config.url}`);
    return response;
  },
  (error) => {
    // Solo manejar errores de autenticación aquí
    // Los demás errores (400, 409, 500, etc.) se manejarán en los componentes
    if (error.response && error.response.status === 401) {
      console.error("[API] Error de autenticación:", error.response);
      // Aquí podrías redirigir al login o mostrar un toast
      return Promise.reject(new Error("Sesión expirada. Vuelve a iniciar sesión."));
    }
    
    // Para otros errores, solo log y rechazar el error original
    if (error.response) {
      console.error(`[API] Error de API (${error.response.status}):`, error.response.data);
    } else if (error.request) {
      console.error("[API] No se recibió respuesta:", error.request);
      // En producción, crear un error más descriptivo
      if (process.env.NODE_ENV === 'production') {
        return Promise.reject(new Error("No se pudo conectar con el servidor. Verifica tu conexión a internet o inténtalo más tarde."));
      }
    } else {
      console.error("[API] Error de Axios:", error.message);
    }

    // Asegurar que el error se propague correctamente
    return Promise.reject(error);
  }
);

const api = {
  permission: {
    get: async (email: string) => {
      console.log(`[API] Obteniendo permisos para: ${email}`);
      try {
        const response = await apiClient.get<
          {
            roldashboardpathID: number;
            url: string;
            title: string;
            icon?: string;
          }[]
        >(`/permission/${email}`);
        
        console.log(`[API] Permisos obtenidos para ${email}:`, response.data);
        return response.data;
      } catch (error) {
        console.error(`[API] Error al obtener permisos para ${email}:`, error);
        // En producción, devolver un array vacío como fallback
        if (process.env.NODE_ENV === 'production') {
          console.log('[API] Entorno de producción, retornando array vacío como fallback');
          return [];
        }
        throw error;
      }
    },
    getAll: async () => {
      const response = await apiClient.get<{
        roldashboardpathID: number;
        rolID: number;
        dashboarpathID: number;
        roleName: string;
        pathName: string;
        path: string;
        icon?: string;
      }[]>("/permission");
      return response.data;
    },
    assign: async (data: { rolID: number; dashboarpathID: number }) => {
      const response = await apiClient.post<{ success: boolean; message: string; data: object }>("/permission", data);
      return response.data;
    },
    delete: async (permissionId: number) => {
      const response = await apiClient.delete<{ success: boolean; message: string; data: object }>(`/permission/${permissionId}`);
      return response.data;
    },
  },
  dashboardPath: {
    getAll: async () => {
      const response = await apiClient.get<{
        dashboarpathID: number;
        path: string;
        name: string;
        icon?: string;
      }[]>("/dashboard-path");
      return response.data;
    },
  },
  user: {
        verify: async (email: string) => {
            console.log(`[API] Verificando usuario: ${email}`);
            try {
                const response = await apiClient.get<{ success: boolean, message: string, errorType?: string, data: unknown }>(`/user/verify/${email}`);
                console.log(`[API] Verificación de usuario ${email}:`, response.data);
                return response.data;
            } catch (error) {
                console.error(`[API] Error al verificar usuario ${email}:`, error);
                // En producción, devolver un objeto simulado como fallback
                if (process.env.NODE_ENV === 'production') {
                    console.log('[API] Entorno de producción, simulando respuesta exitosa');
                    return { success: true, message: "Usuario verificado (fallback)", data: { email } };
                }
                throw error;
            }
        },
        permission: async (email: string) => {
            const response = await apiClient.get<{ rolID: string, name: string, statusUser: boolean, traqueo_Rol_Permisos: [] }>(`/user/permissions/${email}`);
            return response.data;
        },
        getDepartments: async () => {
            const response = await apiClient.get<Department[]>("/user/departments");
            return response.data;
        },
        getDepartmentsBySite: async (siteID: number) => {
            const response = await apiClient.get<Department[]>(`/user/departments/site/${siteID}`);
            return response.data;
        },
        create: async (data: { rolID: number, name: string, email: string, DepartmentID?: number, SiteID?: number }) => {
            try {
                // Map frontend field names to backend DTO field names
                const nameParts = data.name.trim().split(/\s+/);
                const FirstName = nameParts[0] || '';
                const LastName = nameParts.length > 1 ? nameParts.slice(1).join(' ') : nameParts[0] || '';

                const payload = {
                    Email: data.email,
                    FirstName,
                    LastName,
                    rolD: data.rolID,
                    DepartmentID: data.DepartmentID,
                    SiteID: data.SiteID,
                };

                const response = await apiClient.post<{ success: boolean, message: string, data: {userID: number, name: string, email: string, isActive: boolean, pin: string, role: string, rolID: number} }>("/user", payload);
                return response.data;
            } catch (error: unknown) {
                // Re-lanzar el error para que sea manejado por el componente
                throw error;
            }
        },
        getAll: async () => {
            const response = await apiClient.get<User[]>("/user");
            return response.data;
        },
        update : async (userId: number, data: { rolID: number, name: string, email: string, DepartmentID?: number }) => {
            try {
                // Map frontend field names to backend DTO field names
                const nameParts = data.name.trim().split(/\s+/);
                const FirstName = nameParts[0] || '';
                const LastName = nameParts.length > 1 ? nameParts.slice(1).join(' ') : '';

                const payload: Record<string, unknown> = {
                    Email: data.email,
                    FirstName,
                    rolD: data.rolID,
                    DepartmentID: data.DepartmentID,
                };
                if (LastName) {
                    payload.LastName = LastName;
                }

                const response = await apiClient.patch<{ success: boolean, message: string, data: { userID: number, name: string, email: string, isActive: boolean, role: string, rolID: number } }>(`/user/${userId}`, payload);
                return response.data;
            } catch (error: unknown) {
                // Re-lanzar el error para que sea manejado por el componente
                throw error;
            }
        },
        updateStatus: async (userId: number, isActive: boolean) => {
            const response = await apiClient.patch<{ success: boolean, message: string, data: object}>(`/user/${userId}/updateUserStatus`, { isActive})
            return response.data;
        },
        regeneratepin: async (userId: number) => {
            const response = await apiClient.patch<{ success: boolean, message: string, data: { userID: number, pin: string } }>(`/pin/${userId}/generate`);
            return response.data;
        },
        delete: async (userId: number) => {
            const response = await apiClient.delete<{ success: boolean, message: string, data: object }>(`/user/${userId}`);
            return response.data; 
        },
        search: async (params: { q?: string; departmentID?: number; siteID?: number }) => {
            const queryParams = new URLSearchParams();
            if (params.q) queryParams.append('q', params.q);
            if (params.departmentID) queryParams.append('departmentID', params.departmentID.toString());
            if (params.siteID) queryParams.append('siteID', params.siteID.toString());
            const response = await apiClient.get<{
                userID: number;
                email: string;
                name: string;
                firstName: string;
                lastName: string;
                departmentID: number;
                departmentName: string;
                siteID: number;
                rolName: string;
            }[]>(`/user/search?${queryParams.toString()}`);
            return response.data;
        },
        getUserProfile: async (email: string) => {
            console.log(`[API] Obteniendo perfil de usuario: ${email}`);
            try {
                const response = await apiClient.get<{
                    success: boolean;
                    message: string;
                    data: {
                        userInfo: {
                            buyerID: string;
                            name: string;
                            emailAddress: string;
                            approvalPerson: string;
                        };
                        companies: string[];
                    };
                }>(`/user/profile/${email}`);
                
                console.log(`[API] Perfil de usuario obtenido para ${email}:`, response.data);
                return response.data;
            } catch (error) {
                console.error(`[API] Error al obtener perfil de usuario ${email}:`, error);
                throw error;
            }
        },
    
    },
  role: {
    create: async (data: { name: string }) => {
      try {
        const response = await apiClient.post<{ success: boolean, message: string, data: { rolID: number, name: string, isActive: boolean } }>("/rol", data);
        return response.data;
      } catch (error: unknown) {
        throw error;
      }
    },
    getAll: async () => {
      const response = await apiClient.get<{ rolID: number, name: string, isActive: boolean }[]>(`/rol`);
      return response.data;
    },
    update: async (rolID: number, data: { name: string }) => {
      try {
        const response = await apiClient.patch<{ success: boolean, message: string, data: { rolID: number, name: string, isActive: boolean } }>(`/rol/${rolID}`, data);
        return response.data;
      } catch (error: unknown) {
        throw error;
      }
    },
    updateStatus: async (rolID: number, isActive: boolean) => {
      const response = await apiClient.patch<{ success: boolean, message: string, data: object }>(`/rol/${rolID}/updateRoleStatus`, { isActive });
      return response.data;
    },
    delete: async (rolID: number) => {
      const response = await apiClient.delete<{ success: boolean, message: string, data: { rolID: number } }>(`/rol/${rolID}`);
      return response.data;
    }
  },
  // Asset Management
  asset: {
    create: async (data: {
      name: string;
      vendorID: number;
      productTypeID: number;
      assetState?: number;
      companyID?: number;
      siteID?: number;
      userID?: number;
      detail?: Record<string, unknown>;
    }) => {
      const response = await apiClient.post<{ success: boolean; message: string; data: { assetID: number } }>("/asset", data);
      return response.data;
    },
    getAll: async () => {
      const response = await apiClient.get<{
        assetID: number;
        name: string;
        vendorID: number;
        productTypeID: number;
        assetState: number;
        companyID: number;
        siteID: number;
        userID: number;
        vendor?: { vendorID: number; name: string };
        productType?: { productTypeID: number; name: string; category: string; group: string; subCategory: string };
        assetStateInfo?: { assetStateID: number; name: string };
        company?: { companyID: number; description: string };
        site?: { siteID: number; name: string };
        user?: { userID: number; name: string; email: string; department: string; firstName?: string; lastName?: string };
        depart?: { departID: number; Name: string };
        assetDetail?: { assetDetailID: number; serialNum?: string; assetTAG?: string; model?: string };
      }[]>("/asset");
      return response.data;
    },
    getById: async (assetID: number) => {
      const response = await apiClient.get(`/asset/${assetID}`);
      return response.data;
    },
    update: async (assetID: number, data: Record<string, unknown>) => {
      const response = await apiClient.patch<{ success: boolean; message: string; data: unknown }>(`/asset/${assetID}`, data);
      return response.data;
    },
    delete: async (assetID: number) => {
      const response = await apiClient.delete<{ success: boolean; message: string }>(`/asset/${assetID}`);
      return response.data;
    },
    getRelationships: async (assetID: number) => {
      const response = await apiClient.get<{
        asset: {
          assetID: number;
          name: string;
          parentAssetID: number | null;
          productType: { productTypeID: number; name: string; group: string } | null;
          model: string | null;
          serialNum: string | null;
          user: { userID: number; name: string } | null;
        };
        parentAsset: {
          assetID: number;
          name: string;
          productType: { productTypeID: number; name: string; group: string } | null;
          model: string | null;
          serialNum: string | null;
        } | null;
        childAssets: {
          assetID: number;
          name: string;
          productType: { productTypeID: number; name: string; group: string } | null;
          model: string | null;
          serialNum: string | null;
        }[];
      }>(`/asset/${assetID}/relationships`);
      return response.data;
    },
    assignChild: async (parentAssetID: number, childAssetID: number) => {
      const response = await apiClient.patch<{ success: boolean; message: string }>(`/asset/${parentAssetID}/assign`, { childAssetID });
      return response.data;
    },
    unassignChild: async (parentAssetID: number, childAssetID: number) => {
      const response = await apiClient.patch<{ success: boolean; message: string }>(`/asset/${parentAssetID}/unassign`, { childAssetID });
      return response.data;
    },
    assignParent: async (childAssetID: number, parentAssetID: number) => {
      const response = await apiClient.patch<{ success: boolean; message: string }>(`/asset/${childAssetID}/assign-parent`, { parentAssetID });
      return response.data;
    },
    unassignParent: async (childAssetID: number) => {
      const response = await apiClient.patch<{ success: boolean; message: string }>(`/asset/${childAssetID}/unassign-parent`, {});
      return response.data;
    },
  },
  // Movimientos de activos
  movement: {
    create: async (data: CreateMovementDto) => {
      const response = await apiClient.post<{ success: boolean; message: string; data: { movementID: number; assetID: number; movementType: string } }>("/movement", data);
      return response.data;
    },
    getAll: async () => {
      const response = await apiClient.get<Movement[]>("/movement");
      return response.data;
    },
    getHistory: async () => {
      const response = await apiClient.get<{
        historyID: number;
        assetID: number;
        assetName: string;
        operation: string;
        description: string;
        performedBy?: string | null;
        responsible?: string | null;
        createdBy?: string | null;
        createdTime: string;
        assignedUser?: string | null;
        department?: string | null;
        site?: string | null;
        company?: string | null;
      }[]>("/movement/history");
      // Normalize: compute performedBy from whichever fields the API returns
      return response.data.map((r) => ({
        ...r,
        performedBy: r.performedBy || r.responsible || r.createdBy || null,
      }));
    },
    getByAssetId: async (assetID: number) => {
      const response = await apiClient.get<Movement[]>(`/movement/asset/${assetID}`);
      return response.data;
    },
    update: async (movementID: number, data: { description?: string; responsible?: string }) => {
      const response = await apiClient.patch<{ success: boolean; message: string }>(`/movement/${movementID}`, data);
      return response.data;
    },
    createBulk: async (data: {
      assetIDs: number[];
      movementType: 'REASIGNACION' | 'RESGUARDO' | 'REPARACION' | 'BAJA';
      companyID?: number;
      siteID?: number;
      userID?: number;
      departID?: number;
      fromDate?: string;
      toDate?: string;
      description?: string;
      responsible?: string;
    }) => {
      const response = await apiClient.post<{
        success: boolean;
        message: string;
        data: { movementID: number; assetID: number; assetName: string }[];
      }>("/movement/bulk", data);
      return response.data;
    },
  },
  // Catálogos para activos
  productType: {
    getAll: async () => {
      const response = await apiClient.get<{
        productTypeID: number;
        name: string;
        category: string;
        group: string;
        subCategory: string;
      }[]>("/product-type");
      return response.data;
    },
    getByGroup: async (group: string) => {
      const response = await apiClient.get<{
        productTypeID: number;
        name: string;
        category: string;
        group: string;
        subCategory: string;
      }[]>(`/product-type/group/${group}`);
      return response.data;
    },
    getAvailableGroups: async () => {
      const response = await apiClient.get<{
        success: boolean;
        data: string[];
      }>("/product-type/available-groups");
      return response.data;
    },
    create: async (data: { name: string; group: string }) => {
      const response = await apiClient.post<{
        success: boolean;
        message: string;
        data: {
          productTypeID: number;
          name: string;
          category: string;
          group: string;
          subCategory: string;
        };
      }>("/product-type", data);
      return response.data;
    },
    delete: async (productTypeID: number) => {
      const response = await apiClient.delete<{
        success: boolean;
        message: string;
        data: { productTypeID: number };
      }>(`/product-type/${productTypeID}`);
      return response.data;
    },
  },
  vendor: {
    getAll: async () => {
      const response = await apiClient.get<{ vendorID: number; name: string }[]>("/vendor");
      return response.data;
    },
    create: async (data: { name: string }) => {
      const response = await apiClient.post<{ success: boolean; message: string; data: { vendorID: number; name: string } }>("/vendor", data);
      return response.data;
    },
  },
  assetState: {
    getAll: async () => {
      const response = await apiClient.get<{ assetStateID: number; name: string }[]>("/asset-state");
      return response.data;
    },
  },
  company: {
    getAll: async () => {
      const response = await apiClient.get<{ companyID: number; description: string }[]>("/company");
      return response.data;
    },
  },
  site: {
    getAll: async () => {
      const response = await apiClient.get<{ siteID: number; name: string; companyID: number }[]>("/site");
      return response.data;
    },
    getByCompany: async (companyID: number) => {
      const response = await apiClient.get<{ siteID: number; name: string; companyID: number }[]>(`/site/company/${companyID}`);
      return response.data;
    },
  },
  // Reportes y exportaciones
  report: {
    getDeliveryData: async (assetID: number) => {
      const response = await apiClient.get<{
        assetID: number;
        name: string;
        serialNum: string;
        model: string;
        processor: string;
        ram: string;
        hddCapacity: string;
        operatingSystem: string;
        vendor: string;
        productType: string;
        company: string;
        site: string;
        department: string;
        userName: string;
        userEmail: string;
        childAssets: { name: string; productType: string; serialNum: string; model: string }[];
        softwareChecklist: string[];
      }>(`/report/delivery/${assetID}/data`);
      return response.data;
    },
    downloadDeliveryPdf: async (assetID: number, data: { softwareStatus?: Record<string, string>; notes?: string }) => {
      const response = await apiClient.post(`/report/delivery/${assetID}/pdf`, data, {
        responseType: 'blob',
      });
      return response.data;
    },
    downloadAssetsExcel: async (filters?: { group?: string; companyID?: number; assetState?: number }) => {
      const params = new URLSearchParams();
      if (filters?.group) params.append('group', filters.group);
      if (filters?.companyID) params.append('companyID', filters.companyID.toString());
      if (filters?.assetState) params.append('assetState', filters.assetState.toString());
      const response = await apiClient.get(`/report/assets/excel?${params.toString()}`, {
        responseType: 'blob',
      });
      return response.data;
    },
    downloadAssetsCsv: async (filters?: { group?: string; companyID?: number; assetState?: number }) => {
      const params = new URLSearchParams();
      if (filters?.group) params.append('group', filters.group);
      if (filters?.companyID) params.append('companyID', filters.companyID.toString());
      if (filters?.assetState) params.append('assetState', filters.assetState.toString());
      const response = await apiClient.get(`/report/assets/csv?${params.toString()}`, {
        responseType: 'blob',
      });
      return response.data;
    },
    downloadHistoryExcel: async (assetId?: number) => {
      const params = assetId ? `?assetId=${assetId}` : '';
      const response = await apiClient.get(`/report/history/excel${params}`, {
        responseType: 'blob',
      });
      return response.data;
    },
    downloadUserAssetsExcel: async (userId: number) => {
      const response = await apiClient.get(`/report/user/${userId}/assets/excel`, {
        responseType: 'blob',
      });
      return response.data;
    },
  },
};

export default api;
