import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class AssetStateService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async findAll() {
    try {
      const states = await this.prismaShopic.assetState.findMany();
      return states.map((s) => ({
        assetStateID: s.AssetStateID,
        name: s.Name,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los estados de activo',
      });
    }
  }
}
