import { Controller, Get, Query } from '@nestjs/common';
import { StatisticsService } from './statistics.service';

@Controller('statistics')
export class StatisticsController {
  constructor(private readonly statisticsService: StatisticsService) {}

  @Get('dashboard')
  getDashboardStats(
    @Query('siteID') siteID?: string,
    @Query('group') group?: string,
    @Query('stateID') stateID?: string,
  ) {
    return this.statisticsService.getDashboardStats({
      siteID: siteID ? Number(siteID) : undefined,
      group: group || undefined,
      stateID: stateID ? Number(stateID) : undefined,
    });
  }
}
