import { Module } from '@nestjs/common';
import { AssetService } from './asset.service';
import { AssetController } from './asset.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [AssetController],
  providers: [AssetService],
  imports: [DatabaseModule],
})
export class AssetModule {}
