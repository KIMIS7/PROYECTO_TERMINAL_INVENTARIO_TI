import { IsOptional, IsString } from 'class-validator';

export class UpdateMovementDto {
  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  responsible?: string;
}
