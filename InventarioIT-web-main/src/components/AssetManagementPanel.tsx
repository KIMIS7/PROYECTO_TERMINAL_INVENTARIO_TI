import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Plus,
  Search,
  Filter,
  Download,
  RefreshCw,
  Package,
  Monitor,
  Server,
  Laptop,
  Smartphone,
  Printer,
  HardDrive,
  Wifi,
  LayoutGrid
} from "lucide-react";
import { ProductType } from "@/types";

interface AssetManagementPanelProps {
  totalAssets: number;
  productTypes: ProductType[];
  selectedCategory: string | null;
  onRefresh: () => void;
  onCreateAsset: () => void;
  onSearch: (query: string) => void;
  onFilterByCategory: (category: string | null) => void;
}

// Iconos por categoría
const categoryIcons: Record<string, React.ReactNode> = {
  "Computadoras": <Monitor className="h-4 w-4" />,
  "Laptops": <Laptop className="h-4 w-4" />,
  "Servidores": <Server className="h-4 w-4" />,
  "Dispositivos Móviles": <Smartphone className="h-4 w-4" />,
  "Impresoras": <Printer className="h-4 w-4" />,
  "Almacenamiento": <HardDrive className="h-4 w-4" />,
  "Red": <Wifi className="h-4 w-4" />,
  "Todos": <LayoutGrid className="h-4 w-4" />,
};

export const AssetManagementPanel = ({
  totalAssets,
  productTypes,
  selectedCategory,
  onRefresh,
  onCreateAsset,
  onSearch,
  onFilterByCategory,
}: AssetManagementPanelProps) => {
  const [searchQuery, setSearchQuery] = useState("");

  const handleSearch = (value: string) => {
    setSearchQuery(value);
    onSearch(value);
  };

  // Obtener categorías únicas de los tipos de productos
  const uniqueCategories = Array.from(new Set(productTypes.map(pt => pt.category))).filter(Boolean);

  return (
    <div className="bg-white rounded-lg border p-4 mb-6">
      {/* Header con título y estadísticas */}
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4 mb-4">
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-2">
            <Package className="h-6 w-6 text-blue-600" />
            <h2 className="text-lg font-semibold">Alta de Activos</h2>
          </div>
          <Badge variant="secondary" className="text-sm">
            {totalAssets} activos registrados
          </Badge>
        </div>

        {/* Acciones principales */}
        <div className="flex flex-col sm:flex-row gap-2">
          <Button
            onClick={onCreateAsset}
            className="flex items-center gap-2 bg-blue-600 hover:bg-blue-700"
            size="sm"
          >
            <Plus className="h-4 w-4" />
            Nuevo Activo
          </Button>
          <Button
            variant="outline"
            onClick={onRefresh}
            className="flex items-center gap-2"
            size="sm"
          >
            <RefreshCw className="h-4 w-4" />
            Actualizar
          </Button>
        </div>
      </div>

      {/* Mini Menú de Categorías de Activos */}
      <div className="mb-4">
        <p className="text-sm text-gray-600 mb-2 font-medium">Tipo de Activo:</p>
        <div className="flex flex-wrap gap-2">
          <Button
            variant={selectedCategory === null ? "default" : "outline"}
            size="sm"
            onClick={() => onFilterByCategory(null)}
            className="flex items-center gap-2"
          >
            {categoryIcons["Todos"]}
            Todos
          </Button>
          {uniqueCategories.map((category) => (
            <Button
              key={category}
              variant={selectedCategory === category ? "default" : "outline"}
              size="sm"
              onClick={() => onFilterByCategory(category)}
              className="flex items-center gap-2"
            >
              {categoryIcons[category] || <Package className="h-4 w-4" />}
              {category}
            </Button>
          ))}
        </div>
      </div>

      {/* Búsqueda y filtros adicionales */}
      <div className="flex flex-col lg:flex-row gap-4 pt-4 border-t">
        {/* Búsqueda */}
        <div className="flex-1">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
            <Input
              placeholder="Buscar activos por nombre, serie, TAG..."
              value={searchQuery}
              onChange={(e) => handleSearch(e.target.value)}
              className="pl-10"
            />
          </div>
        </div>

        {/* Filtro por tipo específico */}
        <div className="flex items-center gap-2">
          <Filter className="h-4 w-4 text-gray-500" />
          <Select
            value={selectedCategory || "all"}
            onValueChange={(value) => onFilterByCategory(value === "all" ? null : value)}
          >
            <SelectTrigger className="w-[200px]">
              <SelectValue placeholder="Filtrar por categoría" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todas las categorías</SelectItem>
              {uniqueCategories.map((category) => (
                <SelectItem key={category} value={category}>
                  {category}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        {/* Exportar */}
        <Button
          variant="outline"
          size="sm"
          className="flex items-center gap-2"
          onClick={() => {
            console.log("Exportar activos");
          }}
        >
          <Download className="h-4 w-4" />
          Exportar
        </Button>
      </div>
    </div>
  );
};
