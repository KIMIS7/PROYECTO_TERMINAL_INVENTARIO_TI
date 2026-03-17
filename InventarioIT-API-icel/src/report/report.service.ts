import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaShopic } from 'src/database/database.service';
// eslint-disable-next-line @typescript-eslint/no-var-requires
const PdfPrinter = require('pdfmake/src/Printer');
import * as ExcelJS from 'exceljs';

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

@Injectable()
export class ReportService {
  constructor(private readonly prismaShopic: PrismaShopic) {}

  /**
   * Obtiene todos los datos necesarios para generar un reporte de entrega de equipo
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
      })),
      softwareChecklist: SOFTWARE_CHECKLIST,
    };
  }

  /**
   * Genera PDF de "Entrega de Equipo" similar al formato mostrado en la imagen
   */
  async generateDeliveryPdf(
    assetId: number,
    softwareStatus?: Record<string, string>,
    notes?: string,
  ): Promise<Buffer> {
    const data = await this.getDeliveryReportData(assetId);
    const today = new Date();
    const dateStr = `${today.getMonth() + 1}/${today.getDate()}/${today.getFullYear().toString().slice(-2)}`;

    // Construir descripción del equipo
    const description = [
      data.name.toUpperCase(),
      data.processor ? data.processor.toUpperCase() : '',
      data.ram ? `${data.ram} RAM` : '',
      data.hddCapacity ? `${data.hddCapacity} NVME` : '',
      data.operatingSystem ? data.operatingSystem.toUpperCase() : '',
    ]
      .filter(Boolean)
      .join(' / ');

    // Generar filas de checklist de software
    const softwareRows = data.softwareChecklist.map((sw) => {
      const status = softwareStatus?.[sw] || 'NA';
      return [
        { text: sw, fontSize: 9, margin: [2, 1, 2, 1] },
        {
          text: status === 'X' ? 'X' : 'NA',
          fontSize: 9,
          alignment: 'center',
          margin: [2, 1, 2, 1],
        },
      ];
    });

    const fonts = {
      Roboto: {
        normal: Buffer.from(''),
        bold: Buffer.from(''),
        italics: Buffer.from(''),
        bolditalics: Buffer.from(''),
      },
    };

    // Definir documento PDF usando pdfmake
    const docDefinition: any = {
      pageSize: 'LETTER',
      pageMargins: [40, 40, 40, 40],
      defaultStyle: {
        fontSize: 10,
      },
      content: [
        // Encabezado con fecha
        {
          columns: [
            {
              text: 'INVENTARIO TI - REPORTE',
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
          margin: [0, 0, 0, 15],
        },
        // Línea separadora
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
          margin: [0, 0, 0, 10],
        },
        // Asunto
        {
          text: [
            { text: 'ASUNTO: ', bold: true },
            { text: 'ENTREGA DE EQUIPO', bold: true },
          ],
          margin: [0, 0, 0, 8],
        },
        // Depto/Tienda y Recibe
        {
          columns: [
            {
              text: [
                { text: 'DEPTO\\TIENDA: ', bold: true },
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
        // Tabla principal: Cantidad + Descripción
        {
          table: {
            widths: [60, '*'],
            body: [
              [
                {
                  text: 'CANTIDAD',
                  bold: true,
                  alignment: 'center',
                  fillColor: '#f0f0f0',
                },
                {
                  text: 'DESCRIPCION',
                  bold: true,
                  alignment: 'center',
                  fillColor: '#f0f0f0',
                },
              ],
              [
                { text: '1', alignment: 'center', margin: [0, 5, 0, 5] },
                {
                  stack: [
                    {
                      text: description,
                      bold: true,
                      alignment: 'center',
                      margin: [0, 5, 0, 3],
                    },
                    {
                      text: [
                        { text: 'NUMERO DE SERIE: ', fontSize: 9 },
                        { text: data.serialNum, bold: true, fontSize: 9 },
                      ],
                      alignment: 'center',
                      margin: [0, 0, 0, 8],
                    },
                    // Tabla de software checklist dentro de la celda
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
        // Componentes/Accesorios del equipo (si los tiene)
        ...(data.childAssets.length > 0
          ? [
              {
                text: 'COMPONENTES / ACCESORIOS INCLUIDOS:',
                bold: true,
                margin: [0, 5, 0, 5],
              },
              {
                table: {
                  widths: ['*', 100, 100],
                  body: [
                    [
                      {
                        text: 'Componente',
                        bold: true,
                        fillColor: '#f0f0f0',
                      },
                      { text: 'Modelo', bold: true, fillColor: '#f0f0f0' },
                      { text: 'Serie', bold: true, fillColor: '#f0f0f0' },
                    ],
                    ...data.childAssets.map((child) => [
                      { text: `${child.name} (${child.productType})`, fontSize: 9 },
                      { text: child.model || 'N/A', fontSize: 9 },
                      { text: child.serialNum || 'N/A', fontSize: 9 },
                    ]),
                  ],
                },
                layout: {
                  hLineWidth: () => 0.5,
                  vLineWidth: () => 0.5,
                  hLineColor: () => '#cccccc',
                  vLineColor: () => '#cccccc',
                },
                margin: [0, 0, 0, 10],
              },
            ]
          : []),
        // Notas / Condición
        {
          text:
            notes ||
            'Se entrega equipo en buenas condiciones sin golpes ni defectos, recien instalado. Detalles de uso.',
          margin: [0, 10, 0, 10],
          italics: true,
        },
        // Aviso legal
        {
          text: `Recibo de ${data.company || 'la Empresa'} la(s) Herramienta(s) arriba mencionada(s) para hacer buen uso de ellas. En caso de renuncia o cambio de departamento, sirvase hacer entrega del equipo a su cargo a fin de evitar responsabilidades posteriores en efectivo.`,
          bold: true,
          fontSize: 9,
          margin: [0, 10, 0, 20],
          alignment: 'center',
        },
        // Firmas
        {
          columns: [
            {
              stack: [
                {
                  canvas: [
                    {
                      type: 'line',
                      x1: 0,
                      y1: 0,
                      x2: 200,
                      y2: 0,
                      lineWidth: 1,
                    },
                  ],
                  margin: [0, 40, 0, 5],
                },
                {
                  text: 'ENTREGA:',
                  bold: true,
                  alignment: 'center',
                  margin: [0, 0, 0, 3],
                },
                {
                  text: 'DEPARTAMENTO DE SISTEMAS',
                  alignment: 'center',
                  fontSize: 9,
                },
              ],
              width: '50%',
              alignment: 'center',
            },
            {
              stack: [
                {
                  canvas: [
                    {
                      type: 'line',
                      x1: 0,
                      y1: 0,
                      x2: 200,
                      y2: 0,
                      lineWidth: 1,
                    },
                  ],
                  margin: [0, 40, 0, 5],
                },
                {
                  text: 'RECIBE:',
                  bold: true,
                  alignment: 'center',
                  margin: [0, 0, 0, 3],
                },
                {
                  text: data.userName || 'N/A',
                  alignment: 'center',
                  fontSize: 9,
                },
              ],
              width: '50%',
              alignment: 'center',
            },
          ],
        },
      ],
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
        message: error.message || 'Error al generar el PDF de entrega',
      });
    }
  }

  /**
   * Genera Excel con el inventario completo de activos
   */
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

      // Definir columnas
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

      // Estilo del encabezado
      const headerRow = sheet.getRow(1);
      headerRow.font = { bold: true, color: { argb: 'FFFFFFFF' } };
      headerRow.fill = {
        type: 'pattern',
        pattern: 'solid',
        fgColor: { argb: 'FF0077B6' },
      };
      headerRow.alignment = { horizontal: 'center' };

      // Agregar datos
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

      // Aplicar bordes y autofilter
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

  /**
   * Genera Excel de historial de movimientos
   */
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

  /**
   * Genera CSV de activos (más ligero que Excel)
   */
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
        'ID',
        'Nombre',
        'Grupo',
        'Tipo',
        'Marca',
        'Modelo',
        'No. Serie',
        'Estado',
        'Empresa',
        'Sitio',
        'Departamento',
        'Usuario',
        'Email',
        'Procesador',
        'RAM',
        'Disco',
        'S.O.',
        'IP',
        'Factura',
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

  /**
   * Genera reporte de activos por usuario (resguardo)
   */
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

    // Título
    sheet.mergeCells('A1:H1');
    const titleCell = sheet.getCell('A1');
    titleCell.value = 'RESGUARDO DE EQUIPO';
    titleCell.font = { bold: true, size: 14, color: { argb: 'FF0077B6' } };
    titleCell.alignment = { horizontal: 'center' };

    // Info del usuario
    sheet.mergeCells('A3:D3');
    sheet.getCell('A3').value = `Usuario: ${user.Name}`;
    sheet.getCell('A3').font = { bold: true };

    sheet.mergeCells('E3:H3');
    sheet.getCell('E3').value = `Departamento: ${user.Depart?.Name || 'N/A'}`;

    sheet.mergeCells('A4:D4');
    sheet.getCell('A4').value = `Email: ${user.Email}`;

    sheet.mergeCells('E4:H4');
    sheet.getCell('E4').value = `Fecha: ${new Date().toLocaleDateString('es-MX')}`;

    // Tabla de activos
    const dataStartRow = 6;
    const headers = [
      'Nombre',
      'Tipo',
      'Marca',
      'Modelo',
      'No. Serie',
      'Estado',
      'Empresa',
      'Sitio',
    ];

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
      cell.fill = {
        type: 'pattern',
        pattern: 'solid',
        fgColor: { argb: 'FF0077B6' },
      };
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
      row.getCell(6).value =
        asset.AssetState_Asset_AssetStateToAssetState?.Name || '';
      row.getCell(7).value = asset.Company?.Description || '';
      row.getCell(8).value = asset.Site?.Name || '';
    });

    // Firma al final
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
