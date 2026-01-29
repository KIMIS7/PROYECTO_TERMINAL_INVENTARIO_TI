import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { ValidateTokenAuthDto } from './dto/validate-token-auth.dto';
//import axios from 'axios';
import { userAuthDto } from './dto/user-auth';
import { PrismaShopic } from 'src/database/database.service';
//import { stringify } from 'querystring';

@Injectable()
export class AuthService {
  constructor(private readonly prismaShopic: PrismaShopic) {}
  async add(useremail: string, user: userAuthDto) {
    try {
      console.log({
          Message: `Tarea de actualización del token ${user.application} para el usuario ${useremail}`,
      });
        
      if (!useremail || !user.id_token) {
        throw new UnauthorizedException({
          message: 'Email o token no proporcionados',
        });
      }
      if (!user.application) {
        throw new UnauthorizedException({
          message: 'Falta el origen de la solicitud',
        });
      }
      const existingUser = await this.prismaShopic.user.findFirst({
        where: {
          Email: useremail,
        },
      });
      if (!existingUser) {
        throw new UnauthorizedException({
          message: 'No tienes acceso a la aplicación',
        });
      }

      const now2 = new Date();
      const fechaHora2 = now2.toLocaleString(); // Ejemplo: "30/6/2025, 9:35:12"
      console.log(`${fechaHora2}  Ejecutando SET TOKEN con email:`, useremail);

        await this.prismaShopic.user.update({
          where: {
            UserID: existingUser.UserID,
          },
          data: {
            token: user.id_token,
          },
        });

      //const now = new Date();
      //const fechaHora = now.toLocaleString(); // Ejemplo: "30/6/2025, 9:35:12"
      //console.log(`${fechaHora}  TERMINANDO SET TOKEN con email:`, user);
      console.log({
         TypeLog: 'SUCCESS',
          OperationType: 'FINISH_UPDATE_USER_TOKEN',
          Message: `Tarea de actualización del token para el usuario finalizada`,
      })
      /*await this.prismaShopic.traqueo_log.create({
        data: {
          TypeLog: 'SUCCESS',
          OperationType: 'FINISH_UPDATE_USER_TOKEN',
          Message: `Tarea de actualización del token para el usuario finalizada`,
        },
      });*/
      return {
        success: true,
        message: 'Token agregado correctamente',
      };
    } catch (error) {
      console.log({
         TypeLog: 'ERROR',
          OperationType: 'FAILED UPDATE USER TOKEN',
          Message: error?.message || 'Error al actualizar el token del usuario',
      })
      /*await this.prismaShopic.traqueo_log.create({
        data: {
          TypeLog: 'ERROR',
          OperationType: 'FAILED UPDATE USER TOKEN',
          Message: error?.message || 'Error al actualizar el token del usuario',
        },
      });*/
      throw new InternalServerErrorException({
        success: false,
        message: error.message || 'Error al agregar el token',
      });
    }
  }

  async validateToken(user: ValidateTokenAuthDto) {
    try {
      const userRecord = await this.prismaShopic.user.findFirst({
        where: { Email: user.email },
      });

      if (!userRecord) {
        throw new NotFoundException('Usuario no encontrado');
      }

      // Prioritize web token, but fall back to mobile token
      const tokenToValidate = userRecord.token;

      if (!tokenToValidate) {
        throw new NotFoundException('Token no encontrado para el usuario');
      }

      if (user.token !== tokenToValidate) {
        throw new UnauthorizedException('Token no coincide con el almacenado');
      }

      return {
        access_token: tokenToValidate,
      };
    } catch (error) {
      console.error('Error al validar el token:', error);
      throw new UnauthorizedException(error.message);
    }
  }
}