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

  @Get('available-groups')
  getAvailableGroups() {
    return this.productTypeService.getAvailableGroups();
  }

  @Get('groups')
  getGroups() {
    return this.productTypeService.getGroups();
  }

  @Get('group/:group')
  findByGroup(@Param('group') group: string) {
    return this.productTypeService.findByGroup(group);
  }

  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number) {
    return this.productTypeService.delete(id);
  }
}
