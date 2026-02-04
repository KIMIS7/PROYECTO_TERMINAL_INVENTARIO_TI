import { useState, useMemo } from "react";
import {
  ColumnDef,
  flexRender,
  getCoreRowModel,
  useReactTable,
  getSortedRowModel,
  SortingState,
  RowSelectionState,
} from "@tanstack/react-table";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Checkbox } from "@/components/ui/checkbox";
import { Badge } from "@/components/ui/badge";
import { Settings, Paperclip } from "lucide-react";
import { Asset } from "@/types";
import { cn } from "@/lib/utils";

interface AssetDataTableProps {
  data: Asset[];
  loading?: boolean;
  onSelectionChange: (selectedIds: number[]) => void;
  onRowDoubleClick?: (asset: Asset) => void;
}

// Función para obtener el color del estado
const getStateColor = (state: string) => {
  const lowerState = state.toLowerCase();
  if (lowerState.includes("assigned") || lowerState.includes("asignado")) {
    return "text-blue-600 bg-blue-50";
  }
  if (lowerState.includes("in use") || lowerState.includes("en uso") || lowerState.includes("uso")) {
    return "text-green-600 bg-green-50";
  }
  if (lowerState.includes("in shop") || lowerState.includes("disponible") || lowerState.includes("almacen")) {
    return "text-orange-600 bg-orange-50";
  }
  if (lowerState.includes("repair") || lowerState.includes("reparacion")) {
    return "text-yellow-600 bg-yellow-50";
  }
  if (lowerState.includes("retired") || lowerState.includes("retirado") || lowerState.includes("baja")) {
    return "text-gray-600 bg-gray-50";
  }
  return "text-gray-600 bg-gray-50";
};

