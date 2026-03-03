import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { CreateMovementDto, MovementType } from './dto/create-movement.dto';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class MovementService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async create(createMovementDto: CreateMovementDto, userEmail?: string) {
    const { assetID, movementType, description, responsible } = createMovementDto;

    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: assetID },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    try {
      const newStateID = await this.resolveNewState(movementType);

      const descriptionParts: string[] = [];
      descriptionParts.push(description || this.getDefaultDescription(movementType, asset.Name));
      if (responsible) {
        descriptionParts.push(`Responsable: ${responsible}`);
      }
      if (userEmail) {
        descriptionParts.push(`Registrado por: ${userEmail}`);
      }
      const fullDescription = descriptionParts.join(' | ');

      const result = await this.prismaShopic.$transaction(async (tx) => {
        const assetHistory = await tx.assetHistory.create({
          data: {
            AssetID: assetID,
            Operation: movementType,
            Description: fullDescription,
            CreatedTime: new Date(),
          },
        });

        if (newStateID !== null) {
          await tx.asset.update({
            where: { AssetID: assetID },
            data: { AssetState: newStateID },
          });
        }

        return assetHistory;
      });

      return {
        success: true,
        message: `Movimiento de tipo "${movementType}" registrado exitosamente`,
        data: {
          movementID: result.AssetHistoryID,
          assetID: result.AssetID,
          movementType: result.Operation,
        },
      };
    } catch (error) {
      if (error instanceof NotFoundException || error instanceof BadRequestException) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al registrar el movimiento',
      });
    }
  }

  async findByAssetId(assetID: number) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: assetID },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    try {
      const movements = await this.prismaShopic.assetHistory.findMany({
        where: {
          AssetID: assetID,
          Operation: { in: ['ALTA', 'BAJA', 'REASIGNACION', 'PRESTAMO'] },
        },
        orderBy: { CreatedTime: 'desc' },
        include: {
          Asset: {
            select: {
              AssetID: true,
              Name: true,
            },
          },
        },
      });

      return movements.map((m) => this.mapToMovementResponse(m));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener el historial de movimientos',
      });
    }
  }

  async findAll() {
    try {
      const movements = await this.prismaShopic.assetHistory.findMany({
        where: {
          Operation: { in: ['ALTA', 'BAJA', 'REASIGNACION', 'PRESTAMO'] },
        },
        orderBy: { CreatedTime: 'desc' },
        include: {
          Asset: {
            select: {
              AssetID: true,
              Name: true,
            },
          },
        },
      });

      return movements.map((m) => this.mapToMovementResponse(m));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los movimientos',
      });
    }
  }

  private mapToMovementResponse(m: {
    AssetHistoryID: number;
    AssetID: number;
    Operation: string;
    Description: string;
    CreatedTime: Date;
    Asset: { AssetID: number; Name: string };
  }) {
    const { description, responsible, createdBy } = this.parseDescription(m.Description);

    return {
      movementID: m.AssetHistoryID,
      assetID: m.AssetID,
      assetName: m.Asset.Name,
      movementType: m.Operation,
      description,
      responsible,
      createdTime: m.CreatedTime,
      createdBy,
    };
  }

  private parseDescription(fullDescription: string): {
    description: string;
    responsible: string | null;
    createdBy: string | null;
  } {
    const parts = fullDescription.split(' | ');
    let description = parts[0] || fullDescription;
    let responsible: string | null = null;
    let createdBy: string | null = null;

    for (const part of parts.slice(1)) {
      if (part.startsWith('Responsable: ')) {
        responsible = part.replace('Responsable: ', '');
      } else if (part.startsWith('Registrado por: ')) {
        createdBy = part.replace('Registrado por: ', '');
      }
    }

    return { description, responsible, createdBy };
  }

  private async resolveNewState(movementType: MovementType): Promise<number | null> {
    const stateMapping: Record<MovementType, string | null> = {
      ALTA: 'Activo',
      BAJA: 'Inactivo',
      REASIGNACION: null,
      PRESTAMO: null,
    };

    const targetStateName = stateMapping[movementType];
    if (!targetStateName) {
      return null;
    }

    const state = await this.prismaShopic.assetState.findFirst({
      where: {
        Name: {
          contains: targetStateName,
        },
      },
    });

    if (!state) {
      return null;
    }

    return state.AssetStateID;
  }

  private getDefaultDescription(movementType: MovementType, assetName: string): string {
    const descriptions: Record<MovementType, string> = {
      ALTA: `Alta del activo "${assetName}"`,
      BAJA: `Baja del activo "${assetName}"`,
      REASIGNACION: `Reasignacion del activo "${assetName}"`,
      PRESTAMO: `Prestamo del activo "${assetName}"`,
    };
    return descriptions[movementType];
  }
}
