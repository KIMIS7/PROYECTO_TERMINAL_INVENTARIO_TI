import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Query,
  Res,
  UseInterceptors,
  UploadedFile,
  BadRequestException,
  Headers,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ReportService } from './report.service';
import { Response } from 'express';

@Controller('report')
export class ReportController {
  constructor(private readonly reportService: ReportService) {}

  // ==========================================
  // Data endpoints (para previsualización)
  // ==========================================

  @Get('delivery/:assetId/data')
  getDeliveryReportData(@Param('assetId') assetId: string) {
    return this.reportService.getDeliveryReportData(+assetId);
  }

  @Post('multi-item/data')
  getMultiItemReportData(@Body() body: { assetIds: number[] }) {
    return this.reportService.getMultiItemReportData(body.assetIds);
  }

  // ==========================================
  // PDF Formato 1: Entrega con software checklist
  // ==========================================

  @Post('delivery/:assetId/pdf')
  async generateDeliveryPdf(
    @Param('assetId') assetId: string,
    @Body()
    body: {
      softwareStatus?: Record<string, string>;
      notes?: string;
    },
    @Res() res: Response,
  ) {
    const pdfBuffer = await this.reportService.generateEntregaSoftwarePdf(
      +assetId,
      body,
    );

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename="entrega_equipo_${assetId}.pdf"`,
      'Content-Length': pdfBuffer.length,
    });

    res.end(pdfBuffer);
  }

  // ==========================================
  // PDF Formato 2: Entrega multi-item (periféricos)
  // ==========================================

  @Post('entrega-multiitem/pdf')
  async generateEntregaMultiItemPdf(
    @Body()
    body: {
      assetIds: number[];
      asunto?: string;
      razonSocial?: string;
      department?: string;
      receiverName?: string;
      notes?: string;
    },
    @Res() res: Response,
  ) {
    const pdfBuffer = await this.reportService.generateEntregaMultiItemPdf(
      body.assetIds,
      body,
    );

    const dateStr = new Date().toISOString().split('T')[0];
    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename="entrega_multiitem_${dateStr}.pdf"`,
      'Content-Length': pdfBuffer.length,
    });

    res.end(pdfBuffer);
  }

  // ==========================================
  // PDF Formato 3: Resguardo de equipo
  // ==========================================

  @Post('resguardo/pdf')
  async generateResguardoPdf(
    @Body()
    body: {
      assetIds: number[];
      razonSocial?: string;
      storeName?: string;
      receiverName?: string;
    },
    @Res() res: Response,
  ) {
    const pdfBuffer = await this.reportService.generateResguardoPdf(
      body.assetIds,
      body,
    );

    const dateStr = new Date().toISOString().split('T')[0];
    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename="resguardo_equipo_${dateStr}.pdf"`,
      'Content-Length': pdfBuffer.length,
    });

    res.end(pdfBuffer);
  }

  // ==========================================
  // CSV Import
  // ==========================================

  @Post('import/csv')
  @UseInterceptors(FileInterceptor('file'))
  async importCsv(
    @UploadedFile() file: Express.Multer.File,
    @Headers('user-email') userEmail: string,
  ) {
    if (!file) {
      throw new BadRequestException('No se proporcionó un archivo CSV');
    }
    return this.reportService.importCsv(file.buffer, userEmail);
  }

  // ==========================================
  // Excel / CSV exports
  // ==========================================

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

    res.send('\ufeff' + csv);
  }

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
