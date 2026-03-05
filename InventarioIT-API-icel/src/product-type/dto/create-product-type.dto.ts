import { IsNotEmpty, IsString, IsIn } from 'class-validator';

export const PRODUCT_GROUPS = ['Equipo', 'Accesorio', 'Componente', 'Otros'] as const;
export type ProductGroup = (typeof PRODUCT_GROUPS)[number];

export class CreateProductTypeDto {
  @IsNotEmpty({ message: 'El nombre es requerido' })
  @IsString()
  name: string;

  @IsNotEmpty({ message: 'El grupo es requerido' })
  @IsString()
  @IsIn(PRODUCT_GROUPS, {
    message: 'El grupo debe ser: Equipo, Accesorio, Componente u Otros',
  })
  group: ProductGroup;
}
