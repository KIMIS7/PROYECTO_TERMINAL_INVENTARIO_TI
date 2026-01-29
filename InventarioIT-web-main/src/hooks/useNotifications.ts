import { toast } from "sonner";

export const useNotifications = () => {
  const showSuccess = (message: string) => {
    toast.success(message, {
      duration: 4000,
      position: "top-right",
    });
  };

  const showError = (message: string) => {
    toast.error(message, {
      duration: 5000,
      position: "top-right",
    });
  };

  const showWarning = (message: string) => {
    toast.warning(message, {
      duration: 4000,
      position: "top-right",
    });
  };

  const showInfo = (message: string) => {
    toast.info(message, {
      duration: 4000,
      position: "top-right",
    });
  };

  return {
    showSuccess,
    showError,
    showWarning,
    showInfo,
  };
};
