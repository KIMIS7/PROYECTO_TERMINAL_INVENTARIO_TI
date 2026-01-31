import { Controller, Get, Param } from '@nestjs/common';
import { SiteService } from './site.service';

@Controller('site')
export class SiteController {
  constructor(private readonly siteService: SiteService) {}

  @Get()
  findAll() {
    return this.siteService.findAll();
  }

  @Get('company/:companyID')
  findByCompany(@Param('companyID') companyID: string) {
    return this.siteService.findByCompany(+companyID);
  }
}
