// user.dto.ts
import { Expose, Transform } from 'class-transformer';

export class UserDto {
  @Expose({ name: 'userID' })
  @Transform(({ obj }) => obj?.UserID)
  userID: number;

  @Expose({ name: 'email' })
  @Transform(({ obj }) => obj?.Email)
  email: string;

  @Expose({ name: 'name' })
  @Transform(({ obj }) => obj?.Name)
  name: string;

  @Expose()
  isActive: boolean;

  @Expose({ name: 'pin' })
  @Transform(({ obj }) => obj?.token || '')
  pin: string;

  @Expose({ name: 'departmentID' })
  @Transform(({ obj }) => obj?.DepartmentID)
  departmentID: number;

  @Expose({ name: 'rolID' })
  @Transform(({ obj }) => obj?.rolD)
  rolID: number;

  @Expose({ name: 'rolName' })
  @Transform(({ obj }) => obj?.rol?.name)
  rolName: string;

  @Expose({ name: 'departmentName' })
  @Transform(({ obj }) => obj?.Depart?.Name || '')
  departmentName: string;

  @Expose({ name: 'siteID' })
  @Transform(({ obj }) => obj?.SiteID || null)
  siteID: number | null;
}

