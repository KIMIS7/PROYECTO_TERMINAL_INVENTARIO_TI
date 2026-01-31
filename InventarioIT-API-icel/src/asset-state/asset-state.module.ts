import { Module } from '@nestjs/common';
import { AssetStateService } from './asset-state.service';
import { AssetStateController } from './asset-state.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [AssetStateController],
  providers: [AssetStateService],
  imports: [DatabaseModule],
})
export class AssetStateModule {}
