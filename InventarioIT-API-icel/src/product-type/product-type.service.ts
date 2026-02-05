import {
  Injectable,
  InternalServerErrorException,
  ConflictException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';
import { CreateProductTypeDto, PRODUCT_CATEGORIES } from './dto/create-product-type.dto';

@Injectable()
export class ProductTypeService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async create(createProductTypeDto: CreateProductTypeDto) {
    try {
      // Verificar si ya existe un tipo de producto con el mismo nombre
      const existing = await this.prismaShopic.productType.findFirst({
        where: {
          Name: createProductTypeDto.name,
          Category: createProductTypeDto.category,
        },
      });

      if (existing) {
        throw new ConflictException(
          'Ya existe un tipo de producto con este nombre en esta categoría',
        );
      }

      const productType = await this.prismaShopic.productType.create({
        data: {
          Name: createProductTypeDto.name,
          Category: createProductTypeDto.category,
          Group: createProductTypeDto.group,
          SubCategory: createProductTypeDto.subCategory,
        },
      });

      return {
        success: true,
        message: 'Tipo de producto creado exitosamente',
        data: {
          productTypeID: productType.ProductTypeID,
          name: productType.Name,
          category: productType.Category,
          group: productType.Group,
          subCategory: productType.SubCategory,
        },
      };
    } catch (error) {
      if (error instanceof ConflictException) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el tipo de producto',
      });
    }
  }

  async delete(productTypeID: number) {
    try {
      // Verificar si existe
      const existing = await this.prismaShopic.productType.findUnique({
        where: { ProductTypeID: productTypeID },
      });

      if (!existing) {
        throw new NotFoundException('Tipo de producto no encontrado');
      }

      // Verificar si hay activos asociados
      const assetsCount = await this.prismaShopic.asset.count({
        where: { ProductTypeID: productTypeID },
      });

      if (assetsCount > 0) {
        throw new ConflictException(
          `No se puede eliminar: hay ${assetsCount} activo(s) asociado(s) a este tipo de producto`,
        );
      }

      await this.prismaShopic.productType.delete({
        where: { ProductTypeID: productTypeID },
      });

      return {
        success: true,
        message: 'Tipo de producto eliminado exitosamente',
        data: { productTypeID },
      };
    } catch (error) {
      if (
        error instanceof ConflictException ||
        error instanceof NotFoundException
      ) {
        throw error;
      }
      throw new InternalServerErrorException({
        message: error.message || 'Error al eliminar el tipo de producto',
      });
    }
  }

  getAvailableCategories() {
    return {
      success: true,
      data: PRODUCT_CATEGORIES,
    };
  }

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
