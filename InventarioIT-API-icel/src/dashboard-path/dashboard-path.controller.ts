import { Controller, Get, Patch, Param, Body } from '@nestjs/common';
import { DashboardPathService } from './dashboard-path.service';

@Controller('dashboard-path')
export class DashboardPathController {
  constructor(private readonly dashboardPathService: DashboardPathService) {}

  @Get()
  findAll() {
    return this.dashboardPathService.findAll();
  }

  @Patch(':id/icon')
  updateIcon(@Param('id') id: string, @Body('icon') icon: string) {
    return this.dashboardPathService.updateIcon(+id, icon);
  }
}
