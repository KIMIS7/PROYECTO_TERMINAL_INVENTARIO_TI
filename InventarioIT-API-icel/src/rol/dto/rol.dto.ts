// user.dto.ts
import { Expose } from 'class-transformer';

export class RolDto {
  @Expose()
  rolID: number;

  @Expose()
  name: string;

  @Expose()
  isActive: boolean;
}
