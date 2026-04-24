import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { CreateAssetDto } from './dto/create-asset.dto';
import { UpdateAssetDto } from './dto/update-asset.dto';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class AssetService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  // Formato: HS-{ProductTypeID con 2 digitos}-{secuencia con 2 digitos}
  // Ej: el 5o monitor (ProductTypeID = 3) -> HS-03-05
  private async generateAssetTag(productTypeID: number): Promise<string> {
    const productCode = String(productTypeID).padStart(2, '0');
    const tagPrefix = `HS-${productCode}-`;

    const existingDetails = await this.prismaShopic.assetDetail.findMany({
      where: {
        AssetTAG: { startsWith: tagPrefix },
        Asset: { some: { ProductTypeID: productTypeID } },
      },
      select: { AssetTAG: true },
    });

    let maxSeq = 0;
    for (const d of existingDetails) {
      if (!d.AssetTAG) continue;
      const seqPart = d.AssetTAG.substring(tagPrefix.length);
      const seq = parseInt(seqPart, 10);
      if (!isNaN(seq) && seq > maxSeq) maxSeq = seq;
    }

    const nextSeq = maxSeq + 1;
    const padded = String(nextSeq).padStart(2, '0');
    return `${tagPrefix}${padded}`;
  }

  async create(createAssetDto: CreateAssetDto, userEmail?: string) {
    const { name, vendorID, productTypeID, assetState, companyID, siteID, userID, assignmentFromDate, assignmentToDate, detail } =
      createAssetDto;

    try {
      // Obtener el usuario que crea el activo (para lastUpdateBy)
      let lastUpdateBy = 1; // Default user ID
      if (userEmail) {
        const user = await this.prismaShopic.user.findFirst({
          where: { Email: userEmail },
        });
        if (user) {
          lastUpdateBy = user.UserID;
        }
      }

      // Auto-resolve "Stock" state if not provided
      let resolvedAssetState = assetState;
      if (!resolvedAssetState) {
        const stockState = await this.prismaShopic.assetState.findFirst({
          where: { Name: { contains: 'Stock' } },
        });
        resolvedAssetState = stockState?.AssetStateID || 1;
      }

      // Resolve company and site from creator's department chain:
      // User → DepartmentID → Site_Depart → Site → Company
      let resolvedCompanyID = companyID;
      let resolvedSiteID = siteID;
      if (!resolvedCompanyID || !resolvedSiteID) {
        const creatorUser = await this.prismaShopic.user.findFirst({
          where: { Email: userEmail },
        });
        if (creatorUser) {
          const siteDepart = await this.prismaShopic.site_Depart.findFirst({
            where: { ID_depart: creatorUser.DepartmentID },
            include: {
              Site: {
                include: { Company: true },
              },
            },
          });
          if (siteDepart) {
            if (!resolvedSiteID) resolvedSiteID = siteDepart.ID_site;
            if (!resolvedCompanyID) resolvedCompanyID = siteDepart.Site.CompanyID;
          }
        }
      }
      // Fallback if still not resolved
      if (!resolvedCompanyID) {
        const defaultCompany = await this.prismaShopic.company.findFirst();
        resolvedCompanyID = defaultCompany?.CompanyID || 1;
      }
      if (!resolvedSiteID) {
        const defaultSite = await this.prismaShopic.site.findFirst({
          where: { CompanyID: resolvedCompanyID },
        });
        resolvedSiteID = defaultSite?.SiteID || 1;
      }

      // Generar el AssetTAG automaticamente (formato HS-{ProductTypeID}-{secuencia})
      const generatedTag = await this.generateAssetTag(productTypeID);

      // Si hay detalles, crearlos primero para obtener el AssetDetailID
      let assetDetailID: number | null = null;
      if (detail) {
        const newDetail = await this.prismaShopic.assetDetail.create({
          data: {
            ProductManuf: detail.productManuf,
            IPAddress: detail.ipAddress,
            MACAddress: detail.macAddress,
            Loanable: detail.loanable,
            VMPlatform: detail.vmPlatform,
            VirtualHost: detail.virtualHost,
            OperatingSystem: detail.operatingSystem,
            Domain: detail.domain,
            ProcessorInfo: detail.processorInfo,
            Processor: detail.processor,
            PhysicalMemory: detail.physicalMemory,
            HDDModel: detail.hddModel,
            HDDSerial: detail.hddSerial,
            HDDCapacity: detail.hddCapacity,
            KeyboardType: detail.keyboardType,
            MouseType: detail.mouseType,
            NumModel: detail.numModel,
            Model: detail.model,
            IMEI: detail.imei,
            ModemFirmwareVersion: detail.modemFirmwareVersion,
            Platform: detail.platform,
            OSName: detail.osName,
            OSVersion: detail.osVersion,
            RAM: detail.ram,
            SerialNum: detail.serialNum,
            PurchaseDate: detail.purchaseDate ? new Date(detail.purchaseDate) : null,
            WarrantyExpiryDate: detail.warrantyExpiryDate ? new Date(detail.warrantyExpiryDate) : null,
            AssetACQDate: detail.assetACQDate ? new Date(detail.assetACQDate) : null,
            AssetExpiryDate: detail.assetExpiryDate ? new Date(detail.assetExpiryDate) : null,
            AssetTAG: generatedTag,
            WarrantyExpiry: detail.warrantyExpiry ? new Date(detail.warrantyExpiry) : null,
            Barcode: detail.barcode,
            Factura: detail.factura,
            Ticket: detail.ticket,
            CreatedTime: new Date(),
            LastUpdateTime: new Date(),
            LastUpdateBy: lastUpdateBy,
          },
        });
        assetDetailID = newDetail.AssetDetailID;
      }

      // Crear el activo con la referencia al detalle
      const newAsset = await this.prismaShopic.asset.create({
        data: {
          Name: name,
          VendorID: vendorID,
          ProductTypeID: productTypeID,
          AssetState: resolvedAssetState,
          CompanyID: resolvedCompanyID,
          SiteID: resolvedSiteID,
          UserID: userID || lastUpdateBy,
          AssetDetailID: assetDetailID,
        },
      });

      // Obtener nombre del usuario para el historial
      let creatorName: string | null = null;
      if (userEmail) {
        const creatorForHistory = await this.prismaShopic.user.findFirst({
          where: { Email: userEmail },
        });
        if (creatorForHistory) {
          creatorName = creatorForHistory.Name;
        }
      }

      // Registrar en historial
      const createDescParts: string[] = [`Activo "${name}" creado`];
      if (creatorName) createDescParts.push(`Responsable: ${creatorName}`);
      if (userEmail) createDescParts.push(`Registrado por: ${userEmail}`);

      await this.prismaShopic.assetHistory.create({
        data: {
          AssetID: newAsset.AssetID,
          Operation: 'CREATE',
          Description: createDescParts.join(' | '),
          CreatedTime: new Date(),
        },
      });

      // Registrar asignacion de usuario si se especifico
      if (userID && assignmentFromDate) {
        await this.prismaShopic.assetOwnershipHistory.create({
          data: {
            AssetID: newAsset.AssetID,
            UserID: userID,
            FromDate: new Date(assignmentFromDate),
            ToDate: assignmentToDate ? new Date(assignmentToDate) : new Date('9999-12-31'),
          },
        });
      }

      return {
        success: true,
        message: 'Activo creado exitosamente',
        data: { assetID: newAsset.AssetID },
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el activo',
      });
    }
  }

  async findAll() {
    try {
      const assets = await this.prismaShopic.asset.findMany({
        include: {
          Vendor: true,
          ProductType: true,
          AssetState_Asset_AssetStateToAssetState: true,
          Company: true,
          Site: true,
          AssetDetail: true,
          Depart: true,
          User: {
            include: {
              Depart: true,
            },
          },
        },
      });

      return assets.map((asset) => ({
        assetID: asset.AssetID,
        name: asset.Name,
        vendorID: asset.VendorID,
        productTypeID: asset.ProductTypeID,
        assetState: asset.AssetState,
        companyID: asset.CompanyID,
        siteID: asset.SiteID,
        userID: asset.UserID,
        vendor: asset.Vendor
          ? { vendorID: asset.Vendor.VendorID, name: asset.Vendor.Name }
          : null,
        productType: asset.ProductType
          ? {
              productTypeID: asset.ProductType.ProductTypeID,
              name: asset.ProductType.Name,
              category: asset.ProductType.Category,
              group: asset.ProductType.Group,
              subCategory: asset.ProductType.SubCategory,
            }
          : null,
        assetStateInfo: asset.AssetState_Asset_AssetStateToAssetState
          ? {
              assetStateID: asset.AssetState_Asset_AssetStateToAssetState.AssetStateID,
              name: asset.AssetState_Asset_AssetStateToAssetState.Name,
            }
          : null,
        company: asset.Company
          ? { companyID: asset.Company.CompanyID, description: asset.Company.Description }
          : null,
        site: asset.Site
          ? { siteID: asset.Site.SiteID, name: asset.Site.Name, companyID: asset.Site.CompanyID }
          : null,
        user: asset.User
          ? {
              userID: asset.User.UserID,
              name: asset.User.Name,
              email: asset.User.Email,
              departmentID: asset.User.DepartmentID,
              firstName: asset.User.FirstName,
              lastName: asset.User.LastName,
            }
          : null,
        depart: asset.User?.Depart
          ? {
              departID: asset.User.Depart.DepartID,
              Name: asset.User.Depart.Name,
            }
          : asset.Depart
            ? {
                departID: asset.Depart.DepartID,
                Name: asset.Depart.Name,
              }
            : null,
        assetDetail: asset.AssetDetail
          ? {
              assetDetailID: asset.AssetDetail.AssetDetailID,
              serialNum: asset.AssetDetail.SerialNum,
              assetTAG: asset.AssetDetail.AssetTAG,
              model: asset.AssetDetail.Model,
              productManuf: asset.AssetDetail.ProductManuf,
              ipAddress: asset.AssetDetail.IPAddress,
              macAddress: asset.AssetDetail.MACAddress,
              processor: asset.AssetDetail.Processor,
              processorInfo: asset.AssetDetail.ProcessorInfo,
              ram: asset.AssetDetail.RAM,
              physicalMemory: asset.AssetDetail.PhysicalMemory,
              hddModel: asset.AssetDetail.HDDModel,
              hddCapacity: asset.AssetDetail.HDDCapacity,
              operatingSystem: asset.AssetDetail.OperatingSystem,
              purchaseDate: asset.AssetDetail.PurchaseDate,
              warrantyExpiryDate: asset.AssetDetail.WarrantyExpiryDate,
              factura: asset.AssetDetail.Factura,
              ticket: asset.AssetDetail.Ticket,
            }
          : null,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los activos',
      });
    }
  }

  async findOne(id: number) {
    try {
      const asset = await this.prismaShopic.asset.findUnique({
        where: { AssetID: id },
        include: {
          Vendor: true,
          ProductType: true,
          AssetState_Asset_AssetStateToAssetState: true,
          Company: true,
          Site: true,
          AssetDetail: true,
          Depart: true,
          User: {
            include: {
              Depart: true,
            },
          },
          AssetHistory: {
            orderBy: { CreatedTime: 'desc' },
            take: 10,
          },
          Asset: {
            include: {
              ProductType: true,
              AssetDetail: true,
            },
          },
          other_Asset: {
            include: {
              ProductType: true,
              AssetDetail: true,
            },
          },
        },
      });

      if (!asset) {
        throw new NotFoundException('Activo no encontrado');
      }

      return {
        assetID: asset.AssetID,
        name: asset.Name,
        vendorID: asset.VendorID,
        productTypeID: asset.ProductTypeID,
        assetState: asset.AssetState,
        companyID: asset.CompanyID,
        siteID: asset.SiteID,
        userID: asset.UserID,
        parentAssetID: asset.ParentAssetID,
        vendor: asset.Vendor
          ? { vendorID: asset.Vendor.VendorID, name: asset.Vendor.Name }
          : null,
        productType: asset.ProductType
          ? {
              productTypeID: asset.ProductType.ProductTypeID,
              name: asset.ProductType.Name,
              category: asset.ProductType.Category,
              group: asset.ProductType.Group,
              subCategory: asset.ProductType.SubCategory,
            }
          : null,
        assetStateInfo: asset.AssetState_Asset_AssetStateToAssetState
          ? {
              assetStateID: asset.AssetState_Asset_AssetStateToAssetState.AssetStateID,
              name: asset.AssetState_Asset_AssetStateToAssetState.Name,
            }
          : null,
        company: asset.Company
          ? { companyID: asset.Company.CompanyID, description: asset.Company.Description }
          : null,
        site: asset.Site
          ? { siteID: asset.Site.SiteID, name: asset.Site.Name, companyID: asset.Site.CompanyID }
          : null,
        user: asset.User
          ? {
              userID: asset.User.UserID,
              name: asset.User.Name,
              email: asset.User.Email,
              departmentID: asset.User.DepartmentID,
              firstName: asset.User.FirstName,
              lastName: asset.User.LastName,
            }
          : null,
        depart: asset.User?.Depart
          ? {
              departID: asset.User.Depart.DepartID,
              Name: asset.User.Depart.Name,
            }
          : asset.Depart
            ? {
                departID: asset.Depart.DepartID,
                Name: asset.Depart.Name,
              }
            : null,
        assetDetail: asset.AssetDetail
          ? {
              assetDetailID: asset.AssetDetail.AssetDetailID,
              productManuf: asset.AssetDetail.ProductManuf,
              ipAddress: asset.AssetDetail.IPAddress,
              macAddress: asset.AssetDetail.MACAddress,
              loanable: asset.AssetDetail.Loanable,
              vmPlatform: asset.AssetDetail.VMPlatform,
              virtualHost: asset.AssetDetail.VirtualHost,
              operatingSystem: asset.AssetDetail.OperatingSystem,
              domain: asset.AssetDetail.Domain,
              processorInfo: asset.AssetDetail.ProcessorInfo,
              processor: asset.AssetDetail.Processor,
              physicalMemory: asset.AssetDetail.PhysicalMemory,
              hddModel: asset.AssetDetail.HDDModel,
              hddSerial: asset.AssetDetail.HDDSerial,
              hddCapacity: asset.AssetDetail.HDDCapacity,
              keyboardType: asset.AssetDetail.KeyboardType,
              mouseType: asset.AssetDetail.MouseType,
              numModel: asset.AssetDetail.NumModel,
              model: asset.AssetDetail.Model,
              imei: asset.AssetDetail.IMEI,
              modemFirmwareVersion: asset.AssetDetail.ModemFirmwareVersion,
              platform: asset.AssetDetail.Platform,
              osName: asset.AssetDetail.OSName,
              osVersion: asset.AssetDetail.OSVersion,
              ram: asset.AssetDetail.RAM,
              serialNum: asset.AssetDetail.SerialNum,
              purchaseDate: asset.AssetDetail.PurchaseDate,
              warrantyExpiryDate: asset.AssetDetail.WarrantyExpiryDate,
              assetACQDate: asset.AssetDetail.AssetACQDate,
              assetExpiryDate: asset.AssetDetail.AssetExpiryDate,
              assetTAG: asset.AssetDetail.AssetTAG,
              warrantyExpiry: asset.AssetDetail.WarrantyExpiry,
              barcode: asset.AssetDetail.Barcode,
              factura: asset.AssetDetail.Factura,
              ticket: asset.AssetDetail.Ticket,
              createdTime: asset.AssetDetail.CreatedTime,
              lastUpdateTime: asset.AssetDetail.LastUpdateTime,
              lastUpdateBy: asset.AssetDetail.LastUpdateBy,
            }
          : null,
        parentAsset: asset.Asset
          ? {
              assetID: asset.Asset.AssetID,
              name: asset.Asset.Name,
              productType: asset.Asset.ProductType
                ? {
                    productTypeID: asset.Asset.ProductType.ProductTypeID,
                    name: asset.Asset.ProductType.Name,
                    group: asset.Asset.ProductType.Group,
                  }
                : null,
              model: asset.Asset.AssetDetail?.Model || null,
              serialNum: asset.Asset.AssetDetail?.SerialNum || null,
            }
          : null,
        childAssets: asset.other_Asset.map((child) => ({
          assetID: child.AssetID,
          name: child.Name,
          productType: child.ProductType
            ? {
                productTypeID: child.ProductType.ProductTypeID,
                name: child.ProductType.Name,
                group: child.ProductType.Group,
              }
            : null,
          model: child.AssetDetail?.Model || null,
          serialNum: child.AssetDetail?.SerialNum || null,
        })),
        history: asset.AssetHistory.map((h) => ({
          assetHistoryID: h.AssetHistoryID,
          assetID: h.AssetID,
          operation: h.Operation,
          description: h.Description,
          createdTime: h.CreatedTime,
        })),
      };
    } catch (error) {
      if (error instanceof NotFoundException) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener el activo',
      });
    }
  }

  async update(id: number, updateAssetDto: UpdateAssetDto, userEmail?: string) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: id },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    try {
      // Obtener el usuario que actualiza
      let lastUpdateBy = 1;
      if (userEmail) {
        const user = await this.prismaShopic.user.findFirst({
          where: { Email: userEmail },
        });
        if (user) {
          lastUpdateBy = user.UserID;
        }
      }

      const { detail, ...assetData } = updateAssetDto;

      // Actualizar el activo
      const updatedAsset = await this.prismaShopic.asset.update({
        where: { AssetID: id },
        data: {
          Name: assetData.name,
          VendorID: assetData.vendorID,
          ProductTypeID: assetData.productTypeID,
          AssetState: assetData.assetState,
          CompanyID: assetData.companyID,
          SiteID: assetData.siteID,
          UserID: assetData.userID,
        },
      });

      // Si cambia el ProductTypeID, regenerar el AssetTAG para mantener la nomenclatura HS-XX-NN
      let regeneratedTag: string | undefined;
      if (
        assetData.productTypeID !== undefined &&
        assetData.productTypeID !== asset.ProductTypeID
      ) {
        regeneratedTag = await this.generateAssetTag(assetData.productTypeID);
      }

      // Actualizar detalles si existen
      if (detail) {
        const detailData = {
              ProductManuf: detail.productManuf,
              IPAddress: detail.ipAddress,
              MACAddress: detail.macAddress,
              Loanable: detail.loanable,
              VMPlatform: detail.vmPlatform,
              VirtualHost: detail.virtualHost,
              OperatingSystem: detail.operatingSystem,
              Domain: detail.domain,
              ProcessorInfo: detail.processorInfo,
              Processor: detail.processor,
              PhysicalMemory: detail.physicalMemory,
              HDDModel: detail.hddModel,
              HDDSerial: detail.hddSerial,
              HDDCapacity: detail.hddCapacity,
              KeyboardType: detail.keyboardType,
              MouseType: detail.mouseType,
              NumModel: detail.numModel,
              Model: detail.model,
              IMEI: detail.imei,
              ModemFirmwareVersion: detail.modemFirmwareVersion,
              Platform: detail.platform,
              OSName: detail.osName,
              OSVersion: detail.osVersion,
              RAM: detail.ram,
              SerialNum: detail.serialNum,
              // AssetTAG es inmutable salvo cambio de ProductTypeID: se ignora el valor enviado por el cliente
              AssetTAG: regeneratedTag ?? undefined,
              Barcode: detail.barcode,
              Factura: detail.factura,
              Ticket: detail.ticket,
              PurchaseDate: detail.purchaseDate ? new Date(detail.purchaseDate) : undefined,
              WarrantyExpiryDate: detail.warrantyExpiryDate ? new Date(detail.warrantyExpiryDate) : undefined,
              LastUpdateTime: new Date(),
              LastUpdateBy: lastUpdateBy,
            };

        if (updatedAsset.AssetDetailID) {
          // Ya tiene un detalle vinculado, actualizarlo
          await this.prismaShopic.assetDetail.update({
            where: { AssetDetailID: updatedAsset.AssetDetailID },
            data: detailData,
          });
        } else {
          // No tiene detalle, crear uno nuevo y vincularlo al asset
          // Generar tag si no se regenero antes (ProductTypeID sin cambios)
          const tagForNewDetail =
            regeneratedTag ??
            (await this.generateAssetTag(assetData.productTypeID ?? asset.ProductTypeID));
          const newDetail = await this.prismaShopic.assetDetail.create({
            data: {
              ...detailData,
              AssetTAG: tagForNewDetail,
              PurchaseDate: detail.purchaseDate ? new Date(detail.purchaseDate) : null,
              WarrantyExpiryDate: detail.warrantyExpiryDate ? new Date(detail.warrantyExpiryDate) : null,
              CreatedTime: new Date(),
            },
          });
          await this.prismaShopic.asset.update({
            where: { AssetID: id },
            data: { AssetDetailID: newDetail.AssetDetailID },
          });
        }
      }

      // Obtener nombre del usuario para el historial
      let updaterName: string | null = null;
      if (userEmail) {
        const updaterUser = await this.prismaShopic.user.findFirst({
          where: { Email: userEmail },
        });
        if (updaterUser) {
          updaterName = updaterUser.Name;
        }
      }

      // Registrar en historial
      const updateDescParts: string[] = [`Activo "${updatedAsset.Name}" actualizado`];
      if (updaterName) updateDescParts.push(`Responsable: ${updaterName}`);
      if (userEmail) updateDescParts.push(`Registrado por: ${userEmail}`);

      await this.prismaShopic.assetHistory.create({
        data: {
          AssetID: id,
          Operation: 'UPDATE',
          Description: updateDescParts.join(' | '),
          CreatedTime: new Date(),
        },
      });

      return {
        success: true,
        message: 'Activo actualizado exitosamente',
        data: { assetID: updatedAsset.AssetID },
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al actualizar el activo',
      });
    }
  }

  async remove(id: number, userEmail?: string) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: id },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    try {
      // Guardar referencia al detalle antes de eliminar
      const assetDetailID = asset.AssetDetailID;

      // Eliminar historial de propiedad
      await this.prismaShopic.assetOwnershipHistory.deleteMany({
        where: { AssetID: id },
      });

      // Eliminar historial
      await this.prismaShopic.assetHistory.deleteMany({
        where: { AssetID: id },
      });

      // Eliminar el activo primero (tiene la FK hacia AssetDetail)
      await this.prismaShopic.asset.delete({
        where: { AssetID: id },
      });

      // Eliminar el detalle después (si existía)
      if (assetDetailID) {
        await this.prismaShopic.assetDetail.delete({
          where: { AssetDetailID: assetDetailID },
        });
      }

      return {
        success: true,
        message: 'Activo eliminado exitosamente',
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al eliminar el activo',
      });
    }
  }

  // --- Asset Assignment (Parent/Child relationships) ---

  private mapChildAsset(child: any) {
    return {
      assetID: child.AssetID,
      name: child.Name,
      productType: child.ProductType
        ? {
            productTypeID: child.ProductType.ProductTypeID,
            name: child.ProductType.Name,
            group: child.ProductType.Group,
          }
        : null,
      model: child.AssetDetail?.Model || null,
      serialNum: child.AssetDetail?.SerialNum || null,
    };
  }

  async getChildren(parentAssetID: number) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: parentAssetID },
    });
    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    const children = await this.prismaShopic.asset.findMany({
      where: { ParentAssetID: parentAssetID },
      include: {
        ProductType: true,
        AssetDetail: true,
      },
    });

    return children.map(this.mapChildAsset);
  }

  async getParent(childAssetID: number) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: childAssetID },
      include: {
        Asset: {
          include: {
            ProductType: true,
            AssetDetail: true,
          },
        },
      },
    });
    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }
    if (!asset.Asset) {
      return null;
    }
    return this.mapChildAsset(asset.Asset);
  }

  async getRelationships(assetID: number) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: assetID },
      include: {
        ProductType: true,
        AssetDetail: true,
        Asset: {
          include: {
            ProductType: true,
            AssetDetail: true,
          },
        },
        other_Asset: {
          include: {
            ProductType: true,
            AssetDetail: true,
          },
        },
        User: true,
      },
    });
    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    return {
      asset: {
        assetID: asset.AssetID,
        name: asset.Name,
        parentAssetID: asset.ParentAssetID,
        productType: asset.ProductType
          ? {
              productTypeID: asset.ProductType.ProductTypeID,
              name: asset.ProductType.Name,
              group: asset.ProductType.Group,
            }
          : null,
        model: asset.AssetDetail?.Model || null,
        serialNum: asset.AssetDetail?.SerialNum || null,
        user: asset.User
          ? { userID: asset.User.UserID, name: asset.User.Name }
          : null,
      },
      parentAsset: asset.Asset ? this.mapChildAsset(asset.Asset) : null,
      childAssets: asset.other_Asset.map(this.mapChildAsset),
    };
  }

  async assignChild(parentAssetID: number, childAssetID: number, userEmail?: string) {
    const parent = await this.prismaShopic.asset.findUnique({
      where: { AssetID: parentAssetID },
      include: { ProductType: true },
    });
    if (!parent) {
      throw new NotFoundException('Activo padre no encontrado');
    }

    const child = await this.prismaShopic.asset.findUnique({
      where: { AssetID: childAssetID },
      include: { ProductType: true },
    });
    if (!child) {
      throw new NotFoundException('Activo hijo no encontrado');
    }

    // Validate: parent must be "Equipo"
    if (parent.ProductType?.Group !== 'Equipo') {
      throw new InternalServerErrorException({
        message: 'Solo los activos de tipo "Equipo" pueden tener componentes o accesorios asignados',
      });
    }

    // Validate: child must be "Componente" or "Accesorio"
    if (child.ProductType?.Group !== 'Componente' && child.ProductType?.Group !== 'Accesorio') {
      throw new InternalServerErrorException({
        message: 'Solo se pueden asignar activos de tipo "Componente" o "Accesorio" a un equipo',
      });
    }

    // Validate: child is not already assigned to another parent
    if (child.ParentAssetID && child.ParentAssetID !== parentAssetID) {
      throw new InternalServerErrorException({
        message: `Este activo ya esta asignado a otro equipo (ID: ${child.ParentAssetID})`,
      });
    }

    // Prevent self-assignment
    if (parentAssetID === childAssetID) {
      throw new InternalServerErrorException({
        message: 'Un activo no puede asignarse a si mismo',
      });
    }

    await this.prismaShopic.asset.update({
      where: { AssetID: childAssetID },
      data: { ParentAssetID: parentAssetID },
    });

    await this.prismaShopic.assetHistory.create({
      data: {
        AssetID: parentAssetID,
        Operation: 'ASSIGN',
        Description: `"${child.Name}" asignado como ${child.ProductType?.Group || 'hijo'}${userEmail ? ` | Por: ${userEmail}` : ''}`,
        CreatedTime: new Date(),
      },
    });

    await this.prismaShopic.assetHistory.create({
      data: {
        AssetID: childAssetID,
        Operation: 'ASSIGN',
        Description: `Asignado al equipo "${parent.Name}"${userEmail ? ` | Por: ${userEmail}` : ''}`,
        CreatedTime: new Date(),
      },
    });

    return {
      success: true,
      message: `"${child.Name}" asignado exitosamente a "${parent.Name}"`,
    };
  }

  async unassignChild(parentAssetID: number, childAssetID: number, userEmail?: string) {
    const child = await this.prismaShopic.asset.findUnique({
      where: { AssetID: childAssetID },
    });
    if (!child) {
      throw new NotFoundException('Activo hijo no encontrado');
    }
    if (child.ParentAssetID !== parentAssetID) {
      throw new InternalServerErrorException({
        message: 'Este activo no esta asignado a este equipo',
      });
    }

    const parent = await this.prismaShopic.asset.findUnique({
      where: { AssetID: parentAssetID },
    });

    await this.prismaShopic.asset.update({
      where: { AssetID: childAssetID },
      data: { ParentAssetID: null },
    });

    await this.prismaShopic.assetHistory.create({
      data: {
        AssetID: parentAssetID,
        Operation: 'UNASSIGN',
        Description: `"${child.Name}" removido del equipo${userEmail ? ` | Por: ${userEmail}` : ''}`,
        CreatedTime: new Date(),
      },
    });

    await this.prismaShopic.assetHistory.create({
      data: {
        AssetID: childAssetID,
        Operation: 'UNASSIGN',
        Description: `Removido del equipo "${parent?.Name || parentAssetID}"${userEmail ? ` | Por: ${userEmail}` : ''}`,
        CreatedTime: new Date(),
      },
    });

    return {
      success: true,
      message: `"${child.Name}" removido exitosamente`,
    };
  }

  async assignParent(childAssetID: number, parentAssetID: number, userEmail?: string) {
    return this.assignChild(parentAssetID, childAssetID, userEmail);
  }

  async unassignParent(childAssetID: number, userEmail?: string) {
    const child = await this.prismaShopic.asset.findUnique({
      where: { AssetID: childAssetID },
    });
    if (!child) {
      throw new NotFoundException('Activo no encontrado');
    }
    if (!child.ParentAssetID) {
      throw new InternalServerErrorException({
        message: 'Este activo no tiene un equipo asignado',
      });
    }

    return this.unassignChild(child.ParentAssetID, childAssetID, userEmail);
  }
}
