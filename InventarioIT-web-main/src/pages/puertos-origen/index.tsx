import { MainLayout } from "@/components/MainLayout";
import { useAlert } from "@/hooks/useAlert";

export default function PuertosOrigenPage() {
 

   const { AlertDialog } = useAlert();


  return (
   <>
         <AlertDialog />
         <MainLayout breadcrumb={{ title: "Puertos de Origen", subtitle: "..." }}>
           {(sidebarState) => (
             <>
           <div className="flex flex-1 flex-col gap-4 p-4 pt-4 overflow-hidden">
   
            
         </div>
             </>
           )}
         </MainLayout>
       </>
  );
}

