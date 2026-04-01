import NextAuth, { type NextAuthOptions } from "next-auth";
import AzureADProvider from "next-auth/providers/azure-ad";
import CredentialsProvider from "next-auth/providers/credentials";

const env = process.env.NODE_ENV;
const nextBasePath = process.env.NEXT_BASE_PATH;
const basePath = env === "production" ? nextBasePath || "/inventarioit" : nextBasePath || "";
const skipAuth = process.env.SKIP_AUTH === "true";

// Dev-only credentials provider to bypass Azure AD when SKIP_AUTH=true
const devProvider = CredentialsProvider({
  id: "dev-credentials",
  name: "Dev Login",
  credentials: {
    username: { label: "Email", type: "text", placeholder: "dev@localhost" },
  },
  async authorize(credentials) {
    if (!skipAuth) return null;
    return {
      id: "dev-user-id",
      name: "Dev User",
      email: credentials?.username || "dev@localhost",
      preferred_username: credentials?.username || "dev@localhost",
    };
  },
});

const azureProvider = AzureADProvider({
  clientId: process.env.AZURE_AD_CLIENT_ID as string,
  clientSecret: process.env.AZURE_AD_CLIENT_SECRET as string,
  tenantId: process.env.AZURE_AD_TENANT_ID as string,
  authorization: {
    params: {
      scope: "openid email profile User.Read",
    },
  },
});

const providers = skipAuth ? [devProvider] : [azureProvider];

export const authOptions: NextAuthOptions = {
  providers,
  debug: process.env.NODE_ENV === "development",
  session: {
    strategy: "jwt",
    maxAge: 24 * 60 * 60, // 1 day
    updateAge: 60 * 60, // 1 hour
  },
  pages: {
    signIn: basePath || "/inventarioit",
  },
  callbacks: {
    async redirect({ url, baseUrl }) {
      try {
        const target = new URL(url);
        // si la redirección es interna, úsala; si no, manda al dashboard
        if (target.origin === baseUrl) {
          return target.pathname === "/" ? `${baseUrl}${basePath}/dashboard` : url;
        }
      } catch {
        // url relativa
        if (url.startsWith("/")) {
          return url === "/" ? `${baseUrl}${basePath}/dashboard` : `${baseUrl}${basePath}${url}`;
        }
      }
      return `${baseUrl}${basePath}/dashboard`;
    },
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    async signIn({ user, account, profile, email, credentials }: any) {
      const isAllowedToSignIn = true;
      if (isAllowedToSignIn) {
        return true;
      } else {
        return false;
      }
    },
    async jwt({ token, account, profile, user }: any) {
      // Dev bypass: populate token from credentials user
      if (skipAuth && user) {
        token.sub = user.id;
        token.name = user.name;
        token.preferred_username = user.preferred_username || user.email;
        token.id_token = "dev-token";
        return token;
      }

      if (profile?.oid) token.sub = profile.oid as string;

      if (profile?.name) token.name = profile.name as string;
      if ((profile as any)?.picture) token.image = (profile as any).picture;

      if ((profile as any)?.preferred_username) {
        token.preferred_username = (profile as any).preferred_username;
      }

      if (account?.id_token) {
        token.id_token = account.id_token;
      }

      // ❌ No guardes access_token / refresh_token / expires_at
      delete (token as any).access_token;
      delete (token as any).refresh_token;
      delete (token as any).expires_at;

      /*try {
        await api.auth.add(token.preferred_username, {
          id_token: token.id_token,
          application: "web",
        });
      } catch (error) {
        console.error("Error adding auth token:", error);
      }*/

      return token;
    },
    async session({ session, token }: any) {
      session.user.id = token.sub as string;
      session.user.id_token = token?.id_token as string;

      session.user.preferred_username = token.preferred_username as string;

      // Limpia restos
      delete (session as any).error;

      return session;
    },
  },
  /*     cookies: {
        sessionToken: {
            name: `__Secure-next-auth.session-token`,
            options: {
                httpOnly: true,
                sameSite: "lax",
                secure: process.env.NODE_ENV === "production" ? true : false,
                path: `${process.env.NEXT_PUBLIC_REDIRECT_URL}`,
                domain: '',
            },
        }
    }, */
  events: {},
};

export default NextAuth(authOptions);
