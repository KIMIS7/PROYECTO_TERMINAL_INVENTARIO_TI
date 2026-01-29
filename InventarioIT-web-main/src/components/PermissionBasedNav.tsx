import Link from 'next/link';
import { useRouter } from 'next/router';
import { usePermissions } from '@/hooks/usePermissions';

export default function PermissionBasedNav() {
  const router = useRouter();
  const { permissions, loading } = usePermissions();

  if (loading) {
    return (
      <nav className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <div className="animate-pulse bg-gray-200 h-8 w-32 rounded"></div>
            </div>
            <div className="flex items-center space-x-4">
              <div className="animate-pulse bg-gray-200 h-6 w-20 rounded"></div>
              <div className="animate-pulse bg-gray-200 h-6 w-20 rounded"></div>
            </div>
          </div>
        </div>
      </nav>
    );
  }

  const isActive = (path: string) => {
    return router.pathname === path;
  };

  return (
    <nav className="bg-white shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex items-center">
            <Link 
              href="/dashboard" 
              className={`px-3 py-2 rounded-md text-sm font-medium transition-colors ${
                isActive('/dashboard') 
                  ? 'bg-blue-100 text-blue-700' 
                  : 'text-gray-700 hover:bg-gray-100'
              }`}
            >
              Dashboard
            </Link>
            
            {/* Mostrar enlaces solo si el usuario tiene permisos */}
            {permissions.map((permission) => (
              <Link
                key={permission.roldashboardpathID}
                href={permission.url}
                className={`ml-4 px-3 py-2 rounded-md text-sm font-medium transition-colors ${
                  isActive(permission.url)
                    ? 'bg-blue-100 text-blue-700'
                    : 'text-gray-700 hover:bg-gray-100'
                }`}
              >
                {permission.title}
              </Link>
            ))}
          </div>
          
          <div className="flex items-center">
            <span className="text-sm text-gray-500">
              Permisos: {permissions.length}
            </span>
          </div>
        </div>
      </div>
    </nav>
  );
}
