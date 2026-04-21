import {
  ForbiddenException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { CreatePermissionDto } from './dto/create-permission.dto';
import { UpdatePermissionDto } from './dto/update-permission.dto';
import { PrismaShopic } from 'src/database/database.service';
import { plainToInstance } from 'class-transformer';
import { PermissionDto } from './dto/permission.dto';

@Injectable()
export class PermissionService {
  constructor(private readonly prismaShopic: PrismaShopic) {}
  async create(createPermissionDto: CreatePermissionDto) {
    try {
      // Verificar si el rol existe
      const roleExists = await this.prismaShopic.rol.findUnique({
        where: { rolID: createPermissionDto.rolID },
      });

      if (!roleExists) {
        throw new NotFoundException('Rol no encontrado');
      }

      // Verificar si la ruta existe
      const pathExists = await this.prismaShopic.dashboard_paths.findUnique({
        where: { dashboarpathID: createPermissionDto.dashboarpathID },
      });

      if (!pathExists) {
        throw new NotFoundException('Ruta no encontrada');
      }

      // Verificar si el permiso ya existe
      const existingPermission =
        await this.prismaShopic.rol_dashboard_path.findFirst({
          where: {
            rolID: createPermissionDto.rolID,
            dashboarpathID: createPermissionDto.dashboarpathID,
          },
        });

      if (existingPermission) {
        throw new Error('Este permiso ya está asignado al rol');
      }

      // Crear el permiso
      const permission = await this.prismaShopic.rol_dashboard_path.create({
        data: {
          rolID: createPermissionDto.rolID,
          dashboarpathID: createPermissionDto.dashboarpathID,
        },
        include: {
          rol: true,
          dashboard_paths: true,
        },
      });

      return {
        success: true,
        message: 'Permiso asignado exitosamente',
        data: permission,
      };
    } catch (error) {
      if (error instanceof NotFoundException) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el permiso',
      });
    }
  }

  async findAll() {
    try {
      const permissions = await this.prismaShopic.rol_dashboard_path.findMany({
        include: {
          rol: {
            select: {
              rolID: true,
              name: true,
            },
          },
          dashboard_paths: {
            select: {
              dashboarpathID: true,
              path: true,
              name: true,
              icon: true,
            },
          },
        },
      });

      // Transformar los datos para el frontend
      const transformedPermissions = permissions.map((permission) => ({
        roldashboardpathID: permission.roldashboardpathID,
        rolID: permission.rolID,
        dashboarpathID: permission.dashboarpathID,
        roleName: permission.rol.name,
        pathName: permission.dashboard_paths.name,
        path: permission.dashboard_paths.path,
        icon: permission.dashboard_paths.icon,
      }));

      return transformedPermissions;
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los permisos',
      });
    }
  }

  async findOne(useremail: string) {
    const userExists = await this.prismaShopic.user.findFirst({
      where: {
        Email: useremail,
      },
    });

    if (!userExists) {
      throw new NotFoundException('Usuario no encontrado');
    }

    try {
      const paths = await this.prismaShopic.rol_dashboard_path.findMany({
        where: {
          rolID: userExists.rolD as number,
        },
        include: {
          dashboard_paths: true,
        },
      });

      return plainToInstance(PermissionDto, paths, {
        excludeExtraneousValues: true,
      });
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los paths',
      });
    }
  }

  update(id: number, updatePermissionDto: UpdatePermissionDto) {
    return `This action updates a #${id} permission`;
  }

  async remove(id: number) {
    try {
      // Verificar si el permiso existe e incluir el rol para validar admin
      const permissionExists =
        await this.prismaShopic.rol_dashboard_path.findUnique({
          where: { roldashboardpathID: id },
          include: {
            rol: { select: { name: true } },
          },
        });

      if (!permissionExists) {
        throw new NotFoundException('Permiso no encontrado');
      }

      // Los permisos del rol Administrador estan bloqueados por seguridad
      const roleName = permissionExists.rol?.name?.trim().toLowerCase();
      if (roleName === 'administrador' || roleName === 'admin') {
        throw new ForbiddenException(
          'Los permisos del rol Administrador no pueden eliminarse',
        );
      }

      // Eliminar el permiso
      await this.prismaShopic.rol_dashboard_path.delete({
        where: { roldashboardpathID: id },
      });

      return {
        success: true,
        message: 'Permiso eliminado exitosamente',
        data: {},
      };
    } catch (error) {
      if (
        error instanceof NotFoundException ||
        error instanceof ForbiddenException
      ) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al eliminar el permiso',
      });
    }
  }
}
