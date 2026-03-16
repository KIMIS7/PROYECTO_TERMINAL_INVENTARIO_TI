import { useState, useEffect, useCallback } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  X,
  Search,
  Plus,
  Trash2,
  Monitor,
  HardDrive,
  Mouse,
  Link2,
  ArrowUp,
  Loader2,
} from "lucide-react";
import api from "@/lib/api";
import { Asset } from "@/types";

interface RelatedAsset {
  assetID: number;
  name: string;
  productType: { productTypeID: number; name: string; group: string } | null;
  model: string | null;
  serialNum: string | null;
}

interface RelationshipData {
  asset: {
    assetID: number;
    name: string;
    parentAssetID: number | null;
    productType: { productTypeID: number; name: string; group: string } | null;
    model: string | null;
    serialNum: string | null;
    user: { userID: number; name: string } | null;
  };
  parentAsset: RelatedAsset | null;
  childAssets: RelatedAsset[];
}

interface AssetAssignmentModalProps {
  assetID: number;
  isOpen: boolean;
  onClose: () => void;
  onSuccess?: () => void;
}

function getGroupIcon(group: string | undefined) {
  switch (group) {
    case "Equipo":
      return <Monitor className="h-5 w-5" />;
    case "Componente":
      return <HardDrive className="h-5 w-5" />;
    case "Accesorio":
      return <Mouse className="h-5 w-5" />;
    default:
      return <Monitor className="h-5 w-5" />;
  }
}

function getGroupColor(group: string | undefined) {
  switch (group) {
    case "Equipo":
      return "bg-blue-100 text-blue-600 border-blue-200";
    case "Componente":
      return "bg-purple-100 text-purple-600 border-purple-200";
    case "Accesorio":
      return "bg-emerald-100 text-emerald-600 border-emerald-200";
    default:
      return "bg-gray-100 text-gray-600 border-gray-200";
  }
}

