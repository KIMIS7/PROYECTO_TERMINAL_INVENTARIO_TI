import { Controller, Get } from '@nestjs/common';
import { DashboardPathService } from './dashboard-path.service';

@Controller('dashboard-path')
export class DashboardPathController {
  constructor(private readonly dashboardPathService: DashboardPathService) {}

  @Get()
  findAll() {
    return this.dashboardPathService.findAll();
  }
}
