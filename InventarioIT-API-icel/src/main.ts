import { NestFactory, Reflector } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { AzureAuthGuard } from './azure-auth/azure-auth.guard';

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

  const reflector = app.get(Reflector);
  //app.useGlobalGuards(new AzureAuthGuard(reflector));

  await app.listen(process.env.API_PORT ?? 3001);
}
bootstrap();
