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
const LINE_COLOR = '#000000';
const CELL_PAD = [3, 2, 3, 2] as number[];
const HEADER_BG = '#FFFFFF';
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

    const detail = asset.AssetDetail?.[0];

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
        serialNum: child.AssetDetail?.[0]?.SerialNum || '',
        model: child.AssetDetail?.[0]?.Model || '',
        vendor: child.Vendor?.Name || child.AssetDetail?.[0]?.ProductManuf || '',
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
        const detail = asset.AssetDetail?.[0];
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
      hLineWidth: () => 1,
      vLineWidth: () => 1,
      hLineColor: () => LINE_COLOR,
      vLineColor: () => LINE_COLOR,
    };
  }

  private thinGridLayout() {
    return {
      hLineWidth: () => 0.5,
      vLineWidth: () => 0.5,
      hLineColor: () => LINE_COLOR,
      vLineColor: () => LINE_COLOR,
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
      deliveryPerson?: string;
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
        margin: [5, 5, 5, 5],
      },
      {
        text: [
          { text: 'FECHA:    ', bold: true },
          { text: dateStr, decoration: 'underline' },
        ],
        alignment: 'right',
        margin: [0, 10, 10, 0],
      },
    ]);

    // Row 2: (logo continues) + empty
    outerBody.push([
      { text: '' },
      { text: '', margin: CELL_PAD },
    ]);

    // Row 3: ASUNTO
    outerBody.push([
      {
        text: [
          { text: 'ASUNTO: ', bold: true },
          { text: 'ENTREGA DE EQUIPO', bold: true },
        ],
        colSpan: 2,
        margin: CELL_PAD,
      },
      {},
    ]);

    // Row 4: DEPTO\TIENDA + RECIBE
    outerBody.push([
      {
        text: [
          { text: 'DEPTO\\TIENDA ', bold: true },
          { text: data.department || 'N/A' },
        ],
        margin: CELL_PAD,
      },
      {
        text: [
          { text: 'RECIBE: ', bold: true },
          { text: data.userName || 'N/A' },
        ],
        margin: CELL_PAD,
      },
    ]);

    // Row 5: CANTIDAD | DESCRIPCION headers
    outerBody.push([
      { text: 'CANTIDAD', bold: true, alignment: 'center', margin: CELL_PAD },
      { text: 'DESCRIPCION', bold: true, alignment: 'center', margin: CELL_PAD },
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
        text: options?.notes || 'Se entrega equipo en buenas condiciones sin golpes ni defectos, recien instalado. Detalles de uso.',
        colSpan: 2,
        alignment: 'center',
        margin: [15, 10, 15, 10],
        fontSize: 9,
      },
      {},
    ]);

    // Legal text row
    outerBody.push([
      {
        text: `Recibo de ${data.company || 'Hotel Shops S.A. de C.V.'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
        bold: true,
        fontSize: 9,
        alignment: 'center',
        colSpan: 2,
        margin: [15, 8, 15, 8],
      },
      {},
    ]);

    // ENTREGA: | RECIBE: labels
    outerBody.push([
      { text: 'ENTREGA:', bold: true, alignment: 'center', margin: CELL_PAD },
      { text: 'RECIBE:', bold: true, alignment: 'center', margin: CELL_PAD },
    ]);

    // Empty row for signature space
    outerBody.push([
      { text: '', margin: [0, 40, 0, 40] },
      { text: '', margin: [0, 40, 0, 40] },
    ]);

    // Signature lines + names
    outerBody.push([
      {
        stack: [
          { text: '________________________', alignment: 'center', fontSize: 9, margin: [0, 0, 0, 2] },
          { text: 'Responsable', bold: true, alignment: 'center', fontSize: 9 },
        ],
        margin: CELL_PAD,
      },
      {
        stack: [
          { text: '________________________________', alignment: 'center', fontSize: 9, margin: [0, 0, 0, 2] },
          { text: data.userName || 'N/A', bold: true, alignment: 'center', fontSize: 9 },
        ],
        margin: CELL_PAD,
      },
    ]);

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 30, 40, 40],
      defaultStyle: { fontSize: 10 },
      content: [
        {
          table: {
            widths: [160, '*'],
            body: outerBody,
          },
          layout: this.gridLayout(),
        },
      ],
      footer: (currentPage: number) => ({
        text: currentPage.toString(),
        alignment: 'center',
        fontSize: 9,
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
    legalText: string,
    signatures: {
      leftLabel: string;
      leftLine1: string;
      leftLine2: string;
      rightLabel: string;
      rightLine1: string;
      rightLine2: string;
    },
  ): any[][] {
    const body: any[][] = [];

    // Row 1: Logo + FECHA
    body.push([
      {
        ...this.getLogoForPdf(),
        rowSpan: 2,
        margin: [5, 5, 5, 5],
        colSpan: 2,
      },
      {},
      { text: '', colSpan: 2 },
      {},
      {
        text: [
          { text: 'FECHA:    ', bold: true },
          { text: dateStr, decoration: 'underline' },
        ],
        alignment: 'right',
        margin: [0, 10, 5, 0],
      },
    ]);

    // Row 2: Logo continues
    body.push([{ text: '' }, {}, { text: '', colSpan: 3 }, {}, {}]);

    // Row 3: ASUNTO
    body.push([
      { text: [{ text: 'ASUNTO: ', bold: true }, { text: asunto, bold: true }], colSpan: 5, margin: CELL_PAD },
      {}, {}, {}, {},
    ]);

    // Row 4: RAZON SOCIAL
    body.push([
      { text: [{ text: 'RAZON SOCIAL: ', bold: true }, { text: razonSocial }], colSpan: 5, margin: CELL_PAD },
      {}, {}, {}, {},
    ]);

    // Row 5: DEPTO\TIENDA + RECIBE
    body.push([
      { text: [{ text: 'DEPTO\\TIENDA ', bold: true }, { text: deptoTienda }], colSpan: 2, margin: CELL_PAD },
      {},
      { text: [{ text: 'RECIBE: ', bold: true }, { text: recibe }], colSpan: 3, margin: CELL_PAD },
      {}, {},
    ]);

    // Row 6: Table headers
    body.push([
      { text: 'CANTIDAD', bold: true, alignment: 'center', fontSize: 9, margin: CELL_PAD },
      { text: 'DESCRIPCION', bold: true, alignment: 'center', fontSize: 9, margin: CELL_PAD },
      { text: 'MARCA', bold: true, alignment: 'center', fontSize: 9, margin: CELL_PAD },
      { text: 'MODELO', bold: true, alignment: 'center', fontSize: 9, margin: CELL_PAD },
      { text: 'NUMERO DE SERIE', bold: true, alignment: 'center', fontSize: 9, margin: CELL_PAD },
    ]);

    // Data rows
    items.forEach((item) => {
      body.push([
        { text: '1', alignment: 'center', fontSize: 9, margin: CELL_PAD },
        { text: (item.productType || item.name).toUpperCase(), fontSize: 9, margin: CELL_PAD },
        { text: item.vendor.toUpperCase(), fontSize: 9, margin: CELL_PAD },
        { text: item.model, fontSize: 9, margin: CELL_PAD },
        { text: item.serialNum || 'N/A', fontSize: 9, margin: CELL_PAD },
      ]);
    });

    // Empty rows to fill page
    const minRows = 22;
    for (let i = items.length; i < minRows; i++) {
      body.push([
        { text: '', fontSize: 9, margin: CELL_PAD },
        { text: '', fontSize: 9, margin: CELL_PAD },
        { text: '', fontSize: 9, margin: CELL_PAD },
        { text: '', fontSize: 9, margin: CELL_PAD },
        { text: '', fontSize: 9, margin: CELL_PAD },
      ]);
    }

    // Legal text
    body.push([
      { text: legalText, bold: true, fontSize: 9, alignment: 'center', colSpan: 5, margin: [15, 8, 15, 8] },
      {}, {}, {}, {},
    ]);

    // ENTREGA: | RECIBE:
    body.push([
      { text: signatures.leftLabel, bold: true, alignment: 'center', colSpan: 2, margin: CELL_PAD },
      {},
      { text: '', margin: CELL_PAD },
      { text: signatures.rightLabel, bold: true, alignment: 'center', colSpan: 2, margin: CELL_PAD },
      {},
    ]);

    // Empty signature space
    body.push([
      { text: '', colSpan: 2, margin: [0, 40, 0, 40] },
      {},
      { text: '', margin: [0, 40, 0, 40] },
      { text: '', colSpan: 2, margin: [0, 40, 0, 40] },
      {},
    ]);

    // Signature names
    body.push([
      {
        stack: [
          { text: signatures.leftLine1 ? '________________________' : '________________', alignment: 'center', fontSize: 9, margin: [0, 0, 0, 2] },
          ...(signatures.leftLine1 ? [{ text: signatures.leftLine1, bold: true, alignment: 'center' as const, fontSize: 9 }] : []),
          { text: signatures.leftLine2, bold: true, alignment: 'center', fontSize: 9 },
        ],
        colSpan: 2,
        margin: CELL_PAD,
      },
      {},
      { text: '', margin: CELL_PAD },
      {
        stack: [
          { text: '________________________', alignment: 'center', fontSize: 9, margin: [0, 0, 0, 2] },
          ...(signatures.rightLine1 ? [{ text: signatures.rightLine1, bold: true, alignment: 'center' as const, fontSize: 9 }] : []),
          { text: signatures.rightLine2, bold: true, alignment: 'center', fontSize: 9 },
        ],
        colSpan: 2,
        margin: CELL_PAD,
      },
      {},
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
      razonSocial?: string;
      department?: string;
      receiverName?: string;
      deliveryPerson?: string;
      notes?: string;
    },
  ): Promise<Buffer> {
    const data = await this.getMultiItemReportData(assetIds);
    const dateStr = this.getDateStr();

    const outerBody: any[][] = this.buildMultiItemBody(
      dateStr,
      'ENTREGA DE EQUIPO',
      options?.razonSocial || data.company || 'N/A',
      options?.department || data.department || 'N/A',
      options?.receiverName || data.userName || 'N/A',
      data.items,
      `Recibo de ${options?.razonSocial || data.company || 'Hotel Shops S.A. de C.V.'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
      // Signatures: ENTREGA = Responsable | RECIBE = userName
      {
        leftLabel: 'ENTREGA:',
        leftLine1: 'Responsable',
        leftLine2: '',
        rightLabel: 'RECIBE:',
        rightLine1: '',
        rightLine2: options?.receiverName || data.userName || 'N/A',
      },
    );

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 30, 40, 40],
      defaultStyle: { fontSize: 10 },
      content: [
        {
          table: {
            widths: [55, '*', 65, 110, 105],
            body: outerBody,
          },
          layout: this.gridLayout(),
        },
      ],
      footer: (currentPage: number) => ({
        text: currentPage.toString(),
        alignment: 'center',
        fontSize: 9,
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
      deliveryPerson?: string;
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
      'Recibo del Encargado de tienda la(s) Herramienta(s) arriba mencionada(s) para resguardo, reinstalacion o asignacion del mismo. Sirva el presente documento para el deslinde responsabilidades posteriores.',
      {
        leftLabel: 'ENTREGA:',
        leftLine1: '',
        leftLine2: 'ENCARGADO DE TIENDA',
        rightLabel: 'RECIBE:',
        rightLine1: '',
        rightLine2: 'DEPARTAMENTO DE SISTEMAS',
      },
    );

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 30, 40, 40],
      defaultStyle: { fontSize: 10 },
      content: [
        {
          table: {
            widths: [55, '*', 65, 110, 105],
            body: outerBody,
          },
          layout: this.gridLayout(),
        },
      ],
      footer: (currentPage: number) => ({
        text: currentPage.toString(),
        alignment: 'center',
        fontSize: 9,
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
        const detail = asset.AssetDetail?.[0];
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
        'ID', 'Nombre', 'Grupo', 'Tipo', 'Marca', 'Modelo',
        'No. Serie', 'Estado', 'Empresa', 'Sitio', 'Departamento',
        'Usuario', 'Email', 'Procesador', 'RAM', 'Disco', 'S.O.',
        'IP', 'Factura',
      ];

      const rows = assets.map((asset) => {
        const detail = asset.AssetDetail?.[0];
        return [
          asset.AssetID,
          `"${(asset.Name || '').replace(/"/g, '""')}"`,
          asset.ProductType?.Group || '',
          `"${(asset.ProductType?.Name || '').replace(/"/g, '""')}"`,
          `"${(asset.Vendor?.Name || '').replace(/"/g, '""')}"`,
          `"${(detail?.Model || '').replace(/"/g, '""')}"`,
          detail?.SerialNum || '',
          asset.AssetState_Asset_AssetStateToAssetState?.Name || '',
          `"${(asset.Company?.Description || '').replace(/"/g, '""')}"`,
          `"${(asset.Site?.Name || '').replace(/"/g, '""')}"`,
          `"${(asset.Depart?.Name || asset.User?.Depart?.Name || '').replace(/"/g, '""')}"`,
          `"${(asset.User?.Name || '').replace(/"/g, '""')}"`,
          asset.User?.Email || '',
          `"${(detail?.Processor || detail?.ProcessorInfo || '').replace(/"/g, '""')}"`,
          detail?.RAM || detail?.PhysicalMemory || '',
          detail?.HDDCapacity || '',
          `"${(detail?.OperatingSystem || '').replace(/"/g, '""')}"`,
          detail?.IPAddress || '',
          detail?.Factura || '',
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
      const detail = asset.AssetDetail?.[0];
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
}
