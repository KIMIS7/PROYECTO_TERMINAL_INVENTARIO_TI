import { useState, useRef, useEffect, useMemo, useCallback } from "react";
import { X, Search, ChevronRight } from "lucide-react";
import { cn } from "@/lib/utils";

export interface FilterChip {
  id: string;
  facet: string;
  facetLabel: string;
  value: string;
  valueLabel: string;
}

export interface FacetOption {
  value: string;
  label: string;
}

export interface Facet {
  key: string;
  label: string;
  icon?: string;
  color: string;
  options: FacetOption[];
}

interface OmniboxFilterProps {
  facets: Facet[];
  chips: FilterChip[];
  onChipsChange: (chips: FilterChip[]) => void;
  searchQuery: string;
  onSearchQueryChange: (query: string) => void;
  placeholder?: string;
}

type DropdownMode = "facets" | "values";

const FACET_COLORS: Record<string, { chip: string; badge: string }> = {
  empresa: {
    chip: "bg-blue-50 text-blue-700 border-blue-200",
    badge: "bg-blue-100 text-blue-700",
  },
  usuario: {
    chip: "bg-emerald-50 text-emerald-700 border-emerald-200",
    badge: "bg-emerald-100 text-emerald-700",
  },
  estado: {
    chip: "bg-amber-50 text-amber-700 border-amber-200",
    badge: "bg-amber-100 text-amber-700",
  },
  tipo: {
    chip: "bg-purple-50 text-purple-700 border-purple-200",
    badge: "bg-purple-100 text-purple-700",
  },
};

