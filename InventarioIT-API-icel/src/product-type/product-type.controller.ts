import { Controller, Get, Param } from '@nestjs/common';
import { ProductTypeService } from './product-type.service';

@Controller('product-type')
export class ProductTypeController {
  constructor(private readonly productTypeService: ProductTypeService) {}

  @Get()
  findAll() {
    return this.productTypeService.findAll();
  }

  @Get('categories')
  getCategories() {
    return this.productTypeService.getCategories();
  }

  @Get('category/:category')
  findByCategory(@Param('category') category: string) {
    return this.productTypeService.findByCategory(category);
  }
}
