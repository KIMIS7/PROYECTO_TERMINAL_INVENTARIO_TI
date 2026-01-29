export interface OriginPort {
  id: number;
  code: string;
  name: string;
  country?: string;
  description?: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  createdBy?: string;
  updatedBy?: string;
}

export interface CreateOriginPortDto {
  code: string;
  name: string;
  country?: string;
  description?: string;
  isActive?: boolean;
}

export type UpdateOriginPortDto = Partial<CreateOriginPortDto>;
