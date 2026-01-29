// lib/requireAuthGSSP.ts
import { getSession } from "next-auth/react";
import type { GetServerSideProps, GetServerSidePropsContext } from "next";

export function requireAuthGSSP<
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  P extends { [key: string]: any } = { [key: string]: any }
>(gssp?: GetServerSideProps<P>): GetServerSideProps<P> {
  return async (ctx: GetServerSidePropsContext) => {
    const session = await getSession(ctx);

    if (!session) {
      // vuelve al login y preserva la URL objetivo
      const dest = `/?callbackUrl=${encodeURIComponent(ctx.resolvedUrl)}`;
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      return { redirect: { destination: dest, permanent: false } } as any;
    }

    // Si quieres pasar props adicionales, deja un gssp opcional
    if (gssp) return gssp(ctx);
    return { props: {} as P };
  };
}
