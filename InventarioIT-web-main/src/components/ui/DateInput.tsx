import React from 'react';
import { DatePicker } from './date-picker';

interface DateInputProps {
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
  className?: string;
  disabled?: boolean;
}

export function DateInput({ 
  value, 
  onChange, 
  placeholder = "dd/mm/yyyy", 
  className = "",
  disabled = false 
}: DateInputProps) {
  const handleDateChange = (date: Date | undefined) => {
    if (date) {
      // Convertir Date a formato ISO (yyyy-mm-dd) usando hora local
      // para evitar problemas de zona horaria
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      const isoDate = `${year}-${month}-${day}`;
      onChange(isoDate);
    } else {
      onChange('');
    }
  };

  // Convertir string ISO a Date en hora local
  // para evitar problemas de zona horaria (mostrar día anterior)
  const dateValue = value ? (() => {
    const [year, month, day] = value.split('-').map(Number);
    // Crear fecha en hora local (no UTC)
    return new Date(year, month - 1, day);
  })() : undefined;

  return (
    <DatePicker
      value={dateValue}
      onChange={handleDateChange}
      placeholder={placeholder}
      className={className}
      disabled={disabled}
    />
  );
}

