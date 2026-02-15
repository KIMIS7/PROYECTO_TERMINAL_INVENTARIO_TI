import { Module } from '@nestjs/common';
import { MovementService } from './movement.service';
import { MovementController } from './movement.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [MovementController],
  providers: [MovementService],
  imports: [DatabaseModule],
})
export class MovementModule {}
