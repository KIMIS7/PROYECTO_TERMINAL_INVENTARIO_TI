import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';

@Injectable()
export class StatisticsService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  async getDashboardStats() {
    try {
      const [
        assets,
        assetDetails,
        historyRecords,
        assetStates,
        sites,
        productTypes,
      ] = await Promise.all([
        this.prismaShopic.asset.findMany({
          include: {
            AssetState_Asset_AssetStateToAssetState: true,
            Site: true,
            ProductType: true,
          },
        }),
        this.prismaShopic.assetDetail.findMany({
          select: {
            AssetID: true,
            WarrantyExpiryDate: true,
            AssetACQDate: true,
          },
        }),
        this.prismaShopic.assetHistory.findMany({
          select: {
            Operation: true,
            CreatedTime: true,
          },
        }),
        this.prismaShopic.assetState.findMany(),
        this.prismaShopic.site.findMany(),
        this.prismaShopic.productType.findMany(),
      ]);

      const totalAssets = assets.length;
      const now = new Date();

      // Build a map: AssetID → detail
      const detailMap = new Map<number, { WarrantyExpiryDate: Date | null; AssetACQDate: Date | null }>();
      for (const d of assetDetails) {
        detailMap.set(d.AssetID, d);
      }

      // ========== UTILIZACIÓN Y DISPONIBILIDAD ==========

      // 1. Tasa de utilización de activos (assets with UserID assigned)
      const assignedAssets = assets.filter((a) => a.UserID != null).length;
      const utilizationRate = totalAssets > 0 ? Math.round((assignedAssets / totalAssets) * 100) : 0;

      // 2. Equipos en estado inactivo o en reparación
      const inactiveStates = ['Baja', 'Mantenimiento', 'Resguardo'];
      const inactiveAssets = assets.filter(
        (a) => a.AssetState_Asset_AssetStateToAssetState &&
          inactiveStates.includes(a.AssetState_Asset_AssetStateToAssetState.Name),
      ).length;
      const inactiveRate = totalAssets > 0 ? Math.round((inactiveAssets / totalAssets) * 100) : 0;

      // ========== CICLO DE VIDA Y OBSOLESCENCIA ==========

      // 3. Índice de obsolescencia (assets > 4 years old)
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

      // 4. Activos próximos a vencer garantía (within 90 days)
      const ninetyDaysFromNow = new Date();
      ninetyDaysFromNow.setDate(ninetyDaysFromNow.getDate() + 90);

      let warrantyExpiringCount = 0;
      for (const asset of assets) {
        const detail = detailMap.get(asset.AssetID);
        if (detail?.WarrantyExpiryDate) {
          const expiryDate = new Date(detail.WarrantyExpiryDate);
          if (expiryDate > now && expiryDate <= ninetyDaysFromNow) {
            warrantyExpiringCount++;
          }
        }
      }

      // 5. Antigüedad promedio por tipo de equipo
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

      // 6. Distribución de activos por sede
      const assetsBySite = new Map<string, number>();
      for (const asset of assets) {
        const siteName = asset.Site?.Name || 'Sin sede';
        assetsBySite.set(siteName, (assetsBySite.get(siteName) || 0) + 1);
      }
      const distributionBySite = Array.from(assetsBySite.entries())
        .map(([site, count]) => ({ site, count }))
        .sort((a, b) => b.count - a.count);

      // 7. Frecuencia de reasignaciones
      const reassignments = historyRecords.filter((h) => h.Operation === 'REASIGNACION').length;

      // 8. Cobertura de garantía activa
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

      return {
        summary: {
          totalAssets,
          assignedAssets,
          inactiveAssets,
          obsoleteCount,
          warrantyExpiringCount,
          reassignments,
          activeWarrantyCount,
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
        assetsTable: assetsTableData,
      };
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al obtener estadísticas del dashboard',
      });
    }
  }
}
