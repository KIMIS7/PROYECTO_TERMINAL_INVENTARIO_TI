import {
  Controller,
  Get,
  Post,
  Patch,
  Body,
  Param,
  Headers,
} from '@nestjs/common';
import { MovementService } from './movement.service';
import { CreateMovementDto } from './dto/create-movement.dto';
import { CreateBulkMovementDto } from './dto/create-bulk-movement.dto';
import { UpdateMovementDto } from './dto/update-movement.dto';

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

  @Post('bulk')
  createBulk(
    @Body() createBulkMovementDto: CreateBulkMovementDto,
    @Headers('user-email') userEmail: string,
  ) {
    return this.movementService.createBulk(createBulkMovementDto, userEmail);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateMovementDto: UpdateMovementDto,
    @Headers('user-email') userEmail: string,
  ) {
    return this.movementService.update(+id, updateMovementDto, userEmail);
  }

  @Get()
  findAll() {
    return this.movementService.findAll();
  }

  @Get('history')
  findAllHistory() {
    return this.movementService.findAllHistory();
  }

  @Get('asset/:assetId')
  findByAssetId(@Param('assetId') assetId: string) {
    return this.movementService.findByAssetId(+assetId);
  }
}
