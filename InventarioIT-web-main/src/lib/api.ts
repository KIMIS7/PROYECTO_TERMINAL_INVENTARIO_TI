import axios from "axios";
import { getSession } from "next-auth/react";
import { User } from "@/types";

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
        create: async (data: { rolID: number, name: string, email: string }) => {
            try {
                const response = await apiClient.post<{ success: boolean, message: string, data: {userID: number, name: string, email: string, isActive: boolean, pin: string, role: string, rolID: number} }>("/user", data);
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
        update : async (userId: number, data: { rolID: number, name: string, email: string }) => {
            try {
                const response = await apiClient.patch<{ success: boolean, message: string, data: { userID: number, name: string, email: string, isActive: boolean, role: string, rolID: number } }>(`/user/${userId}`, data);
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
};

export default api;
