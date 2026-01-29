import { Module } from '@nestjs/common';
import { RolService } from './rol.service';
import { RolController } from './rol.controller';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  controllers: [RolController],
  providers: [RolService],
  imports: [DatabaseModule],
})
export class RolModule {}
