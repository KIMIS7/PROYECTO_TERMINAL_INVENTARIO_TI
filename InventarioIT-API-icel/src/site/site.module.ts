import { Module } from '@nestjs/common';
import { SiteService } from './site.service';
import { SiteController } from './site.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [SiteController],
  providers: [SiteService],
  imports: [DatabaseModule],
})
export class SiteModule {}
