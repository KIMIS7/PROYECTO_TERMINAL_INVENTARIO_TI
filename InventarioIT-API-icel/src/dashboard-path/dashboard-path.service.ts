import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
  OnModuleInit,
} from '@nestjs/common';
import { CreateDashboardPathDto } from './dto/create-dashboard-path.dto';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class DashboardPathService implements OnModuleInit {
  private readonly logger = new Logger(DashboardPathService.name);

  constructor(private readonly prismaShopic: PrismaShopic) {}

  async onModuleInit() {
    await this.seedRequiredPaths();
  }

  private async seedRequiredPaths() {
    const requiredPaths = [
      { path: '/movimientos', name: 'Movimientos' },
    ];

    for (const requiredPath of requiredPaths) {
      try {
        const exists = await this.prismaShopic.dashboard_paths.findUnique({
          where: { path: requiredPath.path },
        });

        if (!exists) {
          await this.prismaShopic.dashboard_paths.create({
            data: {
              path: requiredPath.path,
              name: requiredPath.name,
            },
          });
          this.logger.log(
            `Ruta "${requiredPath.name}" (${requiredPath.path}) creada automáticamente`,
          );
        }
      } catch (error) {
        this.logger.warn(
          `No se pudo crear la ruta "${requiredPath.path}": ${error.message}`,
        );
      }
    }
  }

  async create(createDashboardPathDto: CreateDashboardPathDto) {
    // Verificar si ya existe un path con la misma ruta
    const existingPath = await this.prismaShopic.dashboard_paths.findUnique({
      where: { path: createDashboardPathDto.path },
    });

    if (existingPath) {
      throw new ConflictException('Ya existe un módulo con esa ruta');
    }

    try {
      const newPath = await this.prismaShopic.dashboard_paths.create({
        data: {
          path: createDashboardPathDto.path,
          name: createDashboardPathDto.name,
        },
        select: {
          dashboarpathID: true,
          path: true,
          name: true,
          icon: true,
        },
      });

      return {
        success: true,
        message: 'Módulo creado exitosamente',
        data: newPath,
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el módulo',
      });
    }
  }

  async findAll() {
    try {
      const paths = await this.prismaShopic.dashboard_paths.findMany({
        select: {
          dashboarpathID: true,
          path: true,
          name: true,
          icon: true,
        },
        orderBy: {
          name: 'asc',
        },
      });

      return paths;
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener las rutas del dashboard',
      });
    }
  }

  async updateIcon(dashboarpathID: number, icon: string) {
    const pathExists = await this.prismaShopic.dashboard_paths.findUnique({
      where: { dashboarpathID },
    });

    if (!pathExists) {
      throw new NotFoundException('La ruta del dashboard no existe');
    }

    try {
      const updatedPath = await this.prismaShopic.dashboard_paths.update({
        where: { dashboarpathID },
        data: { icon },
        select: {
          dashboarpathID: true,
          path: true,
          name: true,
          icon: true,
        },
      });

      return {
        message: 'Icono actualizado exitosamente',
        data: updatedPath,
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al actualizar el icono',
      });
    }
  }
}
