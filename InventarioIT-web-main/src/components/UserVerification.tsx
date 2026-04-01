import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import { signOut } from 'next-auth/react';
import api from '../lib/api';
import { usePermissions } from '@/hooks/usePermissions';

interface UserVerificationProps {
  children: React.ReactNode;
}

const skipAuth = process.env.NEXT_PUBLIC_SKIP_AUTH === "true";

export default function UserVerification({ children }: UserVerificationProps) {
  const { data: session, status } = useSession();
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const { permissions, loading: permissionsLoading, error: permissionsError } = usePermissions();
  const [isVerified, setIsVerified] = useState(skipAuth);
  const [isLoading, setIsLoading] = useState(!skipAuth);
  const [error, setError] = useState<string | null>(null);
  const [timeoutReached, setTimeoutReached] = useState(false);

  // Función para verificar al usuario
  useEffect(() => {
    const verifyUser = async () => {
      if (skipAuth) { setIsVerified(true); setIsLoading(false); return; }
      if (status === 'loading') return;
      
      console.log('[UserVerification] Session status:', status);
      console.log('[UserVerification] User:', session?.user?.preferred_username);

      if (!session?.user?.preferred_username) {
        console.log('[UserVerification] No username found in session');
        setIsLoading(false);
        return;
      }

      try {
        console.log('[UserVerification] Verifying user:', session.user.preferred_username);
        
        const response = await api.user.verify(session.user.preferred_username);
        
        console.log('[UserVerification] API response:', response);
        
        if (response.success) {
          console.log('[UserVerification] User verified:', response.data);
          setIsVerified(true);
        } else {
          // Handle specific error types with custom messages
          let errorMessage = 'Error al verificar usuario';
          
          switch (response.errorType) {
            case 'USER_NOT_FOUND':
              errorMessage = 'Tu cuenta no está registrada en el sistema. Contacta al administrador.';
              break;
            case 'USER_INACTIVE':
              errorMessage = 'Tu cuenta está inactiva. Contacta al administrador.';
              break;
            case 'NO_ROLE_ASSIGNED':
              errorMessage = 'Tu cuenta no tiene un rol asignado. Contacta al administrador para configurar tus permisos.';
              break;
            case 'ROLE_NOT_FOUND':
              errorMessage = 'Tu rol no está correctamente configurado. Contacta al administrador.';
              break;
            case 'ROLE_INACTIVE':
              errorMessage = 'Tu rol está inactivo. Contacta al administrador.';
              break;
            case 'NO_PERMISSIONS':
              errorMessage = 'Tu cuenta no tiene permisos configurados. Contacta al administrador para asignar accesos.';
              break;
            default:
              errorMessage = response.message || 'Error al verificar usuario. Contacta al administrador.';
          }
          
          console.error('[UserVerification] Verification failed:', { errorType: response.errorType, message: errorMessage });
          setError(errorMessage);
          
          // Always block access on verification failure
          alert(errorMessage);
          signOut({ callbackUrl: '/' });
        }
      } catch (error: any) {
        console.error('[UserVerification] Error verifying user:', error);
        const errorMessage = 'Error del sistema al verificar usuario. Contacta al administrador.';
        setError(errorMessage);
        
        // Block access on system error
        alert(errorMessage);
        signOut({ callbackUrl: '/' });
      } finally {
        setIsLoading(false);
      }
    };

    // Solo ejecutar si tenemos un usuario válido y autenticado
    if (session?.user?.preferred_username && status === 'authenticated') {
      verifyUser();
    } else if (status === 'unauthenticated') {
      console.log('[UserVerification] User is not authenticated');
      setIsLoading(false);
    }
  }, [session?.user?.preferred_username, status]);

  // Timeout para evitar que los usuarios se queden bloqueados indefinidamente
  useEffect(() => {
    const timeoutId = setTimeout(() => {
      if ((status === 'loading' || isLoading || permissionsLoading) && !timeoutReached) {
        console.log('[UserVerification] Timeout reached, allowing access to avoid blocking users');
        setTimeoutReached(true);
        setIsLoading(false);
        setIsVerified(true);
      }
    }, 10000); // 10 segundos de timeout

    return () => clearTimeout(timeoutId);
  }, [status, isLoading, permissionsLoading, timeoutReached]);

  // Si hay un timeout, mostrar un mensaje pero permitir continuar
  if (timeoutReached) {
    console.log('[UserVerification] Rendering children after timeout');
    return (
      <>
        {children}
        <div className="fixed bottom-4 right-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 rounded shadow-md max-w-md">
          <div className="flex">
            <div className="flex-shrink-0">
              <svg className="h-5 w-5 text-yellow-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
              </svg>
            </div>
            <div className="ml-3">
              <p className="text-sm">Se ha detectado una respuesta lenta. Algunas funcionalidades podrían estar limitadas.</p>
            </div>
          </div>
        </div>
      </>
    );
  }

  if (status === 'loading' || isLoading || permissionsLoading) {
    console.log('[UserVerification] Loading state. Status:', status, 'IsLoading:', isLoading, 'PermissionsLoading:', permissionsLoading);
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Verificando usuario y permisos...</p>
          {(permissionsLoading && !isLoading) && (
            <p className="text-xs text-gray-400 mt-2">Cargando permisos...</p>
          )}
          {(isLoading && !permissionsLoading) && (
            <p className="text-xs text-gray-400 mt-2">Verificando usuario...</p>
          )}
          {status === 'loading' && (
            <p className="text-xs text-gray-400 mt-2">Cargando sesión...</p>
          )}
        </div>
      </div>
    );
  }

  if (!session) {
    console.log('[UserVerification] No session, rendering children');
    return <>{children}</>;
  }

  if (!isVerified && !timeoutReached) {
    console.log('[UserVerification] User not verified');
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="text-red-600 text-6xl mb-4">⚠️</div>
          <h1 className="text-2xl font-bold text-gray-800 mb-2">Error de verificación</h1>
          <p className="text-red-600 mb-4">
            {error || 'No se pudo verificar tu acceso al sistema.'}
          </p>
          {permissionsError && (
            <p className="text-sm text-red-500 mt-2">{permissionsError}</p>
          )}
          <button
            onClick={() => signOut({ callbackUrl: '/' })}
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            Volver al inicio
          </button>
        </div>
      </div>
    );
  }

  console.log('[UserVerification] User verified or timeout reached, rendering children');
  return <>{children}</>;
}
