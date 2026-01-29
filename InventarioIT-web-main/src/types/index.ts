export interface Role {
  rolID: number;
  name: string;
  power?: number;
  isActive: boolean;
}

export interface User {
  userID: number;
  email: string;
  name: string;
  isActive: boolean;
  pin: string;
  rolName: string;
  rolID: number;
}

export interface DashboardPath {
  dashboarpathID: number;
  path: string;
  name: string;
  icon?: string;
}

export interface RolePermission {
  roldashboardpathID: number;
  rolID: number;
  dashboarpathID: number;
  roleName: string;
  pathName: string;
  path: string;
  icon?: string;
}