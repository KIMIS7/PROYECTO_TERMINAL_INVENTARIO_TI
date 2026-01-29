import { currency } from '../utils/formatters';

export const ESTATUS_PROCESO = [
  'EN ESPERA DE PP SAMPLES',
  'PROCESO DE PAGO ANTICIPO',
  'PRODUCCION',
  'CANCELADO',
  'PROGRAMACION DE AUDITORIA DE CALIDAD',
  'PROCESO DE PAGO SALDO',
  'LIBERADO PARA EMBARQUE',
  'ORIGEN',
  'INSTRUCCIONES ENVIADAS A FORWARDER',
  'CONSOLIDACION',
  'BOOKING',
  'TRANSITO INTERNACIONAL',
  'ADUANA',
  'TRANSITO NACIONAL',
  'CEDIS',
  'RECIBIDO'
];

export const INCOTERMS_OPTIONS = [
  'EXW',
  'FCA',
  'CPT',
  'CIP',
  'DAP',
  'DPU',
  'DDP',
  'FAS',
  'FOB',
  'CFR',
  'CIF'
];

export const ORIGIN_PORT_OPTIONS = [
  { code: 'SHA', name: 'Shanghai' },
  { code: 'SZX', name: 'Shenzhen' },
  { code: 'NGB', name: 'Ningbo' },
  { code: 'HKG', name: 'Hong Kong' },
  { code: 'SGN', name: 'Ho Chi Minh' },
  { code: 'LAX', name: 'Los Angeles' },
  { code: 'NYC', name: 'Nueva York' },
  { code: 'RTM', name: 'Rotterdam' },
  { code: 'BCN', name: 'Barcelona' },
  { code: 'BUE', name: 'Buenos Aires' }
];

export const COLS_PO = [
    {key:'select', label:'', fixed:true},
    {key:'linea', label:'Línea'},
    {key:'coleccion', label:'COLECCIÓN'},
    {key:'sku', label:'SKU'},
    {key:'descripcion', label:'DESCRIPCION'},
    {key:'cantidad', label:'CANTIDAD OC', align:'right'},
    {key:'costoUSD', label:'COSTO USD', align:'right', fmt:currency},
    {key:'landed', label:'LANDED COST', align:'right'},
    {key:'costoFinal', label:'COSTO FINAL', align:'right', fmt:currency},
    {key:'categoria', label:'Categoria'},
    {key:'subcategoria', label:'Subcategoria'},
    {key:'familia', label:'Familia'},
    {key:'portafolio', label:'PORTAFOLIO'},
    {key:'capsula', label:'Capsula'},
    {key:'modeloHS', label:'ModeloHS'},
    {key:'gema', label:'GEMA'},
    {key:'colorMaterial', label:'COLOR MATERIAL'},
    {key:'origen', label:'ORIGEN'},
    {key:'fob', label:'FOB'},
    {key:'progAuditoria', label:'PROGRAMACIÓN DE AUDITORIA'},
    {key:'estatus', label:'ESTATUS'},
    {key:'dueDate', label:'DUE DATE FINAL'},
    {key:'eta', label:'ETA'},
    {key:'week', label:'WEEK'},
    {key:'destino', label:'DESTINO'},
    {key:'embarque', label:'EMBARQUE'},
    {key:'habilitar', label:'HABILITAR'}
];
