import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { CreateMovementDto, MovementType } from './dto/create-movement.dto';
import { CreateBulkMovementDto } from './dto/create-bulk-movement.dto';
import { UpdateMovementDto } from './dto/update-movement.dto';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class MovementService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async create(createMovementDto: CreateMovementDto, userEmail?: string) {
    const { assetID, movementType, description, responsible, userID } = createMovementDto;

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

        // Update asset state if applicable
        if (newStateID !== null) {
          await tx.asset.update({
            where: { AssetID: assetID },
            data: { AssetState: newStateID },
          });
        }

        // Assign user to asset if provided (for ASIGNACION)
        if (userID) {
          await tx.asset.update({
            where: { AssetID: assetID },
            data: { UserID: userID },
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

  async createBulk(dto: CreateBulkMovementDto, userEmail?: string) {
    const { assetIDs, movementType, companyID, siteID, userID, fromDate, toDate, description, responsible } = dto;

    // Validar que todos los activos existen
    const assets = await this.prismaShopic.asset.findMany({
      where: { AssetID: { in: assetIDs } },
    });

    if (assets.length !== assetIDs.length) {
      const foundIDs = assets.map((a) => a.AssetID);
      const missingIDs = assetIDs.filter((id) => !foundIDs.includes(id));
      throw new NotFoundException(`Activos no encontrados: ${missingIDs.join(', ')}`);
    }

    // Validar que la empresa y el sitio existen
    const company = await this.prismaShopic.company.findUnique({ where: { CompanyID: companyID } });
    if (!company) throw new NotFoundException('Empresa no encontrada');

    const site = await this.prismaShopic.site.findUnique({ where: { SiteID: siteID } });
    if (!site) throw new NotFoundException('Sitio no encontrado');

    try {
      const results = await this.prismaShopic.$transaction(async (tx) => {
        const movementResults: { movementID: number; assetID: number; assetName: string }[] = [];

        for (const asset of assets) {
          // Construir descripción
          const descParts: string[] = [];
          descParts.push(
            description ||
              `${movementType === 'ASIGNACION' ? 'Asignación' : 'Resguardo'} del activo "${asset.Name}" → ${company.Description} / ${site.Name}`,
          );
          if (responsible) descParts.push(`Responsable: ${responsible}`);
          if (userEmail) descParts.push(`Registrado por: ${userEmail}`);
          const fullDescription = descParts.join(' | ');

          // Actualizar empresa, sitio y opcionalmente usuario del activo
          const updateData: Record<string, unknown> = {
            CompanyID: companyID,
            SiteID: siteID,
          };
          if (userID) {
            updateData.UserID = userID;
          }

          await tx.asset.update({
            where: { AssetID: asset.AssetID },
            data: updateData,
          });

          // Crear historial del movimiento
          const assetHistory = await tx.assetHistory.create({
            data: {
              AssetID: asset.AssetID,
              Operation: movementType,
              Description: fullDescription,
              CreatedTime: new Date(),
            },
          });

          // Crear historial de asignación si se asigna un usuario
          if (userID && fromDate) {
            await tx.assetOwnershipHistory.create({
              data: {
                AssetID: asset.AssetID,
                UserID: userID,
                FromDate: new Date(fromDate),
                ToDate: toDate ? new Date(toDate) : new Date('9999-12-31'),
              },
            });
          }

          // Cambiar estado si aplica
          const newStateID = await this.resolveNewState(movementType as MovementType);
          if (newStateID !== null) {
            await tx.asset.update({
              where: { AssetID: asset.AssetID },
              data: { AssetState: newStateID },
            });
          }

          movementResults.push({
            movementID: assetHistory.AssetHistoryID,
            assetID: asset.AssetID,
            assetName: asset.Name,
          });
        }

        return movementResults;
      });

      return {
        success: true,
        message: `Movimiento masivo registrado para ${results.length} activo(s)`,
        data: results,
      };
    } catch (error) {
      if (error instanceof NotFoundException || error instanceof BadRequestException) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al registrar el movimiento masivo',
      });
    }
  }

  async update(movementID: number, dto: UpdateMovementDto, userEmail?: string) {
    const movement = await this.prismaShopic.assetHistory.findUnique({
      where: { AssetHistoryID: movementID },
    });

    if (!movement) {
      throw new NotFoundException('Movimiento no encontrado');
    }

    const descriptionParts: string[] = [];
    const { description: currentDesc, responsible: currentResp, createdBy: currentCreatedBy } = this.parseDescription(movement.Description);

    descriptionParts.push(dto.description !== undefined ? dto.description : currentDesc);
    const responsible = dto.responsible !== undefined ? dto.responsible : currentResp;
    if (responsible) {
      descriptionParts.push(`Responsable: ${responsible}`);
    }
    const createdBy = userEmail || currentCreatedBy;
    if (createdBy) {
      descriptionParts.push(`Registrado por: ${createdBy}`);
    }
    const fullDescription = descriptionParts.join(' | ');

    try {
      await this.prismaShopic.assetHistory.update({
        where: { AssetHistoryID: movementID },
        data: { Description: fullDescription },
      });

      return {
        success: true,
        message: 'Movimiento actualizado exitosamente',
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al actualizar el movimiento',
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
          Operation: { in: ['ALTA', 'BAJA', 'ASIGNACION', 'RESGUARDO', 'REASIGNACION', 'PRESTAMO'] },
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
          Operation: { in: ['ALTA', 'BAJA', 'ASIGNACION', 'RESGUARDO', 'REASIGNACION', 'PRESTAMO'] },
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
      ASIGNACION: 'Asignado',
      RESGUARDO: 'Stock',
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
      ASIGNACION: `Asignación del activo "${assetName}"`,
      RESGUARDO: `Resguardo del activo "${assetName}"`,
    };
    return descriptions[movementType];
  }
}