export const AssetAssignmentModal = ({
  assetID,
  isOpen,
  onClose,
  onSuccess,
}: AssetAssignmentModalProps) => {
  const [data, setData] = useState<RelationshipData | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isActioning, setIsActioning] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [searchResults, setSearchResults] = useState<Asset[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [allAssets, setAllAssets] = useState<Asset[]>([]);
  const [showSearch, setShowSearch] = useState(false);
  const [message, setMessage] = useState<{ type: "success" | "error"; text: string } | null>(null);

  const isEquipo = data?.asset?.productType?.group === "Equipo";

  const loadRelationships = useCallback(async () => {
    try {
      setIsLoading(true);
      const result = await api.asset.getRelationships(assetID);
      setData(result);
    } catch (error) {
      console.error("Error loading relationships:", error);
    } finally {
      setIsLoading(false);
    }
  }, [assetID]);

  useEffect(() => {
    if (isOpen && assetID) {
      loadRelationships();
      setSearchQuery("");
      setSearchResults([]);
      setShowSearch(false);
      setMessage(null);
    }
  }, [isOpen, assetID, loadRelationships]);

  const loadAssetsForSearch = async () => {
    if (allAssets.length > 0) return;
    try {
      const assets = await api.asset.getAll();
      setAllAssets(assets as Asset[]);
    } catch (error) {
      console.error("Error loading assets for search:", error);
    }
  };

  const handleSearch = async (query: string) => {
    setSearchQuery(query);
    if (!query.trim()) {
      setSearchResults([]);
      return;
    }

    setIsSearching(true);
    await loadAssetsForSearch();

    const q = query.toLowerCase();
    const currentChildIDs = new Set(data?.childAssets.map((c) => c.assetID) || []);
    const parentID = data?.parentAsset?.assetID;

    const filtered = allAssets.filter((asset) => {
      // Exclude current asset
      if (asset.assetID === assetID) return false;
      // Exclude already assigned children
      if (currentChildIDs.has(asset.assetID)) return false;

      if (isEquipo) {
        // For equipment: only show Componente/Accesorio that are not already assigned elsewhere
        const group = asset.productType?.group;
        if (group !== "Componente" && group !== "Accesorio") return false;
      } else {
        // For Componente/Accesorio: only show Equipo
        if (asset.productType?.group !== "Equipo") return false;
        // Exclude current parent
        if (parentID && asset.assetID === parentID) return false;
      }

      // Search match
      return (
        asset.name.toLowerCase().includes(q) ||
        asset.assetDetail?.serialNum?.toLowerCase().includes(q) ||
        asset.assetDetail?.model?.toLowerCase().includes(q) ||
        asset.productType?.name?.toLowerCase().includes(q)
      );
    });

    setSearchResults(filtered.slice(0, 10));
    setIsSearching(false);
  };

  const handleAssignChild = async (childAssetID: number) => {
    try {
      setIsActioning(true);
      setMessage(null);
      await api.asset.assignChild(assetID, childAssetID);
      setMessage({ type: "success", text: "Activo asignado exitosamente" });
      setSearchQuery("");
      setSearchResults([]);
      setShowSearch(false);
      setAllAssets([]);
      await loadRelationships();
      onSuccess?.();
    } catch (error: unknown) {
      const msg = error && typeof error === "object" && "response" in error
        ? (error as { response: { data: { message?: string } } }).response?.data?.message || "Error al asignar"
        : "Error al asignar";
      setMessage({ type: "error", text: msg });
    } finally {
      setIsActioning(false);
    }
  };

  const handleUnassignChild = async (childAssetID: number) => {
    try {
      setIsActioning(true);
      setMessage(null);
      await api.asset.unassignChild(assetID, childAssetID);
      setMessage({ type: "success", text: "Activo removido exitosamente" });
      setAllAssets([]);
      await loadRelationships();
      onSuccess?.();
    } catch (error: unknown) {
      const msg = error && typeof error === "object" && "response" in error
        ? (error as { response: { data: { message?: string } } }).response?.data?.message || "Error al remover"
        : "Error al remover";
      setMessage({ type: "error", text: msg });
    } finally {
      setIsActioning(false);
    }
  };

  const handleAssignParent = async (parentAssetID: number) => {
    try {
      setIsActioning(true);
      setMessage(null);
      await api.asset.assignParent(assetID, parentAssetID);
      setMessage({ type: "success", text: "Equipo asignado exitosamente" });
      setSearchQuery("");
      setSearchResults([]);
      setShowSearch(false);
      setAllAssets([]);
      await loadRelationships();
      onSuccess?.();
    } catch (error: unknown) {
      const msg = error && typeof error === "object" && "response" in error
        ? (error as { response: { data: { message?: string } } }).response?.data?.message || "Error al asignar"
        : "Error al asignar";
      setMessage({ type: "error", text: msg });
    } finally {
      setIsActioning(false);
    }
  };

  const handleUnassignParent = async () => {
    try {
      setIsActioning(true);
      setMessage(null);
      await api.asset.unassignParent(assetID);
      setMessage({ type: "success", text: "Equipo removido exitosamente" });
      setAllAssets([]);
      await loadRelationships();
      onSuccess?.();
    } catch (error: unknown) {
      const msg = error && typeof error === "object" && "response" in error
        ? (error as { response: { data: { message?: string } } }).response?.data?.message || "Error al remover"
        : "Error al remover";
      setMessage({ type: "error", text: msg });
    } finally {
      setIsActioning(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-3xl max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-5 py-4 border-b bg-gradient-to-r from-blue-50 to-white">
          <div className="flex items-center gap-3">
            <div className="flex items-center justify-center h-10 w-10 rounded-lg bg-blue-100 text-blue-600">
              <Link2 className="h-5 w-5" />
            </div>
            <div>
              <h2 className="text-lg font-semibold text-gray-900">Asignacion</h2>
              <p className="text-sm text-gray-500">
                {isLoading ? "Cargando..." : data?.asset?.name || ""}
              </p>
            </div>
          </div>
          <Button variant="ghost" size="icon" onClick={onClose} className="h-8 w-8">
            <X className="h-4 w-4" />
          </Button>
        </div>

        {/* Message */}
        {message && (
          <div
            className={`mx-5 mt-3 px-4 py-2 rounded-lg text-sm ${
              message.type === "success"
                ? "bg-green-50 text-green-700 border border-green-200"
                : "bg-red-50 text-red-700 border border-red-200"
            }`}
          >
            {message.text}
          </div>
        )}

        {/* Content */}
        <div className="flex-1 overflow-y-auto px-5 py-4">
          {isLoading ? (
            <div className="flex items-center justify-center h-48">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
            </div>
          ) : data ? (
            <div className="space-y-6">
              {/* Current Asset - Center Card */}
              <div className="flex flex-col items-center">
                <div
                  className={`flex items-center gap-3 px-6 py-4 rounded-xl border-2 shadow-sm ${getGroupColor(
                    data.asset.productType?.group
                  )}`}
                >
                  <div className="flex items-center justify-center h-12 w-12 rounded-full bg-white/80 shadow-sm">
                    {getGroupIcon(data.asset.productType?.group)}
                  </div>
                  <div>
                    <p className="font-semibold text-base">{data.asset.name}</p>
                    <p className="text-xs opacity-75">
                      {data.asset.productType?.name || "Sin tipo"} - {data.asset.productType?.group || ""}
                    </p>
                    {data.asset.user && (
                      <p className="text-xs opacity-75 mt-0.5">
                        Usuario: {data.asset.user.name}
                      </p>
                    )}
                  </div>
                </div>

                {/* Connection line */}
                <div className="w-px h-6 bg-gray-300"></div>
              </div>

              {isEquipo ? (
                /* === EQUIPO VIEW: Show children (componentes/accesorios) === */
                <>
                  {/* Section: Componentes */}
                  <div>
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-2">
                        <HardDrive className="h-4 w-4 text-purple-600" />
                        <h3 className="text-sm font-semibold text-gray-700">
                          Componentes ({data.childAssets.filter((c) => c.productType?.group === "Componente").length})
                        </h3>
                      </div>
                    </div>
                    <div className="space-y-2">
                      {data.childAssets
                        .filter((c) => c.productType?.group === "Componente")
                        .map((child) => (
                          <div
                            key={child.assetID}
                            className="flex items-center justify-between px-4 py-3 bg-purple-50 rounded-lg border border-purple-100"
                          >
                            <div className="flex items-center gap-3">
                              <HardDrive className="h-4 w-4 text-purple-500" />
                              <div>
                                <p className="text-sm font-medium text-gray-900">{child.name}</p>
                                <p className="text-xs text-gray-500">
                                  {child.productType?.name}
                                  {child.model ? ` - ${child.model}` : ""}
                                  {child.serialNum ? ` | S/N: ${child.serialNum}` : ""}
                                </p>
                              </div>
                            </div>
                            <Button
                              variant="ghost"
                              size="icon"
                              className="h-8 w-8 text-red-400 hover:text-red-600 hover:bg-red-50"
                              onClick={() => handleUnassignChild(child.assetID)}
                              disabled={isActioning}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </div>
                        ))}
                      {data.childAssets.filter((c) => c.productType?.group === "Componente").length === 0 && (
                        <p className="text-sm text-gray-400 italic text-center py-3">
                          Sin componentes asignados
                        </p>
                      )}
                    </div>
                  </div>

                  {/* Section: Accesorios */}
                  <div>
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-2">
                        <Mouse className="h-4 w-4 text-emerald-600" />
                        <h3 className="text-sm font-semibold text-gray-700">
                          Accesorios ({data.childAssets.filter((c) => c.productType?.group === "Accesorio").length})
                        </h3>
                      </div>
                    </div>
                    <div className="space-y-2">
                      {data.childAssets
                        .filter((c) => c.productType?.group === "Accesorio")
                        .map((child) => (
                          <div
                            key={child.assetID}
                            className="flex items-center justify-between px-4 py-3 bg-emerald-50 rounded-lg border border-emerald-100"
                          >
                            <div className="flex items-center gap-3">
                              <Mouse className="h-4 w-4 text-emerald-500" />
                              <div>
                                <p className="text-sm font-medium text-gray-900">{child.name}</p>
                                <p className="text-xs text-gray-500">
                                  {child.productType?.name}
                                  {child.model ? ` - ${child.model}` : ""}
                                  {child.serialNum ? ` | S/N: ${child.serialNum}` : ""}
                                </p>
                              </div>
                            </div>
                            <Button
                              variant="ghost"
                              size="icon"
                              className="h-8 w-8 text-red-400 hover:text-red-600 hover:bg-red-50"
                              onClick={() => handleUnassignChild(child.assetID)}
                              disabled={isActioning}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </div>
                        ))}
                      {data.childAssets.filter((c) => c.productType?.group === "Accesorio").length === 0 && (
                        <p className="text-sm text-gray-400 italic text-center py-3">
                          Sin accesorios asignados
                        </p>
                      )}
                    </div>
                  </div>

                  {/* Add button */}
                  {!showSearch && (
                    <div className="flex justify-center">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => {
                          setShowSearch(true);
                          loadAssetsForSearch();
                        }}
                        className="flex items-center gap-2"
                      >
                        <Plus className="h-4 w-4" />
                        Agregar componente o accesorio
                      </Button>
                    </div>
                  )}
                </>
              ) : (
                /* === COMPONENTE/ACCESORIO VIEW: Show parent equipment === */
                <>
                  <div>
                    <div className="flex items-center gap-2 mb-3">
                      <ArrowUp className="h-4 w-4 text-blue-600" />
                      <h3 className="text-sm font-semibold text-gray-700">
                        Equipo asignado
                      </h3>
                    </div>

                    {data.parentAsset ? (
                      <div className="flex items-center justify-between px-4 py-3 bg-blue-50 rounded-lg border border-blue-100">
                        <div className="flex items-center gap-3">
                          <Monitor className="h-5 w-5 text-blue-500" />
                          <div>
                            <p className="text-sm font-medium text-gray-900">
                              {data.parentAsset.name}
                            </p>
                            <p className="text-xs text-gray-500">
                              {data.parentAsset.productType?.name}
                              {data.parentAsset.model ? ` - ${data.parentAsset.model}` : ""}
                              {data.parentAsset.serialNum ? ` | S/N: ${data.parentAsset.serialNum}` : ""}
                            </p>
                          </div>
                        </div>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="h-8 w-8 text-red-400 hover:text-red-600 hover:bg-red-50"
                          onClick={handleUnassignParent}
                          disabled={isActioning}
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    ) : (
                      <div className="text-center py-4">
                        <p className="text-sm text-gray-400 italic mb-3">
                          No asignado a ningun equipo
                        </p>
                        {!showSearch && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => {
                              setShowSearch(true);
                              loadAssetsForSearch();
                            }}
                            className="flex items-center gap-2"
                          >
                            <Plus className="h-4 w-4" />
                            Asignar a un equipo
                          </Button>
                        )}
                      </div>
                    )}
                  </div>
                </>
              )}

              {/* Search panel */}
              {showSearch && (
                <div className="border rounded-lg p-4 bg-gray-50">
                  <div className="flex items-center justify-between mb-3">
                    <h4 className="text-sm font-semibold text-gray-700">
                      {isEquipo ? "Buscar componente o accesorio" : "Buscar equipo"}
                    </h4>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-7 w-7"
                      onClick={() => {
                        setShowSearch(false);
                        setSearchQuery("");
                        setSearchResults([]);
                      }}
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>

                  <div className="relative mb-3">
                    <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                      placeholder="Buscar por nombre, serie, modelo..."
                      value={searchQuery}
                      onChange={(e) => handleSearch(e.target.value)}
                      className="pl-10"
                      autoFocus
                    />
                  </div>

                  {isSearching && (
                    <div className="flex items-center justify-center py-4">
                      <Loader2 className="h-5 w-5 animate-spin text-gray-400" />
                    </div>
                  )}

                  {searchResults.length > 0 && (
                    <div className="space-y-1 max-h-48 overflow-y-auto">
                      {searchResults.map((result) => (
                        <button
                          key={result.assetID}
                          className="w-full flex items-center justify-between px-3 py-2 rounded-md hover:bg-white border border-transparent hover:border-gray-200 transition-colors text-left"
                          onClick={() => {
                            if (isEquipo) {
                              handleAssignChild(result.assetID);
                            } else {
                              handleAssignParent(result.assetID);
                            }
                          }}
                          disabled={isActioning}
                        >
                          <div className="flex items-center gap-2">
                            {getGroupIcon(result.productType?.group)}
                            <div>
                              <p className="text-sm font-medium text-gray-900">{result.name}</p>
                              <p className="text-xs text-gray-500">
                                {result.productType?.name}
                                {result.assetDetail?.model ? ` - ${result.assetDetail.model}` : ""}
                                {result.assetDetail?.serialNum ? ` | S/N: ${result.assetDetail.serialNum}` : ""}
                              </p>
                            </div>
                          </div>
                          <Plus className="h-4 w-4 text-blue-500" />
                        </button>
                      ))}
                    </div>
                  )}

                  {searchQuery.trim() && !isSearching && searchResults.length === 0 && (
                    <p className="text-sm text-gray-400 text-center py-3">
                      No se encontraron resultados
                    </p>
                  )}
                </div>
              )}
            </div>
          ) : (
            <div className="flex items-center justify-center h-48 text-gray-500">
              No se pudo cargar la informacion del activo
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex gap-2 px-5 py-3 border-t bg-gray-50">
          <Button variant="outline" onClick={onClose} className="flex-1">
            Cerrar
          </Button>
        </div>
      </div>
    </div>
  );
};
