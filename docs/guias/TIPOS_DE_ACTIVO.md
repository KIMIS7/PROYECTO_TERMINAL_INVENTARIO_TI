# Guia: Tipos de Activo y Plantillas por Categoria

Esta guia documenta la funcionalidad de gestion de tipos de activo con plantillas dinamicas basadas en categorias.

## Indice

1. [Descripcion General](#descripcion-general)
2. [Categorias Disponibles](#categorias-disponibles)
3. [Plantillas de Campos](#plantillas-de-campos)
4. [Archivos Clave](#archivos-clave)
5. [Como Modificar](#como-modificar)
6. [Ejemplos de Uso](#ejemplos-de-uso)

---

## Descripcion General

El sistema permite crear tipos de activo (ProductType) organizados en 4 categorias fijas. Cada categoria tiene una plantilla de campos diferente al dar de alta un activo.

### Flujo de uso:

1. Usuario va a dar de alta un activo
2. Selecciona la categoria (Equipo, Accesorio, Componente, Otros)
3. Selecciona el tipo de activo (filtrado por categoria)
4. Si no existe el tipo, puede crearlo con el boton "Crear nuevo"
5. El formulario muestra campos segun la categoria seleccionada

---

## Categorias Disponibles

| Categoria | Icono | Descripcion | Ejemplos |
|-----------|-------|-------------|----------|
| **Equipo** | Monitor | Dispositivos de computo completos | Laptops, PCs, Servidores, Impresoras |
| **Accesorio** | Headphones | Perifericos y accesorios | Teclados, Mouse, Monitores, Audifonos |
| **Componente** | Cpu | Partes internas de equipos | RAM, Discos duros, Procesadores, Tarjetas |
| **Otros** | Package | Cualquier otro tipo de activo | Celulares, Tablets, Licencias |

---

## Plantillas de Campos

### Campos Basicos (Todas las categorias)

| Campo | ID | Descripcion |
|-------|-----|-------------|
| Numero de Serie | `serialNum` | Numero de serie del fabricante |
| Asset TAG | `assetTAG` | Etiqueta interna del activo |
| Modelo | `model` | Modelo del producto |
| Fabricante | `productManuf` | Fabricante del producto |

### Campos de Equipo (+ campos basicos)

| Campo | ID | Descripcion |
|-------|-----|-------------|
| Direccion IP | `ipAddress` | IP asignada al equipo |
| Direccion MAC | `macAddress` | MAC Address de red |
| Dominio | `domain` | Dominio de red |
| Procesador | `processor` | CPU del equipo |
| Memoria RAM | `ram` | Cantidad de RAM |
| Almacenamiento | `hddCapacity` | Capacidad de disco |
| Sistema Operativo | `operatingSystem` | SO instalado |

### Campos de Componente (+ campos basicos)

| Campo | ID | Descripcion |
|-------|-----|-------------|
| Memoria Fisica | `physicalMemory` | Especificacion de memoria |
| Modelo HDD/SSD | `hddModel` | Modelo del disco |
| Serial HDD/SSD | `hddSerial` | Numero de serie del disco |

### Campos de Otros (TODOS los campos)

Incluye todos los campos anteriores mas:

| Campo | ID | Descripcion |
|-------|-----|-------------|
| IMEI | `imei` | Para dispositivos moviles |
| Plataforma | `platform` | Android, iOS, etc. |
| Nombre SO | `osName` | Nombre del sistema operativo |
| Version SO | `osVersion` | Version del SO |

---

## Archivos Clave

### Backend (NestJS)

```
InventarioIT-API-icel/src/product-type/
├── dto/
│   └── create-product-type.dto.ts    # DTO y categorias fijas
├── product-type.controller.ts         # Endpoints REST
└── product-type.service.ts            # Logica de negocio
```

| Archivo | Proposito |
|---------|-----------|
| `create-product-type.dto.ts` | Define las 4 categorias fijas y validaciones |
| `product-type.service.ts` | Metodos create(), delete(), getAvailableCategories() |
| `product-type.controller.ts` | Endpoints POST, DELETE, GET |

### Frontend (Next.js)

```
InventarioIT-web-main/src/
├── components/
│   ├── CreateAssetModal.tsx           # Modal principal de alta de activos
│   └── CreateProductTypeModal.tsx     # Modal para crear tipos de activo
├── lib/
│   └── api.ts                         # Cliente API con metodos productType
├── pages/
│   └── altas/
│       └── index.tsx                  # Pagina de altas
└── types/
    └── index.ts                       # Interfaces TypeScript
```

---

## Como Modificar

### 1. Agregar/Cambiar Categorias

**Backend** - `create-product-type.dto.ts` (linea 3):
```typescript
export const PRODUCT_CATEGORIES = ['Equipo', 'Accesorio', 'Componente', 'Otros', 'NuevaCategoria'] as const;
```

**Frontend** - `CreateProductTypeModal.tsx` (linea 18):
```typescript
export const PRODUCT_CATEGORIES = ["Equipo", "Accesorio", "Componente", "Otros", "NuevaCategoria"] as const;
```

Tambien actualizar:
- `categoryIcons` (lineas 23-28) - Agregar icono
- `categoryDescriptions` (lineas 31-36) - Agregar descripcion

### 2. Agregar Campo a una Plantilla

En `CreateAssetModal.tsx`:

**Paso 1: Agregar al estado formData** (linea ~62):
```typescript
const [formData, setFormData] = useState({
  // ... campos existentes
  nuevocampo: "",
});
```

**Paso 2: Agregar al resetForm()** (linea ~261):
```typescript
const resetForm = () => {
  setFormData({
    // ... campos existentes
    nuevocamp: "",
  });
};
```

**Paso 3: Agregar al handleSubmit detail** (linea ~188):
```typescript
// Para Accesorio y Otros:
if (productTypeCategory === "Accesorio" || productTypeCategory === "Otros") {
  detail.nuevocamp = formData.nuevocamp || undefined;
}
```

**Paso 4: Agregar el JSX del campo** (en renderTechnicalFields):
```tsx
{(productTypeCategory === "Accesorio" || productTypeCategory === "Otros") && (
  <div>
    <Label htmlFor="nuevocamp" className="text-sm font-medium">
      Nuevo Campo
    </Label>
    <Input
      id="nuevocamp"
      value={formData.nuevocamp}
      onChange={(e) => handleInputChange("nuevocamp", e.target.value)}
      placeholder="Ejemplo de placeholder"
      disabled={isLoading}
    />
  </div>
)}
```

### 3. Modificar Validaciones del Backend

En `product-type.service.ts`:

```typescript
async create(createProductTypeDto: CreateProductTypeDto) {
  // Agregar validaciones personalizadas aqui
  if (createProductTypeDto.name.length < 3) {
    throw new BadRequestException('El nombre debe tener al menos 3 caracteres');
  }
  // ... resto del codigo
}
```

---

## Ejemplos de Uso

### Ejemplo 1: Crear tipo "Teclado Mecanico"

1. En el modal de alta de activos, click en "Crear nuevo"
2. Completar:
   - **Nombre**: Teclado Mecanico
   - **Categoria**: Accesorio
   - **Grupo**: Teclados Latino
   - **Subcategoria**: Alambrico
3. Click en "Crear Tipo de Activo"
4. El nuevo tipo se selecciona automaticamente
5. El formulario muestra campos de **Accesorio** (basicos solamente)

### Ejemplo 2: Crear tipo "Laptop Dell Latitude"

1. Click en "Crear nuevo"
2. Completar:
   - **Nombre**: Dell Latitude 5520
   - **Categoria**: Equipo
   - **Grupo**: Laptops
   - **Subcategoria**: 15 pulgadas
3. El formulario muestra campos de **Equipo** (red, hardware, SO)

### Ejemplo 3: Crear tipo "Memoria RAM DDR4"

1. Click en "Crear nuevo"
2. Completar:
   - **Nombre**: Kingston DDR4 16GB
   - **Categoria**: Componente
   - **Grupo**: Memorias RAM
   - **Subcategoria**: DDR4
3. El formulario muestra campos de **Componente** (memoria, HDD)

---

## Endpoints API

### ProductType

| Metodo | Endpoint | Descripcion |
|--------|----------|-------------|
| GET | `/product-type` | Listar todos los tipos |
| GET | `/product-type/available-categories` | Obtener categorias fijas |
| GET | `/product-type/category/:category` | Filtrar por categoria |
| POST | `/product-type` | Crear nuevo tipo |
| DELETE | `/product-type/:id` | Eliminar tipo |

### Ejemplo de creacion (POST /product-type):

```json
{
  "name": "Teclado Mecanico",
  "category": "Accesorio",
  "group": "Teclados Latino",
  "subCategory": "Alambrico"
}
```

### Respuesta exitosa:

```json
{
  "success": true,
  "message": "Tipo de producto creado exitosamente",
  "data": {
    "productTypeID": 15,
    "name": "Teclado Mecanico",
    "category": "Accesorio",
    "group": "Teclados Latino",
    "subCategory": "Alambrico"
  }
}
```

---

## Notas Importantes

1. **Las categorias son fijas** en el backend para mantener consistencia
2. **No se puede eliminar** un tipo de activo si tiene activos asociados
3. **La plantilla "Otros"** incluye TODOS los campos disponibles
4. Al crear un tipo desde el modal de activos, se **selecciona automaticamente**
5. Los campos de la plantilla son **opcionales** (solo el formulario basico es requerido)
