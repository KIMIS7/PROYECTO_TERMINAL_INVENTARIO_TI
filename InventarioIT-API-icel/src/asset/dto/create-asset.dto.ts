import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateAssetDetailDto {
  @IsOptional()
  @IsString()
  productManuf?: string;

  @IsOptional()
  @IsString()
  ipAddress?: string;

  @IsOptional()
  @IsString()
  macAddress?: string;

  @IsOptional()
  @IsString()
  loanable?: string;

  @IsOptional()
  @IsString()
  vmPlatform?: string;

  @IsOptional()
  @IsString()
  virtualHost?: string;

  @IsOptional()
  @IsString()
  operatingSystem?: string;

  @IsOptional()
  @IsString()
  domain?: string;

  @IsOptional()
  @IsString()
  processorInfo?: string;

  @IsOptional()
  @IsString()
  processor?: string;

  @IsOptional()
  @IsString()
  physicalMemory?: string;

  @IsOptional()
  @IsString()
  hddModel?: string;

  @IsOptional()
  @IsString()
  hddSerial?: string;

  @IsOptional()
  @IsString()
  hddCapacity?: string;

  @IsOptional()
  @IsString()
  keyboardType?: string;

  @IsOptional()
  @IsString()
  mouseType?: string;

  @IsOptional()
  @IsString()
  numModel?: string;

  @IsOptional()
  @IsString()
  model?: string;

  @IsOptional()
  @IsString()
  imei?: string;

  @IsOptional()
  @IsString()
  modemFirmwareVersion?: string;

  @IsOptional()
  @IsString()
  platform?: string;

  @IsOptional()
  @IsString()
  osName?: string;

  @IsOptional()
  @IsString()
  osVersion?: string;

  @IsOptional()
  @IsString()
  ram?: string;

  @IsOptional()
  @IsString()
  serialNum?: string;

  @IsOptional()
  @IsString()
  purchaseDate?: string;

  @IsOptional()
  @IsString()
  warrantyExpiryDate?: string;

  @IsOptional()
  @IsString()
  assetACQDate?: string;

  @IsOptional()
  @IsString()
  assetExpiryDate?: string;

  @IsOptional()
  @IsString()
  assetTAG?: string;

  @IsOptional()
  @IsString()
  warrantyExpiry?: string;

  @IsOptional()
  @IsString()
  barcode?: string;
}

export class CreateAssetDto {
  @IsNotEmpty({ message: 'El nombre es requerido' })
  @IsString()
  name: string;

  @IsNotEmpty({ message: 'El proveedor es requerido' })
  @IsNumber()
  vendorID: number;

  @IsNotEmpty({ message: 'El tipo de producto es requerido' })
  @IsNumber()
  productTypeID: number;

  @IsOptional()
  @IsNumber()
  assetState?: number;

  @IsOptional()
  @IsNumber()
  companyID?: number;

  @IsOptional()
  @IsNumber()
  siteID?: number;

  @IsOptional()
  @IsNumber()
  userID?: number;

  @IsOptional()
  @IsString()
  assignmentFromDate?: string;

  @IsOptional()
  @IsString()
  assignmentToDate?: string;

  @IsOptional()
  detail?: CreateAssetDetailDto;
}
