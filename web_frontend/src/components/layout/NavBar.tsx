import {
  ActionIcon,
  Anchor,
  Box,
  Button,
  Group,
  Menu,
  TextInput,
} from "@mantine/core";
import logo from "../../assets/logo.png";
import { Link, useNavigate } from "react-router-dom";
import {
  IconBell,
  IconChevronDown,
  IconHeart,
  IconNotification,
  IconSearch,
  IconShoppingCart,
} from "@tabler/icons-react";
import { useState } from "react";

const categories = [
  //temp
  { id: 1, name: "Fruits" },
  { id: 2, name: "Dairy" },
  { id: 3, name: "Vegetables" },
];
function NavBar() {
  const [query, setQuery] = useState("");
  const navigate = useNavigate();

  return (
    <Box h={105} pl={100} pr={100} pt={20}>
      <Group justify="space-between">
        <img src={logo} width={200} alt="BigCart" />
        <Group gap={50}>
          <Anchor component={Link} to="/">
            Home
          </Anchor>
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
                <Menu.Item key={c.id} component={Link} to={`/category/${c.id}`}>
                  {c.name}
                </Menu.Item>
              ))}
            </Menu.Dropdown>
          </Menu>
          <form
            onSubmit={(e) => {
              e.preventDefault();
              navigate(`/shop?search=${query}`);
            }}
          >
            <TextInput
              w={300}
              leftSection={<IconSearch size={20} />}
              placeholder="Search"
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
          <Button bg={"green"} w={83} h={40} fz={16} p={0} bdrs={16}>
            Sign In
          </Button>
        </Group>
      </Group>
    </Box>
  );
}

export default NavBar;
