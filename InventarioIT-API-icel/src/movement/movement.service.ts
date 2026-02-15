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

      const result = await this.prismaShopic.$transaction(async (tx) => {
        const movement = await tx.movement.create({
          data: {
            AssetID: assetID,
            MovementType: movementType,
            Description: description || this.getDefaultDescription(movementType, asset.Name),
            Responsible: responsible || null,
            CreatedTime: new Date(),
            CreatedBy: userEmail || null,
          },
        });

        if (newStateID !== null) {
          await tx.asset.update({
            where: { AssetID: assetID },
            data: { AssetState: newStateID },
          });
        }

        await tx.assetHistory.create({
          data: {
            AssetID: assetID,
            Operation: 'MOVEMENT',
            Description: `Movimiento "${movementType}" registrado para activo "${asset.Name}"`,
            CreatedTime: new Date(),
          },
        });

        return movement;
      });

      return {
        success: true,
        message: `Movimiento de tipo "${movementType}" registrado exitosamente`,
        data: {
          movementID: result.MovementID,
          assetID: result.AssetID,
          movementType: result.MovementType,
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
      const movements = await this.prismaShopic.movement.findMany({
        where: { AssetID: assetID },
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

      return movements.map((m) => ({
        movementID: m.MovementID,
        assetID: m.AssetID,
        assetName: m.Asset.Name,
        movementType: m.MovementType,
        description: m.Description,
        responsible: m.Responsible,
        createdTime: m.CreatedTime,
        createdBy: m.CreatedBy,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener el historial de movimientos',
      });
    }
  }

  async findAll() {
    try {
      const movements = await this.prismaShopic.movement.findMany({
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

      return movements.map((m) => ({
        movementID: m.MovementID,
        assetID: m.AssetID,
        assetName: m.Asset.Name,
        movementType: m.MovementType,
        description: m.Description,
        responsible: m.Responsible,
        createdTime: m.CreatedTime,
        createdBy: m.CreatedBy,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los movimientos',
      });
    }
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
      REASIGNACION: `Reasignación del activo "${assetName}"`,
      PRESTAMO: `Préstamo del activo "${assetName}"`,
    };
    return descriptions[movementType];
  }
}
