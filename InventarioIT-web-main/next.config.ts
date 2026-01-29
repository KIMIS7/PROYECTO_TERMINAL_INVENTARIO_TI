import type { NextConfig } from "next";
import { loadEnvConfig } from "@next/env";

loadEnvConfig(".");

const env = process.env.NODE_ENV;
const basePath = process.env.NEXT_BASE_PATH;
const nextPublicApi = process.env.NEXT_PUBLIC_API;

const nextConfig: NextConfig = {
  reactStrictMode: true,
  basePath: env === "production" ? basePath : "/inventarioit-staging",
  output: 'standalone',
  env: {
    NEXT_PUBLIC_API: nextPublicApi,
  },
};

export default nextConfig;
