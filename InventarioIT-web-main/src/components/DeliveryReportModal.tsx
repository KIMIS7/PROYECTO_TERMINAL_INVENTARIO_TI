import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import api from "@/lib/api";
import {
  X,
  Download,
  FileText,
  Loader2,
  Check,
} from "lucide-react";
import { toast } from "sonner";

type ReportFormat = "entrega_software" | "entrega_multiitem";

interface AvailableAsset {
  assetID: number;
  name: string;
  vendor: string;
  model: string;
  serialNum: string;
}

interface DeliveryReportModalProps {
  assetID?: number;
  assetIDs?: number[];
  availableAssets?: AvailableAsset[];
  format?: ReportFormat;
  title?: string;
  prefillDepartment?: string;
  prefillSite?: string;
  prefillReceiverName?: string;
  isOpen: boolean;
  onClose: () => void;
}

interface DeliveryData {
  assetID: number;
  name: string;
  serialNum: string;
  model: string;
  processor: string;
  ram: string;
  hddCapacity: string;
  operatingSystem: string;
  vendor: string;
  productType: string;
  productManuf: string;
  company: string;
  site: string;
  department: string;
  userName: string;
  userEmail: string;
  childAssets: { name: string; productType: string; serialNum: string; model: string; vendor: string }[];
  softwareChecklist: string[];
}

function triggerDownload(blob: Blob, filename: string) {
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  window.URL.revokeObjectURL(url);
  document.body.removeChild(a);
}

const FORMAT_LABELS: Record<ReportFormat, string> = {
  entrega_software: "Entrega de Equipo (con Software)",
  entrega_multiitem: "Entrega de Equipo (Multi-item)",
};

