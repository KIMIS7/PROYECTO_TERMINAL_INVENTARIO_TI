import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class SiteService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async findAll() {
    try {
      const sites = await this.prismaShopic.site.findMany();
      return sites.map((s) => ({
        siteID: s.SiteID,
        name: s.Name,
        companyID: s.CompanyID,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los sitios',
      });
    }
  }

  async findByCompany(companyID: number) {
    try {
      const sites = await this.prismaShopic.site.findMany({
        where: { CompanyID: companyID },
      });
      return sites.map((s) => ({
        siteID: s.SiteID,
        name: s.Name,
        companyID: s.CompanyID,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los sitios por empresa',
      });
    }
  }
}
