import { useState, useEffect } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Switch } from '@/components/ui/switch';
import { OriginPort, UpdateOriginPortDto } from '@/types/origin-port';

interface EditOriginPortModalProps {
  open: boolean;
  onClose: () => void;
  onSubmit: (id: number, data: UpdateOriginPortDto) => Promise<void>;
  originPort: OriginPort | null;
}

export function EditOriginPortModal({ open, onClose, onSubmit, originPort }: EditOriginPortModalProps) {
  const [formData, setFormData] = useState<UpdateOriginPortDto>({});
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (originPort) {
      setFormData({
        code: originPort.code,
        name: originPort.name,
        country: originPort.country,
        description: originPort.description,
        isActive: originPort.isActive,
      });
    }
  }, [originPort]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!originPort) return;

    setIsLoading(true);
    try {
      await onSubmit(originPort.id, formData);
      onClose();
    } catch (error) {
      console.error('Error updating origin port:', error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[500px]">
        <DialogHeader>
          <DialogTitle>Editar Puerto de Origen</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="code">Código *</Label>
            <Input
              id="code"
              value={formData.code || ''}
              onChange={(e) => setFormData({ ...formData, code: e.target.value })}
              maxLength={50}
              required
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="name">Nombre *</Label>
            <Input
              id="name"
              value={formData.name || ''}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              maxLength={255}
              required
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="country">País</Label>
            <Input
              id="country"
              value={formData.country || ''}
              onChange={(e) => setFormData({ ...formData, country: e.target.value })}
              maxLength={100}
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="description">Descripción</Label>
            <Textarea
              id="description"
              value={formData.description || ''}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              maxLength={500}
            />
          </div>
          <div className="flex items-center space-x-2">
            <Switch
              id="isActive"
              checked={formData.isActive ?? true}
              onCheckedChange={(checked) => setFormData({ ...formData, isActive: checked })}
            />
            <Label htmlFor="isActive">Activo</Label>
          </div>
          <div className="flex justify-end space-x-2">
            <Button type="button" variant="outline" onClick={onClose} disabled={isLoading}>
              Cancelar
            </Button>
            <Button type="submit" disabled={isLoading}>
              {isLoading ? 'Guardando...' : 'Guardar Cambios'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
}
