import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Headers,
} from '@nestjs/common';
import { AssetService } from './asset.service';
import { CreateAssetDto } from './dto/create-asset.dto';
import { UpdateAssetDto } from './dto/update-asset.dto';

@Controller('asset')
export class AssetController {
  constructor(private readonly assetService: AssetService) {}

  @Post()
  create(
    @Body() createAssetDto: CreateAssetDto,
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.create(createAssetDto, userEmail);
  }

  @Get()
  findAll() {
    return this.assetService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.assetService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateAssetDto: UpdateAssetDto,
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.update(+id, updateAssetDto, userEmail);
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.remove(+id, userEmail);
  }

  // --- Asset Assignment (Parent/Child relationships) ---

  @Get(':id/children')
  getChildren(@Param('id') id: string) {
    return this.assetService.getChildren(+id);
  }

  @Get(':id/parent')
  getParent(@Param('id') id: string) {
    return this.assetService.getParent(+id);
  }

  @Get(':id/relationships')
  getRelationships(@Param('id') id: string) {
    return this.assetService.getRelationships(+id);
  }

  @Patch(':id/assign')
  assignChild(
    @Param('id') id: string,
    @Body() body: { childAssetID: number },
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.assignChild(+id, body.childAssetID, userEmail);
  }

  @Patch(':id/unassign')
  unassignChild(
    @Param('id') id: string,
    @Body() body: { childAssetID: number },
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.unassignChild(+id, body.childAssetID, userEmail);
  }

  @Patch(':id/assign-parent')
  assignParent(
    @Param('id') id: string,
    @Body() body: { parentAssetID: number },
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.assignParent(+id, body.parentAssetID, userEmail);
  }

  @Patch(':id/unassign-parent')
  unassignParent(
    @Param('id') id: string,
    @Headers('user-email') userEmail: string,
  ) {
    return this.assetService.unassignParent(+id, userEmail);
  }
}
