import { useState, useMemo } from "react";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible";
import {
  Search,
  ChevronRight,
  ChevronDown,
  Folder,
  FolderOpen,
  Monitor,
  Laptop,
  Smartphone,
  Server,
  Printer,
  HardDrive,
  Wifi,
  Package,
  Star,
  LayoutGrid,
} from "lucide-react";
import { ProductType } from "@/types";
import { cn } from "@/lib/utils";

interface AssetCategorySidebarProps {
  productTypes: ProductType[];
  selectedFilter: {
    type: "all" | "category" | "group" | "subCategory" | "productType";
    value: string | null;
  };
  onFilterChange: (filter: {
    type: "all" | "category" | "group" | "subCategory" | "productType";
    value: string | null;
  }) => void;
  assetCounts?: Record<string, number>;
}

// Iconos por categoría
const getCategoryIcon = (name: string, isOpen?: boolean) => {
  const lowerName = name.toLowerCase();
  if (lowerName.includes("computer") || lowerName.includes("computadora") || lowerName.includes("desktop")) {
    return <Monitor className="h-4 w-4 text-blue-500" />;
  }
  if (lowerName.includes("laptop") || lowerName.includes("notebook")) {
    return <Laptop className="h-4 w-4 text-indigo-500" />;
  }
  if (lowerName.includes("mobile") || lowerName.includes("phone") || lowerName.includes("handheld") || lowerName.includes("movil")) {
    return <Smartphone className="h-4 w-4 text-green-500" />;
  }
  if (lowerName.includes("server") || lowerName.includes("servidor")) {
    return <Server className="h-4 w-4 text-purple-500" />;
  }
  if (lowerName.includes("printer") || lowerName.includes("impresora")) {
    return <Printer className="h-4 w-4 text-orange-500" />;
  }
  if (lowerName.includes("storage") || lowerName.includes("disk") || lowerName.includes("almacenamiento")) {
    return <HardDrive className="h-4 w-4 text-gray-500" />;
  }
  if (lowerName.includes("network") || lowerName.includes("wifi") || lowerName.includes("access point") || lowerName.includes("red")) {
    return <Wifi className="h-4 w-4 text-cyan-500" />;
  }
  if (isOpen !== undefined) {
    return isOpen ? <FolderOpen className="h-4 w-4 text-yellow-500" /> : <Folder className="h-4 w-4 text-yellow-500" />;
  }
  return <Package className="h-4 w-4 text-gray-400" />;
};

// Estructura jerárquica de categorías
interface CategoryTree {
  name: string;
  groups: {
    name: string;
    subCategories: {
      name: string;
      productTypes: ProductType[];
    }[];
  }[];
}

