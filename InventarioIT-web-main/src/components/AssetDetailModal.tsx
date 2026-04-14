import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Asset } from "@/types";
import api from "@/lib/api";
import {
  X,
  Pencil,
  Monitor,
  Building2,
  MapPin,
  User,
  Tag,
  Calendar,
  Cpu,
  HardDrive,
  Network,
  Globe,
  Smartphone,
  Clock,
  Package,
  ShieldCheck,
  MemoryStick,
  AppWindow,
  FileText,
  Link2,
} from "lucide-react";

interface AssetDetailModalProps {
  assetID: number;
  isOpen: boolean;
  onClose: () => void;
  onEdit: (asset: Asset) => void;
  onOpenAssignment?: (assetID: number) => void;
  onOpenDeliveryReport?: (assetID: number) => void;
}

interface AssetFullData {
  assetID: number;
  name: string;
  vendorID: number;
  productTypeID: number;
  assetState: number;
  companyID: number;
  siteID: number;
  userID: number;
  vendor?: { vendorID: number; name: string } | null;
  productType?: {
    productTypeID: number;
    name: string;
    category: string;
    group: string;
    subCategory: string;
  } | null;
  assetStateInfo?: { assetStateID: number; name: string } | null;
  company?: { companyID: number; description: string } | null;
  site?: { siteID: number; name: string } | null;
  depart?: { departID: number; Name: string } | null;
  user?: {
    userID: number;
    name: string;
    email: string;
    departmentID?: number;
  } | null;
  assetDetail?: Record<string, unknown> | null;
  history?: { assetHistoryID: number; operation: string; description: string; createdTime: string }[];
}

function formatDate(dateStr: string | null | undefined): string {
  if (!dateStr) return "-";
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return "-";
  return date.toLocaleDateString("es-MX", {
    year: "numeric",
    month: "short",
    day: "numeric",
  });
}

