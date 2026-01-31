import { Module } from '@nestjs/common';
import { ProductTypeService } from './product-type.service';
import { ProductTypeController } from './product-type.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [ProductTypeController],
  providers: [ProductTypeService],
  imports: [DatabaseModule],
})
export class ProductTypeModule {}