export const AssetCategorySidebar = ({
  productTypes,
  selectedFilter,
  onFilterChange,
  assetCounts = {},
}: AssetCategorySidebarProps) => {
  const [searchQuery, setSearchQuery] = useState("");
  const [expandedCategories, setExpandedCategories] = useState<Set<string>>(new Set(["IT"]));
  const [expandedGroups, setExpandedGroups] = useState<Set<string>>(new Set());
  const [expandedSubCategories, setExpandedSubCategories] = useState<Set<string>>(new Set());

  // Construir árbol jerárquico de categorías
  const categoryTree = useMemo(() => {
    const tree: CategoryTree[] = [];
    const categoryMap = new Map<string, CategoryTree>();

    productTypes.forEach((pt) => {
      // Categoría
      if (!categoryMap.has(pt.category)) {
        categoryMap.set(pt.category, {
          name: pt.category,
          groups: [],
        });
      }
      const category = categoryMap.get(pt.category)!;

      // Grupo
      let group = category.groups.find((g) => g.name === pt.group);
      if (!group) {
        group = { name: pt.group, subCategories: [] };
        category.groups.push(group);
      }

      // SubCategoría
      let subCategory = group.subCategories.find((sc) => sc.name === pt.subCategory);
      if (!subCategory) {
        subCategory = { name: pt.subCategory, productTypes: [] };
        group.subCategories.push(subCategory);
      }

      // ProductType
      subCategory.productTypes.push(pt);
    });

    categoryMap.forEach((cat) => tree.push(cat));
    return tree;
  }, [productTypes]);

  // Filtrar por búsqueda
  const filteredTree = useMemo(() => {
    if (!searchQuery.trim()) return categoryTree;

    const query = searchQuery.toLowerCase();
    return categoryTree
      .map((cat) => ({
        ...cat,
        groups: cat.groups
          .map((group) => ({
            ...group,
            subCategories: group.subCategories
              .map((sub) => ({
                ...sub,
                productTypes: sub.productTypes.filter((pt) =>
                  pt.name.toLowerCase().includes(query)
                ),
              }))
              .filter(
                (sub) =>
                  sub.productTypes.length > 0 ||
                  sub.name.toLowerCase().includes(query)
              ),
          }))
          .filter(
            (group) =>
              group.subCategories.length > 0 ||
              group.name.toLowerCase().includes(query)
          ),
      }))
      .filter(
        (cat) =>
          cat.groups.length > 0 || cat.name.toLowerCase().includes(query)
      );
  }, [categoryTree, searchQuery]);

  const toggleCategory = (categoryName: string) => {
    const newExpanded = new Set(expandedCategories);
    if (newExpanded.has(categoryName)) {
      newExpanded.delete(categoryName);
    } else {
      newExpanded.add(categoryName);
    }
    setExpandedCategories(newExpanded);
  };

  const toggleGroup = (groupKey: string) => {
    const newExpanded = new Set(expandedGroups);
    if (newExpanded.has(groupKey)) {
      newExpanded.delete(groupKey);
    } else {
      newExpanded.add(groupKey);
    }
    setExpandedGroups(newExpanded);
  };

  const toggleSubCategory = (subCategoryKey: string) => {
    const newExpanded = new Set(expandedSubCategories);
    if (newExpanded.has(subCategoryKey)) {
      newExpanded.delete(subCategoryKey);
    } else {
      newExpanded.add(subCategoryKey);
    }
    setExpandedSubCategories(newExpanded);
  };

  const isSelected = (type: string, value: string | null) => {
    return selectedFilter.type === type && selectedFilter.value === value;
  };

  return (
    <div className="flex flex-col h-full bg-white border-r">
      {/* Búsqueda */}
      <div className="p-3 border-b">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
          <Input
            placeholder="Buscar..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-9 h-8 text-sm"
          />
        </div>
      </div>

      {/* Favoritos */}
      <div className="px-3 py-2 border-b">
        <div className="flex items-center gap-2 text-sm text-gray-500">
          <Star className="h-4 w-4 text-yellow-500" />
          <span>Favorites</span>
        </div>
      </div>

      {/* All Assets */}
      <div className="px-3 py-2 border-b">
        <button
          onClick={() => onFilterChange({ type: "all", value: null })}
          className={cn(
            "flex items-center justify-between w-full text-sm font-medium hover:bg-gray-100 rounded px-2 py-1.5 transition-colors",
            isSelected("all", null) && "bg-blue-50 text-blue-600"
          )}
        >
          <div className="flex items-center gap-2">
            <LayoutGrid className="h-4 w-4" />
            <span>All Assets</span>
          </div>
          <span className="text-xs text-blue-500 hover:underline">Expand</span>
        </button>
      </div>

      {/* Árbol de Categorías */}
      <ScrollArea className="flex-1">
        <div className="p-2">
          <div className="text-xs font-semibold text-gray-500 uppercase tracking-wider px-2 py-1 mb-1">
            Assets
          </div>

          {filteredTree.map((category) => {
            const categoryKey = category.name;
            const isCategoryExpanded = expandedCategories.has(categoryKey);

            return (
              <Collapsible
                key={categoryKey}
                open={isCategoryExpanded}
                onOpenChange={() => toggleCategory(categoryKey)}
              >
                <CollapsibleTrigger asChild>
                  <button
                    className={cn(
                      "flex items-center gap-1 w-full text-sm hover:bg-gray-100 rounded px-2 py-1.5 transition-colors",
                      isSelected("category", category.name) && "bg-blue-50 text-blue-600"
                    )}
                  >
                    {isCategoryExpanded ? (
                      <ChevronDown className="h-4 w-4 text-gray-400" />
                    ) : (
                      <ChevronRight className="h-4 w-4 text-gray-400" />
                    )}
                    {getCategoryIcon(category.name, isCategoryExpanded)}
                    <span className="truncate">{category.name}</span>
                  </button>
                </CollapsibleTrigger>

                <CollapsibleContent>
                  <div className="ml-4">
                    {category.groups.map((group) => {
                      const groupKey = `${categoryKey}-${group.name}`;
                      const isGroupExpanded = expandedGroups.has(groupKey);

                      return (
                        <Collapsible
                          key={groupKey}
                          open={isGroupExpanded}
                          onOpenChange={() => toggleGroup(groupKey)}
                        >
                          <CollapsibleTrigger asChild>
                            <button
                              className={cn(
                                "flex items-center gap-1 w-full text-sm hover:bg-gray-100 rounded px-2 py-1.5 transition-colors",
                                isSelected("group", group.name) && "bg-blue-50 text-blue-600"
                              )}
                            >
                              {isGroupExpanded ? (
                                <ChevronDown className="h-4 w-4 text-gray-400" />
                              ) : (
                                <ChevronRight className="h-4 w-4 text-gray-400" />
                              )}
                              {getCategoryIcon(group.name, isGroupExpanded)}
                              <span className="truncate">{group.name}</span>
                            </button>
                          </CollapsibleTrigger>

                          <CollapsibleContent>
                            <div className="ml-4">
                              {group.subCategories.map((subCat) => {
                                const subCatKey = `${groupKey}-${subCat.name}`;
                                const isSubCatExpanded = expandedSubCategories.has(subCatKey);

                                return (
                                  <Collapsible
                                    key={subCatKey}
                                    open={isSubCatExpanded}
                                    onOpenChange={() => toggleSubCategory(subCatKey)}
                                  >
                                    <CollapsibleTrigger asChild>
                                      <button
                                        className={cn(
                                          "flex items-center gap-1 w-full text-sm hover:bg-gray-100 rounded px-2 py-1.5 transition-colors",
                                          isSelected("subCategory", subCat.name) && "bg-blue-50 text-blue-600"
                                        )}
                                        onClick={(e) => {
                                          e.stopPropagation();
                                          onFilterChange({ type: "subCategory", value: subCat.name });
                                        }}
                                      >
                                        {subCat.productTypes.length > 0 ? (
                                          isSubCatExpanded ? (
                                            <ChevronDown className="h-4 w-4 text-gray-400" />
                                          ) : (
                                            <ChevronRight className="h-4 w-4 text-gray-400" />
                                          )
                                        ) : (
                                          <span className="w-4" />
                                        )}
                                        {getCategoryIcon(subCat.name)}
                                        <span className="truncate">{subCat.name}</span>
                                      </button>
                                    </CollapsibleTrigger>

                                    <CollapsibleContent>
                                      <div className="ml-4">
                                        {subCat.productTypes.map((pt) => (
                                          <button
                                            key={pt.productTypeID}
                                            onClick={() =>
                                              onFilterChange({
                                                type: "productType",
                                                value: pt.productTypeID.toString(),
                                              })
                                            }
                                            className={cn(
                                              "flex items-center gap-2 w-full text-sm hover:bg-gray-100 rounded px-2 py-1.5 transition-colors truncate",
                                              isSelected("productType", pt.productTypeID.toString()) &&
                                                "bg-blue-50 text-blue-600"
                                            )}
                                          >
                                            {getCategoryIcon(pt.name)}
                                            <span className="truncate" title={pt.name}>
                                              {pt.name}
                                            </span>
                                          </button>
                                        ))}
                                      </div>
                                    </CollapsibleContent>
                                  </Collapsible>
                                );
                              })}
                            </div>
                          </CollapsibleContent>
                        </Collapsible>
                      );
                    })}
                  </div>
                </CollapsibleContent>
              </Collapsible>
            );
          })}
        </div>
      </ScrollArea>

      {/* Asset Allocation Details */}
      <div className="p-3 border-t">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
          <Input
            placeholder="Asset Allocation Details"
            className="pl-9 h-8 text-sm"
            readOnly
          />
        </div>
      </div>
    </div>
  );
};
