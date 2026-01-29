// user.dto.ts
import { Expose, Transform } from 'class-transformer';

export class UserDto {
  UserID: number;
  Email: string;
  FirstName: string;
  LastName: string;
  Name: string;
  Department: string;
  SiteID: number;
  rolD: number;
  isActive: boolean;
  token: string;
  createdAt: Date;
}

