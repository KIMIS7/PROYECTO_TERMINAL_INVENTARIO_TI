import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Headers,
} from '@nestjs/common';
import { MovementService } from './movement.service';
import { CreateMovementDto } from './dto/create-movement.dto';

@Controller('movement')
export class MovementController {
  constructor(private readonly movementService: MovementService) {}

  @Post()
  create(
    @Body() createMovementDto: CreateMovementDto,
    @Headers('user-email') userEmail: string,
  ) {
    return this.movementService.create(createMovementDto, userEmail);
  }

  @Get()
  findAll() {
    return this.movementService.findAll();
  }

  @Get('asset/:assetId')
  findByAssetId(@Param('assetId') assetId: string) {
    return this.movementService.findByAssetId(+assetId);
  }
}
