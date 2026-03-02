import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaShopic } from 'src/database/database.service';
import { plainToInstance } from 'class-transformer';
import { UserDto } from './dto/user.dto';

@Injectable()
export class UserService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async create(createUserDto: CreateUserDto) {
    const { Email, FirstName, LastName, DepartmentID, SiteID, rolD } =
      createUserDto;

    if (!Email) throw new NotFoundException('El email es requerido');
    if (!FirstName) throw new NotFoundException('El nombre es requerido');
    if (!LastName) throw new NotFoundException('El apellido es requerido');
    if (!rolD) throw new NotFoundException('El rol es requerido');

    const rolExists = await this.prismaShopic.rol.findUnique({
      where: { rolID: rolD },
    });

    if (!rolExists) throw new NotFoundException('El rol enviado no existe');

    const emailExists = await this.prismaShopic.user.findFirst({
      where: { Email: Email.toLowerCase() },
    });

    if (emailExists) throw new ConflictException('El email enviado ya existe');

    try {
      const user = await this.prismaShopic.user.create({
        data: {
          Name: `${FirstName} ${LastName}`,
          Email,
          FirstName,
          LastName,
          DepartmentID,
          SiteID,
          rolD,
          isActive: true,
          token: '',
          createdAt: new Date(),
        },
        include: {
          rol: true,
          Depart: true,
        },
      });

      return {
        message: 'Usuario creado exitosamente',
        data: plainToInstance(UserDto, user, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el usuario',
      });
    }
  }

  async findAll() {
    try {
      const users = await this.prismaShopic.user.findMany({
        include: {
          rol: true,
          Depart: true,
        },
      });

      return plainToInstance(UserDto, users, {
        excludeExtraneousValues: true,
      });
    } catch (error) {
      console.error('Error en findAll (con Depart):', error);
      // Si falla con Depart, intentar sin la relacion
      try {
        const users = await this.prismaShopic.user.findMany({
          include: {
            rol: true,
          },
        });
        return plainToInstance(UserDto, users, {
          excludeExtraneousValues: true,
        });
      } catch (fallbackError) {
        throw new InternalServerErrorException({
          message: fallbackError.message || 'Error al obtener los usuarios',
        });
      }
    }
  }

  async findOne(userID: number) {
    const user = await this.prismaShopic.user.findUnique({
      where: { UserID: userID },
      include: {
        rol: true,
        Depart: true,
      },
    });
    if (!user) throw new NotFoundException('El usuario no existe');
    try {
      return plainToInstance(UserDto, user, {
        excludeExtraneousValues: true,
      });
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener el usuario',
      });
    }
  }

  async update(userID: number, updateUserDto: UpdateUserDto) {
    const { Email, FirstName, LastName, DepartmentID, SiteID, rolD } =
      updateUserDto;

    const userExists = await this.prismaShopic.user.findUnique({
      where: { UserID: userID },
    });

    if (!userExists) throw new NotFoundException('El usuario no existe');

    if (rolD) {
      const rolExists = await this.prismaShopic.rol.findUnique({
        where: { rolID: rolD },
      });

      if (!rolExists) throw new NotFoundException('El rol enviado no existe');
    }

    if (Email) {
      const emailExists = await this.prismaShopic.user.findFirst({
        where: {
          Email: Email.toLowerCase(),
          UserID: { not: userID },
        },
      });

      if (emailExists)
        throw new ConflictException('El email enviado ya existe');
    }

    try {
      const user = await this.prismaShopic.user.update({
        where: { UserID: userID },
        data: {
          ...(FirstName && LastName && { Name: `${FirstName} ${LastName}` }),
          ...(Email && { Email: Email.toLowerCase() }),
          ...(FirstName && { FirstName }),
          ...(LastName && { LastName }),
          ...(DepartmentID && { DepartmentID }),
          ...(SiteID && { SiteID }),
          ...(rolD && { rolD }),
        },
        include: {
          rol: true,
          Depart: true,
        },
      });

      return {
        message: 'Usuario actualizado exitosamente',
        data: plainToInstance(UserDto, user, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al actualizar el usuario',
      });
    }
  }

  async updateStatus(userID: number, isActive: boolean) {
    const userExists = await this.prismaShopic.user.findUnique({
      where: { UserID: userID },
    });

    if (!userExists) throw new NotFoundException('El usuario no existe');

    try {
      const user = await this.prismaShopic.user.update({
        where: { UserID: userID },
        data: { isActive },
        include: {
          rol: true,
          Depart: true,
        },
      });

      return {
        message: `Usuario ${isActive ? 'habilitado' : 'deshabilitado'} exitosamente`,
        data: plainToInstance(UserDto, user, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al cambiar el estado del usuario',
      });
    }
  }

  async verifyUser(email: string) {
    try {
      const user = await this.prismaShopic.user.findFirst({
        where: {
          Email: email.toLowerCase(),
        },
        include: {
          rol: {
            include: {
              rol_dashboard_path: true, // Include permissions
            },
          },
        },
      });

      // Check if user exists
      if (!user) {
        return {
          success: false,
          message: 'Usuario no encontrado en el sistema. Contacte al administrador.',
          errorType: 'USER_NOT_FOUND',
          data: null,
        };
      }

      // Check if user is active
      if (!user.isActive) {
        return {
          success: false,
          message: 'Usuario inactivo. Contacte al administrador.',
          errorType: 'USER_INACTIVE',
          data: null,
        };
      }

      // Check if user has a role assigned
      if (!user.rolD) {
        return {
          success: false,
          message: 'Usuario sin rol asignado. Contacte al administrador para configurar sus permisos.',
          errorType: 'NO_ROLE_ASSIGNED',
          data: null,
        };
      }

      // Check if role exists and is active
      if (!user.rol) {
        return {
          success: false,
          message: 'Rol no encontrado en el sistema. Contacte al administrador.',
          errorType: 'ROLE_NOT_FOUND',
          data: null,
        };
      }

      if (!user.rol.isActive) {
        return {
          success: false,
          message: 'Rol inactivo. Contacte al administrador.',
          errorType: 'ROLE_INACTIVE',
          data: null,
        };
      }

      // Check if user has permissions (rol_dashboard_path entries)
      if (!user.rol.rol_dashboard_path || user.rol.rol_dashboard_path.length === 0) {
        return {
          success: false,
          message: 'Usuario sin permisos configurados. Contacte al administrador para asignar accesos.',
          errorType: 'NO_PERMISSIONS',
          data: null,
        };
      }

      // Return success with user data
      return {
        success: true,
        message: 'Usuario verificado exitosamente',
        data: {
          UserID: user.UserID,
          Email: user.Email,
          Name: user.Name,
          rolD: user.rolD,
          rolName: user.rol?.name,
          isActive: user.isActive,
        },
      };
    } catch (error) {
      return {
        success: false,
        message: 'Error al verificar el usuario',
        errorType: 'SYSTEM_ERROR',
        data: null,
      };
    }
  }

  async remove(userID: number) {
    const userExists = await this.prismaShopic.user.findUnique({
      where: { UserID: userID },
    });

    if (!userExists) throw new NotFoundException('El usuario no existe');

    try {
      const user = await this.prismaShopic.user.delete({
        where: { UserID: userID },
      });

      return {
        message: 'Usuario eliminado exitosamente',
        data: plainToInstance(UserDto, user, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al eliminar el usuario',
      });
    }
  }

  async getDepartments() {
    try {
      const departments = await this.prismaShopic.depart.findMany({
        orderBy: { Name: 'asc' },
      });
      return departments.map((d) => ({
        departID: d.DepartID,
        name: d.Name,
      }));
    } catch (error) {
      console.error('Error en getDepartments:', error);
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los departamentos',
      });
    }
  }

  async getUserProfile(email: string) {
    try {
      // Now the SP returns a single result set with all information
      const query = `EXEC GetInfoProfileUser @Email = '${email.replace(/'/g, "''")}'`;
      const result = await this.prismaShopic.$queryRawUnsafe(query);

      console.log('Resultado del SP GetInfoProfileUser:', result);

      if (!result || !Array.isArray(result) || result.length === 0) {
        return {
          success: false,
          message: 'No se encontró información del usuario',
          data: {
            userInfo: {
              buyerID: '',
              name: '',
              emailAddress: '',
              approvalPerson: '',
            },
            companies: [],
          },
        };
      }

      // Extract user info from the first row (all rows have the same user info)
      const firstRow = result[0];
      const userInfo = {
        buyerID: firstRow.BuyerID || '',
        name: firstRow.Name || '',
        emailAddress: firstRow.EMailAddress || '',
        approvalPerson: firstRow.ApprovalPerson || '',
      };

      // Extract companies from all rows
      const companies = result.map((row: any) => row.Company).filter(Boolean);

      return {
        success: true,
        message: 'Perfil de usuario obtenido exitosamente',
        data: {
          userInfo,
          companies,
        },
      };
    } catch (error) {
      console.error('Error al obtener perfil de usuario:', error);
      return {
        success: false,
        message: 'Error al obtener el perfil del usuario',
        data: {
          userInfo: {
            buyerID: '',
            name: '',
            emailAddress: '',
            approvalPerson: '',
          },
          companies: [],
        },
      };
    }
  }
}
