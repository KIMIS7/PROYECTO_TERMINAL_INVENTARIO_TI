import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';
import * as path from 'path';
// eslint-disable-next-line @typescript-eslint/no-var-requires
const PdfPrinter = require('pdfmake/src/Printer');
import * as ExcelJS from 'exceljs';

const PDFMAKE_FONTS_DIR = path.join(
  __dirname,
  '..',
  '..',
  'node_modules',
  'pdfmake',
  'build',
  'fonts',
  'Roboto',
);

// Lista de software estándar que se revisa en cada entrega de equipo
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

// Tipos de reporte soportados
type ReportFormat = 'entrega_software' | 'entrega_multiitem' | 'resguardo';

@Injectable()
export class ReportService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  /**
   * Obtiene datos de un activo con todos sus hijos para el reporte
   */
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

  /**
   * Obtiene datos de múltiples activos para reporte multi-item
   */
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

    // Tomar datos del encabezado del primer activo
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
  // Helpers para generar PDF
  // ============================

  private createPdfBuffer(docDefinition: any): Promise<Buffer> {
    const fonts = {
      Roboto: {
        normal: path.join(PDFMAKE_FONTS_DIR, 'Roboto-Regular.ttf'),
        bold: path.join(PDFMAKE_FONTS_DIR, 'Roboto-Medium.ttf'),
        italics: path.join(PDFMAKE_FONTS_DIR, 'Roboto-Italic.ttf'),
        bolditalics: path.join(PDFMAKE_FONTS_DIR, 'Roboto-MediumItalic.ttf'),
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

  private buildHeader(dateStr: string) {
    return [
      {
        columns: [
          {
            text: 'INVENTARIO TI',
            bold: true,
            fontSize: 14,
            color: '#0077B6',
            width: '*',
          },
          {
            text: [
              { text: 'FECHA: ', bold: true },
              { text: dateStr },
            ],
            alignment: 'right',
            width: 'auto',
          },
        ],
        margin: [0, 0, 0, 10],
      },
      {
        canvas: [
          {
            type: 'line',
            x1: 0,
            y1: 0,
            x2: 535,
            y2: 0,
            lineWidth: 2,
            lineColor: '#0077B6',
          },
        ],
        margin: [0, 0, 0, 8],
      },
    ];
  }

  private buildSignatures(
    leftLabel: string,
    leftName: string,
    rightLabel: string,
    rightName: string,
  ) {
    return {
      columns: [
        {
          stack: [
            {
              canvas: [
                { type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1 },
              ],
              margin: [0, 40, 0, 5],
            },
            {
              text: leftLabel,
              bold: true,
              alignment: 'center',
              margin: [0, 0, 0, 3],
            },
            { text: leftName, alignment: 'center', fontSize: 9 },
          ],
          width: '50%',
          alignment: 'center',
        },
        {
          stack: [
            {
              canvas: [
                { type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1 },
              ],
              margin: [0, 40, 0, 5],
            },
            {
              text: rightLabel,
              bold: true,
              alignment: 'center',
              margin: [0, 0, 0, 3],
            },
            { text: rightName, alignment: 'center', fontSize: 9 },
          ],
          width: '50%',
          alignment: 'center',
        },
      ],
    };
  }

  // ==========================================
  // FORMATO 1: Entrega con checklist de software
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

    const softwareRows = data.softwareChecklist.map((sw) => {
      const status = options?.softwareStatus?.[sw] || 'NA';
      return [
        { text: sw, fontSize: 9, margin: [2, 1, 2, 1] as number[] },
        {
          text: status === 'X' ? 'X' : 'NA',
          fontSize: 9,
          alignment: 'center' as const,
          margin: [2, 1, 2, 1] as number[],
        },
      ];
    });

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 40, 40, 40],
      defaultStyle: { fontSize: 10 },
      content: [
        ...this.buildHeader(dateStr),
        // Asunto
        {
          text: [
            { text: 'ASUNTO: ', bold: true },
            { text: 'ENTREGA DE EQUIPO', bold: true },
          ],
          margin: [0, 0, 0, 4],
        },
        // Razon Social
        {
          text: [
            { text: 'RAZON SOCIAL: ', bold: true },
            { text: data.company || 'N/A' },
          ],
          margin: [0, 0, 0, 4],
        },
        // Depto/Tienda y Recibe
        {
          columns: [
            {
              text: [
                { text: 'DEPTO\\TIENDA ', bold: true },
                { text: data.department || 'N/A' },
              ],
              width: '50%',
            },
            {
              text: [
                { text: 'RECIBE: ', bold: true },
                { text: data.userName || 'N/A' },
              ],
              width: '50%',
            },
          ],
          margin: [0, 0, 0, 12],
        },
        // Tabla: Cantidad + Descripción con software checklist
        {
          table: {
            widths: [60, '*'],
            body: [
              [
                { text: 'CANTIDAD', bold: true, alignment: 'center', fillColor: '#f0f0f0' },
                { text: 'DESCRIPCION', bold: true, alignment: 'center', fillColor: '#f0f0f0' },
              ],
              [
                { text: '1', alignment: 'center', margin: [0, 5, 0, 5] },
                {
                  stack: [
                    { text: description, bold: true, alignment: 'center', margin: [0, 5, 0, 3] },
                    {
                      text: [
                        { text: 'NUMERO DE SERIE:       ', fontSize: 9 },
                        { text: data.serialNum, bold: true, fontSize: 9 },
                      ],
                      alignment: 'center',
                      margin: [0, 0, 0, 8],
                    },
                    // Software checklist
                    {
                      table: {
                        widths: [200, 60],
                        body: softwareRows,
                      },
                      layout: {
                        hLineWidth: () => 0.5,
                        vLineWidth: () => 0.5,
                        hLineColor: () => '#cccccc',
                        vLineColor: () => '#cccccc',
                      },
                      margin: [80, 0, 80, 10],
                    },
                  ],
                },
              ],
            ],
          },
          layout: {
            hLineWidth: () => 1,
            vLineWidth: () => 1,
            hLineColor: () => '#999999',
            vLineColor: () => '#999999',
          },
          margin: [0, 0, 0, 10],
        },
        // Notas
        {
          text:
            options?.notes ||
            'Se entrega equipo en buenas condiciones sin golpes ni defectos, recien instalado. Detalles de uso.',
          margin: [0, 10, 0, 10],
          italics: true,
        },
        // Aviso legal
        {
          text: `Recibo de ${data.company || 'Hotel Shops S.A. de C.V.'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
          bold: true,
          fontSize: 9,
          margin: [0, 10, 0, 20],
          alignment: 'center',
        },
        // Firmas: Entrega (Depto Sistemas) | Recibe (Usuario)
        this.buildSignatures(
          'ENTREGA:',
          options?.deliveryPerson || 'DEPARTAMENTO DE SISTEMAS',
          'RECIBE:',
          data.userName || 'N/A',
        ),
      ],
    };

    return this.createPdfBuffer(docDefinition);
  }

  // ==========================================
  // FORMATO 2: Entrega multi-item (periféricos)
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

    // Filas de items
    const itemRows: any[][] = data.items.map((item) => [
      { text: '1', alignment: 'center', fontSize: 9 },
      { text: item.productType || item.name, fontSize: 9 },
      { text: item.vendor, fontSize: 9 },
      { text: item.model, fontSize: 9 },
      { text: item.serialNum || 'N/A', fontSize: 9 },
    ]);

    // Rellenar filas vacías para mantener el formato
    const minRows = 15;
    while (itemRows.length < minRows) {
      itemRows.push([
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
      ]);
    }

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 40, 40, 40],
      defaultStyle: { fontSize: 10 },
      content: [
        ...this.buildHeader(dateStr),
        {
          text: [
            { text: 'ASUNTO: ', bold: true },
            { text: 'ENTREGA DE EQUIPO', bold: true },
          ],
          margin: [0, 0, 0, 4],
        },
        {
          text: [
            { text: 'RAZON SOCIAL: ', bold: true },
            { text: options?.razonSocial || data.company || 'N/A' },
          ],
          margin: [0, 0, 0, 4],
        },
        {
          columns: [
            {
              text: [
                { text: 'DEPTO\\TIENDA ', bold: true },
                { text: options?.department || data.department || 'N/A' },
              ],
              width: '50%',
            },
            {
              text: [
                { text: 'RECIBE: ', bold: true },
                { text: options?.receiverName || data.userName || 'N/A' },
              ],
              width: '50%',
            },
          ],
          margin: [0, 0, 0, 12],
        },
        // Tabla multi-item: CANTIDAD | DESCRIPCION | MARCA | MODELO | NÚMERO DE SERIE
        {
          table: {
            widths: [55, '*', 70, 120, 110],
            body: [
              [
                { text: 'CANTIDAD', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'DESCRIPCION', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'MARCA', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'MODELO', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'NUMERO DE SERIE', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
              ],
              ...itemRows,
            ],
          },
          layout: {
            hLineWidth: () => 0.5,
            vLineWidth: () => 0.5,
            hLineColor: () => '#999999',
            vLineColor: () => '#999999',
          },
          margin: [0, 0, 0, 10],
        },
        // Aviso legal
        {
          text: `Recibo de ${options?.razonSocial || data.company || 'Hotel Shops S.A. de C.V.'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
          bold: true,
          fontSize: 9,
          margin: [0, 10, 0, 20],
          alignment: 'center',
        },
        // Firmas: Entrega (persona + Depto Sistemas) | Recibe (usuario)
        this.buildSignatures(
          'ENTREGA:',
          `${options?.deliveryPerson || ''}\nDEPTO DE SISTEMAS`,
          'RECIBE:',
          options?.receiverName || data.userName || 'N/A',
        ),
      ],
    };

    return this.createPdfBuffer(docDefinition);
  }

  // ==========================================
  // FORMATO 3: Resguardo de equipo
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

    // Filas de items
    const itemRows: any[][] = data.items.map((item) => [
      { text: '1', alignment: 'center', fontSize: 9 },
      { text: item.productType || item.name, fontSize: 9 },
      { text: item.vendor, fontSize: 9 },
      { text: item.model, fontSize: 9 },
      { text: item.serialNum || 'N/A', fontSize: 9 },
    ]);

    const minRows = 15;
    while (itemRows.length < minRows) {
      itemRows.push([
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
        { text: '', fontSize: 9 },
      ]);
    }

    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 40, 40, 40],
      defaultStyle: { fontSize: 10 },
      content: [
        ...this.buildHeader(dateStr),
        {
          text: [
            { text: 'ASUNTO: ', bold: true },
            { text: 'RESGUARDO DE EQUIPO', bold: true },
          ],
          margin: [0, 0, 0, 4],
        },
        {
          text: [
            { text: 'RAZON SOCIAL: ', bold: true },
            { text: options?.razonSocial || data.company || 'N/A' },
          ],
          margin: [0, 0, 0, 4],
        },
        {
          columns: [
            {
              text: [
                { text: 'DEPTO\\TIENDA ', bold: true },
                { text: options?.storeName || data.site || 'N/A' },
              ],
              width: '50%',
            },
            {
              text: [
                { text: 'RECIBE: ', bold: true },
                { text: options?.receiverName || 'DEPARTAMENTO DE SISTEMAS' },
              ],
              width: '50%',
            },
          ],
          margin: [0, 0, 0, 12],
        },
        // Tabla multi-item
        {
          table: {
            widths: [55, '*', 70, 120, 110],
            body: [
              [
                { text: 'CANTIDAD', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'DESCRIPCION', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'MARCA', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'MODELO', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
                { text: 'NUMERO DE SERIE', bold: true, alignment: 'center', fillColor: '#f0f0f0', fontSize: 9 },
              ],
              ...itemRows,
            ],
          },
          layout: {
            hLineWidth: () => 0.5,
            vLineWidth: () => 0.5,
            hLineColor: () => '#999999',
            vLineColor: () => '#999999',
          },
          margin: [0, 0, 0, 10],
        },
        // Aviso legal (diferente para resguardo)
        {
          text: 'Recibo del Encargado de tienda la(s) Herramienta(s) arriba mencionada(s) para resguardo, reinstalacion o asignacion del mismo. Sirva el presente documento para el deslinde responsabilidades posteriores.',
          bold: true,
          fontSize: 9,
          margin: [0, 10, 0, 20],
          alignment: 'center',
        },
        // Firmas invertidas: Entrega (Encargado de Tienda) | Recibe (Depto Sistemas)
        this.buildSignatures(
          'ENTREGA:',
          `${options?.deliveryPerson || ''}\nENCARGADO DE TIENDA`,
          'RECIBE:',
          `${options?.receiverName || ''}\nDEPARTAMENTO DE SISTEMAS`,
        ),
      ],
    };

    return this.createPdfBuffer(docDefinition);
  }

  // ==========================================
  // Método unificado (mantiene compatibilidad)
  // ==========================================

  async generateDeliveryPdf(
    assetId: number,
    softwareStatus?: Record<string, string>,
    notes?: string,
  ): Promise<Buffer> {
    return this.generateEntregaSoftwarePdf(assetId, { softwareStatus, notes });
  }

  // ==========================================
  // Excel exports (sin cambios)
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
