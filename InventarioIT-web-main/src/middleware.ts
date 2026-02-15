import { getToken } from "next-auth/jwt";
import { NextResponse } from "next/server";

export async function middleware(req: any) {
    const token = await getToken({ req, secret: process.env.NEXTAUTH_SECRET });
    if (
        !token /*|| (token.expires_at && Date.now() / 1000 > Number(token.expires_at))*/
    ) {
        return NextResponse.redirect(
            new URL(`${process.env.NEXT_PUBLIC_REDIRECT_URL}`, req.url)
        );
    }



    return NextResponse.next();
}
export const config = {
    matcher: [
        "/dashboard/:path*",
        "/roles/:path*",
        "/usuarios/:path*",
        "/permisos/:path*",
        "/puertos-origen/:path*",
        "/movimientos/:path*",
    ],
};