import { Module } from '@nestjs/common';
import { DashboardPathService } from './dashboard-path.service';
import { DashboardPathController } from './dashboard-path.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [DashboardPathController],
  providers: [DashboardPathService],
  exports: [DashboardPathService],
})
export class DashboardPathModule {}
