import { Module } from '@nestjs/common';
import { PrismaShopic } from './database.service';

@Module({
  providers: [PrismaShopic],
  exports: [PrismaShopic],
})
export class DatabaseModule {}
