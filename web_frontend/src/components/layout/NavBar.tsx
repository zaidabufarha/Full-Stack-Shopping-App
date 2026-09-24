import {
  ActionIcon,
  Anchor,
  Avatar,
  Box,
  Button,
  Group,
  Menu,
  TextInput,
} from "@mantine/core";
import logo from "../../assets/logo.png";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import {
  IconBell,
  IconChevronDown,
  IconHeart,
  IconLogout,
  IconSearch,
  IconShoppingCart,
  IconUser,
} from "@tabler/icons-react";
import { useEffect, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../app/hooks";
import { baseApi } from "../../app/service/baseApi";
import { logOut } from "../../features/auth/authSlice";
import { useGetCategoriesQuery } from "../../features/buy/buyApi";
import { slugify } from "../../features/buy/slug";

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
  const dispatch = useAppDispatch();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));

  // same cached query the home page uses, so this costs no extra request
  const { data: categories = [] } = useGetCategoriesQuery();

  const handleLogOut = () => {
    dispatch(logOut());
    // cached data is per-user (cart, favorites, is_favorite on products), so
    // drop all of it or the next person to log in sees the last one's
    dispatch(baseApi.util.resetApiState());
    navigate("/");
  };

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
          <ActionIcon
            component={Link}
            to="/notifications"
            variant="subtle"
            size={40}
          >
            <IconBell size={40} />
          </ActionIcon>
          {isLoggedIn ? (
            <Menu position="bottom-end">
              <Menu.Target>
                <ActionIcon
                  variant="subtle"
                  size={40}
                  radius={999}
                  aria-label="Account menu"
                >
                  <Avatar size={40} color="green">
                    <IconUser />
                  </Avatar>
                </ActionIcon>
              </Menu.Target>
              <Menu.Dropdown>
                <Menu.Item
                  leftSection={<IconLogout size={16} />}
                  onClick={handleLogOut}
                >
                  Log out
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
