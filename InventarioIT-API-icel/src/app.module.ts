import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { DatabaseModule } from './database/database.module';
import { RolModule } from './rol/rol.module';
import { PermissionModule } from './permission/permission.module';
import { DashboardPathModule } from './dashboard-path/dashboard-path.module';
import { UserModule } from './user/user.module';
import { SimpleAuthMiddleware } from './auth/simple-auth.middleware';
import { AuthModule } from './auth/auth.module';
//import { APP_GUARD } from '@nestjs/core';
//import { AzureAuthGuard } from './azure-auth/azure-auth.guard';

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
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(SimpleAuthMiddleware)
      .forRoutes(
        '/user',
        '/rol',
        '/permission',
        '/dashboard-path',
        '/upload',
        '/user-preferences',
        '/dashboard',
        '/comments',
        '/origin-port',
        '/approval-hierarchy',
      );
  }
}
