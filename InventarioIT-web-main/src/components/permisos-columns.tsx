import { ColumnDef } from "@tanstack/react-table";
import { RolePermission, Role, DashboardPath } from "@/types";
import { PermissionActionCell } from "@/components/PermissionActionCell";

interface PermissionColumnsProps {
  setPermissions: React.Dispatch<React.SetStateAction<RolePermission[]>>;
  setFilteredPermissions: React.Dispatch<React.SetStateAction<RolePermission[]>>;
  roles: Role[];
  dashboardPaths: DashboardPath[];
}

export const createPermissionColumns = ({ 
  setPermissions, 
  setFilteredPermissions,
  roles,
  dashboardPaths 
}: PermissionColumnsProps): ColumnDef<RolePermission>[] => [
  {
    accessorKey: "roldashboardpathID",
    header: "ID",
    cell: ({ row }) => <div className="font-medium">{row.getValue("roldashboardpathID")}</div>,
  },
  {
    accessorKey: "roleName",
    header: "Rol",
    cell: ({ row }) => <div className="font-medium">{row.getValue("roleName")}</div>,
  },
  {
    accessorKey: "pathName",
    header: "Módulo/Ruta",
    cell: ({ row }) => <div className="font-medium">{row.getValue("pathName")}</div>,
  },
  {
    accessorKey: "path",
    header: "URL",
    cell: ({ row }) => (
      <div className="text-sm text-gray-600 font-mono">
        {row.getValue("path")}
      </div>
    ),
  },
  {
    accessorKey: "icon",
    header: "Icono",
    cell: ({ row }) => {
      const icon = row.getValue("icon") as string;
      return icon ? (
        <div className="flex items-center justify-center">
          <span
            className="w-4 h-4 [&>svg]:w-4 [&>svg]:h-4"
            dangerouslySetInnerHTML={{ __html: icon }}
          />
        </div>
      ) : (
        <div className="text-gray-400">—</div>
      );
    },
  },
  {
    id: "actions",
    header: "Acciones",
    cell: ({ row }) => (
      <PermissionActionCell 
        row={row} 
        setPermissions={setPermissions} 
        setFilteredPermissions={setFilteredPermissions}
        roles={roles}
        dashboardPaths={dashboardPaths}
      />
    ),
  },
];
