import "@/styles/globals.css";
import { SessionProvider } from "next-auth/react";
import type { AppProps } from "next/app";
import { Toaster } from "@/components/ui/sonner";
import UserVerification from "@/components/UserVerification";

const env = process.env.NODE_ENV as string;
const authBasePath = process.env.NEXT_PUBLIC_AUTH_BASEPATH;

const BASE_URL =
  env === "production"
    ? authBasePath || "/inventarioit/api/auth"
    : env === "staging"
    ? authBasePath || "/inventarioit-staging/api/auth"
    : "/inventarioit-staging/api/auth";

// Configuración en tiempo de ejecución para ser accesible en el cliente
function getRuntimeConfig() {
  return {
    appVersion: process.env.NEXT_PUBLIC_APP_VERSION || 'v0.0.0',
  };
}

export default function App({ Component, pageProps }: AppProps) {
  const { session, ...rest } = pageProps;

  // Inyectar la configuración en tiempo de ejecución en pageProps
  const pagePropsWithConfig = {
    ...rest,
    runtimeConfig: getRuntimeConfig(),
    appVersion: process.env.NEXT_PUBLIC_APP_VERSION || 'v0.0.0',
  };

  return (
    <SessionProvider session={session} basePath={BASE_URL}>
      <UserVerification>
        <Component {...pagePropsWithConfig}/>
      </UserVerification>
      <Toaster />
    </SessionProvider>
  );
}
