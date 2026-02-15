import { IsNotEmpty, IsNumber, IsOptional, IsString, IsIn } from 'class-validator';

export const MOVEMENT_TYPES = ['ALTA', 'BAJA', 'REASIGNACION', 'PRESTAMO'] as const;
export type MovementType = (typeof MOVEMENT_TYPES)[number];

export class CreateMovementDto {
  @IsNotEmpty({ message: 'El ID del activo es requerido' })
  @IsNumber()
  assetID: number;

  @IsNotEmpty({ message: 'El tipo de movimiento es requerido' })
  @IsString()
  @IsIn(MOVEMENT_TYPES, {
    message: 'El tipo de movimiento debe ser: ALTA, BAJA, REASIGNACION o PRESTAMO',
  })
  movementType: MovementType;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  responsible?: string;
}
