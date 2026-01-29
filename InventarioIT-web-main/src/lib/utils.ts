import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export const getInitials = (fullName: string) => {
  // Validar que el input sea string y no esté vacío
  if (!fullName || typeof fullName !== 'string') {
    return '';
  }

  // Eliminar espacios extras y dividir por espacios
  return fullName
    .trim()
    .split(/\s+/)
    .map(name => name.charAt(0).toUpperCase())
    .join('');
};