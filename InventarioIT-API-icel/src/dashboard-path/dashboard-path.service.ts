import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class DashboardPathService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

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
}
