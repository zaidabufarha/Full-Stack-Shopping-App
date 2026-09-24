import {
  Avatar,
  Box,
  Container,
  Divider,
  Group,
  NavLink,
  Stack,
  Text,
} from "@mantine/core";
import {
  IconBell,
  IconChevronRight,
  IconCreditCard,
  IconLogout,
  IconMapPin,
  IconPackage,
  IconReceipt,
  IconUser,
} from "@tabler/icons-react";
import { Link, Navigate, Outlet, useLocation } from "react-router-dom";
import { useAppSelector } from "../../app/hooks";
import { useLogOut } from "../auth/useLogOut";
import { useGetUserDataQuery } from "./accountApi";

// Sidebar groups, in the UI kit's style. Paths are under /account.
const SECTIONS: { heading: string; links: { label: string; to: string; icon: typeof IconUser }[] }[] = [
  {
    heading: "Account",
    links: [{ label: "Personal Information", to: "/account/profile", icon: IconUser }],
  },
  {
    heading: "Orders & Payment",
    links: [
      { label: "My Orders", to: "/account/orders", icon: IconPackage },
      { label: "Credit Cards", to: "/account/cards", icon: IconCreditCard },
      { label: "Transactions", to: "/account/transactions", icon: IconReceipt },
    ],
  },
  {
    heading: "Shipping",
    links: [{ label: "My Address", to: "/account/addresses", icon: IconMapPin }],
  },
  {
    heading: "Settings",
    links: [{ label: "Notifications", to: "/account/notifications", icon: IconBell }],
  },
];

/**
 * Layout route for everything under /account: the sidebar (user header +
 * grouped links + sign out) stays put while the page on the right swaps
 * through <Outlet />. Nested inside RootLayout, so nav and footer stay too.
 */
function AccountLayout() {
  const { pathname } = useLocation();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data: user } = useGetUserDataQuery(undefined, { skip: !isLoggedIn });
  const signOut = useLogOut();

  // every account page is per-user
  if (!isLoggedIn) return <Navigate to="/login" replace />;

  return (
    <Container size={1440} w="100%" py={40}>
      <Group align="flex-start" gap={40} wrap="nowrap">
        {/* sidebar */}
        <Stack w={300} gap="lg" style={{ flexShrink: 0 }}>
          <Group gap="sm" wrap="nowrap">
            <Avatar src={user?.image_path} size={48} radius="xl" color="green">
              <IconUser />
            </Avatar>
            <Stack gap={0} style={{ minWidth: 0 }}>
              <Text fw={600} c="black" lineClamp={1}>
                {user?.name ?? "…"}
              </Text>
              <Text size="sm" lineClamp={1}>
                {user?.email ?? ""}
              </Text>
            </Stack>
          </Group>

          {SECTIONS.map((section) => (
            <Stack key={section.heading} gap={4}>
              <Text size="xs" tt="uppercase" fw={600} px="sm">
                {section.heading}
              </Text>
              {section.links.map(({ label, to, icon: Icon }) => (
                <NavLink
                  key={to}
                  component={Link}
                  to={to}
                  label={label}
                  // startsWith so /account/orders/42 still highlights My Orders
                  active={pathname === to || pathname.startsWith(`${to}/`)}
                  color="green"
                  variant="light"
                  leftSection={<Icon size={18} />}
                  rightSection={<IconChevronRight size={14} />}
                  style={{ borderRadius: 8 }}
                />
              ))}
            </Stack>
          ))}

          <Divider />
          <NavLink
            label="Sign out"
            leftSection={<IconLogout size={18} />}
            onClick={signOut}
            style={{ borderRadius: 8 }}
          />
        </Stack>

        {/* page */}
        <Box style={{ flex: 1, minWidth: 0 }}>
          <Outlet />
        </Box>
      </Group>
    </Container>
  );
}

export default AccountLayout;
