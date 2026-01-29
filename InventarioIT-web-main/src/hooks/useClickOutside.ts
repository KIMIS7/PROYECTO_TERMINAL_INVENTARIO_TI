import { useEffect, RefObject } from 'react';

/**
 * Hook personalizado para detectar clics fuera de un elemento
 * @param ref - Referencia al elemento que queremos proteger
 * @param handler - Función que se ejecutará cuando se haga clic fuera
 * @param enabled - Si el hook debe estar activo (por defecto true)
 */
export function useClickOutside<T extends HTMLElement = HTMLElement>(
  ref: RefObject<T | null>,
  handler: (event: MouseEvent | TouchEvent) => void,
  enabled: boolean = true
) {
  useEffect(() => {
    if (!enabled) return;

    const listener = (event: MouseEvent | TouchEvent) => {
      const el = ref?.current;
      
      // No hacer nada si el elemento no existe o si el clic fue dentro del elemento
      if (!el || el.contains(event.target as Node)) {
        return;
      }

      // Ejecutar el handler si el clic fue fuera del elemento
      handler(event);
    };

    // Agregar listeners para mouse y touch
    document.addEventListener('mousedown', listener);
    document.addEventListener('touchstart', listener);

    // Cleanup
    return () => {
      document.removeEventListener('mousedown', listener);
      document.removeEventListener('touchstart', listener);
    };
  }, [ref, handler, enabled]);
}
