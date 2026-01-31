import { Controller, Get } from '@nestjs/common';
import { AssetStateService } from './asset-state.service';

@Controller('asset-state')
export class AssetStateController {
  constructor(private readonly assetStateService: AssetStateService) {}

  @Get()
  findAll() {
    return this.assetStateService.findAll();
  }
}
