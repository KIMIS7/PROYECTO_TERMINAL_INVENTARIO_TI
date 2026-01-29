import { AppSidebar } from "@/components/app.sidebar";
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from "@/components/ui/breadcrumb";
import { Separator } from "@/components/ui/separator";
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
  useSidebar,
} from "@/components/ui/sidebar";

function MainLayoutContent({
  children,
  breadcrumb,
}: {
  children: (sidebarState: string) => React.ReactNode;
  breadcrumb?: { title: string; subtitle: string };
}) {
  const { state: sidebarState } = useSidebar();
  
  return (
    <>
      <AppSidebar />
      <SidebarInset>
        <header className="flex h-16 shrink-0 items-center gap-2 border-b transition-[width,height] ease-linear group-has-data-[collapsible=icon]/sidebar-wrapper:h-12">
          <div className="flex items-center gap-2 px-4">
            <SidebarTrigger className="-ml-1" />
            <Separator
              orientation="vertical"
              className="mr-2 data-[orientation=vertical]:h-4"
            />
            <Breadcrumb>
              <BreadcrumbList>
                <BreadcrumbItem className="hidden md:block">
                  <BreadcrumbLink href="#">{breadcrumb?.title}</BreadcrumbLink>
                </BreadcrumbItem>
                <BreadcrumbSeparator className="hidden md:block" />
                <BreadcrumbItem>
                  <BreadcrumbPage>{breadcrumb?.subtitle}</BreadcrumbPage>
                </BreadcrumbItem>
              </BreadcrumbList>
            </Breadcrumb>
          </div>
        </header>
        {/* Render Main Content */}
        <main>{children(sidebarState)}</main>
      </SidebarInset>
    </>
  );
}

export function MainLayout({
  children,
  breadcrumb,
}: {
  children: (sidebarState: string) => React.ReactNode;
  breadcrumb?: { title: string; subtitle: string };
}) {
  return (
    <SidebarProvider>
      <MainLayoutContent breadcrumb={breadcrumb}>
        {children}
      </MainLayoutContent>
    </SidebarProvider>
  );
}
