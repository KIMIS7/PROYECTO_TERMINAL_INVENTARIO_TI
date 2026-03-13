import {
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  IsIn,
  IsArray,
  ArrayMinSize,
} from 'class-validator';

export const BULK_MOVEMENT_TYPES = ['REASIGNACION', 'RESGUARDO', 'REPARACION', 'BAJA'] as const;
export type BulkMovementType = (typeof BULK_MOVEMENT_TYPES)[number];

export class CreateBulkMovementDto {
  @IsArray()
  @ArrayMinSize(1, { message: 'Debe seleccionar al menos un activo' })
  @IsNumber({}, { each: true })
  assetIDs: number[];

  @IsNotEmpty({ message: 'El tipo de movimiento es requerido' })
  @IsString()
  @IsIn(BULK_MOVEMENT_TYPES, {
    message: 'El tipo de movimiento debe ser: REASIGNACION, RESGUARDO, REPARACION o BAJA',
  })
  movementType: BulkMovementType;

  @IsOptional()
  @IsNumber()
  companyID?: number;

  @IsOptional()
  @IsNumber()
  siteID?: number;

  @IsOptional()
  @IsNumber()
  userID?: number;

  @IsOptional()
  @IsNumber()
  departID?: number;

  @IsOptional()
  @IsString()
  fromDate?: string;

  @IsOptional()
  @IsString()
  toDate?: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  responsible?: string;
}
