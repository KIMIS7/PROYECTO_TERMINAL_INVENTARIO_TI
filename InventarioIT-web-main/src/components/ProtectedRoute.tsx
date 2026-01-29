import { useRouter } from 'next/router';
import { usePermissions } from '@/hooks/usePermissions';
import { useSession } from 'next-auth/react';
import { useEffect, useState } from 'react';

interface ProtectedRouteProps {
  children: React.ReactNode;
  fallback?: React.ReactNode;
}

export default function ProtectedRoute({ children, fallback }: ProtectedRouteProps) {
  const router = useRouter();
  const { data: session, status } = useSession();
  const { canAccessRoute, loading: permissionsLoading } = usePermissions();
  const [isAuthorized, setIsAuthorized] = useState(false);
  const [isChecking, setIsChecking] = useState(true);

  // Usar solo el username en lugar del objeto session completo para evitar ciclos
  const username = session?.user?.preferred_username;

  useEffect(() => {
    const checkAccess = () => {
      if (status === 'loading' || permissionsLoading) {
        return;
      }

      if (!username || status === 'unauthenticated') {
        // No hay sesión, redirigir al login
        router.push('/');
        return;
      }

      const currentPath = router.pathname;
      const hasAccess = canAccessRoute(currentPath);

      if (hasAccess) {
        setIsAuthorized(true);
      } else {
        // No tiene permisos para esta ruta
        console.warn(`Acceso denegado a: ${currentPath}`);
        router.push('/dashboard');
      }

      setIsChecking(false);
    };

    checkAccess();
  }, [username, status, permissionsLoading, canAccessRoute, router.pathname]);

  // Mostrar loading mientras se verifica
  if (status === 'loading' || permissionsLoading || isChecking) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Verificando permisos...</p>
        </div>
      </div>
    );
  }

  // Si no está autorizado, mostrar fallback o redirigir
  if (!isAuthorized) {
    if (fallback) {
      return <>{fallback}</>;
    }
    
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="text-red-600 text-6xl mb-4">🚫</div>
          <h1 className="text-2xl font-bold text-gray-800 mb-2">Acceso Denegado</h1>
          <p className="text-gray-600 mb-4">
            No tienes permisos para acceder a esta página.
          </p>
          <button
            onClick={() => router.push('/dashboard')}
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            Volver al Dashboard
          </button>
        </div>
      </div>
    );
  }

  // Si está autorizado, mostrar el contenido
  return <>{children}</>;
}