export const AssetDataTable = ({
  data,
  loading = false,
  onSelectionChange,
  onRowDoubleClick,
}: AssetDataTableProps) => {
  const [sorting, setSorting] = useState<SortingState>([]);
  const [rowSelection, setRowSelection] = useState<RowSelectionState>({});

  // Columnas de la tabla
  const columns: ColumnDef<Asset>[] = useMemo(
    () => [
      {
        id: "select",
        header: ({ table }) => (
          <Checkbox
            checked={table.getIsAllPageRowsSelected()}
            onCheckedChange={(value) => table.toggleAllPageRowsSelected(!!value)}
            aria-label="Select all"
          />
        ),
        cell: ({ row }) => (
          <Checkbox
            checked={row.getIsSelected()}
            onCheckedChange={(value) => row.toggleSelected(!!value)}
            aria-label="Select row"
          />
        ),
        enableSorting: false,
        size: 40,
      },
      {
        id: "actions",
        header: "",
        cell: () => (
          <div className="flex items-center gap-1">
            <button className="p-1 hover:bg-gray-100 rounded">
              <Settings className="h-4 w-4 text-gray-400" />
            </button>
            <button className="p-1 hover:bg-gray-100 rounded">
              <Paperclip className="h-4 w-4 text-gray-400" />
            </button>
          </div>
        ),
        enableSorting: false,
        size: 70,
      },
      {
        accessorKey: "name",
        header: "Name",
        cell: ({ row }) => {
          const asset = row.original;
          const hasAttachment = false; // TODO: Verificar si tiene adjuntos
          return (
            <div className="flex items-center gap-2">
              {hasAttachment && <Paperclip className="h-3 w-3 text-gray-400" />}
              <span className="font-medium text-gray-900 truncate max-w-[250px]" title={asset.name}>
                {asset.name}
              </span>
            </div>
          );
        },
        size: 300,
      },
      {
        id: "user",
        header: "User",
        cell: ({ row }) => {
          const user = row.original.user;
          return (
            <span className="text-gray-600 truncate max-w-[150px]" title={user?.name}>
              {user?.name || "-"}
            </span>
          );
        },
        size: 150,
      },
      {
        id: "department",
        header: "Department",
        cell: ({ row }) => {
          const user = row.original.user;
          return (
            <span className="text-gray-600 truncate max-w-[150px]" title={user?.department}>
              {user?.department || "-"}
            </span>
          );
        },
        size: 150,
      },
      {
        id: "associatedTo",
        header: "Associated To",
        cell: ({ row }) => {
          const site = row.original.site;
          return (
            <span className="text-gray-600 truncate max-w-[150px]" title={site?.name}>
              {site?.name || "-"}
            </span>
          );
        },
        size: 150,
      },
      {
        id: "product",
        header: "Product",
        cell: ({ row }) => {
          const detail = row.original.assetDetail;
          const vendor = row.original.vendor;
          const productName = detail?.model || row.original.name;
          const fullName = vendor ? `${vendor.name} ${productName}` : productName;
          return (
            <span className="text-gray-600 truncate max-w-[180px]" title={fullName}>
              {fullName}
            </span>
          );
        },
        size: 180,
      },
      {
        id: "productType",
        header: "Product Type",
        cell: ({ row }) => {
          const productType = row.original.productType;
          return (
            <span className="text-gray-600 truncate max-w-[120px]" title={productType?.subCategory || productType?.name}>
              {productType?.subCategory || productType?.name || "-"}
            </span>
          );
        },
        size: 120,
      },
      {
        id: "state",
        header: "State",
        cell: ({ row }) => {
          const stateInfo = row.original.assetStateInfo;
          const stateName = stateInfo?.name || "Unknown";
          return (
            <Badge
              variant="outline"
              className={cn("font-normal", getStateColor(stateName))}
            >
              {stateName}
            </Badge>
          );
        },
        size: 100,
      },
      {
        id: "assetTag",
        header: "AssetTag",
        cell: ({ row }) => {
          const detail = row.original.assetDetail;
          return (
            <span className="text-gray-600 font-mono text-xs">
              {detail?.assetTAG || "-"}
            </span>
          );
        },
        size: 100,
      },
    ],
    []
  );

  const table = useReactTable({
    data,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    onSortingChange: setSorting,
    onRowSelectionChange: (updater) => {
      const newSelection = typeof updater === "function" ? updater(rowSelection) : updater;
      setRowSelection(newSelection);

      // Notificar cambios de selección
      const selectedIds = Object.keys(newSelection)
        .filter((key) => newSelection[key])
        .map((key) => data[parseInt(key)]?.assetID)
        .filter(Boolean) as number[];
      onSelectionChange(selectedIds);
    },
    state: {
      sorting,
      rowSelection,
    },
  });

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="border rounded-md overflow-hidden">
      <Table>
        <TableHeader className="bg-gray-50">
          {table.getHeaderGroups().map((headerGroup) => (
            <TableRow key={headerGroup.id}>
              {headerGroup.headers.map((header) => (
                <TableHead
                  key={header.id}
                  className="text-xs font-semibold text-gray-600 uppercase tracking-wider"
                  style={{ width: header.getSize() }}
                >
                  {header.isPlaceholder
                    ? null
                    : flexRender(header.column.columnDef.header, header.getContext())}
                </TableHead>
              ))}
            </TableRow>
          ))}
        </TableHeader>
        <TableBody>
          {table.getRowModel().rows?.length ? (
            table.getRowModel().rows.map((row) => (
              <TableRow
                key={row.id}
                data-state={row.getIsSelected() && "selected"}
                className={cn(
                  "hover:bg-gray-50 cursor-pointer",
                  row.getIsSelected() && "bg-blue-50"
                )}
                onDoubleClick={() => onRowDoubleClick?.(row.original)}
              >
                {row.getVisibleCells().map((cell) => (
                  <TableCell key={cell.id} className="py-2 px-3 text-sm">
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                  </TableCell>
                ))}
              </TableRow>
            ))
          ) : (
            <TableRow>
              <TableCell colSpan={columns.length} className="h-24 text-center">
                No se encontraron activos.
              </TableCell>
            </TableRow>
          )}
        </TableBody>
      </Table>
    </div>
  );
};
