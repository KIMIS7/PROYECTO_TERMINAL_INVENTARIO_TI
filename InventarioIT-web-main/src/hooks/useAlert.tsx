import { useState, useCallback } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { AlertCircle, CheckCircle, Info, AlertTriangle } from 'lucide-react';

type AlertType = 'error' | 'warning' | 'success' | 'info';

interface AlertOptions {
  title?: string;
  description: string;
  type?: AlertType;
  confirmText?: string;
  onConfirm?: () => void;
}

export function useAlert() {
  const [isOpen, setIsOpen] = useState(false);
  const [alertConfig, setAlertConfig] = useState<AlertOptions>({
    description: '',
    type: 'info',
  });

  const showAlert = useCallback((description: string, options?: Partial<AlertOptions>) => {
    setAlertConfig({
      description,
      type: options?.type || 'info',
      title: options?.title,
      confirmText: options?.confirmText || 'Aceptar',
      onConfirm: options?.onConfirm,
    });
    setIsOpen(true);
  }, []);

  const closeAlert = useCallback(() => {
    setIsOpen(false);
    if (alertConfig.onConfirm) {
      alertConfig.onConfirm();
    }
  }, [alertConfig]);

  const getIcon = () => {
    const iconClass = 'h-5 w-5';
    switch (alertConfig.type) {
      case 'error':
        return <AlertCircle className={`${iconClass} text-red-500`} />;
      case 'warning':
        return <AlertTriangle className={`${iconClass} text-amber-500`} />;
      case 'success':
        return <CheckCircle className={`${iconClass} text-green-500`} />;
      case 'info':
      default:
        return <Info className={`${iconClass} text-blue-500`} />;
    }
  };

  const getTitle = () => {
    if (alertConfig.title) return alertConfig.title;
    
    switch (alertConfig.type) {
      case 'error':
        return 'Error';
      case 'warning':
        return 'Advertencia';
      case 'success':
        return 'Éxito';
      case 'info':
      default:
        return 'Información';
    }
  };

  const AlertDialog = () => (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <div className="flex items-center gap-3">
            {getIcon()}
            <DialogTitle className="text-lg font-semibold">
              {getTitle()}
            </DialogTitle>
          </div>
          <DialogDescription className="pt-2 text-base">
            {alertConfig.description.split('\n').map((line, index) => (
              <span key={index}>
                {line}
                {index < alertConfig.description.split('\n').length - 1 && <br />}
              </span>
            ))}
          </DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button onClick={closeAlert} className="w-full sm:w-auto">
            {alertConfig.confirmText || 'Aceptar'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );

  return {
    showAlert,
    AlertDialog,
  };
}

