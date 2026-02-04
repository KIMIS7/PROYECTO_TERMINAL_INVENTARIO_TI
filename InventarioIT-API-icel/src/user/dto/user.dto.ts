// user.dto.ts
import { Expose, Transform } from 'class-transformer';

export class UserDto {
  @Expose()
  UserID: number;

  @Expose()
  Email: string;

  @Expose()
  FirstName: string;

  @Expose()
  LastName: string;

  @Expose()
  Name: string;

  @Expose()
  Department: string;

  @Expose()
  SiteID: number;

  @Expose()
  rolD: number;

  @Expose()
  isActive: boolean;

  @Expose()
  token: string;

  @Expose()
  createdAt: Date;

  @Expose()
  @Transform(({ obj }) => obj?.rol?.name)
  rolName: string;
}

