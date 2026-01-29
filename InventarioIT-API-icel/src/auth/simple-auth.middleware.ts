import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { PrismaShopic } from '../database/database.service';

@Injectable()
export class SimpleAuthMiddleware implements NestMiddleware {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async use(req: Request, res: Response, next: NextFunction) {
    try {
      const userEmail = req.headers['user-email'] as string;

      if (userEmail) {
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

        if (user) {
          // Agregar información del usuario a la request si existe
          (req as any).user = {
            UserID: user.UserID,
            Email: user.Email,
            Name: user.Name,
            rolD: user.rolD,
            rolName: user.rol?.name,
            isActive: user.isActive,
          };
        } else {
          // Usuario no encontrado, pero no bloqueamos el acceso
          console.log(`Usuario no encontrado en BD: ${userEmail}`);
        }
      }

      next();
    } catch (error) {
      console.error('Error en SimpleAuthMiddleware:', error);
      next(); // Continuar incluso si hay error
    }
  }
}
