import { DefaultSession } from "next-auth";

declare module "next-auth" {
  /**
   * Extiende la interfaz `Session` para añadir tus propiedades personalizadas.
   */
  interface Session {
    user: {
      accessToken?: string;
      id_token?: string;
      preferred_username?: string;
    } & DefaultSession["user"]; // Mantiene las propiedades originales: name, email, image
  }
}