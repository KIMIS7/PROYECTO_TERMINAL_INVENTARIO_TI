import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class VendorService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async findAll() {
    try {
      const vendors = await this.prismaShopic.vendor.findMany();
      return vendors.map((v) => ({
        vendorID: v.VendorID,
        name: v.Name,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los proveedores',
      });
    }
  }

  async create(name: string) {
    const existing = await this.prismaShopic.vendor.findFirst({
      where: { Name: name },
    });

    if (existing) {
      throw new ConflictException('El proveedor ya existe');
    }

    try {
      const vendor = await this.prismaShopic.vendor.create({
        data: { Name: name },
      });
      return {
        success: true,
        message: 'Proveedor creado exitosamente',
        data: { vendorID: vendor.VendorID, name: vendor.Name },
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el proveedor',
      });
    }
  }
}
