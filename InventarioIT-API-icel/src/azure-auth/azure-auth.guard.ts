import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
} from '@nestjs/common';
import * as jwt from 'jsonwebtoken';
import axios from 'axios';
import { Reflector } from '@nestjs/core';
import { IS_PUBLIC_KEY } from '../auth/public.decorator';
import { PrismaShopic } from '../database/database.service';

@Injectable()
export class AzureAuthGuard implements CanActivate {
  private cachedKeys: any[] = [];
  private keysCachedAt = 0;
  private readonly KEYS_TTL_MS = 60 * 60 * 1000; // 1 hora

  constructor(
    private reflector: Reflector,
    private readonly prismaShopic: PrismaShopic,
  ) {}

  private readonly azureIssuer = `https://login.microsoftonline.com/${process.env.TENANT_ID}/v2.0`;

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // Verificar si la ruta está marcada como @Public()
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (isPublic) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const token = request.headers['authorization']?.split(' ')[1];

    if (!token) {
      throw new UnauthorizedException(
        'Token no proporcionado. Inicia sesión para acceder.',
      );
    }

    try {
      // 1. Verificar el JWT de Azure AD
      const decodedToken: any = jwt.decode(token, { complete: true });

      if (!decodedToken) {
        throw new UnauthorizedException('Token malformado');
      }

      const kid = decodedToken?.header?.kid;

      // Obtener claves públicas de Azure AD (con caché)
      const keys = await this.getAzurePublicKeys();
      const publicKey = keys.find((key: any) => key.kid === kid);

      if (!publicKey) {
        throw new UnauthorizedException('Clave pública no encontrada');
      }

      // Construir la clave pública en formato PEM
      const rsaPublicKey = `-----BEGIN CERTIFICATE-----\n${publicKey.x5c[0]}\n-----END CERTIFICATE-----`;

      // Verificar el token
      jwt.verify(token, rsaPublicKey, {
        algorithms: ['RS256'],
        issuer: this.azureIssuer,
      });

      // 2. Verificar que el usuario existe y está activo en la BD
      const userEmail = request.headers['user-email'] as string;

      if (!userEmail) {
        throw new UnauthorizedException(
          'Header user-email es requerido',
        );
      }

      const user = await this.prismaShopic.user.findFirst({
        where: {
          Email: userEmail.toLowerCase(),
          isActive: true,
        },
        include: {
          rol: true,
        },
      });

      if (!user) {
        throw new UnauthorizedException(
          'Usuario no autorizado. Contacta al administrador.',
        );
      }

      // 3. Adjuntar la información del usuario al request
      (request as any).user = {
        UserID: user.UserID,
        Email: user.Email,
        Name: user.Name,
        rolD: user.rolD,
        rolName: user.rol?.name,
        isActive: user.isActive,
      };

      return true;
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }
      throw new UnauthorizedException('Token inválido o expirado');
    }
  }

  private async getAzurePublicKeys(): Promise<any[]> {
    const now = Date.now();
    if (this.cachedKeys.length > 0 && now - this.keysCachedAt < this.KEYS_TTL_MS) {
      return this.cachedKeys;
    }

    const { data } = await axios.get(
      `https://login.microsoftonline.com/common/discovery/keys`,
    );
    this.cachedKeys = data.keys;
    this.keysCachedAt = now;
    return this.cachedKeys;
  }
}