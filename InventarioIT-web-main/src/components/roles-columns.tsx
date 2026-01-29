import { ColumnDef } from "@tanstack/react-table";
import { Role } from "@/types";
import { Badge } from "@/components/ui/badge";
import { RoleActionCell } from "@/components/RoleActionCell";

interface ColumnsProps {
  setRoles: React.Dispatch<React.SetStateAction<Role[]>>;
  setFilteredRoles: React.Dispatch<React.SetStateAction<Role[]>>;
}

export const createColumns = ({ setRoles, setFilteredRoles }: ColumnsProps): ColumnDef<Role>[] => [
  {
    accessorKey: "rolID",
    header: "ID",
    cell: ({ row }) => <div className="font-medium">{row.getValue("rolID")}</div>,
  },
  {
    accessorKey: "name",
    header: "Nombre del Rol",
    cell: ({ row }) => <div className="font-medium">{row.getValue("name")}</div>,
  },
  {
    accessorKey: "isActive",
    header: "Estado",
    cell: ({ row }) => {
      const isActive = row.getValue("isActive") as boolean;
      return (
        <Badge variant={isActive ? "default" : "secondary"}>
          {isActive ? "Activo" : "Inactivo"}
        </Badge>
      );
    },
  },
  {
    id: "actions",
    header: "Acciones",
    cell: ({ row }) => <RoleActionCell row={row} setRoles={setRoles} setFilteredRoles={setFilteredRoles} />,
  },
];
