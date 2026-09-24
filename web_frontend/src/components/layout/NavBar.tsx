import {
  ActionIcon,
  Anchor,
  Avatar,
  Badge,
  Box,
  Button,
  Group,
  Menu,
  Stack,
  Text,
  TextInput,
  UnstyledButton,
} from "@mantine/core";
import logo from "../../assets/logo.png";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import {
  IconBell,
  IconChevronDown,
  IconCreditCard,
  IconHeart,
  IconLogout,
  IconMapPin,
  IconPackage,
  IconReceipt,
  IconSearch,
  IconShoppingCart,
  IconUser,
} from "@tabler/icons-react";
import { useEffect, useState } from "react";
import { useAppSelector } from "../../app/hooks";
import { useGetUserDataQuery } from "../../features/account/accountApi";
import { useLogOut } from "../../features/auth/useLogOut";
import { useGetCategoriesQuery } from "../../features/buy/buyApi";
import { slugify } from "../../features/buy/slug";

// The account dropdown mirrors the Flutter Account page, minus Favorites,
// which the heart icon in the bar already covers. An entry without `to`
// renders disabled with a "Soon" tag rather than linking nowhere.
const ACCOUNT_LINKS: { label: string; icon: typeof IconUser; to?: string }[] = [
  { label: "About me", icon: IconUser, to: "/account/profile" },
  { label: "My Orders", icon: IconPackage, to: "/account/orders" },
  { label: "My Address", icon: IconMapPin, to: "/account/addresses" },
  { label: "Credit Cards", icon: IconCreditCard, to: "/account/cards" },
  { label: "Transactions", icon: IconReceipt, to: "/account/transactions" },
  { label: "Notifications", icon: IconBell, to: "/account/notifications" },
];

function NavBar() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const urlSearch = searchParams.get("search") ?? "";
  const [query, setQuery] = useState(urlSearch);

  // keep the box in step with the URL, so "Clear filters", the back button or
  // a pasted link all show the right text
  useEffect(() => {
    setQuery(urlSearch);
  }, [urlSearch]);
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const handleLogOut = useLogOut();

  // same cached query the home page uses, so this costs no extra request
  const { data: categories = [] } = useGetCategoriesQuery();
  // name, email and picture for the account menu; per-user, so skipped logged out
  const { data: user } = useGetUserDataQuery(undefined, { skip: !isLoggedIn });

  return (
    <Box h={105} pl={100} pr={100} pt={20}>
      <Group justify="space-between">
        <Link to="/" aria-label="BigCart home">
          <img src={logo} width={200} alt="BigCart" />
        </Link>
        <Group gap={50}>
          <Menu trigger="hover">
            <Menu.Target>
              <Anchor component="button">
                <Group gap={10}>
                  Category <IconChevronDown size={25} />
                </Group>
              </Anchor>
            </Menu.Target>
            <Menu.Dropdown>
              {categories.map((c) => (
                <Menu.Item
                  key={c.id}
                  component={Link}
                  to={`/?category=${slugify(c.name)}`}
                >
                  {c.name}
                </Menu.Item>
              ))}
            </Menu.Dropdown>
          </Menu>
          <form
            onSubmit={(e) => {
              e.preventDefault();
              const term = query.trim();
              // a new search starts from a clean slate; an empty one clears it
              navigate(term ? `/?search=${encodeURIComponent(term)}` : "/");
            }}
          >
            <TextInput
              w={300}
              leftSection={<IconSearch size={20} />}
              placeholder="Search"
              value={query}
              onChange={(e) => {
                setQuery(e.currentTarget.value);
              }}
            />
          </form>
        </Group>
        <Group gap={30}>
          <ActionIcon component={Link} to="/cart" variant="subtle" size={40}>
            <IconShoppingCart size={40} />
          </ActionIcon>
          <ActionIcon
            component={Link}
            to="/favorites"
            variant="subtle"
            size={40}
          >
            <IconHeart size={40} />
          </ActionIcon>
          {isLoggedIn ? (
            <Menu position="bottom-end" width={260}>
              <Menu.Target>
                <UnstyledButton aria-label="Account menu">
                  {/* real profile picture; the icon only shows if it fails to load */}
                  <Avatar src={user?.image_path} size={40} radius="xl" color="green">
                    <IconUser />
                  </Avatar>
                </UnstyledButton>
              </Menu.Target>
              <Menu.Dropdown>
                <Group gap="sm" p="sm" wrap="nowrap">
                  <Avatar src={user?.image_path} size={44} radius="xl" color="green">
                    <IconUser />
                  </Avatar>
                  <Stack gap={0} style={{ minWidth: 0 }}>
                    <Text fw={600} c="black" lineClamp={1}>
                      {user?.name ?? "…"}
                    </Text>
                    <Text size="xs" lineClamp={1}>
                      {user?.email ?? ""}
                    </Text>
                  </Stack>
                </Group>
                <Menu.Divider />
                {ACCOUNT_LINKS.map(({ label, icon: Icon, to }) =>
                  to ? (
                    <Menu.Item
                      key={label}
                      component={Link}
                      to={to}
                      leftSection={<Icon size={18} />}
                    >
                      {label}
                    </Menu.Item>
                  ) : (
                    <Menu.Item
                      key={label}
                      disabled
                      leftSection={<Icon size={18} />}
                      rightSection={
                        <Badge size="xs" variant="light" color="gray">
                          Soon
                        </Badge>
                      }
                    >
                      {label}
                    </Menu.Item>
                  ),
                )}
                <Menu.Divider />
                <Menu.Item
                  leftSection={<IconLogout size={18} />}
                  onClick={handleLogOut}
                >
                  Sign out
                </Menu.Item>
              </Menu.Dropdown>
            </Menu>
          ) : (
            <Button
              component={Link}
              to="/login"
              bg={"green"}
              w={83}
              h={40}
              fz={16}
              p={0}
              bdrs={16}
            >
              Sign In
            </Button>
          )}
        </Group>
      </Group>
    </Box>
  );
}

export default NavBar;
