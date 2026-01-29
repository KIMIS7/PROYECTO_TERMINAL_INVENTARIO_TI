import { IsNumber, IsNotEmpty } from 'class-validator';

export class CreatePermissionDto {
  @IsNumber()
  @IsNotEmpty()
  rolID: number;

  @IsNumber()
  @IsNotEmpty()
  dashboarpathID: number;
}
