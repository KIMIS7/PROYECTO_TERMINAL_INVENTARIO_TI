import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
} from '@nestjs/common';
import * as jwt from 'jsonwebtoken';
import axios from 'axios';
//import { SkipAuth } from './skip-auth.decorator';
import { Reflector } from '@nestjs/core';

@Injectable()
export class AzureAuthGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  private readonly azureIssuer = `https://login.microsoftonline.com/${process.env.TENANT_ID}/v2.0`;

  async canActivate(context: ExecutionContext): Promise<boolean> {
    /*const isSkipAuth = this.reflector.get<boolean>(
      'skipAuth',
      context.getHandler(),
    );
    if (isSkipAuth) {
      return true;
    }*/

    const request = context.switchToHttp().getRequest();
    const token = request.headers['authorization']?.split(' ')[1];

    if (!token) {
      throw new UnauthorizedException(
        'Token no proporcionado o Token expirado',
      );
    }

    try {
      const decodedToken: any = jwt.decode(token, { complete: true });
      const kid = decodedToken?.header?.kid;

      // Obtén las claves públicas de Azure AD
      const { data } = await axios.get(
        `https://login.microsoftonline.com/common/discovery/keys`,
      );
      const publicKey = data.keys.find((key) => key.kid === kid);

      if (!publicKey) {
        throw new UnauthorizedException('Clave pública no encontrada');
      }

      // Construye la clave pública en formato PEM
      const rsaPublicKey = `-----BEGIN CERTIFICATE-----\n${publicKey.x5c[0]}\n-----END CERTIFICATE-----`;

      // Verifica el token
      jwt.verify(token, rsaPublicKey, {
        algorithms: ['RS256'],
        issuer: this.azureIssuer /*ignoreExpiration: true*/,
      });

      return true;
    } catch (error) {
      throw new UnauthorizedException('Token inválido o expirado');
    }
  }
}