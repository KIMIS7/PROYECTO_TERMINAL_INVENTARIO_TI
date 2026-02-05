import { Controller, Get, Post, Delete, Param, Body, ParseIntPipe } from '@nestjs/common';
import { ProductTypeService } from './product-type.service';
import { CreateProductTypeDto } from './dto/create-product-type.dto';

@Controller('product-type')
export class ProductTypeController {
  constructor(private readonly productTypeService: ProductTypeService) {}

  @Post()
  create(@Body() createProductTypeDto: CreateProductTypeDto) {
    return this.productTypeService.create(createProductTypeDto);
  }

  @Get()
  findAll() {
    return this.productTypeService.findAll();
  }

  @Get('available-categories')
  getAvailableCategories() {
    return this.productTypeService.getAvailableCategories();
  }

  @Get('categories')
  getCategories() {
    return this.productTypeService.getCategories();
  }

  @Get('category/:category')
  findByCategory(@Param('category') category: string) {
    return this.productTypeService.findByCategory(category);
  }

  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number) {
    return this.productTypeService.delete(id);
  }
}
