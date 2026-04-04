import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';
import * as path from 'path';
import * as fs from 'fs';
// eslint-disable-next-line @typescript-eslint/no-var-requires
const PdfPrinter = require('pdfmake/src/printer');
import * as ExcelJS from 'exceljs';
import { parse } from 'csv-parse/sync';

const ASSETS_DIR = path.join(__dirname, '..', '..', 'assets');
const FONTS_DIR = path.join(ASSETS_DIR, 'fonts');
const LOGO_PATH = path.join(ASSETS_DIR, 'logo-hotelshops.png');

const SOFTWARE_CHECKLIST = [
  'EPICOR',
  'EPICOR TEST',
  'INVENTARIO MANAGER',
  'TEAMS',
  'VNC',
  'OFFICE',
  'DMT',
  'CARPETAS COMPARTIDAS',
  'ANYDESK',
  'CORREO',
  'HAMACHI',
  'FORTI',
  'PANDA',
  'SQL',
  'VISUALIZADOR DE VIDEOS',
  'TEAMVIEWER',
];

type ReportFormat = 'entrega_software' | 'entrega_multiitem' | 'resguardo';

// Constantes de layout
const LINE_COLOR = '#AAAAAA';
const HEADER_LINE = '#1B3A5C';
const CELL_PAD = [4, 3, 4, 3] as number[];
const COL_HEADER_BG = '#1B3A5C';
const COL_HEADER_COLOR = '#FFFFFF';
const INFO_LABEL_COLOR = '#1B3A5C';
const EMPTY_ROW_HEIGHT = 16;

