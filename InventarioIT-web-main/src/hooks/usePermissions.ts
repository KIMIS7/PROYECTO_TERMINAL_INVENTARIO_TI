import { useState, useEffect, useRef, useMemo, useCallback } from 'react';
import { useSession } from 'next-auth/react';
import api from '@/lib/api';

export interface Permission {
  roldashboardpathID: number;
  url: string;
  title: string;
  icon?: string;
}

export function usePermissions() {
  const { data: session, status } = useSession();
  const [permissions, setPermissions] = useState<Permission[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const fetchAttemptedRef = useRef(false);

  // Usar useMemo para estabilizar el username
  const username = useMemo(() => session?.user?.preferred_username, [session?.user?.preferred_username]);

  useEffect(() => {
    let isMounted = true;
    let timeoutId: NodeJS.Timeout;

    // Solo ejecutar si ya intentamos cargar
    if (fetchAttemptedRef.current) return;

    const fetchPermissions = async () => {
      if (status === 'loading') return;
      
      console.log('[usePermissions] Session status:', status);
      console.log('[usePermissions] User:', username);

      if (!username) {
        console.log('[usePermissions] No username found in session');
        if (isMounted) {
          setLoading(false);
          fetchAttemptedRef.current = true;
        }
        return;
      }

      // Establecer un timeout para evitar que la carga se quede bloqueada indefinidamente
      timeoutId = setTimeout(() => {
        if (isMounted && loading && !fetchAttemptedRef.current) {
          console.log('[usePermissions] Timeout reached, continuing with empty permissions');
          setPermissions([]);
          setLoading(false);
          fetchAttemptedRef.current = true;
          setError('Tiempo de espera agotado al cargar permisos');
        }
      }, 8000); // 8 segundos de timeout

      try {
        if (isMounted) {
          setLoading(true);
          setError(null);
        }
        
        console.log('[usePermissions] Fetching permissions for:', username);
        
        const userPermissions = await api.permission.get(username);
        
        console.log('[usePermissions] Permissions received:', userPermissions);
        
        if (isMounted) {
          setPermissions(userPermissions || []);
          fetchAttemptedRef.current = true;
        }
      } catch (err: any) {
        console.error('[usePermissions] Error fetching permissions:', err);
        
        if (isMounted) {
          setError(err?.message || 'Error al cargar permisos');
          fetchAttemptedRef.current = true;
          
          // En entorno de producción, establecer permisos vacíos pero permitir continuar
          if (process.env.NODE_ENV === 'production') {
            console.log('[usePermissions] Production environment, continuing with empty permissions');
            setPermissions([]);
          }
        }
      } finally {
        clearTimeout(timeoutId);
        if (isMounted) {
          setLoading(false);
        }
      }
    };

    // Solo ejecutar si tenemos un usuario válido y no hemos intentado cargar antes
    if (username && status === 'authenticated' && !fetchAttemptedRef.current) {
      fetchPermissions();
    } else if (status === 'unauthenticated' && !fetchAttemptedRef.current) {
      console.log('[usePermissions] User is not authenticated');
      setLoading(false);
      fetchAttemptedRef.current = true;
    }

    return () => {
      isMounted = false;
      clearTimeout(timeoutId);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [username, status]);

  const hasPermission = useCallback((path: string): boolean => {
    // En producción y cuando no hay permisos, permitir acceso
    if (!permissions.length) {
      console.log(`[usePermissions] No permissions available for path: ${path}`);
      
      // Si estamos en producción o hubo un intento de carga que falló, permitir acceso
      if (process.env.NODE_ENV === 'production' || (fetchAttemptedRef.current && error)) {
        console.log('[usePermissions] Production or fetch error - allowing access');
        return true;
      }
      
      // Si aún estamos cargando, no definir respuesta definitiva
      if (loading && !fetchAttemptedRef.current) {
        console.log('[usePermissions] Still loading permissions - default access');
        return true;
      }
    }
    
    // Normalizar el path para comparación
    const normalizedPath = path.startsWith('/') ? path : `/${path}`;
    
    const hasAccess = permissions.some(permission => {
      const permissionPath = permission.url.startsWith('/') ? permission.url : `/${permission.url}`;
      return permissionPath === normalizedPath;
    });
    
    console.log(`[usePermissions] Path: ${path}, Access: ${hasAccess}`);
    return hasAccess;
  }, [permissions, loading, error]);

  const canAccessRoute = useCallback((path: string): boolean => {
    // Rutas públicas que no requieren permisos
    const publicRoutes = ['/', '/login', '/dashboard'];
    
    if (publicRoutes.includes(path)) {
      console.log(`[usePermissions] Public route: ${path}`);
      return true;
    }

    // En producción, si hubo error al cargar permisos, permitir acceso a todas las rutas
    if (process.env.NODE_ENV === 'production' && (error || (fetchAttemptedRef.current && !permissions.length))) {
      console.log(`[usePermissions] Production with errors - allowing access to: ${path}`);
      return true;
    }

    const hasAccess = hasPermission(path);
    console.log(`[usePermissions] Checking access for: ${path}, Result: ${hasAccess}`);
    return hasAccess;
  }, [hasPermission, error, permissions]);

  const getPermissionByPath = useCallback((path: string): Permission | undefined => {
    const normalizedPath = path.startsWith('/') ? path : `/${path}`;
    
    return permissions.find(permission => {
      const permissionPath = permission.url.startsWith('/') ? permission.url : `/${permission.url}`;
      return permissionPath === normalizedPath;
    });
  }, [permissions]);

  const refreshPermissions = useCallback(() => {
    if (username) {
      console.log('[usePermissions] Refreshing permissions for:', username);
      fetchAttemptedRef.current = false; // Reset para permitir recarga
      api.permission.get(username)
          .then(perms => {
            console.log('[usePermissions] Refreshed permissions:', perms);
            setPermissions(perms || []);
          fetchAttemptedRef.current = true;
            setError(null);
          })
          .catch(err => {
            console.error('[usePermissions] Error refreshing permissions:', err);
            setError(err?.message || 'Error al actualizar permisos');
          fetchAttemptedRef.current = true;
            
            // En producción, continuar con permisos vacíos
            if (process.env.NODE_ENV === 'production') {
              setPermissions([]);
            }
          });
      }
  }, [username]);

  return {
    permissions,
    loading,
    error,
    hasPermission,
    canAccessRoute,
    getPermissionByPath,
    refreshPermissions
  };
}
