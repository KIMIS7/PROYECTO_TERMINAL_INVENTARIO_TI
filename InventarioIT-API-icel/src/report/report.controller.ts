import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Query,
  Res,
  Headers,
} from '@nestjs/common';
import { ReportService } from './report.service';
import { Response } from 'express';

@Controller('report')
export class ReportController {
  constructor(private readonly reportService: ReportService) {}

  /**
   * GET /report/delivery/:assetId/data
   * Obtiene los datos necesarios para previsualizar un reporte de entrega
   */
  @Get('delivery/:assetId/data')
  getDeliveryReportData(@Param('assetId') assetId: string) {
    return this.reportService.getDeliveryReportData(+assetId);
  }

  /**
   * POST /report/delivery/:assetId/pdf
   * Genera y descarga el PDF de entrega de equipo
   * Body: { softwareStatus?: Record<string, string>, notes?: string }
   */
  @Post('delivery/:assetId/pdf')
  async generateDeliveryPdf(
    @Param('assetId') assetId: string,
    @Body() body: { softwareStatus?: Record<string, string>; notes?: string },
    @Res() res: Response,
  ) {
    const pdfBuffer = await this.reportService.generateDeliveryPdf(
      +assetId,
      body.softwareStatus,
      body.notes,
    );

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename="entrega_equipo_${assetId}.pdf"`,
      'Content-Length': pdfBuffer.length,
    });

    res.end(pdfBuffer);
  }

  /**
   * GET /report/assets/excel
   * Genera y descarga el Excel del inventario completo
   * Query params: group, companyID, assetState
   */
  @Get('assets/excel')
  async generateAssetsExcel(
    @Query('group') group: string,
    @Query('companyID') companyID: string,
    @Query('assetState') assetState: string,
    @Res() res: Response,
  ) {
    const filters: any = {};
    if (group) filters.group = group;
    if (companyID) filters.companyID = +companyID;
    if (assetState) filters.assetState = +assetState;

    const buffer = await this.reportService.generateAssetsExcel(filters);

    const dateStr = new Date().toISOString().split('T')[0];
    res.set({
      'Content-Type':
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'Content-Disposition': `attachment; filename="inventario_${dateStr}.xlsx"`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }

  /**
   * GET /report/assets/csv
   * Genera y descarga el CSV del inventario
   */
  @Get('assets/csv')
  async generateAssetsCsv(
    @Query('group') group: string,
    @Query('companyID') companyID: string,
    @Query('assetState') assetState: string,
    @Res() res: Response,
  ) {
    const filters: any = {};
    if (group) filters.group = group;
    if (companyID) filters.companyID = +companyID;
    if (assetState) filters.assetState = +assetState;

    const csv = await this.reportService.generateAssetsCsv(filters);

    const dateStr = new Date().toISOString().split('T')[0];
    res.set({
      'Content-Type': 'text/csv; charset=utf-8',
      'Content-Disposition': `attachment; filename="inventario_${dateStr}.csv"`,
    });

    // Agregar BOM para UTF-8 en Excel
    res.send('\ufeff' + csv);
  }

  /**
   * GET /report/history/excel
   * Genera y descarga el Excel del historial de movimientos
   */
  @Get('history/excel')
  async generateMovementHistoryExcel(
    @Query('assetId') assetId: string,
    @Res() res: Response,
  ) {
    const buffer = await this.reportService.generateMovementHistoryExcel(
      assetId ? +assetId : undefined,
    );

    const dateStr = new Date().toISOString().split('T')[0];
    res.set({
      'Content-Type':
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'Content-Disposition': `attachment; filename="historial_movimientos_${dateStr}.xlsx"`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }

  /**
   * GET /report/user/:userId/assets/excel
   * Genera reporte de resguardo de equipo por usuario
   */
  @Get('user/:userId/assets/excel')
  async generateUserAssetsReport(
    @Param('userId') userId: string,
    @Res() res: Response,
  ) {
    const buffer = await this.reportService.generateUserAssetsReport(+userId);

    const dateStr = new Date().toISOString().split('T')[0];
    res.set({
      'Content-Type':
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'Content-Disposition': `attachment; filename="resguardo_usuario_${userId}_${dateStr}.xlsx"`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }
}
