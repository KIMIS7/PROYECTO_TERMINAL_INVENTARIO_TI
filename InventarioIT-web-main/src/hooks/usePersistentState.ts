"use client";

import { useState, useEffect } from 'react';

export function usePersistentState<T>(
  key: string, 
  defaultValue: T
): [T, (value: T) => void] {
  const [state, setState] = useState<T>(defaultValue);

  // Cargar estado desde localStorage al montar
  useEffect(() => {
    try {
      const saved = localStorage.getItem(key);
      if (saved) {
        const parsed = JSON.parse(saved);
        
        // Manejar Set específicamente
        if (key === 'dashboard-selLineas' && Array.isArray(parsed)) {
          setState(new Set(parsed) as T);
        } else {
          setState(parsed);
        }
      }
    } catch (error) {
      console.error(`Error al cargar estado para ${key}:`, error);
    }
  }, [key]);

  // Guardar estado en localStorage cuando cambie
  useEffect(() => {
    try {
      // Manejar Set específicamente
      if (key === 'dashboard-selLineas' && state instanceof Set) {
        localStorage.setItem(key, JSON.stringify([...state]));
      } else {
        localStorage.setItem(key, JSON.stringify(state));
      }
    } catch (error) {
      console.error(`Error al guardar estado para ${key}:`, error);
    }
  }, [key, state]);

  return [state, setState];
}

