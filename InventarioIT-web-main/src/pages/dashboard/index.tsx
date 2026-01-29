import { MainLayout } from "@/components/MainLayout";
import { requireAuthGSSP } from "@/lib/requireAuthGSSP";
import { useSession } from "next-auth/react";
import { useUserData } from "@/hooks/dashboard/useUserData";
import { useAlert } from "@/hooks/useAlert";


export const getServerSideProps = requireAuthGSSP(async () => {
  return { props: {} };
});

export default function CarteraPO() {
  // Obtener la sesión del usuario
  const { data : session } = useSession();

  const { usuario, setUsuario, userCompanies } = useUserData();
  
  const userEmail = session?.user?.preferred_username || '';
  const { showAlert, AlertDialog } = useAlert();



  return (
    <>
      <AlertDialog />
      <MainLayout breadcrumb={{ title: "Dashboard", subtitle: "..." }}>
        {(sidebarState) => (
          <>
        <div className="flex flex-1 flex-col gap-4 p-4 pt-4 overflow-hidden">

          <h1>{usuario}</h1>
          <h2>{userEmail}</h2>
      </div>
          </>
        )}
      </MainLayout>
    </>
  );
}
