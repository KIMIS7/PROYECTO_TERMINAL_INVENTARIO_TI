import { Controller, Get, Post, Patch, Param, Body } from '@nestjs/common';
import { DashboardPathService } from './dashboard-path.service';
import { CreateDashboardPathDto } from './dto/create-dashboard-path.dto';

@Controller('dashboard-path')
export class DashboardPathController {
  constructor(private readonly dashboardPathService: DashboardPathService) {}

  @Post()
  create(@Body() createDashboardPathDto: CreateDashboardPathDto) {
    return this.dashboardPathService.create(createDashboardPathDto);
  }

  @Get()
  findAll() {
    return this.dashboardPathService.findAll();
  }

  @Patch(':id/icon')
  updateIcon(@Param('id') id: string, @Body('icon') icon: string) {
    return this.dashboardPathService.updateIcon(+id, icon);
  }
}
