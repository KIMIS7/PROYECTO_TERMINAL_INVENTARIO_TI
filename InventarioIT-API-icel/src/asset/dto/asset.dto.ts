import { Expose, Type } from 'class-transformer';

export class AssetDetailDto {
  @Expose()
  assetDetailID: number;

  @Expose()
  assetID: number;

  @Expose()
  productManuf: string;

  @Expose()
  ipAddress: string;

  @Expose()
  macAddress: string;

  @Expose()
  loanable: string;

  @Expose()
  vmPlatform: string;

  @Expose()
  virtualHost: string;

  @Expose()
  operatingSystem: string;

  @Expose()
  domain: string;

  @Expose()
  processorInfo: string;

  @Expose()
  processor: string;

  @Expose()
  physicalMemory: string;

  @Expose()
  hddModel: string;

  @Expose()
  hddSerial: string;

  @Expose()
  hddCapacity: string;

  @Expose()
  keyboardType: string;

  @Expose()
  mouseType: string;

  @Expose()
  numModel: string;

  @Expose()
  model: string;

  @Expose()
  imei: string;

  @Expose()
  modemFirmwareVersion: string;

  @Expose()
  platform: string;

  @Expose()
  osName: string;

  @Expose()
  osVersion: string;

  @Expose()
  ram: string;

  @Expose()
  serialNum: string;

  @Expose()
  purchaseDate: Date;

  @Expose()
  warrantyExpiryDate: Date;

  @Expose()
  createdTime: Date;

  @Expose()
  lastUpdateTime: Date;

  @Expose()
  assetACQDate: Date;

  @Expose()
  assetExpiryDate: Date;

  @Expose()
  assetTAG: string;

  @Expose()
  warrantyExpiry: Date;

  @Expose()
  assignedTime: Date;

  @Expose()
  barcode: string;

  @Expose()
  lastUpdateBy: number;
}

export class ProductTypeDto {
  @Expose()
  productTypeID: number;

  @Expose()
  name: string;

  @Expose()
  category: string;

  @Expose()
  group: string;

  @Expose()
  subCategory: string;
}

export class VendorDto {
  @Expose()
  vendorID: number;

  @Expose()
  name: string;
}

export class AssetStateDto {
  @Expose()
  assetStateID: number;

  @Expose()
  name: string;
}

export class CompanyDto {
  @Expose()
  companyID: number;

  @Expose()
  description: string;
}

export class SiteDto {
  @Expose()
  siteID: number;

  @Expose()
  name: string;

  @Expose()
  companyID: number;
}

export class AssetDto {
  @Expose()
  assetID: number;

  @Expose()
  name: string;

  @Expose()
  vendorID: number;

  @Expose()
  productTypeID: number;

  @Expose()
  assetState: number;

  @Expose()
  companyID: number;

  @Expose()
  siteID: number;

  @Expose()
  userID: number;

  @Expose()
  @Type(() => VendorDto)
  Vendor: VendorDto;

  @Expose()
  @Type(() => ProductTypeDto)
  ProductType: ProductTypeDto;

  @Expose()
  @Type(() => AssetStateDto)
  AssetState_Asset_AssetStateToAssetState: AssetStateDto;

  @Expose()
  @Type(() => CompanyDto)
  Company: CompanyDto;

  @Expose()
  @Type(() => SiteDto)
  Site: SiteDto;

  @Expose()
  @Type(() => AssetDetailDto)
  AssetDetail: AssetDetailDto[];
}
