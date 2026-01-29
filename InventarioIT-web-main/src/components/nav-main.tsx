"use client";

import {
  SidebarGroup,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import Link from "next/link";
import { usePathname } from "next/navigation";

export function NavMain({
  items,
}: {
  items: {
    roldashboardpathID: number;
    url: string;
    title: string;
    icon?: string;
  }[];
}) {
  const pathname = usePathname();
  const isItemActive = (url: string) => {
    return pathname === url;
  };
  return (
    <SidebarGroup>
      <SidebarGroupLabel>Platform</SidebarGroupLabel>
      <SidebarMenu>
        {items?.map((item) => (
          <SidebarMenuItem key={item.roldashboardpathID}>
            <Link href={item.url}>
              <SidebarMenuButton
                tooltip={item.title}
                className={`transition-colors duration-200 cursor-pointer ${
                  isItemActive(item.url)
                    ? "bg-rose-100 text-rose-600 hover:bg-rose-100 hover:text-rose-600"
                    : "text-gray-400 hover:bg-gray-100 hover:text-gray-600"
                }`}
              >
                {item.icon && (
                  <span
                    className="w-4 h-4 [&>svg]:w-4 [&>svg]:h-4"
                    dangerouslySetInnerHTML={{ __html: item.icon }}
                  ></span>
                )}
                <span>{item.title}</span>
              </SidebarMenuButton>
            </Link>
          </SidebarMenuItem>
        ))}
      </SidebarMenu>
    </SidebarGroup>
  );
}
