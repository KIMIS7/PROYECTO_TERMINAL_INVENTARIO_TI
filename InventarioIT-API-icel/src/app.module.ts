import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { APP_GUARD } from '@nestjs/core';
import { AppController } from './app.controller';
import { DatabaseModule } from './database/database.module';
import { RolModule } from './rol/rol.module';
import { PermissionModule } from './permission/permission.module';
import { DashboardPathModule } from './dashboard-path/dashboard-path.module';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { AzureAuthModule } from './azure-auth/azure-auth.module';
import { AzureAuthGuard } from './azure-auth/azure-auth.guard';
// Módulos de activos
import { AssetModule } from './asset/asset.module';
import { ProductTypeModule } from './product-type/product-type.module';
import { VendorModule } from './vendor/vendor.module';
import { AssetStateModule } from './asset-state/asset-state.module';
import { CompanyModule } from './company/company.module';
import { SiteModule } from './site/site.module';
import { MovementModule } from './movement/movement.module';
import { ReportModule } from './report/report.module';
import { StatisticsModule } from './statistics/statistics.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    DatabaseModule,
    RolModule,
    PermissionModule,
    DashboardPathModule,
    UserModule,
    AuthModule,
    AzureAuthModule,
    // Módulos de activos
    AssetModule,
    ProductTypeModule,
    VendorModule,
    AssetStateModule,
    CompanyModule,
    SiteModule,
    MovementModule,
    ReportModule,
    StatisticsModule,
  ],
  controllers: [AppController],
  providers: [
    // Guard global: protege TODOS los endpoints excepto los marcados con @Public()
    {
      provide: APP_GUARD,
      useClass: AzureAuthGuard,
    },
  ],
})
export class AppModule {}
