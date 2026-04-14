import { Module } from '@nestjs/common';
import { DatabaseModule } from '../database/database.module';
import { AzureAuthGuard } from './azure-auth.guard';

@Module({
  imports: [DatabaseModule],
  providers: [AzureAuthGuard],
  exports: [AzureAuthGuard],
})
export class AzureAuthModule {}
