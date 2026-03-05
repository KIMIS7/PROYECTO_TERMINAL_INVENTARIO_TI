import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.userService.create(createUserDto);
  }

  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @Get('search')
  searchUsers(
    @Query('q') query?: string,
    @Query('departmentID') departmentID?: string,
    @Query('siteID') siteID?: string,
  ) {
    return this.userService.searchUsers(
      query,
      departmentID ? +departmentID : undefined,
      siteID ? +siteID : undefined,
    );
  }

  @Get('departments')
  getDepartments() {
    return this.userService.getDepartments();
  }

  @Get('verify/:email')
  async verifyUser(@Param('email') email: string) {
    return this.userService.verifyUser(email);
  }

  @Get('profile/:email')
  async getUserProfile(@Param('email') email: string) {
    return this.userService.getUserProfile(email);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.userService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.userService.update(+id, updateUserDto);
  }

  @Patch(':id/updateUserStatus')
  updateStatus(@Param('id') id: string, @Body() body: { isActive: boolean }) {
    return this.userService.updateStatus(+id, body.isActive);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.userService.remove(+id);
  }
}
