import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';

// Global BigInt serialization fix
(BigInt.prototype as any).toJSON = function () {
  return this.toString();
};

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { cors: true });

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  // Aplicar prefijo global si existe en las variables de entorno
  if (process.env.API_PREFIX) {
    app.setGlobalPrefix(process.env.API_PREFIX);
  }

  // El guard de autenticación (AzureAuthGuard) se registra globalmente
  // via APP_GUARD en app.module.ts. Todos los endpoints están protegidos
  // excepto los marcados con @Public().

  await app.listen(process.env.API_PORT ?? 3001);
}
bootstrap();