export function OmniboxFilter({
  facets,
  chips,
  onChipsChange,
  searchQuery,
  onSearchQueryChange,
  placeholder = "Buscar o filtrar por atributo...",
}: OmniboxFilterProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [mode, setMode] = useState<DropdownMode>("facets");
  const [selectedFacet, setSelectedFacet] = useState<Facet | null>(null);
  const [inputValue, setInputValue] = useState("");
  const [highlightedIndex, setHighlightedIndex] = useState(0);

  const inputRef = useRef<HTMLInputElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);

  // Click outside to close
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (
        containerRef.current &&
        !containerRef.current.contains(e.target as Node)
      ) {
        closeDropdown();
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const closeDropdown = useCallback(() => {
    setIsOpen(false);
    setMode("facets");
    setSelectedFacet(null);
    setInputValue("");
  }, []);

  // Filtered facet list
  const filteredFacets = useMemo(() => {
    if (!inputValue.trim() || mode === "values") return facets;
    const query = inputValue.toLowerCase();
    return facets.filter((f) => f.label.toLowerCase().includes(query));
  }, [facets, inputValue, mode]);

  // Filtered values for selected facet
  const filteredValues = useMemo(() => {
    if (!selectedFacet) return [];
    // Exclude values already selected for this facet
    const usedValues = new Set(
      chips.filter((c) => c.facet === selectedFacet.key).map((c) => c.value)
    );
    let options = selectedFacet.options.filter(
      (o) => !usedValues.has(o.value)
    );
    if (inputValue.trim()) {
      const query = inputValue.toLowerCase();
      options = options.filter((o) =>
        o.label.toLowerCase().includes(query)
      );
    }
    return options;
  }, [selectedFacet, inputValue, chips]);

  // Reset highlight on list change
  useEffect(() => {
    setHighlightedIndex(0);
  }, [filteredFacets.length, filteredValues.length, mode]);

  // Scroll highlighted item into view
  useEffect(() => {
    if (!dropdownRef.current) return;
    const highlighted = dropdownRef.current.querySelector(
      `[data-index="${highlightedIndex}"]`
    );
    if (highlighted) {
      highlighted.scrollIntoView({ block: "nearest" });
    }
  }, [highlightedIndex]);

  const handleFacetSelect = (facet: Facet) => {
    setSelectedFacet(facet);
    setMode("values");
    setInputValue("");
    setHighlightedIndex(0);
    inputRef.current?.focus();
  };

  const handleValueSelect = (option: FacetOption) => {
    if (!selectedFacet) return;
    const newChip: FilterChip = {
      id: `${selectedFacet.key}-${option.value}`,
      facet: selectedFacet.key,
      facetLabel: selectedFacet.label,
      value: option.value,
      valueLabel: option.label,
    };
    onChipsChange([...chips, newChip]);
    setSelectedFacet(null);
    setMode("facets");
    setInputValue("");
    setHighlightedIndex(0);
    inputRef.current?.focus();
  };

  const handleRemoveChip = (chipId: string) => {
    onChipsChange(chips.filter((c) => c.id !== chipId));
    inputRef.current?.focus();
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value;
    setInputValue(val);
    if (!isOpen) setIsOpen(true);

    // In facets mode, update the search query for free-text search
    if (mode === "facets") {
      onSearchQueryChange(val);
    }
  };

  const handleInputFocus = () => {
    setIsOpen(true);
    if (mode === "facets") {
      setInputValue(searchQuery);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "Escape") {
      closeDropdown();
      inputRef.current?.blur();
      return;
    }

    if (e.key === "Backspace" && inputValue === "") {
      if (selectedFacet) {
        // Go back to facet selection
        setSelectedFacet(null);
        setMode("facets");
        setInputValue(searchQuery);
      } else if (chips.length > 0) {
        // Remove last chip
        handleRemoveChip(chips[chips.length - 1].id);
      }
      return;
    }

    if (!isOpen) return;

    const itemCount =
      mode === "facets" ? filteredFacets.length : filteredValues.length;

    if (e.key === "ArrowDown") {
      e.preventDefault();
      setHighlightedIndex((prev) =>
        prev < itemCount - 1 ? prev + 1 : 0
      );
    } else if (e.key === "ArrowUp") {
      e.preventDefault();
      setHighlightedIndex((prev) =>
        prev > 0 ? prev - 1 : Math.max(itemCount - 1, 0)
      );
    } else if (e.key === "Enter") {
      e.preventDefault();
      if (mode === "facets" && filteredFacets[highlightedIndex]) {
        handleFacetSelect(filteredFacets[highlightedIndex]);
      } else if (mode === "values" && filteredValues[highlightedIndex]) {
        handleValueSelect(filteredValues[highlightedIndex]);
      }
    }
  };

  const getChipColors = (facetKey: string) =>
    FACET_COLORS[facetKey] || {
      chip: "bg-gray-50 text-gray-700 border-gray-200",
      badge: "bg-gray-100 text-gray-700",
    };

  const activeFilterCount = chips.length;

  return (
    <div ref={containerRef} className="relative flex-1 min-w-0">
      {/* Omnibox input area */}
      <div
        className={cn(
          "flex items-center flex-wrap gap-1.5 min-h-[38px] pl-3 pr-2 py-1 border rounded-lg bg-white transition-all cursor-text",
          isOpen
            ? "border-blue-400 ring-2 ring-blue-50 shadow-sm"
            : "border-gray-200 hover:border-gray-300"
        )}
        onClick={() => inputRef.current?.focus()}
      >
        <Search className="h-4 w-4 text-gray-400 shrink-0" />

        {/* Chips */}
        {chips.map((chip) => {
          const colors = getChipColors(chip.facet);
          return (
            <span
              key={chip.id}
              className={cn(
                "inline-flex items-center gap-1 pl-1.5 pr-1 py-0.5 rounded-md text-xs font-medium border shrink-0 transition-colors",
                colors.chip
              )}
            >
              <span className="opacity-70 font-semibold">
                {chip.facetLabel}:
              </span>
              <span>{chip.valueLabel}</span>
              <button
                onClick={(e) => {
                  e.stopPropagation();
                  handleRemoveChip(chip.id);
                }}
                className="ml-0.5 p-0.5 rounded hover:bg-black/10 transition-colors"
              >
                <X className="h-3 w-3" />
              </button>
            </span>
          );
        })}

        {/* Active facet label (when selecting a value) */}
        {selectedFacet && (
          <span
            className={cn(
              "inline-flex items-center px-1.5 py-0.5 rounded-md text-xs font-semibold shrink-0",
              getChipColors(selectedFacet.key).badge
            )}
          >
            {selectedFacet.label}:
          </span>
        )}

        {/* Text input */}
        <input
          ref={inputRef}
          type="text"
          className="flex-1 min-w-[140px] outline-none text-sm bg-transparent placeholder:text-gray-400"
          value={inputValue}
          onChange={handleInputChange}
          onFocus={handleInputFocus}
          onKeyDown={handleKeyDown}
          placeholder={
            chips.length > 0 || selectedFacet
              ? "Agregar filtro..."
              : placeholder
          }
        />

        {/* Clear all button */}
        {(activeFilterCount > 0 || searchQuery) && (
          <button
            onClick={(e) => {
              e.stopPropagation();
              onChipsChange([]);
              onSearchQueryChange("");
              setInputValue("");
              setSelectedFacet(null);
              setMode("facets");
            }}
            className="shrink-0 p-1 rounded-md text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-colors"
            title="Limpiar todo"
          >
            <X className="h-3.5 w-3.5" />
          </button>
        )}
      </div>

      {/* Dropdown */}
      {isOpen && (
        <div
          ref={dropdownRef}
          className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-50 max-h-72 overflow-y-auto"
        >
          {/* Facet selection mode */}
          {mode === "facets" && (
            <div className="p-1">
              <div className="px-3 py-1.5 text-[11px] font-semibold text-gray-400 uppercase tracking-wider">
                Filtrar por
              </div>
              {filteredFacets.map((facet, index) => {
                const colors = getChipColors(facet.key);
                const activeCount = chips.filter(
                  (c) => c.facet === facet.key
                ).length;
                return (
                  <button
                    key={facet.key}
                    data-index={index}
                    className={cn(
                      "flex items-center justify-between w-full px-3 py-2 text-sm rounded-md text-left transition-colors",
                      index === highlightedIndex
                        ? "bg-blue-50 text-blue-700"
                        : "text-gray-700 hover:bg-gray-50"
                    )}
                    onMouseEnter={() => setHighlightedIndex(index)}
                    onClick={() => handleFacetSelect(facet)}
                  >
                    <div className="flex items-center gap-2">
                      <span
                        className={cn(
                          "px-2 py-0.5 rounded text-xs font-semibold",
                          colors.badge
                        )}
                      >
                        {facet.label}
                      </span>
                      <span className="text-gray-400 text-xs">
                        {facet.options.length} opciones
                      </span>
                      {activeCount > 0 && (
                        <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-blue-100 text-blue-600 font-semibold">
                          {activeCount} activo{activeCount > 1 ? "s" : ""}
                        </span>
                      )}
                    </div>
                    <ChevronRight className="h-3.5 w-3.5 text-gray-400" />
                  </button>
                );
              })}
              {filteredFacets.length === 0 && inputValue.trim() && (
                <div className="px-3 py-6 text-center">
                  <p className="text-sm text-gray-500">
                    Buscando por texto: &ldquo;{inputValue}&rdquo;
                  </p>
                  <p className="text-xs text-gray-400 mt-1">
                    Presiona Esc para cerrar
                  </p>
                </div>
              )}
            </div>
          )}

          {/* Value selection mode */}
          {mode === "values" && selectedFacet && (
            <div className="p-1">
              <button
                className="flex items-center gap-1.5 px-3 py-1.5 text-[11px] font-semibold text-gray-400 uppercase tracking-wider hover:text-gray-600 w-full text-left"
                onClick={() => {
                  setSelectedFacet(null);
                  setMode("facets");
                  setInputValue(searchQuery);
                }}
              >
                <ChevronRight className="h-3 w-3 rotate-180" />
                {selectedFacet.label} — Selecciona un valor
              </button>
              {filteredValues.length > 0 ? (
                filteredValues.map((option, index) => (
                  <button
                    key={option.value}
                    data-index={index}
                    className={cn(
                      "flex items-center w-full px-3 py-2 text-sm rounded-md text-left transition-colors",
                      index === highlightedIndex
                        ? "bg-blue-50 text-blue-700"
                        : "text-gray-700 hover:bg-gray-50"
                    )}
                    onMouseEnter={() => setHighlightedIndex(index)}
                    onClick={() => handleValueSelect(option)}
                  >
                    {option.label}
                  </button>
                ))
              ) : (
                <div className="px-3 py-6 text-sm text-gray-500 text-center">
                  No se encontraron opciones
                </div>
              )}
            </div>
          )}
        </div>
      )}
    </div>
  );
}
