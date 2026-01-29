import { Expose, Transform } from 'class-transformer';

export class PermissionDto {
  @Expose()
  roldashboardpathID: number;

  @Expose()
  @Transform(({ obj }) => obj?.dashboard_paths?.path)
  url: string;

  @Expose()
  @Transform(({ obj }) => obj?.dashboard_paths?.name)
  title: string;

  @Expose()
  @Transform(({ obj }) => obj?.dashboard_paths?.icon)
  icon: string;
}