function formatDateTime(dateStr: string | null | undefined): string {
  if (!dateStr) return "-";
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return "-";
  return date.toLocaleDateString("es-MX", {
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
}

function DetailRow({ label, value }: { label: string; value: string | undefined | null }) {
  const displayValue = value && value.toString().trim() ? value : null;
  if (!displayValue) return null;
  return (
    <div className="flex items-start py-2 border-b border-gray-100 last:border-0">
      <span className="text-xs font-medium text-gray-500 w-40 shrink-0 pt-0.5">
        {label}
      </span>
      <span className="text-sm text-gray-900 break-words">{displayValue}</span>
    </div>
  );
}

function SectionHeader({
  icon,
  title,
}: {
  icon: React.ReactNode;
  title: string;
}) {
  return (
    <div className="flex items-center gap-2 mb-3 mt-6 first:mt-0">
      <div className="flex items-center justify-center h-7 w-7 rounded-md bg-blue-50 text-blue-600">
        {icon}
      </div>
      <h3 className="text-sm font-semibold text-gray-800">{title}</h3>
    </div>
  );
}

function StateBadge({ name }: { name: string }) {
  const colorMap: Record<string, string> = {
    Activo: "bg-green-100 text-green-700",
    Inactivo: "bg-red-100 text-red-700",
    "En reparación": "bg-amber-100 text-amber-700",
    "En mantenimiento": "bg-amber-100 text-amber-700",
    Prestado: "bg-blue-100 text-blue-700",
  };
  const colors = colorMap[name] || "bg-gray-100 text-gray-700";
  return (
    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${colors}`}>
      {name}
    </span>
  );
}

// Helper to get detail field (handles both camelCase and PascalCase from API)
function getDetail(detail: Record<string, unknown> | null | undefined, camelKey: string, pascalKey: string): string | null {
  if (!detail) return null;
  const val = detail[camelKey] ?? detail[pascalKey];
  return val ? String(val) : null;
}

export const AssetDetailModal = ({
  assetID,
  isOpen,
  onClose,
  onEdit,
  onOpenAssignment,
  onOpenDeliveryReport,
}: AssetDetailModalProps) => {
  const [data, setData] = useState<AssetFullData | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (isOpen && assetID) {
      loadAsset();
    }
    return () => {
      if (!isOpen) setData(null);
    };
  }, [isOpen, assetID]);

  const loadAsset = async () => {
    try {
      setIsLoading(true);
      const response = await api.asset.getById(assetID);
      const assetData = response.data || response;
      setData(assetData);
    } catch (error) {
      console.error("Error loading asset detail:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleEdit = () => {
    if (data) {
      onEdit(data as unknown as Asset);
      onClose();
    }
  };

  if (!isOpen) return null;

  const detail = data?.assetDetail as Record<string, unknown> | null | undefined;

  // Technical detail fields
  const serialNum = getDetail(detail, "serialNum", "SerialNum");
  const assetTAG = getDetail(detail, "assetTAG", "AssetTAG");
  const model = getDetail(detail, "model", "Model");
  const productManuf = getDetail(detail, "productManuf", "ProductManuf");
  const ipAddress = getDetail(detail, "ipAddress", "IPAddress");
  const macAddress = getDetail(detail, "macAddress", "MACAddress");
  const domain = getDetail(detail, "domain", "Domain");
  const processor = getDetail(detail, "processor", "Processor");
  const processorInfo = getDetail(detail, "processorInfo", "ProcessorInfo");
  const ram = getDetail(detail, "ram", "RAM");
  const physicalMemory = getDetail(detail, "physicalMemory", "PhysicalMemory");
  const hddModel = getDetail(detail, "hddModel", "HDDModel");
  const hddCapacity = getDetail(detail, "hddCapacity", "HDDCapacity");
  const operatingSystem = getDetail(detail, "operatingSystem", "OperatingSystem");
  const hddSerial = getDetail(detail, "hddSerial", "HDDSerial");
  const imei = getDetail(detail, "imei", "IMEI");
  const platform = getDetail(detail, "platform", "Platform");
  const osName = getDetail(detail, "osName", "OSName");
  const osVersion = getDetail(detail, "osVersion", "OSVersion");
  const purchaseDate = getDetail(detail, "purchaseDate", "PurchaseDate");
  const warrantyExpiryDate = getDetail(detail, "warrantyExpiryDate", "WarrantyExpiryDate");
  const barcode = getDetail(detail, "barcode", "Barcode");
  const factura = getDetail(detail, "factura", "Factura");
  const ticket = getDetail(detail, "ticket", "Ticket");

  const hasTechnicalInfo = serialNum || assetTAG || model || productManuf;
  const hasNetworkInfo = ipAddress || macAddress || domain;
  const hasProcessingInfo = processor || processorInfo;
  const hasMemoryInfo = ram || physicalMemory;
  const hasStorageInfo = hddModel || hddCapacity || hddSerial;
  const hasSoftwareInfo = operatingSystem;
  const hasMobileInfo = imei || platform || osName || osVersion;
  const hasDateInfo = purchaseDate || warrantyExpiryDate;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col">
        
        {/* Header */}
        <div className="flex items-center justify-between px-5 py-4 border-b bg-gradient-to-r from-blue-50 to-white">
          <div className="flex items-center gap-3 min-w-0">
            <div className="flex items-center justify-center h-10 w-10 rounded-lg bg-blue-100 text-blue-600 shrink-0">
              <Monitor className="h-5 w-5" />
            </div>
            <div className="min-w-0">
              <h2 className="text-lg font-semibold text-gray-900 truncate">
                {isLoading ? "Cargando..." : data?.name || "Activo"}
              </h2>
            </div>
          </div>
          <div className="flex items-center gap-2 shrink-0">
            
          </div>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto px-5 py-4">
          {isLoading ? (
            <div className="flex items-center justify-center h-48">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
            </div>
          ) : data ? (
            <>
              {/* Informacion General */}
              <SectionHeader
                icon={<Package className="h-4 w-4" />}
                title="Informacion General"
              />
              <div className="bg-gray-50 rounded-lg px-4 py-1">
                <DetailRow label="Nombre" value={data.name} />
                <DetailRow
                  label="Tipo"
                  value={data.productType?.name}
                />
                <DetailRow
                  label="Grupo"
                  value={data.productType?.group}
                />
                <DetailRow label="Proveedor" value={data.vendor?.name} />
                <DetailRow
                  label="Estado"
                  value={data.assetStateInfo?.name}
                />
              </div>

              {/* Ubicacion */}
              <SectionHeader
                icon={<Building2 className="h-4 w-4" />}
                title="Ubicacion"
              />
              <div className="bg-gray-50 rounded-lg px-4 py-1">
                <DetailRow label="Empresa" value={data.company?.description} />
                <DetailRow label="Site" value={data.site?.name} />
                <DetailRow label="Departamento" value={data.depart?.Name} />
              </div>

              {/* Usuario Asignado */}
              {data.user && (
                <>
                  <SectionHeader
                    icon={<User className="h-4 w-4" />}
                    title="Usuario Asignado"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Nombre" value={data.user.name} />
                    <DetailRow label="Email" value={data.user.email} />
                  </div>
                </>
              )}

              {/* Identificacion del Activo */}
              {hasTechnicalInfo && (
                <>
                  <SectionHeader
                    icon={<Tag className="h-4 w-4" />}
                    title="Identificacion"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Fabricante" value={productManuf} />
                    <DetailRow label="Modelo" value={model} />
                    <DetailRow label="Numero de Serie" value={serialNum} />
                    <DetailRow label="Asset TAG" value={assetTAG} />
                    {barcode && <DetailRow label="Codigo de Barras" value={barcode} />}
                  </div>
                </>
              )}

              {/* Documentos (Factura y Ticket) */}
              {(factura || ticket) && (
                <>
                  <SectionHeader
                    icon={<FileText className="h-4 w-4" />}
                    title="Documentos"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Factura" value={factura} />
                    <DetailRow label="Ticket" value={ticket} />
                  </div>
                </>
              )}

              {/* Red */}
              {hasNetworkInfo && (
                <>
                  <SectionHeader
                    icon={<Network className="h-4 w-4" />}
                    title="Red"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Direccion IP" value={ipAddress} />
                    <DetailRow label="Direccion MAC" value={macAddress} />
                    <DetailRow label="Dominio" value={domain} />
                  </div>
                </>
              )}

              {/* Procesamiento */}
              {hasProcessingInfo && (
                <>
                  <SectionHeader
                    icon={<Cpu className="h-4 w-4" />}
                    title="Procesamiento"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Procesador" value={processor} />
                    <DetailRow label="Velocidad CPU" value={processorInfo} />
                  </div>
                </>
              )}

              {/* Memoria */}
              {hasMemoryInfo && (
                <>
                  <SectionHeader
                    icon={<MemoryStick className="h-4 w-4" />}
                    title="Memoria"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Memoria RAM" value={ram} />
                    <DetailRow label="Tipo de Memoria" value={physicalMemory} />
                  </div>
                </>
              )}

              {/* Almacenamiento */}
              {hasStorageInfo && (
                <>
                  <SectionHeader
                    icon={<HardDrive className="h-4 w-4" />}
                    title="Almacenamiento"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Tipo de Disco" value={hddModel} />
                    <DetailRow label="Capacidad de Disco" value={hddCapacity} />
                    <DetailRow label="Serial HDD/SSD" value={hddSerial} />
                  </div>
                </>
              )}

              {/* Software */}
              {hasSoftwareInfo && (
                <>
                  <SectionHeader
                    icon={<AppWindow className="h-4 w-4" />}
                    title="Software"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="Sistema Operativo" value={operatingSystem} />
                  </div>
                </>
              )}

              {/* Movil */}
              {hasMobileInfo && (
                <>
                  <SectionHeader
                    icon={<Smartphone className="h-4 w-4" />}
                    title="Informacion Movil"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow label="IMEI" value={imei} />
                    <DetailRow label="Plataforma" value={platform} />
                    <DetailRow label="Nombre SO" value={osName} />
                    <DetailRow label="Version SO" value={osVersion} />
                  </div>
                </>
              )}

              {/* Fechas */}
              {hasDateInfo && (
                <>
                  <SectionHeader
                    icon={<Calendar className="h-4 w-4" />}
                    title="Fechas"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-1">
                    <DetailRow
                      label="Fecha de Compra"
                      value={formatDate(purchaseDate)}
                    />
                    <DetailRow
                      label="Vencimiento Garantia"
                      value={formatDate(warrantyExpiryDate)}
                    />
                  </div>
                </>
              )}

              {/* Historial reciente */}
              {data.history && data.history.length > 0 && (
                <>
                  <SectionHeader
                    icon={<Clock className="h-4 w-4" />}
                    title="Historial Reciente"
                  />
                  <div className="bg-gray-50 rounded-lg px-4 py-2">
                    <div className="space-y-2">
                      {data.history.map((entry) => (
                        <div
                          key={entry.assetHistoryID}
                          className="flex items-start gap-3 py-1.5 border-b border-gray-100 last:border-0"
                        >
                          <div className="flex items-center justify-center h-6 w-6 rounded-full bg-blue-100 text-blue-600 shrink-0 mt-0.5">
                            <ShieldCheck className="h-3 w-3" />
                          </div>
                          <div className="min-w-0 flex-1">
                            <p className="text-sm text-gray-800 break-words">
                              {entry.description}
                            </p>
                            <p className="text-xs text-gray-400 mt-0.5">
                              {formatDateTime(entry.createdTime)}
                            </p>
                          </div>
                          <span className="text-xs font-medium text-gray-500 bg-gray-200 px-2 py-0.5 rounded shrink-0">
                            {entry.operation}
                          </span>
                        </div>
                      ))}
                    </div>
                  </div>
                </>
              )}
            </>
          ) : (
            <div className="flex items-center justify-center h-48 text-gray-500">
              No se pudo cargar la informacion del activo
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex gap-2 px-5 py-3 border-t bg-gray-50">
          <Button
            variant="outline"
            onClick={onClose}
            className="flex-1"
          >
            Cerrar
          </Button>
          {onOpenDeliveryReport && (
            <Button
              variant="outline"
              onClick={() => onOpenDeliveryReport(assetID)}
              disabled={isLoading || !data}
              className="flex items-center gap-2 border-green-200 text-green-600 hover:bg-green-50"
            >
              <FileText className="h-4 w-4" />
              Entrega
            </Button>
          )}
          {onOpenAssignment && (
            <Button
              variant="outline"
              onClick={() => onOpenAssignment(assetID)}
              disabled={isLoading || !data}
              className="flex items-center gap-2 border-blue-200 text-blue-600 hover:bg-blue-50"
            >
              <Link2 className="h-4 w-4" />
              Asignacion
            </Button>
          )}
          <Button
            onClick={handleEdit}
            disabled={isLoading || !data}
            className="flex-1 bg-blue-600 hover:bg-blue-700"
          >
            <Pencil className="h-4 w-4 mr-1.5" />
            Editar Activo
          </Button>
        </div>
      </div>
    </div>
  );
};
