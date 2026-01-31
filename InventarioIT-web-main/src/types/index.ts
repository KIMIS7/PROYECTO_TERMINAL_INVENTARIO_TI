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

// Tipos para Activos (Assets)
export interface ProductType {
  productTypeID: number;
  name: string;
  category: string;
  group: string;
  subCategory: string;
}

export interface Vendor {
  vendorID: number;
  name: string;
}

export interface AssetState {
  assetStateID: number;
  name: string;
}

export interface Company {
  companyID: number;
  description: string;
}

export interface Site {
  siteID: number;
  name: string;
  companyID: number;
}

export interface Asset {
  assetID: number;
  name: string;
  vendorID: number;
  productTypeID: number;
  assetState: number;
  companyID: number;
  siteID: number;
  userID: number;
  // Relaciones
  vendor?: Vendor;
  productType?: ProductType;
  assetStateInfo?: AssetState;
  company?: Company;
  site?: Site;
  assetDetail?: AssetDetail;
}

export interface AssetDetail {
  assetDetailID: number;
  assetID: number;
  productManuf?: string;
  ipAddress?: string;
  macAddress?: string;
  loanable?: string;
  vmPlatform?: string;
  virtualHost?: string;
  operatingSystem?: string;
  domain?: string;
  processorInfo?: string;
  processor?: string;
  physicalMemory?: string;
  hddModel?: string;
  hddSerial?: string;
  hddCapacity?: string;
  keyboardType?: string;
  mouseType?: string;
  numModel?: string;
  model?: string;
  imei?: string;
  modemFirmwareVersion?: string;
  platform?: string;
  osName?: string;
  osVersion?: string;
  ram?: string;
  serialNum?: string;
  purchaseDate?: string;
  warrantyExpiryDate?: string;
  createdTime?: string;
  lastUpdateTime?: string;
  assetACQDate?: string;
  assetExpiryDate?: string;
  assetTAG?: string;
  warrantyExpiry?: string;
  assignedTime?: string;
  barcode?: string;
  lastUpdateBy: number;
}

export interface CreateAssetDto {
  name: string;
  vendorID: number;
  productTypeID: number;
  assetState: number;
  companyID: number;
  siteID: number;
  userID?: number;
  // Detalles opcionales
  detail?: Partial<Omit<AssetDetail, 'assetDetailID' | 'assetID' | 'lastUpdateBy'>>;
}