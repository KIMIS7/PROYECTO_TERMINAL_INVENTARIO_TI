import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class CompanyService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async findAll() {
    try {
      const companies = await this.prismaShopic.company.findMany();
      return companies.map((c) => ({
        companyID: c.CompanyID,
        description: c.Description,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener las empresas',
      });
    }
  }
}
