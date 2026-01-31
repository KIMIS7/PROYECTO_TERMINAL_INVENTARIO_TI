import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class ProductTypeService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async findAll() {
    try {
      const productTypes = await this.prismaShopic.productType.findMany();
      return productTypes.map((pt) => ({
        productTypeID: pt.ProductTypeID,
        name: pt.Name,
        category: pt.Category,
        group: pt.Group,
        subCategory: pt.SubCategory,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los tipos de producto',
      });
    }
  }

  async findByCategory(category: string) {
    try {
      const productTypes = await this.prismaShopic.productType.findMany({
        where: { Category: category },
      });
      return productTypes.map((pt) => ({
        productTypeID: pt.ProductTypeID,
        name: pt.Name,
        category: pt.Category,
        group: pt.Group,
        subCategory: pt.SubCategory,
      }));
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los tipos de producto por categoría',
      });
    }
  }

  async getCategories() {
    try {
      const productTypes = await this.prismaShopic.productType.findMany({
        select: { Category: true },
        distinct: ['Category'],
      });
      return productTypes.map((pt) => pt.Category);
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener las categorías',
      });
    }
  }
}
