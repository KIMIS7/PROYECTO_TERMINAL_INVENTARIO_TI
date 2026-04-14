import {
  Injectable,
  NestMiddleware,
  UnauthorizedException,
  ForbiddenException,
} from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { PrismaShopic } from '../database/database.service';

@Injectable()
export class SimpleAuthMiddleware implements NestMiddleware {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async use(req: Request, res: Response, next: NextFunction) {
    try {
      const userEmail = req.headers['user-email'] as string;

      if (!userEmail) {
        throw new UnauthorizedException({
          success: false,
          message:
            'Header "user-email" es requerido para acceder a este recurso',
        });
      }

      // Verificar si el usuario existe en la base de datos
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
        console.log(`Usuario no encontrado o inactivo en BD: ${userEmail}`);
        throw new ForbiddenException({
          success: false,
          message:
            'Usuario no registrado o inactivo. Acceso denegado.',
        });
      }

      // Agregar información del usuario a la request
      (req as any).user = {
        UserID: user.UserID,
        Email: user.Email,
        Name: user.Name,
        rolD: user.rolD,
        rolName: user.rol?.name,
        isActive: user.isActive,
      };

      next();
    } catch (error) {
      if (
        error instanceof UnauthorizedException ||
        error instanceof ForbiddenException
      ) {
        return next(error);
      }
      console.error('Error en SimpleAuthMiddleware:', error);
      return next(
        new UnauthorizedException({
          success: false,
          message: 'Error validando credenciales',
        }),
      );
    }
  }
}
