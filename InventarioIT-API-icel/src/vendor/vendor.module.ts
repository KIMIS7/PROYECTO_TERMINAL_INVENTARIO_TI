import { Module } from '@nestjs/common';
import { VendorService } from './vendor.service';
import { VendorController } from './vendor.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [VendorController],
  providers: [VendorService],
  imports: [DatabaseModule],
})
export class VendorModule {}