export function DeliveryReportModal({
  assetID,
  assetIDs,
  availableAssets = [],
  format: initialFormat,
  title: customTitle,
  prefillDepartment,
  prefillSite,
  prefillReceiverName,
  isOpen,
  onClose,
}: DeliveryReportModalProps) {
  const [data, setData] = useState<DeliveryData | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isGenerating, setIsGenerating] = useState(false);
  const [format, setFormat] = useState<ReportFormat>(initialFormat || "entrega_software");
  const [selectedItems, setSelectedItems] = useState<Set<number>>(new Set());
  const [softwareStatus, setSoftwareStatus] = useState<Record<string, string>>({});
  const [notes, setNotes] = useState(
    "Se entrega equipo en buenas condiciones sin golpes ni defectos, recien instalado. Detalles de uso."
  );
  const [razonSocial, setRazonSocial] = useState("");

  useEffect(() => {
    if (isOpen && assetID) {
      loadData();
    }
    if (isOpen) {
      setFormat(initialFormat || "entrega_software");
      // Pre-select the asset(s)
      const initial = new Set<number>();
      if (assetIDs && assetIDs.length > 0) {
        assetIDs.forEach((id) => initial.add(id));
      } else if (assetID) {
        initial.add(assetID);
      }
      setSelectedItems(initial);
    }
  }, [isOpen, assetID, initialFormat]);

  const loadData = async () => {
    if (!assetID) return;
    try {
      setIsLoading(true);
      const result = await api.report.getDeliveryData(assetID);
      setData(result);
      setRazonSocial(result.company || "");

      const initialStatus: Record<string, string> = {};
      result.softwareChecklist.forEach((sw: string) => {
        initialStatus[sw] = "NA";
      });
      setSoftwareStatus(initialStatus);
    } catch (error) {
      console.error("Error loading delivery data:", error);
      toast.error("Error al cargar datos del reporte");
    } finally {
      setIsLoading(false);
    }
  };

  const toggleSoftware = (sw: string) => {
    setSoftwareStatus((prev) => ({
      ...prev,
      [sw]: prev[sw] === "X" ? "NA" : "X",
    }));
  };

  const toggleItem = (id: number) => {
    setSelectedItems((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const handleDownloadPdf = async () => {
    try {
      setIsGenerating(true);

      if (format === "entrega_software" && assetID) {
        const blob = await api.report.downloadDeliveryPdf(assetID, {
          softwareStatus,
          notes,
        });
        triggerDownload(
          new Blob([blob], { type: "application/pdf" }),
          `entrega_equipo_${assetID}.pdf`
        );
      } else if (format === "entrega_multiitem") {
        const ids = Array.from(selectedItems);
        if (ids.length === 0) {
          toast.error("Selecciona al menos un item");
          setIsGenerating(false);
          return;
        }
        const blob = await api.report.downloadEntregaMultiItemPdf({
          assetIds: ids,
          asunto: customTitle || undefined,
          razonSocial: razonSocial || undefined,
          department: data?.department || prefillDepartment || undefined,
          receiverName: data?.userName || prefillReceiverName || undefined,
          notes: notes || undefined,
        });
        triggerDownload(
          new Blob([blob], { type: "application/pdf" }),
          `entrega_multiitem_${new Date().toISOString().split("T")[0]}.pdf`
        );
      }

      toast.success("PDF generado exitosamente");
    } catch (error) {
      console.error("Error generating PDF:", error);
      toast.error("Error al generar el PDF");
    } finally {
      setIsGenerating(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50" onClick={onClose} />

      <div className="relative bg-white rounded-lg shadow-xl w-full max-w-3xl max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b bg-gradient-to-r from-blue-600 to-blue-700">
          <div className="flex items-center gap-3 text-white">
            <FileText className="h-5 w-5" />
            <h2 className="text-lg font-semibold">{customTitle || FORMAT_LABELS[format]}</h2>
          </div>
          <button onClick={onClose} className="text-white/80 hover:text-white">
            <X className="h-5 w-5" />
          </button>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6">
          {isLoading ? (
            <div className="flex items-center justify-center h-48">
              <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
            </div>
          ) : data ? (
            <div className="space-y-6">
              {/* Selector de formato - hidden when format is pre-selected */}
              {!initialFormat && (
                <div>
                  <h3 className="font-semibold text-gray-700 mb-2">Tipo de Reporte</h3>
                  <div className="flex gap-2">
                    {(Object.keys(FORMAT_LABELS) as ReportFormat[]).map((f) => (
                      <button
                        key={f}
                        onClick={() => setFormat(f)}
                        className={`px-3 py-2 rounded-md border text-sm transition-colors ${
                          format === f
                            ? "bg-blue-50 border-blue-300 text-blue-800 font-medium"
                            : "bg-white border-gray-200 text-gray-600 hover:border-gray-300"
                        }`}
                      >
                        {FORMAT_LABELS[f]}
                      </button>
                    ))}
                  </div>
                </div>
              )}

              {/* Info del equipo - solo para entrega_software */}
              {format === "entrega_software" && (
                <div className="bg-gray-50 rounded-lg p-4">
                  <h3 className="font-semibold text-gray-700 mb-3">Informacion del Equipo</h3>
                  <div className="grid grid-cols-2 gap-3 text-sm">
                    <div>
                      <span className="font-medium text-gray-500">Equipo:</span>{" "}
                      <span className="text-gray-900">{data.name}</span>
                    </div>
                    <div>
                      <span className="font-medium text-gray-500">No. Serie:</span>{" "}
                      <span className="text-gray-900 font-mono">{data.serialNum}</span>
                    </div>
                    <div>
                      <span className="font-medium text-gray-500">Departamento:</span>{" "}
                      <span className="text-gray-900">{data.department || "N/A"}</span>
                    </div>
                    <div>
                      <span className="font-medium text-gray-500">Recibe:</span>{" "}
                      <span className="text-gray-900">{data.userName || "N/A"}</span>
                    </div>
                    <div>
                      <span className="font-medium text-gray-500">Empresa:</span>{" "}
                      <span className="text-gray-900">{data.company || "N/A"}</span>
                    </div>
                    <div>
                      <span className="font-medium text-gray-500">Sitio:</span>{" "}
                      <span className="text-gray-900">{data.site || "N/A"}</span>
                    </div>
                  </div>
                </div>
              )}

              {/* Selector de items - solo para multi-item */}
              {format === "entrega_multiitem" && (
                <div>
                  <h3 className="font-semibold text-gray-700 mb-2">
                    Selecciona los items a entregar
                    <span className="text-xs font-normal text-gray-400 ml-2">
                      ({selectedItems.size} seleccionados)
                    </span>
                  </h3>
                  <div className="border rounded-lg max-h-52 overflow-y-auto">
                    {availableAssets.map((asset) => (
                      <label
                        key={asset.assetID}
                        className={`flex items-center gap-3 px-3 py-2 border-b last:border-b-0 cursor-pointer hover:bg-gray-50 text-sm ${
                          selectedItems.has(asset.assetID) ? "bg-blue-50" : ""
                        }`}
                      >
                        <input
                          type="checkbox"
                          checked={selectedItems.has(asset.assetID)}
                          onChange={() => toggleItem(asset.assetID)}
                          className="rounded border-gray-300"
                        />
                        <span className="font-medium">{asset.name}</span>
                        <span className="text-gray-500">{asset.vendor}</span>
                        <span className="text-gray-500">{asset.model || "-"}</span>
                        <span className="text-gray-400 font-mono">{asset.serialNum || "N/A"}</span>
                      </label>
                    ))}
                  </div>
                </div>
              )}

              {/* Campos editables comunes */}
              <div>
                <label className="text-sm font-medium text-gray-600 block mb-1">Razon Social</label>
                <input
                  type="text"
                  value={razonSocial}
                  onChange={(e) => setRazonSocial(e.target.value)}
                  className="w-full border rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                  placeholder="Razon social de la empresa"
                />
              </div>

              {/* Software Checklist - solo para formato entrega_software */}
              {format === "entrega_software" && (
                <div>
                  <h3 className="font-semibold text-gray-700 mb-3">
                    Software Instalado
                    <span className="text-xs font-normal text-gray-400 ml-2">
                      (Haz clic para marcar como instalado)
                    </span>
                  </h3>
                  <div className="grid grid-cols-2 gap-2">
                    {data.softwareChecklist.map((sw) => (
                      <button
                        key={sw}
                        onClick={() => toggleSoftware(sw)}
                        className={`flex items-center justify-between px-3 py-2 rounded-md border text-sm transition-colors ${
                          softwareStatus[sw] === "X"
                            ? "bg-green-50 border-green-300 text-green-800"
                            : "bg-white border-gray-200 text-gray-500 hover:border-gray-300"
                        }`}
                      >
                        <span>{sw}</span>
                        {softwareStatus[sw] === "X" ? (
                          <Check className="h-4 w-4 text-green-600" />
                        ) : (
                          <span className="text-xs text-gray-400">NA</span>
                        )}
                      </button>
                    ))}
                  </div>
                </div>
              )}

              {/* Componentes incluidos - solo para entrega_software */}
              {format === "entrega_software" && data.childAssets.length > 0 && (
                <div>
                  <h3 className="font-semibold text-gray-700 mb-3">
                    Componentes / Accesorios Incluidos
                  </h3>
                  <div className="space-y-2">
                    {data.childAssets.map((child, idx) => (
                      <div key={idx} className="flex items-center gap-4 px-3 py-2 bg-gray-50 rounded text-sm">
                        <span className="font-medium">{child.name}</span>
                        <span className="text-gray-500">{child.vendor}</span>
                        <span className="text-gray-500">{child.model || "-"}</span>
                        <span className="text-gray-400 font-mono">{child.serialNum || "N/A"}</span>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Notas */}
              <div>
                <h3 className="font-semibold text-gray-700 mb-2">Notas / Condicion del equipo</h3>
                <textarea
                  value={notes}
                  onChange={(e) => setNotes(e.target.value)}
                  className="w-full border rounded-md p-3 text-sm resize-none h-20 focus:outline-none focus:ring-2 focus:ring-blue-500"
                  placeholder="Describe la condicion del equipo..."
                />
              </div>

              {/* Preview del aviso legal */}
              <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-3">
                <p className="text-xs text-yellow-800 font-medium mb-1">Aviso legal que aparecera en el PDF:</p>
                <p className="text-xs text-yellow-700 italic">
                  {`Recibo de ${razonSocial || "la Empresa"} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`}
                </p>
              </div>

              {/* Preview de firmas */}
              <div className="flex gap-8 text-center text-sm">
                <div className="flex-1 border-t-2 border-gray-300 pt-2">
                  <p className="font-semibold text-gray-700">ENTREGA:</p>
                  <p className="text-gray-500 text-xs">RESPONSABLE DE TIENDA</p>
                </div>
                <div className="flex-1 border-t-2 border-gray-300 pt-2">
                  <p className="font-semibold text-gray-700">RECIBE:</p>
                  <p className="text-gray-500 text-xs">DEPARTAMENTO DE SISTEMAS</p>
                </div>
              </div>
            </div>
          ) : (
            <div className="text-center text-gray-500 py-12">
              No se pudieron cargar los datos del reporte
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t bg-gray-50">
          <Button variant="outline" onClick={onClose}>
            Cancelar
          </Button>
          <Button
            onClick={handleDownloadPdf}
            disabled={!data || isGenerating || (format === "entrega_multiitem" && selectedItems.size === 0)}
            className="bg-blue-600 hover:bg-blue-700 text-white"
          >
            {isGenerating ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                Generando...
              </>
            ) : (
              <>
                <Download className="h-4 w-4 mr-2" />
                Descargar PDF
              </>
            )}
          </Button>
        </div>
      </div>
    </div>
  );
}
