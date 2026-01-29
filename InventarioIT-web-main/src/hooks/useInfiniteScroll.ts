"use client";

import { useEffect, useRef, useCallback } from 'react';

interface UseInfiniteScrollOptions {
  hasMore: boolean;
  isLoading: boolean;
  onLoadMore: () => void;
  threshold?: number; // Píxeles desde el final para activar la carga
  rootMargin?: string; // Margen del root para el Intersection Observer
}

export function useInfiniteScroll({
  hasMore,
  isLoading,
  onLoadMore, // Píxeles desde el final para activar la carga
  rootMargin = '0px' // Margen del root para el Intersection Observer
}: UseInfiniteScrollOptions) {
  const observerRef = useRef<IntersectionObserver | null>(null);
  const triggerRef = useRef<HTMLDivElement | null>(null);

  const handleObserver = useCallback((entries: IntersectionObserverEntry[]) => {
    const target = entries[0];
    if (target.isIntersecting && hasMore && !isLoading) {
      onLoadMore();
    }
  }, [hasMore, isLoading, onLoadMore]);

  useEffect(() => {
    if (triggerRef.current) {
      observerRef.current = new IntersectionObserver(handleObserver, {
        rootMargin,
        threshold: 0.1
      });
      observerRef.current.observe(triggerRef.current);
    }

    return () => {
      if (observerRef.current) {
        observerRef.current.disconnect();
      }
    };
  }, [handleObserver, rootMargin]);

  return triggerRef;
}
