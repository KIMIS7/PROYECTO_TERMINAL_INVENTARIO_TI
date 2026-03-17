import { Module } from '@nestjs/common';
import { ReportService } from './report.service';
import { ReportController } from './report.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [ReportController],
  providers: [ReportService],
  imports: [DatabaseModule],
})
export class ReportModule {}
