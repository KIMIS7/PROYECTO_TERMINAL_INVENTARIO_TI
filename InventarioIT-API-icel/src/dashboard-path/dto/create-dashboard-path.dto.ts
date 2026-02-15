import { IsNotEmpty, IsString } from 'class-validator';

export class CreateDashboardPathDto {
  @IsString()
  @IsNotEmpty({ message: 'El path es requerido' })
  path: string;

  @IsString()
  @IsNotEmpty({ message: 'El nombre es requerido' })
  name: string;
}
