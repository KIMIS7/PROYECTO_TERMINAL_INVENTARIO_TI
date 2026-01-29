import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { CreateRolDto } from './dto/create-rol.dto';
import { UpdateRolDto } from './dto/update-rol.dto';
import { PrismaShopic } from 'src/database/database.service';
import { plainToInstance } from 'class-transformer';
import { RolDto } from './dto/rol.dto';

@Injectable()
export class RolService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async create(createRolDto: CreateRolDto) {
    const { name } = createRolDto;

    if (!name) throw new NotFoundException('El nombre del rol es requerido');

    const rolExists = await this.prismaShopic.rol.findFirst({
      where: { name: name.toUpperCase() },
    });
    if (rolExists) throw new ConflictException('El rol ya existe');
    try {
      const newRol = await this.prismaShopic.rol.create({
        data: {
          name: name.toUpperCase(),
        },
      });
      return {
        message: 'Rol creado exitosamente',
        data: plainToInstance(RolDto, newRol, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al crear el rol',
      });
    }
  }

  async findAll() {
    try {
      const roles = await this.prismaShopic.rol.findMany();
      return plainToInstance(RolDto, roles, {
        excludeExtraneousValues: true,
      });
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener los roles',
      });
    }
  }

  findOne(id: number) {
    return `This action returns a #${id} rol`;
  }

  async update(id: number, updateRolDto: UpdateRolDto) {
    const { name } = updateRolDto;

    if (!name) throw new NotFoundException('El nombre del rol es requerido');

    const rolExists = await this.prismaShopic.rol.findUnique({
      where: { rolID: id },
    });
    if (!rolExists) throw new NotFoundException('El rol no existe');

    const rolNameExists = await this.prismaShopic.rol.findFirst({
      where: {
        name: name.toUpperCase(),
        rolID: { not: id },
      },
    });
    if (rolNameExists)
      throw new ConflictException('El nombre del rol ya existe');

    try {
      const updatedRol = await this.prismaShopic.rol.update({
        where: { rolID: id },
        data: {
          name: name.toUpperCase(),
        },
      });
      return {
        message: 'Rol actualizado exitosamente',
        data: plainToInstance(RolDto, updatedRol, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al actualizar el rol',
      });
    }
  }

  async updateStatus(rolID: number, isActive: boolean) {
    const rolExists = await this.prismaShopic.rol.findUnique({
      where: { rolID },
    });
    if (!rolExists) throw new NotFoundException('El rol no existe');

    try {
      const updatedRol = await this.prismaShopic.rol.update({
        where: { rolID },
        data: {
          isActive,
        },
      });
      return {
        message: `Rol ${isActive ? 'habilitado' : 'deshabilitado'} exitosamente`,
        data: plainToInstance(RolDto, updatedRol, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al actualizar el estado del rol',
      });
    }
  }

  async remove(rolID: number) {
    const rolExists = await this.prismaShopic.rol.findUnique({
      where: { rolID },
    });
    if (!rolExists) throw new NotFoundException('El rol no existe');
    try {
      const deletedRol = await this.prismaShopic.rol.delete({
        where: { rolID },
      });
      return {
        message: 'Rol eliminado exitosamente',
        data: plainToInstance(RolDto, deletedRol, {
          excludeExtraneousValues: true,
        }),
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al eliminar el rol',
      });
    }
  }
}
