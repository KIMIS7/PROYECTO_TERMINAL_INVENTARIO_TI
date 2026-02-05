import { IsNotEmpty, IsString, IsIn } from 'class-validator';

export const PRODUCT_CATEGORIES = ['Equipo', 'Accesorio', 'Componente', 'Otros'] as const;
export type ProductCategory = (typeof PRODUCT_CATEGORIES)[number];

export class CreateProductTypeDto {
  @IsNotEmpty({ message: 'El nombre es requerido' })
  @IsString()
  name: string;

  @IsNotEmpty({ message: 'La categoría es requerida' })
  @IsString()
  @IsIn(PRODUCT_CATEGORIES, {
    message: 'La categoría debe ser: Equipo, Accesorio, Componente u Otros',
  })
  category: ProductCategory;

  @IsNotEmpty({ message: 'El grupo es requerido' })
  @IsString()
  group: string;

  @IsNotEmpty({ message: 'La subcategoría es requerida' })
  @IsString()
  subCategory: string;
}
