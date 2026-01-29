import { IsEmail, IsNotEmpty, IsNumber, IsString } from 'class-validator';

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

  @IsString()
  @IsNotEmpty()
  Department: string;

  @IsNumber()
  @IsNotEmpty()
  SiteID: number;

  @IsNumber()
  @IsNotEmpty()
  rolD: number;
}
