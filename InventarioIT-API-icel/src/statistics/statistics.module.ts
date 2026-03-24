import { Module } from '@nestjs/common';
import { StatisticsService } from './statistics.service';
import { StatisticsController } from './statistics.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [StatisticsController],
  providers: [StatisticsService],
  imports: [DatabaseModule],
})
export class StatisticsModule {}
