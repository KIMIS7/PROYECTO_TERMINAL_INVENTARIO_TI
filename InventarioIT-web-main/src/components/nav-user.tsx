"use client";

import {
  ChevronsUpDown,
  LogOut,
} from "lucide-react";
import { useState } from "react";

import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar";
import { signOut } from "next-auth/react";
import { getInitials } from "@/lib/utils";

interface UserProfile {
  userInfo?: {
    buyerID?: string;
    name?: string;
    emailAddress?: string;
    approvalPerson?: string;
  };
  companies?: string[];
}

export function NavUser({
  user,
}: {
  user: {
    name: string;
    email: string;
    avatar: string;
  };
}) {
  const { isMobile } = useSidebar();
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);

  /*useEffect(() => {
    const fetchUserProfile = async () => {
      if (!user.email) return;
      
      try {
        const response = await api.user.getUserProfile(user.email// 'arendon@hotel-shops.com'//);
        if (response.success) {
          setUserProfile(response.data);
        }
      } catch (error) {
        console.error('Error al cargar perfil de usuario:', error);
      }
    };

    fetchUserProfile();
  }, [user.email]);*/

  const userInitials = getInitials(user.name);

  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <SidebarMenuButton
              size="lg"
              className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
            >
              <Avatar className="h-8 w-8 rounded-lg">
                <AvatarImage src={user.avatar} alt={user.name} />
                <AvatarFallback className="rounded-lg">HS</AvatarFallback>
              </Avatar>
              <div className="grid flex-1 text-left text-sm leading-tight">
                <span className="truncate font-medium">{user.name}</span>
                <span className="truncate text-xs">{user.email}</span>
                {/* {userProfile?.userInfo?.buyerID && (
                  <span className="truncate text-xs text-gray-500">ID: {userProfile.userInfo.buyerID}</span>
                )} */}
              </div>
              <ChevronsUpDown className="ml-auto size-4" />
            </SidebarMenuButton>
          </DropdownMenuTrigger>
          <DropdownMenuContent
            className="w-80"
            side={isMobile ? "bottom" : "right"}
            align="end"
            sideOffset={4}
          >
            <DropdownMenuLabel className="p-0 font-normal">
              <div className="flex items-center gap-2 px-1 py-1.5 text-left text-sm">
                <Avatar className="h-8 w-8 rounded-lg">
                  <AvatarImage src={user.avatar} alt={user.name} />
                  <AvatarFallback className="rounded-lg">{userInitials}</AvatarFallback>
                </Avatar>
                <div className="grid flex-1 text-left text-sm leading-tight">
                  <span className="truncate font-medium">{user.name}</span>
                  <span className="truncate text-xs">{user.email}</span>
                  {userProfile?.userInfo?.buyerID && (
                    <span className="truncate text-xs">Buyer ID: {userProfile.userInfo.buyerID}</span>
                  )}
                </div>
              </div>
            </DropdownMenuLabel>
            <DropdownMenuSeparator />
            
            {/* Company Information - Solo visual */}
            {userProfile?.companies && userProfile.companies.length > 0 && (
              <>
                <div className="px-2 py-1">
                  <label className="text-xs font-medium text-gray-600">Compañías asociadas</label>
                  <div className="mt-1 space-y-1">
                    {userProfile.companies.map((company: string) => (
                      <div key={company} className="text-xs text-gray-700 bg-gray-50 px-2 py-1 rounded">
                        {company}
                      </div>
                    ))}
                  </div>
                </div>
                <DropdownMenuSeparator />
              </>
            )}
            
            <DropdownMenuItem
              onClick={() => signOut({ callbackUrl: "/", redirect: true })}
            >
              <LogOut />
              Log out
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </SidebarMenuItem>
    </SidebarMenu>
  );
}