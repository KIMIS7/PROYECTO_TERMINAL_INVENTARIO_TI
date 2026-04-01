import Image from "next/image";
import logoLogin from "../../public/flujos.png";
import { signIn, useSession } from "next-auth/react";
import { useEffect } from "react";
import { useRouter } from "next/router";

export default function Home() {
  const { data: session, status } = useSession();
  const router = useRouter();
  const basePath = process.env.NEXT_BASE_PATH || "";

  useEffect(() => {
    // Si el usuario ya está autenticado, redirigir al dashboard
    if (session) {
      const dashboardPath = basePath ? `${basePath}/dashboard` : "/dashboard";
      console.log(`[Home] User is authenticated, redirecting to: ${dashboardPath}`);
      router.push(dashboardPath);
    }
  }, [session, router, basePath]);

  const skipAuth = process.env.NEXT_PUBLIC_SKIP_AUTH === "true";

  // Auto-login en modo dev bypass
  useEffect(() => {
    if (skipAuth && !session && status !== "loading") {
      const dashboardPath = basePath ? `${basePath}/dashboard` : "/dashboard";
      signIn("dev-credentials", { username: "dev@localhost", callbackUrl: dashboardPath });
    }
  }, [skipAuth, session, status, basePath]);

  // Maneja el inicio de sesión teniendo en cuenta el basePath
  const handleSignIn = () => {
    const dashboardPath = basePath ? `${basePath}/dashboard` : "/dashboard";
    console.log(`[Home] Signing in with callbackUrl: ${dashboardPath}`);
    if (skipAuth) {
      signIn("dev-credentials", { username: "dev@localhost", callbackUrl: dashboardPath });
    } else {
      signIn("azure-ad", { callbackUrl: dashboardPath });
    }
  };

  // Si estamos verificando la sesión, mostrar un indicador de carga
  if (status === "loading") {
    return (
      <div className="h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  // Si no hay sesión, mostrar la página de login
  return (
    <div>
      <div className="h-screen flex flex-col justify-center px-0 select-none">
        <Image
          src={logoLogin}
          alt="HotelShops"
          fill
          style={{
            zIndex: -1,
            objectFit: "contain",
            objectPosition: "right",
          }}
        />
        <div className="w-full md:w-1/2 lg:w-2/6 h-full bg-white p-8 flex flex-col justify-center items-center gap-8 rounded-lg md:rounded-l-none shadow-sm">
          <h1 className="text-xl font-bold text-gray-700">Flujos</h1>
          <h6 className="text-sm font-semibold text-gray-600 -mt-6">V{process.env.NEXT_PUBLIC_APP_VERSION || "0.0.0"}</h6>
          <button
            className="flex w-full items-center justify-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
            onClick={handleSignIn}
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="20"
              height="20"
              viewBox="0 0 23 23"
            >
              <path fill="#f35325" d="M1 1h10v10H1z" />
              <path fill="#81bc06" d="M12 1h10v10H12z" />
              <path fill="#05a6f0" d="M1 12h10v10H1z" />
              <path fill="#ffba08" d="M12 12h10v10H12z" />
            </svg>
            <span>Sign in with Microsoft</span>
          </button>
        </div>
      </div>
    </div>
  );
}
