import { Controller, Get, Post, Body } from '@nestjs/common';
import { VendorService } from './vendor.service';

@Controller('vendor')
export class VendorController {
  constructor(private readonly vendorService: VendorService) {}

  @Get()
  findAll() {
    return this.vendorService.findAll();
  }

  @Post()
  create(@Body() body: { name: string }) {
    return this.vendorService.create(body.name);
  }
}
