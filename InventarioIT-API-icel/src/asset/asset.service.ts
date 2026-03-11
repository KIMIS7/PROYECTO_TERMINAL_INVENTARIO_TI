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

      // Crear el activo
      const newAsset = await this.prismaShopic.asset.create({
        data: {
          Name: name,
          VendorID: vendorID,
          ProductTypeID: productTypeID,
          AssetState: resolvedAssetState,
          CompanyID: resolvedCompanyID,
          SiteID: resolvedSiteID,
          UserID: userID || lastUpdateBy,
        },
      });

      // Si hay detalles, crearlos
      if (detail) {
        await this.prismaShopic.assetDetail.create({
          data: {
            AssetID: newAsset.AssetID,
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
            AssetTAG: detail.assetTAG,
            WarrantyExpiry: detail.warrantyExpiry ? new Date(detail.warrantyExpiry) : null,
            Barcode: detail.barcode,
            CreatedTime: new Date(),
            LastUpdateTime: new Date(),
            LastUpdateBy: lastUpdateBy,
          },
        });
      }

      // Registrar en historial
      await this.prismaShopic.assetHistory.create({
        data: {
          AssetID: newAsset.AssetID,
          Operation: 'CREATE',
          Description: `Activo "${name}" creado`,
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
          User: true,
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
        assetDetail: asset.AssetDetail[0]
          ? {
              assetDetailID: asset.AssetDetail[0].AssetDetailID,
              serialNum: asset.AssetDetail[0].SerialNum,
              assetTAG: asset.AssetDetail[0].AssetTAG,
              model: asset.AssetDetail[0].Model,
              productManuf: asset.AssetDetail[0].ProductManuf,
              ipAddress: asset.AssetDetail[0].IPAddress,
              macAddress: asset.AssetDetail[0].MACAddress,
              processor: asset.AssetDetail[0].Processor,
              processorInfo: asset.AssetDetail[0].ProcessorInfo,
              ram: asset.AssetDetail[0].RAM,
              physicalMemory: asset.AssetDetail[0].PhysicalMemory,
              hddModel: asset.AssetDetail[0].HDDModel,
              hddCapacity: asset.AssetDetail[0].HDDCapacity,
              operatingSystem: asset.AssetDetail[0].OperatingSystem,
              purchaseDate: asset.AssetDetail[0].PurchaseDate,
              warrantyExpiryDate: asset.AssetDetail[0].WarrantyExpiryDate,
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
          User: true,
          AssetHistory: {
            orderBy: { CreatedTime: 'desc' },
            take: 10,
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
        assetDetail: asset.AssetDetail[0]
          ? {
              assetDetailID: asset.AssetDetail[0].AssetDetailID,
              assetID: asset.AssetDetail[0].AssetID,
              productManuf: asset.AssetDetail[0].ProductManuf,
              ipAddress: asset.AssetDetail[0].IPAddress,
              macAddress: asset.AssetDetail[0].MACAddress,
              loanable: asset.AssetDetail[0].Loanable,
              vmPlatform: asset.AssetDetail[0].VMPlatform,
              virtualHost: asset.AssetDetail[0].VirtualHost,
              operatingSystem: asset.AssetDetail[0].OperatingSystem,
              domain: asset.AssetDetail[0].Domain,
              processorInfo: asset.AssetDetail[0].ProcessorInfo,
              processor: asset.AssetDetail[0].Processor,
              physicalMemory: asset.AssetDetail[0].PhysicalMemory,
              hddModel: asset.AssetDetail[0].HDDModel,
              hddSerial: asset.AssetDetail[0].HDDSerial,
              hddCapacity: asset.AssetDetail[0].HDDCapacity,
              keyboardType: asset.AssetDetail[0].KeyboardType,
              mouseType: asset.AssetDetail[0].MouseType,
              numModel: asset.AssetDetail[0].NumModel,
              model: asset.AssetDetail[0].Model,
              imei: asset.AssetDetail[0].IMEI,
              modemFirmwareVersion: asset.AssetDetail[0].ModemFirmwareVersion,
              platform: asset.AssetDetail[0].Platform,
              osName: asset.AssetDetail[0].OSName,
              osVersion: asset.AssetDetail[0].OSVersion,
              ram: asset.AssetDetail[0].RAM,
              serialNum: asset.AssetDetail[0].SerialNum,
              purchaseDate: asset.AssetDetail[0].PurchaseDate,
              warrantyExpiryDate: asset.AssetDetail[0].WarrantyExpiryDate,
              assetACQDate: asset.AssetDetail[0].AssetACQDate,
              assetExpiryDate: asset.AssetDetail[0].AssetExpiryDate,
              assetTAG: asset.AssetDetail[0].AssetTAG,
              warrantyExpiry: asset.AssetDetail[0].WarrantyExpiry,
              barcode: asset.AssetDetail[0].Barcode,
              createdTime: asset.AssetDetail[0].CreatedTime,
              lastUpdateTime: asset.AssetDetail[0].LastUpdateTime,
              lastUpdateBy: asset.AssetDetail[0].LastUpdateBy,
            }
          : null,
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

      // Actualizar detalles si existen
      if (detail) {
        const existingDetail = await this.prismaShopic.assetDetail.findFirst({
          where: { AssetID: id },
        });

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
              AssetTAG: detail.assetTAG,
              Barcode: detail.barcode,
              PurchaseDate: detail.purchaseDate ? new Date(detail.purchaseDate) : undefined,
              WarrantyExpiryDate: detail.warrantyExpiryDate ? new Date(detail.warrantyExpiryDate) : undefined,
              LastUpdateTime: new Date(),
              LastUpdateBy: lastUpdateBy,
            };

        if (existingDetail) {
          await this.prismaShopic.assetDetail.update({
            where: { AssetDetailID: existingDetail.AssetDetailID },
            data: detailData,
          });
        } else {
          await this.prismaShopic.assetDetail.create({
            data: {
              AssetID: id,
              ...detailData,
              PurchaseDate: detail.purchaseDate ? new Date(detail.purchaseDate) : null,
              WarrantyExpiryDate: detail.warrantyExpiryDate ? new Date(detail.warrantyExpiryDate) : null,
              CreatedTime: new Date(),
            },
          });
        }
      }

      // Registrar en historial
      await this.prismaShopic.assetHistory.create({
        data: {
          AssetID: id,
          Operation: 'UPDATE',
          Description: `Activo "${updatedAsset.Name}" actualizado`,
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

  async remove(id: number) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: id },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    try {
      // Eliminar detalles primero
      await this.prismaShopic.assetDetail.deleteMany({
        where: { AssetID: id },
      });

      // Eliminar historial
      await this.prismaShopic.assetHistory.deleteMany({
        where: { AssetID: id },
      });

      // Eliminar historial de propiedad
      await this.prismaShopic.assetOwnershipHistory.deleteMany({
        where: { AssetID: id },
      });

      // Eliminar el activo
      await this.prismaShopic.asset.delete({
        where: { AssetID: id },
      });

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
}
