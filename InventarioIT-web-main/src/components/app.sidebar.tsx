"use client";

import * as React from "react";

import { NavMain } from "@/components/nav-main";
//import { NavProjects } from "@/components/nav-projects"
import { NavUser } from "@/components/nav-user";
import { TeamSwitcher } from "@/components/team-switcher";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarRail,
} from "@/components/ui/sidebar";
import { useSession } from "next-auth/react";
import api from "@/lib/api";

export function AppSidebar({ ...props }: React.ComponentProps<typeof Sidebar>) {
  const { data: sessionData } = useSession();
  const [navMain, setNavMain] = React.useState<
    { roldashboardpathID: number; url: string; title: string; icon?: string }[]
  >([]);

  const user = {
    name: sessionData?.user?.name || "",
    email: sessionData?.user?.preferred_username || "",
    avatar: sessionData?.user?.image || "",
  };

  React.useEffect(() => {
    (async () => {
      if (!user?.email) return;
      try {
        const res = await api.permission.get(user.email);
        setNavMain(res ?? []);
      } catch {
        setNavMain([]);
      }
    })();
  }, [user.email]);

  return (
    <Sidebar collapsible="icon" {...props}>
      <SidebarHeader>
        <TeamSwitcher />
      </SidebarHeader>
      <SidebarContent>
        <NavMain items={navMain} />
        {/*<NavProjects projects={data.projects} />*/}
      </SidebarContent>
      <SidebarFooter>
        <NavUser user={user} />
      </SidebarFooter>
      <SidebarRail />
    </Sidebar>
  );
}
