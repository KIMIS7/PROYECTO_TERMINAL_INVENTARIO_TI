import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import {
  Plus,
  Pencil,
  Trash2,
  ChevronDown,
  Upload,
  UserPlus,
  Download,
  RefreshCw,
  Settings,
  Copy,
  FileText,
  List,
  LayoutGrid,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";

interface AssetToolbarProps {
  selectedCount: number;
  totalCount: number;
  currentPage: number;
  pageSize: number;
  onNew: () => void;
  onEdit: () => void;
  onDelete: () => void;
  onImportCSV: () => void;
  onAssignUsers: () => void;
  onExport: () => void;
  onRefresh: () => void;
  onPageChange: (page: number) => void;
  onViewChange: (view: "list" | "grid") => void;
  currentView: "list" | "grid";
}

export const AssetToolbar = ({
  selectedCount,
  totalCount,
  currentPage,
  pageSize,
  onNew,
  onEdit,
  onDelete,
  onImportCSV,
  onAssignUsers,
  onExport,
  onRefresh,
  onPageChange,
  onViewChange,
  currentView,
}: AssetToolbarProps) => {
  const totalPages = Math.ceil(totalCount / pageSize);
  const startItem = (currentPage - 1) * pageSize + 1;
  const endItem = Math.min(currentPage * pageSize, totalCount);

  return (
    <div className="flex items-center justify-between py-2 px-1 border-b bg-gray-50">
      {/* Acciones principales */}
      <div className="flex items-center gap-1">
        {/* Icono de configuración */}
        <Button variant="ghost" size="icon" className="h-8 w-8">
          <Settings className="h-4 w-4 text-gray-500" />
        </Button>

        {/* Búsqueda rápida */}
        <Button variant="ghost" size="icon" className="h-8 w-8">
          <FileText className="h-4 w-4 text-gray-500" />
        </Button>

        <div className="h-6 w-px bg-gray-300 mx-1" />

        {/* Nuevo */}
        <Button
          variant="outline"
          size="sm"
          onClick={onNew}
          className="h-8 text-sm font-normal"
        >
          <Plus className="h-4 w-4 mr-1" />
          New
        </Button>

        {/* Editar */}
        <Button
          variant="outline"
          size="sm"
          onClick={onEdit}
          disabled={selectedCount !== 1}
          className="h-8 text-sm font-normal"
        >
          <Pencil className="h-4 w-4 mr-1" />
          Edit
        </Button>

        {/* Eliminar */}
        <Button
          variant="outline"
          size="sm"
          onClick={onDelete}
          disabled={selectedCount === 0}
          className="h-8 text-sm font-normal"
        >
          <Trash2 className="h-4 w-4 mr-1" />
          Delete
        </Button>

        {/* Actions Dropdown */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="outline" size="sm" className="h-8 text-sm font-normal">
              Actions
              <ChevronDown className="h-4 w-4 ml-1" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="start">
            <DropdownMenuItem onClick={onExport}>
              <Download className="h-4 w-4 mr-2" />
              Export to CSV
            </DropdownMenuItem>
            <DropdownMenuItem onClick={() => console.log("Export PDF")}>
              <FileText className="h-4 w-4 mr-2" />
              Export to PDF
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem onClick={() => console.log("Duplicate")}>
              <Copy className="h-4 w-4 mr-2" />
              Duplicate Selected
            </DropdownMenuItem>
            <DropdownMenuItem onClick={onRefresh}>
              <RefreshCw className="h-4 w-4 mr-2" />
              Refresh
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>

        <div className="h-6 w-px bg-gray-300 mx-1" />

        {/* Import from CSV */}
        <Button
          variant="outline"
          size="sm"
          onClick={onImportCSV}
          className="h-8 text-sm font-normal"
        >
          <Upload className="h-4 w-4 mr-1" />
          Import from CSV
        </Button>

        {/* Assign Users */}
        <Button
          variant="outline"
          size="sm"
          onClick={onAssignUsers}
          disabled={selectedCount === 0}
          className="h-8 text-sm font-normal"
        >
          <UserPlus className="h-4 w-4 mr-1" />
          Assign Users
        </Button>
      </div>

      {/* Vista y paginación */}
      <div className="flex items-center gap-2">
        {/* Cambiar vista */}
        <div className="flex items-center border rounded">
          <Button
            variant={currentView === "list" ? "secondary" : "ghost"}
            size="icon"
            className="h-7 w-7 rounded-r-none"
            onClick={() => onViewChange("list")}
          >
            <List className="h-4 w-4" />
          </Button>
          <Button
            variant={currentView === "grid" ? "secondary" : "ghost"}
            size="icon"
            className="h-7 w-7 rounded-l-none"
            onClick={() => onViewChange("grid")}
          >
            <LayoutGrid className="h-4 w-4" />
          </Button>
        </div>

        <div className="h-6 w-px bg-gray-300 mx-1" />

        {/* Paginación */}
        <div className="flex items-center gap-2 text-sm text-gray-600">
          <span>
            {startItem} - {endItem} of {totalCount}
          </span>
          <span className="text-gray-400">...</span>
          <div className="flex items-center">
            <Button
              variant="ghost"
              size="icon"
              className="h-7 w-7"
              onClick={() => onPageChange(currentPage - 1)}
              disabled={currentPage <= 1}
            >
              <ChevronLeft className="h-4 w-4" />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              className="h-7 w-7"
              onClick={() => onPageChange(currentPage + 1)}
              disabled={currentPage >= totalPages}
            >
              <ChevronRight className="h-4 w-4" />
            </Button>
          </div>

          {/* Exportar */}
          <Button variant="ghost" size="icon" className="h-7 w-7">
            <Download className="h-4 w-4" />
          </Button>

          {/* Configuración */}
          <Button variant="ghost" size="icon" className="h-7 w-7">
            <Settings className="h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
};