@Injectable()
export class ReportService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  // ============================
  // Data fetching
  // ============================

  async getDeliveryReportData(assetId: number) {
    const asset = await this.prismaShopic.asset.findUnique({
      where: { AssetID: assetId },
      include: {
        Vendor: true,
        ProductType: true,
        AssetState_Asset_AssetStateToAssetState: true,
        Company: true,
        Site: true,
        Depart: true,
        AssetDetail: true,
        User: {
          include: {
            Depart: true,
          },
        },
        other_Asset: {
          include: {
            ProductType: true,
            AssetDetail: true,
            Vendor: true,
          },
        },
      },
    });

    if (!asset) {
      throw new NotFoundException('Activo no encontrado');
    }

    const detail = asset.AssetDetail;

    return {
      assetID: asset.AssetID,
      name: asset.Name,
      serialNum: detail?.SerialNum || 'N/A',
      model: detail?.Model || '',
      processor: detail?.Processor || detail?.ProcessorInfo || '',
      ram: detail?.RAM || detail?.PhysicalMemory || '',
      hddCapacity: detail?.HDDCapacity || '',
      operatingSystem: detail?.OperatingSystem || '',
      vendor: asset.Vendor?.Name || '',
      productType: asset.ProductType?.Name || '',
      productManuf: detail?.ProductManuf || asset.Vendor?.Name || '',
      company: asset.Company?.Description || '',
      site: asset.Site?.Name || '',
      department: asset.Depart?.Name || asset.User?.Depart?.Name || '',
      userName: asset.User?.Name || '',
      userEmail: asset.User?.Email || '',
      childAssets: asset.other_Asset.map((child) => ({
        name: child.Name,
        productType: child.ProductType?.Name || '',
        serialNum: child.AssetDetail?.SerialNum || '',
        model: child.AssetDetail?.Model || '',
        vendor: child.Vendor?.Name || child.AssetDetail?.ProductManuf || '',
      })),
      softwareChecklist: SOFTWARE_CHECKLIST,
    };
  }

  async getMultiItemReportData(assetIds: number[]) {
    const assets = await this.prismaShopic.asset.findMany({
      where: { AssetID: { in: assetIds } },
      include: {
        Vendor: true,
        ProductType: true,
        Company: true,
        Site: true,
        Depart: true,
        AssetDetail: true,
        User: {
          include: {
            Depart: true,
          },
        },
      },
    });

    if (assets.length === 0) {
      throw new NotFoundException('No se encontraron activos');
    }

    const first = assets[0];
    return {
      company: first.Company?.Description || '',
      site: first.Site?.Name || '',
      department: first.Depart?.Name || first.User?.Depart?.Name || '',
      userName: first.User?.Name || '',
      items: assets.map((asset) => {
        const detail = asset.AssetDetail;
        return {
          name: asset.Name,
          productType: asset.ProductType?.Name || '',
          vendor: asset.Vendor?.Name || detail?.ProductManuf || '',
          model: detail?.Model || '',
          serialNum: detail?.SerialNum || '',
        };
      }),
    };
  }

  // ============================
  // PDF Helpers
  // ============================

  private createPdfBuffer(docDefinition: any): Promise<Buffer> {
    const fonts = {
      Roboto: {
        normal: path.join(FONTS_DIR, 'Roboto-Regular.ttf'),
        bold: path.join(FONTS_DIR, 'Roboto-Medium.ttf'),
        italics: path.join(FONTS_DIR, 'Roboto-Italic.ttf'),
        bolditalics: path.join(FONTS_DIR, 'Roboto-MediumItalic.ttf'),
      },
    };

    try {
      const printer = new PdfPrinter(fonts);
      const pdfDoc = printer.createPdfKitDocument(docDefinition);

      return new Promise<Buffer>((resolve, reject) => {
        const chunks: Buffer[] = [];
        pdfDoc.on('data', (chunk: Buffer) => chunks.push(chunk));
        pdfDoc.on('end', () => resolve(Buffer.concat(chunks)));
        pdfDoc.on('error', (err: Error) => reject(err));
        pdfDoc.end();
      });
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al generar el PDF',
      });
    }
  }

  private getDateStr(): string {
    const today = new Date();
    return `${today.getMonth() + 1}/${today.getDate()}/${today.getFullYear().toString().slice(-2)}`;
  }

  private getLogoForPdf(): any {
    try {
      if (fs.existsSync(LOGO_PATH)) {
        return { image: LOGO_PATH, width: 120, height: 90 };
      }
    } catch {
      // fallback
    }
    return { text: 'hotelshops\nTravel Retail', bold: true, fontSize: 14, color: '#0077B6' };
  }

  private gridLayout() {
    return {
      hLineWidth: () => 0.75,
      vLineWidth: () => 0.75,
      hLineColor: () => LINE_COLOR,
      vLineColor: () => LINE_COLOR,
      paddingLeft: () => 4,
      paddingRight: () => 4,
      paddingTop: () => 3,
      paddingBottom: () => 3,
    };
  }

  private thinGridLayout() {
    return {
      hLineWidth: () => 0.5,
      vLineWidth: () => 0.5,
      hLineColor: () => '#CCCCCC',
      vLineColor: () => '#CCCCCC',
    };
  }

  private professionalLayout(headerRowIndex: number) {
    return {
      hLineWidth: (i: number, node: any) => {
        if (i === 0 || i === node.table.body.length) return 1.5;
        if (i === headerRowIndex || i === headerRowIndex + 1) return 1.2;
        return 0.5;
      },
      vLineWidth: (i: number, node: any) => {
        if (i === 0 || i === node.table.widths.length) return 1.5;
        return 0.5;
      },
      hLineColor: (i: number, node: any) => {
        if (i === 0 || i === node.table.body.length) return HEADER_LINE;
        if (i === headerRowIndex || i === headerRowIndex + 1) return HEADER_LINE;
        return LINE_COLOR;
      },
      vLineColor: (i: number, node: any) => {
        if (i === 0 || i === node.table.widths.length) return HEADER_LINE;
        return LINE_COLOR;
      },
      paddingLeft: () => 5,
      paddingRight: () => 5,
      paddingTop: () => 4,
      paddingBottom: () => 4,
    };
  }

  // ==========================================
  // FORMATO 1: Entrega con checklist de software
  // Replica exacta del PDF página 1
  // ==========================================

  async generateEntregaSoftwarePdf(
    assetId: number,
    options?: {
      softwareStatus?: Record<string, string>;
      notes?: string;
    },
  ): Promise<Buffer> {
    const data = await this.getDeliveryReportData(assetId);
    const dateStr = this.getDateStr();

    const description = [
      data.name.toUpperCase(),
      data.processor ? data.processor.toUpperCase() : '',
      data.ram ? `${data.ram} RAM` : '',
      data.hddCapacity ? `${data.hddCapacity} NVME` : '',
      data.operatingSystem ? data.operatingSystem.toUpperCase() : '',
    ]
      .filter(Boolean)
      .join(' / ');

    // Software checklist rows (inner table)
    const swRows = data.softwareChecklist.map((sw) => {
      const status = options?.softwareStatus?.[sw] || 'NA';
      return [
        { text: sw, fontSize: 9, margin: [4, 1, 4, 1] as number[] },
        { text: status === 'X' ? 'X' : 'NA', fontSize: 9, alignment: 'center' as const, margin: [2, 1, 2, 1] as number[] },
      ];
    });

    // Build the outer table that wraps everything (like the Excel grid)
    const outerBody: any[][] = [];

    // Row 1: Logo + FECHA (logo spans 2 rows)
    outerBody.push([
      {
        ...this.getLogoForPdf(),
        rowSpan: 2,
        margin: [8, 8, 8, 8],
        border: [true, true, false, false],
      },
      {
        text: [
          { text: 'FECHA:  ', bold: true, color: INFO_LABEL_COLOR },
          { text: dateStr, decoration: 'underline' },
        ],
        alignment: 'right',
        margin: [0, 12, 10, 0],
        border: [false, true, true, false],
      },
    ]);

    // Row 2: (logo continues) + empty
    outerBody.push([
      { text: '', border: [true, false, false, true] },
      { text: '', margin: CELL_PAD, border: [false, false, true, true] },
    ]);

    // Row 3: ASUNTO
    outerBody.push([
      {
        text: [
          { text: 'ASUNTO: ', bold: true, color: INFO_LABEL_COLOR },
          { text: 'ENTREGA DE EQUIPO', bold: true },
        ],
        colSpan: 2,
        margin: [6, 4, 6, 4],
      },
      {},
    ]);

    // Row 4: DEPTO\TIENDA + RECIBE
    outerBody.push([
      {
        text: [
          { text: 'DEPTO\\TIENDA: ', bold: true, color: INFO_LABEL_COLOR },
          { text: data.department || 'N/A' },
        ],
        margin: [6, 4, 6, 4],
      },
      {
        text: [
          { text: 'RECIBE: ', bold: true, color: INFO_LABEL_COLOR },
          { text: data.userName || 'N/A' },
        ],
        margin: [6, 4, 6, 4],
      },
    ]);

    // Row 5: CANTIDAD | DESCRIPCION headers (styled)
    outerBody.push([
      { text: 'CANTIDAD', bold: true, alignment: 'center', color: COL_HEADER_COLOR, fillColor: COL_HEADER_BG, margin: [4, 6, 4, 6] as number[] },
      { text: 'DESCRIPCION', bold: true, alignment: 'center', color: COL_HEADER_COLOR, fillColor: COL_HEADER_BG, margin: [4, 6, 4, 6] as number[] },
    ]);

    // Row 6: 1 | Equipment description + Serial + Software checklist
    outerBody.push([
      { text: '1', alignment: 'center', margin: [0, 5, 0, 5] },
      {
        stack: [
          { text: description, bold: true, alignment: 'center', fontSize: 9, margin: [0, 5, 0, 3] },
          {
            text: [
              { text: 'NUMERO DE SERIE:       ', fontSize: 9 },
              { text: data.serialNum, bold: true, fontSize: 9 },
            ],
            alignment: 'center',
            margin: [0, 0, 0, 8],
          },
          // Software checklist inner table
          {
            table: {
              widths: [180, 50],
              body: swRows,
            },
            layout: this.thinGridLayout(),
            alignment: 'center',
            margin: [60, 0, 60, 5],
          },
        ],
        margin: CELL_PAD,
      },
    ]);

    // Notes row
    outerBody.push([
      {
        stack: [
          { text: 'Notas / Condicion del equipo:', bold: true, fontSize: 9, color: INFO_LABEL_COLOR, margin: [0, 0, 0, 4] },
          { text: options?.notes || 'Se entrega equipo en buenas condiciones sin golpes ni defectos, recien instalado. Detalles de uso.', fontSize: 9 },
        ],
        colSpan: 2,
        fillColor: '#F9FAFB',
        margin: [15, 8, 15, 8],
      },
      {},
    ]);

    // Legal text row
    outerBody.push([
      {
        text: `Recibo de ${data.company || 'Hotel Shops S.A. de C.V.'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
        bold: true,
        fontSize: 8,
        italics: true,
        alignment: 'center',
        colSpan: 2,
        fillColor: '#F9FAFB',
        margin: [15, 10, 15, 10],
      },
      {},
    ]);

    // RESPONSABLE: | RECIBE: labels
    outerBody.push([
      { text: 'RESPONSABLE:', bold: true, alignment: 'center', color: INFO_LABEL_COLOR, fontSize: 10, margin: [4, 8, 4, 4] as number[] },
      { text: 'RECIBE:', bold: true, alignment: 'center', color: INFO_LABEL_COLOR, fontSize: 10, margin: [4, 8, 4, 4] as number[] },
    ]);

    // Signature space + name with line
    outerBody.push([
      {
        stack: [
          { text: '', margin: [0, 40, 0, 0] },
          { canvas: [{ type: 'line', x1: 30, y1: 0, x2: 130, y2: 0, lineWidth: 1, lineColor: HEADER_LINE }] },
          { text: 'DEPARTAMENTO DE SISTEMAS', bold: true, alignment: 'center', fontSize: 9, margin: [0, 4, 0, 0] },
        ],
        margin: CELL_PAD,
      },
      {
        stack: [
          { text: '', margin: [0, 40, 0, 0] },
          { canvas: [{ type: 'line', x1: 60, y1: 0, x2: 300, y2: 0, lineWidth: 1, lineColor: HEADER_LINE }] },
          { text: data.userName || 'N/A', bold: true, alignment: 'center', fontSize: 9, margin: [0, 4, 0, 0] },
        ],
        margin: CELL_PAD,
      },
    ]);

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 30, 40, 40],
      defaultStyle: { fontSize: 10, font: 'Roboto' },
      content: [
        {
          table: {
            widths: [160, '*'],
            body: outerBody,
          },
          layout: this.professionalLayout(4),
        },
      ],
      footer: (currentPage: number) => ({
        text: currentPage.toString(),
        alignment: 'center',
        fontSize: 8,
        color: '#999999',
        margin: [0, 10, 0, 0],
      }),
    };

    return this.createPdfBuffer(docDefinition);
  }

  // ==========================================
  // Helper compartido para formatos 2 y 3
  // ==========================================

  private buildMultiItemBody(
    dateStr: string,
    asunto: string,
    razonSocial: string,
    deptoTienda: string,
    recibe: string,
    items: { name: string; productType: string; vendor: string; model: string; serialNum: string }[],
    notes: string,
    legalText: string,
    signatures: {
      leftLabel: string;
      leftName?: string;
      rightLabel: string;
      rightName: string;
    },
  ): any[][] {
    const body: any[][] = [];

    // Row 1: Logo + FECHA
    body.push([
      {
        ...this.getLogoForPdf(),
        rowSpan: 2,
        margin: [8, 8, 8, 8],
        colSpan: 2,
        border: [true, true, false, false],
      },
      {},
      { text: '', colSpan: 2, border: [false, true, false, false] },
      {},
      {
        text: [
          { text: 'FECHA:  ', bold: true, color: INFO_LABEL_COLOR },
          { text: dateStr, decoration: 'underline' },
        ],
        alignment: 'right',
        margin: [0, 12, 8, 0],
        border: [false, true, true, false],
      },
    ]);

    // Row 2: Logo continues
    body.push([
      { text: '', border: [true, false, false, true] },
      {},
      { text: '', colSpan: 2, border: [false, false, false, true] },
      {},
      { text: '', border: [false, false, true, true] },
    ]);

    // Row 3: ASUNTO
    body.push([
      {
        text: [
          { text: 'ASUNTO: ', bold: true, color: INFO_LABEL_COLOR },
          { text: asunto, bold: true },
        ],
        colSpan: 5,
        margin: [6, 4, 6, 4],
      },
      {}, {}, {}, {},
    ]);

    // Row 4: RAZON SOCIAL
    body.push([
      {
        text: [
          { text: 'RAZON SOCIAL: ', bold: true, color: INFO_LABEL_COLOR },
          { text: razonSocial },
        ],
        colSpan: 5,
        margin: [6, 4, 6, 4],
      },
      {}, {}, {}, {},
    ]);

    // Row 5: DEPTO\TIENDA + RECIBE
    body.push([
      {
        text: [
          { text: 'DEPTO\\TIENDA: ', bold: true, color: INFO_LABEL_COLOR },
          { text: deptoTienda },
        ],
        colSpan: 2,
        margin: [6, 4, 6, 4],
      },
      {},
      {
        text: [
          { text: 'RECIBE: ', bold: true, color: INFO_LABEL_COLOR },
          { text: recibe },
        ],
        colSpan: 3,
        margin: [6, 4, 6, 4],
      },
      {}, {},
    ]);

    // Row 6: Table headers (styled with dark background)
    const colHeaderStyle = { bold: true, alignment: 'center' as const, fontSize: 9, color: COL_HEADER_COLOR, fillColor: COL_HEADER_BG, margin: [4, 6, 4, 6] as number[] };
    body.push([
      { text: 'CANTIDAD', ...colHeaderStyle },
      { text: 'DESCRIPCION', ...colHeaderStyle },
      { text: 'MARCA', ...colHeaderStyle },
      { text: 'MODELO', ...colHeaderStyle },
      { text: 'NUMERO DE SERIE', ...colHeaderStyle },
    ]);

    // Data rows (alternating background)
    items.forEach((item, idx) => {
      const fillColor = idx % 2 === 1 ? '#F5F7FA' : undefined;
      body.push([
        { text: '1', alignment: 'center', fontSize: 9, margin: CELL_PAD, fillColor },
        { text: (item.productType || item.name).toUpperCase(), fontSize: 9, margin: CELL_PAD, fillColor },
        { text: item.vendor.toUpperCase(), fontSize: 9, margin: CELL_PAD, fillColor },
        { text: item.model, fontSize: 9, margin: CELL_PAD, fillColor },
        { text: item.serialNum || 'N/A', fontSize: 9, margin: CELL_PAD, fillColor },
      ]);
    });

    // Empty rows - just enough to keep the layout clean
    const minRows = Math.max(items.length + 3, 8);
    for (let i = items.length; i < minRows; i++) {
      const fillColor = i % 2 === 1 ? '#F5F7FA' : undefined;
      body.push([
        { text: '', fontSize: 9, margin: CELL_PAD, fillColor },
        { text: '', fontSize: 9, margin: CELL_PAD, fillColor },
        { text: '', fontSize: 9, margin: CELL_PAD, fillColor },
        { text: '', fontSize: 9, margin: CELL_PAD, fillColor },
        { text: '', fontSize: 9, margin: CELL_PAD, fillColor },
      ]);
    }

    // Notes / Condición del equipo
    if (notes) {
      body.push([
        {
          stack: [
            { text: 'Notas / Condicion del equipo:', bold: true, fontSize: 9, color: INFO_LABEL_COLOR, margin: [0, 0, 0, 4] },
            { text: notes, fontSize: 9 },
          ],
          colSpan: 5,
          fillColor: '#F9FAFB',
          margin: [15, 8, 15, 8],
        },
        {}, {}, {}, {},
      ]);
    }

    // Legal text
    body.push([
      { text: legalText, bold: true, fontSize: 8, italics: true, alignment: 'center', colSpan: 5, fillColor: '#F9FAFB', margin: [15, 10, 15, 10] },
      {}, {}, {}, {},
    ]);

    // Signature labels (2 visual columns using colSpan)
    body.push([
      {
        text: signatures.leftLabel, bold: true, alignment: 'center', color: INFO_LABEL_COLOR, fontSize: 10,
        colSpan: 2, margin: [4, 8, 4, 4] as number[],
        border: [true, true, false, false],
      },
      {},
      {
        text: signatures.rightLabel, bold: true, alignment: 'center', color: INFO_LABEL_COLOR, fontSize: 10,
        colSpan: 3, margin: [4, 8, 4, 4] as number[],
        border: [false, true, true, false],
      },
      {}, {},
    ]);

    // Empty signature space + name + line (2 visual columns)
    body.push([
      {
        stack: [
          { text: '', margin: [0, 40, 0, 0] },
          { canvas: [{ type: 'line', x1: 30, y1: 0, x2: 170, y2: 0, lineWidth: 1, lineColor: HEADER_LINE }] },
          { text: signatures.leftName || '', bold: true, alignment: 'center', fontSize: 9, margin: [0, 4, 0, 0] },
        ],
        colSpan: 2,
        margin: CELL_PAD,
        border: [true, false, false, true],
      },
      {},
      {
        stack: [
          { text: '', margin: [0, 40, 0, 0] },
          { canvas: [{ type: 'line', x1: 30, y1: 0, x2: 170, y2: 0, lineWidth: 1, lineColor: HEADER_LINE }] },
          { text: signatures.rightName, bold: true, alignment: 'center', fontSize: 9, margin: [0, 4, 0, 0] },
        ],
        colSpan: 3,
        margin: CELL_PAD,
        border: [false, false, true, true],
      },
      {}, {},
    ]);

    return body;
  }

  // ==========================================
  // FORMATO 2: Entrega multi-item (perifericos)
  // Replica exacta del PDF página 2
  // ==========================================

  async generateEntregaMultiItemPdf(
    assetIds: number[],
    options?: {
      asunto?: string;
      razonSocial?: string;
      department?: string;
      receiverName?: string;
      notes?: string;
    },
  ): Promise<Buffer> {
    const data = await this.getMultiItemReportData(assetIds);
    const dateStr = this.getDateStr();

    const outerBody: any[][] = this.buildMultiItemBody(
      dateStr,
      (options?.asunto || 'ENTREGA DE EQUIPO').toUpperCase(),
      options?.razonSocial || data.company || 'N/A',
      options?.department || data.department || 'N/A',
      options?.receiverName || data.userName || 'N/A',
      data.items,
      options?.notes || '',
      `Recibo de ${options?.razonSocial || data.company || 'Hotel Shops S.A. de C.V.'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
      {
        leftLabel: 'ENTREGA:',
        leftName: 'RESPONSABLE DE TIENDA',
        rightLabel: 'RECIBE:',
        rightName: 'DEPARTAMENTO DE SISTEMAS',
      },
    );

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 30, 40, 40],
      defaultStyle: { fontSize: 10, font: 'Roboto' },
      content: [
        {
          table: {
            widths: [55, '*', 65, 110, 105],
            body: outerBody,
          },
          layout: this.professionalLayout(5),
        },
      ],
      footer: (currentPage: number) => ({
        text: currentPage.toString(),
        alignment: 'center',
        fontSize: 8,
        color: '#999999',
        margin: [0, 10, 0, 0],
      }),
    };

    return this.createPdfBuffer(docDefinition);
  }

  // ==========================================
  // FORMATO 3: Resguardo de equipo
  // Replica exacta del PDF página 3
  // ==========================================

  async generateResguardoPdf(
    assetIds: number[],
    options?: {
      razonSocial?: string;
      storeName?: string;
      receiverName?: string;
    },
  ): Promise<Buffer> {
    const data = await this.getMultiItemReportData(assetIds);
    const dateStr = this.getDateStr();

    const outerBody: any[][] = this.buildMultiItemBody(
      dateStr,
      'RESGUARDO DE EQUIPO',
      options?.razonSocial || data.company || 'N/A',
      options?.storeName || data.site || 'N/A',
      'DEPARTAMENTO DE SISTEMAS',
      data.items,
      '',
      'Recibo del Encargado de tienda la(s) Herramienta(s) arriba mencionada(s) para resguardo, reinstalacion o asignacion del mismo. Sirva el presente documento para el deslinde responsabilidades posteriores.',
      {
        leftLabel: 'ENTREGA:',
        leftName: 'DEPARTAMENTO DE SISTEMAS',
        rightLabel: 'RECIBE:',
        rightName: 'RESPONSABLE DE TIENDA',
      },
    );

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 30, 40, 40],
      defaultStyle: { fontSize: 10, font: 'Roboto' },
      content: [
        {
          table: {
            widths: [55, '*', 65, 110, 105],
            body: outerBody,
          },
          layout: this.professionalLayout(5),
        },
      ],
      footer: (currentPage: number) => ({
        text: currentPage.toString(),
        alignment: 'center',
        fontSize: 8,
        color: '#999999',
        margin: [0, 10, 0, 0],
      }),
    };

    return this.createPdfBuffer(docDefinition);
  }

  // ==========================================
  // Metodo unificado (mantiene compatibilidad)
  // ==========================================

  async generateDeliveryPdf(
    assetId: number,
    softwareStatus?: Record<string, string>,
    notes?: string,
  ): Promise<Buffer> {
    return this.generateEntregaSoftwarePdf(assetId, { softwareStatus, notes });
  }

  // ==========================================
  // Excel exports
  // ==========================================

  async generateAssetsExcel(filters?: {
    group?: string;
    companyID?: number;
    assetState?: number;
  }): Promise<Buffer> {
    try {
      const whereClause: any = {};
      if (filters?.companyID) whereClause.CompanyID = filters.companyID;
      if (filters?.assetState) whereClause.AssetState = filters.assetState;
      if (filters?.group) {
        whereClause.ProductType = { Group: filters.group };
      }

      const assets = await this.prismaShopic.asset.findMany({
        where: whereClause,
        include: {
          Vendor: true,
          ProductType: true,
          AssetState_Asset_AssetStateToAssetState: true,
          Company: true,
          Site: true,
          Depart: true,
          AssetDetail: true,
          User: {
            include: {
              Depart: true,
            },
          },
        },
        orderBy: { AssetID: 'asc' },
      });

      const workbook = new ExcelJS.Workbook();
      workbook.creator = 'Inventario TI';
      workbook.created = new Date();

      const sheet = workbook.addWorksheet('Inventario de Activos');

      sheet.columns = [
        { header: 'ID', key: 'id', width: 8 },
        { header: 'Nombre', key: 'name', width: 30 },
        { header: 'Grupo', key: 'group', width: 15 },
        { header: 'Tipo', key: 'type', width: 20 },
        { header: 'Marca', key: 'vendor', width: 15 },
        { header: 'Modelo', key: 'model', width: 20 },
        { header: 'No. Serie', key: 'serial', width: 20 },
        { header: 'Asset TAG', key: 'tag', width: 15 },
        { header: 'Estado', key: 'state', width: 12 },
        { header: 'Empresa', key: 'company', width: 20 },
        { header: 'Sitio', key: 'site', width: 15 },
        { header: 'Departamento', key: 'department', width: 20 },
        { header: 'Usuario Asignado', key: 'user', width: 25 },
        { header: 'Email Usuario', key: 'email', width: 30 },
        { header: 'Procesador', key: 'processor', width: 20 },
        { header: 'RAM', key: 'ram', width: 10 },
        { header: 'Disco', key: 'hdd', width: 15 },
        { header: 'S.O.', key: 'os', width: 20 },
        { header: 'IP', key: 'ip', width: 15 },
        { header: 'MAC', key: 'mac', width: 18 },
        { header: 'Factura', key: 'invoice', width: 15 },
        { header: 'Fecha Compra', key: 'purchaseDate', width: 15 },
        { header: 'Garantia Hasta', key: 'warranty', width: 15 },
      ];

      const headerRow = sheet.getRow(1);
      headerRow.font = { bold: true, color: { argb: 'FFFFFFFF' } };
      headerRow.fill = {
        type: 'pattern',
        pattern: 'solid',
        fgColor: { argb: 'FF0077B6' },
      };
      headerRow.alignment = { horizontal: 'center' };

      assets.forEach((asset) => {
        const detail = asset.AssetDetail;
        sheet.addRow({
          id: asset.AssetID,
          name: asset.Name,
          group: asset.ProductType?.Group || '',
          type: asset.ProductType?.Name || '',
          vendor: asset.Vendor?.Name || '',
          model: detail?.Model || '',
          serial: detail?.SerialNum || '',
          tag: detail?.AssetTAG || '',
          state: asset.AssetState_Asset_AssetStateToAssetState?.Name || '',
          company: asset.Company?.Description || '',
          site: asset.Site?.Name || '',
          department: asset.Depart?.Name || asset.User?.Depart?.Name || '',
          user: asset.User?.Name || '',
          email: asset.User?.Email || '',
          processor: detail?.Processor || detail?.ProcessorInfo || '',
          ram: detail?.RAM || detail?.PhysicalMemory || '',
          hdd: detail?.HDDCapacity || '',
          os: detail?.OperatingSystem || '',
          ip: detail?.IPAddress || '',
          mac: detail?.MACAddress || '',
          invoice: detail?.Factura || '',
          purchaseDate: detail?.PurchaseDate
            ? new Date(detail.PurchaseDate).toLocaleDateString('es-MX')
            : '',
          warranty: detail?.WarrantyExpiryDate
            ? new Date(detail.WarrantyExpiryDate).toLocaleDateString('es-MX')
            : '',
        });
      });

      sheet.autoFilter = {
        from: { row: 1, column: 1 },
        to: { row: 1, column: sheet.columns.length },
      };

      const buffer = await workbook.xlsx.writeBuffer();
      return Buffer.from(buffer);
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al generar el Excel de inventario',
      });
    }
  }

  async generateMovementHistoryExcel(assetId?: number): Promise<Buffer> {
    try {
      const whereClause: any = {};
      if (assetId) whereClause.AssetID = assetId;

      const history = await this.prismaShopic.assetHistory.findMany({
        where: whereClause,
        include: {
          Asset: {
            include: {
              User: true,
            },
          },
        },
        orderBy: { CreatedTime: 'desc' },
      });

      const workbook = new ExcelJS.Workbook();
      workbook.creator = 'Inventario TI';
      workbook.created = new Date();

      const sheet = workbook.addWorksheet('Historial de Movimientos');

      sheet.columns = [
        { header: 'ID Historial', key: 'historyId', width: 12 },
        { header: 'ID Activo', key: 'assetId', width: 10 },
        { header: 'Nombre Activo', key: 'assetName', width: 30 },
        { header: 'Operacion', key: 'operation', width: 18 },
        { header: 'Descripcion', key: 'description', width: 50 },
        { header: 'Fecha', key: 'date', width: 20 },
      ];

      const headerRow = sheet.getRow(1);
      headerRow.font = { bold: true, color: { argb: 'FFFFFFFF' } };
      headerRow.fill = {
        type: 'pattern',
        pattern: 'solid',
        fgColor: { argb: 'FF0077B6' },
      };
      headerRow.alignment = { horizontal: 'center' };

      history.forEach((h) => {
        sheet.addRow({
          historyId: h.AssetHistoryID,
          assetId: h.AssetID,
          assetName: h.Asset?.Name || '',
          operation: h.Operation,
          description: h.Description,
          date: new Date(h.CreatedTime).toLocaleString('es-MX'),
        });
      });

      sheet.autoFilter = {
        from: { row: 1, column: 1 },
        to: { row: 1, column: sheet.columns.length },
      };

      const buffer = await workbook.xlsx.writeBuffer();
      return Buffer.from(buffer);
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al generar el Excel de historial',
      });
    }
  }

  async generateAssetsCsv(filters?: {
    group?: string;
    companyID?: number;
    assetState?: number;
  }): Promise<string> {
    try {
      const whereClause: any = {};
      if (filters?.companyID) whereClause.CompanyID = filters.companyID;
      if (filters?.assetState) whereClause.AssetState = filters.assetState;
      if (filters?.group) {
        whereClause.ProductType = { Group: filters.group };
      }

      const assets = await this.prismaShopic.asset.findMany({
        where: whereClause,
        include: {
          Vendor: true,
          ProductType: true,
          AssetState_Asset_AssetStateToAssetState: true,
          Company: true,
          Site: true,
          Depart: true,
          AssetDetail: true,
          User: {
            include: {
              Depart: true,
            },
          },
        },
        orderBy: { AssetID: 'asc' },
      });

      const headers = [
        'Product Type',
        'Product',
        'Product Manufacturer',
        'Asset Name',
        'Asset Tag',
        'Serial Number',
        'Barcode / QR code',
        'Vendor',
        'IP Address',
        'MAC Address',
        'Asset State',
        'Assign to User',
        'Assign to Department',
        'Site',
        'Loanable',
        'Acquisition Date',
        'Warranty Expiry Date',
        'Expiry Date',
        'Created Time',
        'Last Updated Time',
      ];

      const esc = (val?: string | null) =>
        val ? `"${val.replace(/"/g, '""')}"` : '';

      const fmtDate = (val?: Date | string | null) => {
        if (!val) return '';
        const d = val instanceof Date ? val : new Date(val);
        if (isNaN(d.getTime())) return '';
        return d.toISOString().replace('T', ' ').substring(0, 19);
      };

      const rows = assets.map((asset) => {
        const d = asset.AssetDetail;
        return [
          esc(asset.ProductType?.Name),
          esc(asset.ProductType?.Category),
          esc(d?.ProductManuf),
          esc(asset.Name),
          esc(d?.AssetTAG),
          esc(d?.SerialNum),
          esc(d?.Barcode),
          esc(asset.Vendor?.Name),
          esc(d?.IPAddress),
          esc(d?.MACAddress),
          esc(asset.AssetState_Asset_AssetStateToAssetState?.Name),
          esc(asset.User?.Name),
          esc(asset.Depart?.Name || asset.User?.Depart?.Name),
          esc(asset.Site?.Name),
          d?.Loanable || '',
          fmtDate(d?.AssetACQDate),
          fmtDate(d?.WarrantyExpiryDate),
          fmtDate(d?.AssetExpiryDate),
          fmtDate(d?.CreatedTime),
          fmtDate(d?.LastUpdateTime),
        ].join(',');
      });

      return [headers.join(','), ...rows].join('\n');
    } catch (error) {
      throw new InternalServerErrorException({
        message: error.message || 'Error al generar el CSV',
      });
    }
  }

  async generateUserAssetsReport(userId: number): Promise<Buffer> {
    const user = await this.prismaShopic.user.findUnique({
      where: { UserID: userId },
      include: { Depart: true },
    });

    if (!user) {
      throw new NotFoundException('Usuario no encontrado');
    }

    const assets = await this.prismaShopic.asset.findMany({
      where: { UserID: userId },
      include: {
        ProductType: true,
        Vendor: true,
        AssetDetail: true,
        AssetState_Asset_AssetStateToAssetState: true,
        Company: true,
        Site: true,
      },
    });

    const workbook = new ExcelJS.Workbook();
    workbook.creator = 'Inventario TI';
    workbook.created = new Date();

    const sheet = workbook.addWorksheet(`Resguardo - ${user.Name}`);

    sheet.mergeCells('A1:H1');
    const titleCell = sheet.getCell('A1');
    titleCell.value = 'RESGUARDO DE EQUIPO';
    titleCell.font = { bold: true, size: 14, color: { argb: 'FF0077B6' } };
    titleCell.alignment = { horizontal: 'center' };

    sheet.mergeCells('A3:D3');
    sheet.getCell('A3').value = `Usuario: ${user.Name}`;
    sheet.getCell('A3').font = { bold: true };

    sheet.mergeCells('E3:H3');
    sheet.getCell('E3').value = `Departamento: ${user.Depart?.Name || 'N/A'}`;

    sheet.mergeCells('A4:D4');
    sheet.getCell('A4').value = `Email: ${user.Email}`;

    sheet.mergeCells('E4:H4');
    sheet.getCell('E4').value = `Fecha: ${new Date().toLocaleDateString('es-MX')}`;

    const dataStartRow = 6;
    const headers = ['Nombre', 'Tipo', 'Marca', 'Modelo', 'No. Serie', 'Estado', 'Empresa', 'Sitio'];

    sheet.columns = [
      { key: 'name', width: 30 },
      { key: 'type', width: 20 },
      { key: 'vendor', width: 15 },
      { key: 'model', width: 20 },
      { key: 'serial', width: 20 },
      { key: 'state', width: 12 },
      { key: 'company', width: 20 },
      { key: 'site', width: 15 },
    ];

    const headerRow = sheet.getRow(dataStartRow);
    headers.forEach((h, i) => {
      const cell = headerRow.getCell(i + 1);
      cell.value = h;
      cell.font = { bold: true, color: { argb: 'FFFFFFFF' } };
      cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FF0077B6' } };
      cell.alignment = { horizontal: 'center' };
    });

    assets.forEach((asset, index) => {
      const detail = asset.AssetDetail;
      const row = sheet.getRow(dataStartRow + 1 + index);
      row.getCell(1).value = asset.Name;
      row.getCell(2).value = asset.ProductType?.Name || '';
      row.getCell(3).value = asset.Vendor?.Name || '';
      row.getCell(4).value = detail?.Model || '';
      row.getCell(5).value = detail?.SerialNum || '';
      row.getCell(6).value = asset.AssetState_Asset_AssetStateToAssetState?.Name || '';
      row.getCell(7).value = asset.Company?.Description || '';
      row.getCell(8).value = asset.Site?.Name || '';
    });

    const signRow = dataStartRow + assets.length + 4;
    sheet.mergeCells(`A${signRow}:D${signRow}`);
    sheet.getCell(`A${signRow}`).value = '___________________________';
    sheet.getCell(`A${signRow}`).alignment = { horizontal: 'center' };

    sheet.mergeCells(`E${signRow}:H${signRow}`);
    sheet.getCell(`E${signRow}`).value = '___________________________';
    sheet.getCell(`E${signRow}`).alignment = { horizontal: 'center' };

    sheet.mergeCells(`A${signRow + 1}:D${signRow + 1}`);
    sheet.getCell(`A${signRow + 1}`).value = 'ENTREGA: Depto. Sistemas';
    sheet.getCell(`A${signRow + 1}`).alignment = { horizontal: 'center' };
    sheet.getCell(`A${signRow + 1}`).font = { bold: true };

    sheet.mergeCells(`E${signRow + 1}:H${signRow + 1}`);
    sheet.getCell(`E${signRow + 1}`).value = `RECIBE: ${user.Name}`;
    sheet.getCell(`E${signRow + 1}`).alignment = { horizontal: 'center' };
    sheet.getCell(`E${signRow + 1}`).font = { bold: true };

    const buffer = await workbook.xlsx.writeBuffer();
    return Buffer.from(buffer);
  }

  // ============================
  // CSV Import
  // ============================

  async importCsv(fileBuffer: Buffer, userEmail?: string) {
    const csvString = fileBuffer.toString('utf-8').replace(/^\uFEFF/, '');

    const records: Record<string, string>[] = parse(csvString, {
      columns: true,
      skip_empty_lines: true,
      trim: true,
    });

    if (!records.length) {
      throw new InternalServerErrorException('El archivo CSV está vacío');
    }

    // Resolve the user performing the import
    let lastUpdateBy = 1;
    if (userEmail) {
      const user = await this.prismaShopic.user.findFirst({
        where: { Email: userEmail },
      });
      if (user) lastUpdateBy = user.UserID;
    }

    // Caches for lookup tables to avoid repeated queries
    const vendorCache = new Map<string, number>();
    const productTypeCache = new Map<string, number>();
    const assetStateCache = new Map<string, number>();
    const siteCache = new Map<string, number>();
    const departCache = new Map<string, number>();
    const companyCache = new Map<string, number>();

    let created = 0;
    let skipped = 0;
    const errors: string[] = [];

    for (let i = 0; i < records.length; i++) {
      const row = records[i];
      const rowNum = i + 2; // +2 because header is row 1

      try {
        const assetName = row['Asset Name']?.trim();
        if (!assetName) {
          skipped++;
          continue;
        }

        // --- Resolve Vendor ---
        const vendorName = row['Vendor']?.trim() || 'Sin Proveedor';
        let vendorID = vendorCache.get(vendorName);
        if (!vendorID) {
          let vendor = await this.prismaShopic.vendor.findFirst({
            where: { Name: vendorName },
          });
          if (!vendor) {
            vendor = await this.prismaShopic.vendor.create({
              data: { Name: vendorName },
            });
          }
          vendorID = vendor.VendorID;
          vendorCache.set(vendorName, vendorID);
        }

        // --- Resolve ProductType ---
        const productTypeName = row['Product Type']?.trim() || 'Otro';
        const productName = row['Product']?.trim() || 'Sin Producto';
        const ptKey = `${productTypeName}||${productName}`;
        let productTypeID = productTypeCache.get(ptKey);
        if (!productTypeID) {
          let pt = await this.prismaShopic.productType.findFirst({
            where: { Name: productTypeName, Category: productName },
          });
          if (!pt) {
            pt = await this.prismaShopic.productType.create({
              data: {
                Name: productTypeName,
                Category: productName,
                Group: productTypeName,
                SubCategory: '',
              },
            });
          }
          productTypeID = pt.ProductTypeID;
          productTypeCache.set(ptKey, productTypeID);
        }

        // --- Resolve AssetState ---
        const stateName = row['Asset State']?.trim() || 'In Shop';
        let assetStateID = assetStateCache.get(stateName);
        if (!assetStateID) {
          let state = await this.prismaShopic.assetState.findFirst({
            where: { Name: stateName },
          });
          if (!state) {
            state = await this.prismaShopic.assetState.create({
              data: { Name: stateName },
            });
          }
          assetStateID = state.AssetStateID;
          assetStateCache.set(stateName, assetStateID);
        }

        // --- Resolve Company (from Site) ---
        const siteName = row['Site']?.trim() || 'Base Site';
        let companyID = companyCache.get(siteName);
        let siteID = siteCache.get(siteName);

        if (!siteID) {
          let site = await this.prismaShopic.site.findFirst({
            where: { Name: siteName },
            include: { Company: true },
          });
          if (!site) {
            // Find or create a default company
            let company = await this.prismaShopic.company.findFirst();
            if (!company) {
              company = await this.prismaShopic.company.create({
                data: { Description: 'Hotel Shops' },
              });
            }
            site = await this.prismaShopic.site.create({
              data: { Name: siteName, CompanyID: company.CompanyID },
              include: { Company: true },
            });
          }
          siteID = site.SiteID;
          companyID = site.CompanyID;
          siteCache.set(siteName, siteID);
          companyCache.set(siteName, companyID);
        }

        // --- Resolve Department ---
        const departName = row['Assign to Department']?.trim();
        let departID: number | undefined;
        if (departName) {
          departID = departCache.get(departName);
          if (!departID) {
            let depart = await this.prismaShopic.depart.findFirst({
              where: { Name: departName },
            });
            if (!depart) {
              depart = await this.prismaShopic.depart.create({
                data: { Name: departName },
              });
            }
            departID = depart.DepartID;
            departCache.set(departName, departID);
          }
        }

        // --- Parse dates ---
        const parseDate = (val?: string): Date | null => {
          if (!val || val === 'null') return null;
          const d = new Date(val);
          return isNaN(d.getTime()) ? null : d;
        };

        // --- Create AssetDetail ---
        const newDetail = await this.prismaShopic.assetDetail.create({
          data: {
            ProductManuf: row['Product Manufacturer']?.trim() || null,
            IPAddress: row['IP Address']?.trim() || null,
            MACAddress: row['MAC Address']?.trim() || null,
            Loanable: row['Loanable']?.trim() || null,
            SerialNum: row['Serial Number']?.trim() || null,
            AssetTAG: row['Asset Tag']?.trim() || null,
            Barcode: row['Barcode / QR code']?.trim() || null,
            AssetACQDate: parseDate(row['Acquisition Date']),
            WarrantyExpiryDate: parseDate(row['Warranty Expiry Date']),
            AssetExpiryDate: parseDate(row['Expiry Date']),
            CreatedTime: parseDate(row['Created Time']) || new Date(),
            LastUpdateTime: parseDate(row['Last Updated Time']) || new Date(),
            LastUpdateBy: lastUpdateBy,
          },
        });

        // --- Create Asset ---
        await this.prismaShopic.asset.create({
          data: {
            Name: assetName,
            VendorID: vendorID,
            ProductTypeID: productTypeID,
            AssetState: assetStateID,
            CompanyID: companyID,
            SiteID: siteID,
            DepartID: departID || null,
            AssetDetailID: newDetail.AssetDetailID,
          },
        });

        created++;
      } catch (err) {
        errors.push(`Fila ${rowNum}: ${err.message}`);
        skipped++;
      }
    }

    return {
      success: true,
      message: `Importación completada: ${created} creados, ${skipped} omitidos`,
      created,
      skipped,
      total: records.length,
      errors: errors.slice(0, 20),
    };
  }
}
