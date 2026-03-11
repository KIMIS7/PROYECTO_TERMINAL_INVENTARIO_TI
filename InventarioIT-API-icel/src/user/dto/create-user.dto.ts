import { IsEmail, IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateUserDto {
  @IsEmail()
  @IsNotEmpty()
  Email: string;

  @IsString()
  @IsNotEmpty()
  FirstName: string;

  @IsString()
  @IsNotEmpty()
  LastName: string;

  @IsNumber()
  @IsNotEmpty()
  DepartmentID: number;

  @IsNumber()
  @IsNotEmpty()
  rolD: number;

  @IsNumber()
  @IsOptional()
  SiteID?: number;
}
