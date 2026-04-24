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

// All movement operation types for queries
const ALL_MOVEMENT_OPERATIONS = [
  'BAJA', 'RESGUARDO', 'REASIGNACION', 'REPARACION',
];

@Injectable()
export class MovementService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async create(createMovementDto: CreateMovementDto, userEmail?: string) {
    const { assetID, movementType, description, responsible, userID, companyID, siteID, departID } = createMovementDto;

    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: assetID },
      include: { AssetState_Asset_AssetStateToAssetState: true },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    // Block movements on assets already in Baja state
    if (asset.AssetState_Asset_AssetStateToAssetState?.Name === 'Baja') {
      throw new BadRequestException('No se pueden realizar movimientos en activos dados de baja');
    }

    try {
      const newStateID = await this.resolveNewState(movementType);

      // Enrich description with target user, department, site info
      let targetUserName: string | null = null;
      let targetDepartName: string | null = null;
      let targetSiteName: string | null = null;
      let targetCompanyName: string | null = null;

      if (userID) {
        const targetUser = await this.prismaShopic.user.findUnique({
          where: { UserID: userID },
          include: { Depart: true },
        });
        if (targetUser) {
          targetUserName = targetUser.Name;
          targetDepartName = targetUser.Depart?.Name || null;
        }
      }
      if (siteID) {
        const targetSite = await this.prismaShopic.site.findUnique({
          where: { SiteID: siteID },
          include: { Company: true },
        });
        if (targetSite) {
          targetSiteName = targetSite.Name;
          targetCompanyName = targetSite.Company?.Description || null;
        }
      }
      if (departID && !targetDepartName) {
        const targetDepart = await this.prismaShopic.depart.findUnique({
          where: { DepartID: departID },
        });
        if (targetDepart) targetDepartName = targetDepart.Name;
      }

      // Build enriched default description
      const defaultDesc = description || this.getDefaultDescription(movementType, asset.Name);
      const contextParts: string[] = [];
      if (targetUserName) contextParts.push(targetUserName);
      if (targetDepartName) contextParts.push(targetDepartName);
      if (targetSiteName) contextParts.push(targetSiteName);
      if (targetCompanyName) contextParts.push(targetCompanyName);

      const enrichedDesc = contextParts.length > 0
        ? `${defaultDesc} → ${contextParts.join(' / ')}`
        : defaultDesc;

      const descriptionParts: string[] = [];
      descriptionParts.push(enrichedDesc);
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

        // Build asset update data based on movement type
        const assetUpdateData: Record<string, unknown> = {};

        if (newStateID !== null) {
          assetUpdateData.AssetState = newStateID;
        }

        if (movementType === 'BAJA') {
          // On BAJA, clear all assignment info
          assetUpdateData.UserID = null;
          assetUpdateData.CompanyID = null;
          assetUpdateData.SiteID = null;
          assetUpdateData.DepartID = null;
        } else {
          // Update asset assignment data (user, company, site, department)
          if (userID) assetUpdateData.UserID = userID;
          if (companyID) assetUpdateData.CompanyID = companyID;
          if (siteID) assetUpdateData.SiteID = siteID;
          if (departID) assetUpdateData.DepartID = departID;
        }

        if (Object.keys(assetUpdateData).length > 0) {
          await tx.asset.update({
            where: { AssetID: assetID },
            data: assetUpdateData,
          });
        }

        // Close previous open AssetOwnershipHistory record and create new one
        if (movementType === 'REASIGNACION' || movementType === 'RESGUARDO' || movementType === 'BAJA') {
          // Close any open record (ToDate = 9999-12-31)
          const openRecords = await tx.assetOwnershipHistory.findMany({
            where: {
              AssetID: assetID,
              ToDate: new Date('9999-12-31'),
            },
          });
          for (const record of openRecords) {
            await tx.assetOwnershipHistory.update({
              where: { AssetOwnershipHistoryID: record.AssetOwnershipHistoryID },
              data: { ToDate: new Date() },
            });
          }

          // Create new ownership record for REASIGNACION
          if (movementType === 'REASIGNACION' && userID) {
            await tx.assetOwnershipHistory.create({
              data: {
                AssetID: assetID,
                UserID: userID,
                FromDate: new Date(),
                ToDate: new Date('9999-12-31'),
              },
            });
          }
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
    const { assetIDs, movementType, companyID, siteID, userID, departID, fromDate, toDate, description, responsible } = dto;

    // Validar que todos los activos existen
    const assets = await this.prismaShopic.asset.findMany({
      where: { AssetID: { in: assetIDs } },
      include: { AssetState_Asset_AssetStateToAssetState: true },
    });

    if (assets.length !== assetIDs.length) {
      const foundIDs = assets.map((a) => a.AssetID);
      const missingIDs = assetIDs.filter((id) => !foundIDs.includes(id));
      throw new NotFoundException(`Activos no encontrados: ${missingIDs.join(', ')}`);
    }

    // Block movements on assets already in Baja state
    const bajaAssets = assets.filter(a => a.AssetState_Asset_AssetStateToAssetState?.Name === 'Baja');
    if (bajaAssets.length > 0) {
      const bajaNames = bajaAssets.map(a => a.Name).join(', ');
      throw new BadRequestException(`No se pueden realizar movimientos en activos dados de baja: ${bajaNames}`);
    }

    // Validar empresa y sitio solo si se proporcionan (requeridos para REASIGNACION)
    if (companyID) {
      const company = await this.prismaShopic.company.findUnique({ where: { CompanyID: companyID } });
      if (!company) throw new NotFoundException('Empresa no encontrada');
    }

    if (siteID) {
      const site = await this.prismaShopic.site.findUnique({ where: { SiteID: siteID } });
      if (!site) throw new NotFoundException('Sitio no encontrado');
    }

    try {
      // Enrich: resolve target user, department, site, company names once
      let bulkTargetUserName: string | null = null;
      let bulkTargetDepartName: string | null = null;
      let bulkTargetSiteName: string | null = null;
      let bulkTargetCompanyName: string | null = null;

      // For RESGUARDO/REPARACION: resolve the performing user from email
      // so we can reassign the asset to them
      let performingUserID: number | null = null;
      if ((movementType === 'RESGUARDO' || movementType === 'REPARACION') && userEmail) {
        const performingUser = await this.prismaShopic.user.findFirst({
          where: { Email: { contains: userEmail } },
        });
        if (performingUser) {
          performingUserID = performingUser.UserID;
        }
      }

      // Determine effective userID: for RESGUARDO/REPARACION use performing user
      const effectiveUserID = (movementType === 'RESGUARDO' || movementType === 'REPARACION')
        ? performingUserID
        : userID;

      const resolveUserID = effectiveUserID || userID;
      if (resolveUserID) {
        const targetUser = await this.prismaShopic.user.findUnique({
          where: { UserID: resolveUserID },
          include: { Depart: true },
        });
        if (targetUser) {
          bulkTargetUserName = targetUser.Name;
          bulkTargetDepartName = targetUser.Depart?.Name || null;
        }
      }
      if (siteID) {
        const targetSite = await this.prismaShopic.site.findUnique({
          where: { SiteID: siteID },
          include: { Company: true },
        });
        if (targetSite) {
          bulkTargetSiteName = targetSite.Name;
          bulkTargetCompanyName = targetSite.Company?.Description || null;
        }
      }
      if (departID && !bulkTargetDepartName) {
        const targetDepart = await this.prismaShopic.depart.findUnique({
          where: { DepartID: departID },
        });
        if (targetDepart) bulkTargetDepartName = targetDepart.Name;
      }

      const bulkContextParts: string[] = [];
      if (bulkTargetUserName) bulkContextParts.push(bulkTargetUserName);
      if (bulkTargetDepartName) bulkContextParts.push(bulkTargetDepartName);
      if (bulkTargetSiteName) bulkContextParts.push(bulkTargetSiteName);
      if (bulkTargetCompanyName) bulkContextParts.push(bulkTargetCompanyName);

      const results = await this.prismaShopic.$transaction(async (tx) => {
        const movementResults: { movementID: number; assetID: number; assetName: string }[] = [];

        for (const asset of assets) {
          // Construir descripción enriquecida
          const defaultDesc = description || this.getDefaultDescription(movementType as MovementType, asset.Name);
          const enrichedDesc = bulkContextParts.length > 0
            ? `${defaultDesc} → ${bulkContextParts.join(' / ')}`
            : defaultDesc;

          const descParts: string[] = [];
          descParts.push(enrichedDesc);
          if (responsible) descParts.push(`Responsable: ${responsible}`);
          if (userEmail) descParts.push(`Registrado por: ${userEmail}`);
          const fullDescription = descParts.join(' | ');

          // Build update data based on movement type
          const updateData: Record<string, unknown> = {};

          // Cambiar estado si aplica
          const newStateID = await this.resolveNewState(movementType as MovementType);
          if (newStateID !== null) {
            updateData.AssetState = newStateID;
          }

          if (movementType === 'BAJA') {
            // On BAJA, clear all assignment info
            updateData.UserID = null;
            updateData.CompanyID = null;
            updateData.SiteID = null;
            updateData.DepartID = null;
          } else if (movementType === 'RESGUARDO' || movementType === 'REPARACION') {
            // For RESGUARDO/REPARACION: reassign to the performing user
            if (effectiveUserID) updateData.UserID = effectiveUserID;
            if (companyID) updateData.CompanyID = companyID;
            if (siteID) updateData.SiteID = siteID;
            if (departID) updateData.DepartID = departID;
          } else {
            if (companyID) updateData.CompanyID = companyID;
            if (siteID) updateData.SiteID = siteID;
            if (userID) updateData.UserID = userID;
            if (departID) updateData.DepartID = departID;
          }

          if (Object.keys(updateData).length > 0) {
            await tx.asset.update({
              where: { AssetID: asset.AssetID },
              data: updateData,
            });
          }

          // Crear historial del movimiento
          const assetHistory = await tx.assetHistory.create({
            data: {
              AssetID: asset.AssetID,
              Operation: movementType,
              Description: fullDescription,
              CreatedTime: new Date(),
            },
          });

          // Close previous open AssetOwnershipHistory records
          if (movementType === 'REASIGNACION' || movementType === 'RESGUARDO' || movementType === 'REPARACION' || movementType === 'BAJA') {
            const today = new Date();
            const openRecords = await tx.assetOwnershipHistory.findMany({
              where: {
                AssetID: asset.AssetID,
                ToDate: new Date('9999-12-31'),
              },
            });
            for (const record of openRecords) {
              await tx.assetOwnershipHistory.update({
                where: { AssetOwnershipHistoryID: record.AssetOwnershipHistoryID },
                data: { ToDate: new Date(fromDate || today) },
              });
            }

            // Create new ownership record for the new assignee
            const newOwnerID = (movementType === 'RESGUARDO' || movementType === 'REPARACION')
              ? effectiveUserID
              : (movementType === 'REASIGNACION' ? userID : null);

            if (newOwnerID) {
              await tx.assetOwnershipHistory.create({
                data: {
                  AssetID: asset.AssetID,
                  UserID: newOwnerID,
                  FromDate: new Date(fromDate || today),
                  ToDate: toDate ? new Date(toDate) : new Date('9999-12-31'),
                },
              });
            }
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
          Operation: { in: ALL_MOVEMENT_OPERATIONS },
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
          Operation: { in: ALL_MOVEMENT_OPERATIONS },
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

  async findAllHistory() {
    try {
      const records = await this.prismaShopic.assetHistory.findMany({
        orderBy: { CreatedTime: 'desc' },
        include: {
          Asset: {
            select: {
              AssetID: true,
              Name: true,
              AssetDetail: {
                select: {
                  AssetTAG: true,
                },
              },
              ProductType: {
                select: {
                  ProductTypeID: true,
                  Name: true,
                  Group: true,
                },
              },
              User: {
                select: {
                  UserID: true,
                  Name: true,
                  Email: true,
                },
              },
              Depart: {
                select: {
                  DepartID: true,
                  Name: true,
                },
              },
              Site: {
                select: {
                  SiteID: true,
                  Name: true,
                },
              },
              Company: {
                select: {
                  CompanyID: true,
                  Description: true,
                },
              },
            },
          },
        },
      });

      // Collect unique emails to resolve names in bulk
      const emailsToResolve = new Set<string>();
      for (const m of records) {
        const { createdBy } = this.parseDescription(m.Description);
        if (createdBy) emailsToResolve.add(createdBy);
      }

      // Resolve email → name mapping
      const emailNameMap = new Map<string, string>();
      if (emailsToResolve.size > 0) {
        const users = await this.prismaShopic.user.findMany({
          where: { Email: { in: Array.from(emailsToResolve) } },
          select: { Email: true, Name: true },
        });
        for (const u of users) {
          emailNameMap.set(u.Email, u.Name);
        }
      }

      return records.map((m) => {
        const { description, responsible, createdBy } = this.parseDescription(m.Description);
        // Use responsible name if available, otherwise resolve createdBy email to name
        const performedBy = responsible || (createdBy ? emailNameMap.get(createdBy) || createdBy : null);
        return {
          historyID: m.AssetHistoryID,
          assetID: m.AssetID,
          assetName: m.Asset?.Name || 'Activo eliminado',
          assetTAG: m.Asset?.AssetDetail?.AssetTAG || null,
          productTypeName: m.Asset?.ProductType?.Name || null,
          productTypeGroup: m.Asset?.ProductType?.Group || null,
          operation: m.Operation,
          description,
          performedBy,
          createdTime: m.CreatedTime,
          assignedUser: m.Asset?.User?.Name || null,
          department: m.Asset?.Depart?.Name || null,
          site: m.Asset?.Site?.Name || null,
          company: m.Asset?.Company?.Description || null,
        };
      });
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener el historial completo',
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
      REASIGNACION: 'Asignado',
      RESGUARDO: 'Resguardo',
      REPARACION: 'Mantenimiento',
      BAJA: 'Baja',
    };

    const targetStateName = stateMapping[movementType];
    if (!targetStateName) {
      return null;
    }

    const state = await this.prismaShopic.assetState.findFirst({
      where: {
        Name: {
          equals: targetStateName,
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
      REASIGNACION: `Reasignacion del activo "${assetName}"`,
      RESGUARDO: `Resguardo del activo "${assetName}"`,
      REPARACION: `Reparacion del activo "${assetName}"`,
      BAJA: `Baja del activo "${assetName}"`,
    };
    return descriptions[movementType];
  }
}
