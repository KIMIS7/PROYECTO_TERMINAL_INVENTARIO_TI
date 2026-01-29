import { useState, useEffect } from 'react';
import api from '@/lib/api';

interface ApprovalHierarchyBuyer {
  Company: string;
  Name: string;
  BuyerID: string;
  EMailAddress: string;
  ApprovalPerson: string;
  Nivel: number;
}

interface UseApprovalHierarchyReturn {
  buyers: ApprovalHierarchyBuyer[];
  isLoading: boolean;
  error: string | null;
  refetch: () => Promise<void>;
}

/**
 * Hook para obtener la jerarquía de aprobaciones de un comprador
 * @param buyerID - ID del comprador raíz (si es null, no hace fetch)
 * @param company - Compañía opcional
 * @returns Objeto con buyers, isLoading, error y refetch
 */
export const useApprovalHierarchy = (
  buyerID: string | null,
  company?: string
): UseApprovalHierarchyReturn => {
  const [buyers, setBuyers] = useState<ApprovalHierarchyBuyer[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchHierarchy = async () => {
    if (!buyerID) {
      setBuyers([]);
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const response = await api.approvalHierarchy.getHierarchy(buyerID, company);
      
      if (response.success && response.data) {
        setBuyers(response.data);
      } else {
        setError(response.message || 'Error al obtener jerarquía');
        setBuyers([]);
      }
    } catch (err: any) {
      console.error('Error en useApprovalHierarchy:', err);
      setError(err?.response?.data?.message || 'Error al cargar jerarquía de aprobaciones');
      setBuyers([]);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchHierarchy();
  }, [buyerID, company]);

  return {
    buyers,
    isLoading,
    error,
    refetch: fetchHierarchy,
  };
};
