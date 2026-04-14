import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

interface DashboardFilters {
  siteID?: number;
  group?: string;
  stateID?: number;
}

@Injectable()
export class StatisticsService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async getDashboardStats(filters: DashboardFilters = {}) {
    try {
      // Build Prisma where clause from filters
      const where: Record<string, unknown> = {};
      if (filters.siteID) where.SiteID = filters.siteID;
      if (filters.stateID) where.AssetState = filters.stateID;
      if (filters.group) {
        where.ProductType = { Group: filters.group };
      }

      const [
        assets,
        historyRecords,
        recentMovementsRaw,
        assetStates,
        sites,
        productTypes,
      ] = await Promise.all([
        this.prismaShopic.asset.findMany({
          where,
          include: {
            AssetState_Asset_AssetStateToAssetState: true,
            Site: true,
            ProductType: true,
            User: true,
            AssetDetail: {
              select: {
                WarrantyExpiryDate: true,
                AssetACQDate: true,
              },
            },
          },
        }),
        this.prismaShopic.assetHistory.findMany({
          select: {
            AssetID: true,
            Operation: true,
            CreatedTime: true,
          },
        }),
        this.prismaShopic.assetHistory.findMany({
          select: {
            AssetID: true,
            Operation: true,
            Description: true,
            CreatedTime: true,
            Asset: {
              select: {
                Name: true,
                User: { select: { Name: true } },
              },
            },
          },
          orderBy: { CreatedTime: 'desc' },
          take: 10,
        }),
        this.prismaShopic.assetState.findMany(),
        this.prismaShopic.site.findMany(),
        this.prismaShopic.productType.findMany(),
      ]);

      // Build a set of filtered asset IDs for filtering history records
      const filteredAssetIDs = new Set(assets.map((a) => a.AssetID));

      const totalAssets = assets.length;
      const now = new Date();

      // Build a map: AssetID → detail (from included AssetDetail relation)
      const detailMap = new Map<number, { WarrantyExpiryDate: Date | null; AssetACQDate: Date | null }>();
      for (const a of assets) {
        if (a.AssetDetail) {
          detailMap.set(a.AssetID, a.AssetDetail);
        }
      }

      // ========== UTILIZACIÓN Y DISPONIBILIDAD ==========

      // Tasa de utilización: assets con un usuario real asignado
      // Un asset tiene usuario asignado si UserID no es null Y el estado es "Asignado"
      const assignedStateNames = ['Asignado'];
      const assignedAssets = assets.filter((a) => {
        const stateName = a.AssetState_Asset_AssetStateToAssetState?.Name;
        const hasUser = a.UserID != null;
        return hasUser && assignedStateNames.includes(stateName || '');
      }).length;
      const utilizationRate = totalAssets > 0 ? Math.round((assignedAssets / totalAssets) * 100) : 0;

      // Equipos en estado inactivo o en reparación
      const inactiveStates = ['Baja', 'Mantenimiento', 'Resguardo'];
      const inactiveAssets = assets.filter(
        (a) => a.AssetState_Asset_AssetStateToAssetState &&
          inactiveStates.includes(a.AssetState_Asset_AssetStateToAssetState.Name),
      ).length;
      const inactiveRate = totalAssets > 0 ? Math.round((inactiveAssets / totalAssets) * 100) : 0;

      // ========== CICLO DE VIDA Y OBSOLESCENCIA ==========

      // Índice de obsolescencia (assets > 4 years old)
      const fourYearsAgo = new Date();
      fourYearsAgo.setFullYear(fourYearsAgo.getFullYear() - 4);

      let obsoleteCount = 0;
      let totalWithAcqDate = 0;
      for (const asset of assets) {
        const detail = detailMap.get(asset.AssetID);
        if (detail?.AssetACQDate) {
          totalWithAcqDate++;
          if (new Date(detail.AssetACQDate) < fourYearsAgo) {
            obsoleteCount++;
          }
        }
      }
      const obsolescenceRate = totalWithAcqDate > 0 ? Math.round((obsoleteCount / totalWithAcqDate) * 100) : 0;

      // Activos próximos a vencer garantía (within 90 days)
      const ninetyDaysFromNow = new Date();
      ninetyDaysFromNow.setDate(ninetyDaysFromNow.getDate() + 90);

      let warrantyExpiringCount = 0;
      const warrantyAlertsList: {
        name: string;
        site: string;
        daysUntilExpiry: number;
      }[] = [];

      for (const asset of assets) {
        const detail = detailMap.get(asset.AssetID);
        if (detail?.WarrantyExpiryDate) {
          const expiryDate = new Date(detail.WarrantyExpiryDate);
          if (expiryDate > now && expiryDate <= ninetyDaysFromNow) {
            warrantyExpiringCount++;
            const daysUntilExpiry = Math.ceil(
              (expiryDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24),
            );
            warrantyAlertsList.push({
              name: asset.Name,
              site: asset.Site?.Name || 'Sin sede',
              daysUntilExpiry,
            });
          }
        }
      }

      // Sort warranty alerts by days ascending (most urgent first)
      warrantyAlertsList.sort((a, b) => a.daysUntilExpiry - b.daysUntilExpiry);

      // Antigüedad promedio por tipo de equipo
      const ageByType = new Map<string, { totalYears: number; count: number }>();
      for (const asset of assets) {
        const detail = detailMap.get(asset.AssetID);
        if (detail?.AssetACQDate && asset.ProductType) {
          const acqDate = new Date(detail.AssetACQDate);
          const ageYears = (now.getTime() - acqDate.getTime()) / (1000 * 60 * 60 * 24 * 365.25);
          const typeName = asset.ProductType.Name;
          const current = ageByType.get(typeName) || { totalYears: 0, count: 0 };
          current.totalYears += ageYears;
          current.count++;
          ageByType.set(typeName, current);
        }
      }
      const avgAgeByType = Array.from(ageByType.entries())
        .map(([type, data]) => ({
          type,
          avgYears: Math.round((data.totalYears / data.count) * 10) / 10,
          count: data.count,
        }))
        .sort((a, b) => b.avgYears - a.avgYears);

      // ========== DISTRIBUCIÓN Y TRAZABILIDAD ==========

      // Distribución de activos por sede
      const assetsBySite = new Map<string, number>();
      for (const asset of assets) {
        const siteName = asset.Site?.Name || 'Sin sede';
        assetsBySite.set(siteName, (assetsBySite.get(siteName) || 0) + 1);
      }
      const distributionBySite = Array.from(assetsBySite.entries())
        .map(([site, count]) => ({ site, count }))
        .sort((a, b) => b.count - a.count);

      // Frecuencia de reasignaciones (filtered by asset IDs if filters active)
      const hasFilters = filters.siteID || filters.group || filters.stateID;
      const filteredHistory = hasFilters
        ? historyRecords.filter((h) => filteredAssetIDs.has(h.AssetID))
        : historyRecords;

      const reassignments = filteredHistory.filter((h) => h.Operation === 'REASIGNACION').length;

      // Cobertura de garantía activa
      let activeWarrantyCount = 0;
      let totalWithWarranty = 0;
      for (const asset of assets) {
        const detail = detailMap.get(asset.AssetID);
        if (detail?.WarrantyExpiryDate) {
          totalWithWarranty++;
          if (new Date(detail.WarrantyExpiryDate) > now) {
            activeWarrantyCount++;
          }
        }
      }
      const warrantyCoverageRate = totalWithWarranty > 0
        ? Math.round((activeWarrantyCount / totalWithWarranty) * 100)
        : 0;

      // ========== Movements by month (last 6 months) ==========
      const monthNames = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
      const movementsByMonth: { month: string; count: number }[] = [];

      for (let i = 5; i >= 0; i--) {
        const d = new Date(now.getFullYear(), now.getMonth() - i, 1);
        const monthStart = new Date(d.getFullYear(), d.getMonth(), 1);
        const monthEnd = new Date(d.getFullYear(), d.getMonth() + 1, 1);

        const count = filteredHistory.filter((h) => {
          const created = new Date(h.CreatedTime);
          return created >= monthStart && created < monthEnd;
        }).length;

        movementsByMonth.push({
          month: monthNames[d.getMonth()],
          count,
        });
      }

      // ========== Assets created this month ==========
      const currentMonthStart = new Date(now.getFullYear(), now.getMonth(), 1);
      const newAssetsThisMonth = filteredHistory.filter((h) => {
        return h.Operation === 'CREATE' && new Date(h.CreatedTime) >= currentMonthStart;
      }).length;

      // ========== Recent movements with details ==========
      const filteredRecentMovements = hasFilters
        ? recentMovementsRaw.filter((m) => filteredAssetIDs.has(m.AssetID))
        : recentMovementsRaw;

      const recentMovements = filteredRecentMovements.slice(0, 10).map((m) => ({
        assetName: m.Asset?.Name || 'N/A',
        operation: m.Operation,
        user: m.Asset?.User?.Name || '—',
        date: m.CreatedTime,
      }));

      // ========== ASSETS TABLE DATA ==========
      const assetsTableData = assets.map((a) => {
        const detail = detailMap.get(a.AssetID);
        return {
          assetID: a.AssetID,
          name: a.Name,
          state: a.AssetState_Asset_AssetStateToAssetState?.Name || 'N/A',
          site: a.Site?.Name || 'Sin sede',
          productType: a.ProductType?.Name || 'N/A',
          group: a.ProductType?.Group || 'N/A',
          warrantyExpiry: detail?.WarrantyExpiryDate || null,
          acquisitionDate: detail?.AssetACQDate || null,
          hasActiveWarranty: detail?.WarrantyExpiryDate ? new Date(detail.WarrantyExpiryDate) > now : false,
          isObsolete: detail?.AssetACQDate ? new Date(detail.AssetACQDate) < fourYearsAgo : false,
        };
      });

      // ========== STATS BY STATE ==========
      const assetsByState = new Map<string, number>();
      for (const asset of assets) {
        const stateName = asset.AssetState_Asset_AssetStateToAssetState?.Name || 'Sin estado';
        assetsByState.set(stateName, (assetsByState.get(stateName) || 0) + 1);
      }
      const distributionByState = Array.from(assetsByState.entries())
        .map(([state, count]) => ({ state, count }))
        .sort((a, b) => b.count - a.count);

      // Warranty expiring percentage
      const warrantyExpiringPercent = totalAssets > 0
        ? Math.round((warrantyExpiringCount / totalAssets) * 1000) / 10
        : 0;

      // ========== FILTER OPTIONS (for frontend dropdowns) ==========
      const filterOptions = {
        sites: sites.map((s) => ({ siteID: s.SiteID, name: s.Name })),
        groups: [...new Set(productTypes.map((pt) => pt.Group))].filter(Boolean).sort(),
        states: assetStates.map((s) => ({ stateID: s.AssetStateID, name: s.Name })),
      };

      return {
        summary: {
          totalAssets,
          assignedAssets,
          inactiveAssets,
          obsoleteCount,
          warrantyExpiringCount,
          reassignments,
          activeWarrantyCount,
          newAssetsThisMonth,
          unassignedCount: totalAssets - assignedAssets,
          warrantyExpiringPercent,
        },
        kpis: {
          utilizationRate,
          inactiveRate,
          obsolescenceRate,
          warrantyCoverageRate,
          warrantyExpiringCount,
          reassignments,
          avgAgeByType,
        },
        distributions: {
          bySite: distributionBySite,
          byState: distributionByState,
        },
        movementsByMonth,
        warrantyAlerts: warrantyAlertsList.slice(0, 10),
        recentMovements,
        assetsTable: assetsTableData,
        filterOptions,
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener estadísticas del dashboard',
      });
    }
  }
}
