// flujoshs-web/src/utils/formatters.ts
export const currency = (n: number) => new Intl.NumberFormat('es-MX', { style: 'currency', currency: 'USD' }).format(n);

export const fmt = (s: string | number | null | undefined) => (s === undefined || s === null || s === '') ? '—' : s;

export const formatDateMexican = (dateInput: string | Date) => {
  if (!dateInput) return '—';
  const d = new Date(dateInput);
  if (isNaN(d.getTime())) return '—';
  return new Intl.DateTimeFormat('es-MX', {
    timeZone: 'UTC',
    day: '2-digit', month: '2-digit', year: 'numeric'
  }).format(d).replaceAll('/', '-');
};

export const formatDateTimeMexican = (dateString: string | Date) => {
  if (!dateString) return '—';
  const date = new Date(dateString);
  if (isNaN(date.getTime())) return '—';
  
  const day = date.getDate().toString().padStart(2, '0');
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const year = date.getFullYear();
  const hours = date.getHours().toString().padStart(2, '0');
  const minutes = date.getMinutes().toString().padStart(2, '0');
  const seconds = date.getSeconds().toString().padStart(2, '0');
  
  return `${day}-${month}-${year} ${hours}:${minutes}:${seconds}`;
};

export const mexicanToISO = (mexicanDate: string) => {
  if (!mexicanDate) return '';
  const parts = mexicanDate.split('-');
  if (parts.length === 3) {
    const [day, month, year] = parts;
    return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;
  }
  return mexicanDate;
};

export const isoToMexican = (isoDate: string) => {
  if (!isoDate) return '';
  const date = new Date(isoDate);
  if (isNaN(date.getTime())) return isoDate;
  
  const day = date.getDate().toString().padStart(2, '0');
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const year = date.getFullYear();
  
  return `${day}-${month}-${year}`;
};

export const todayISO = () => {
    return new Date().toISOString().slice(0, 16).replace('T', ' ');
}
