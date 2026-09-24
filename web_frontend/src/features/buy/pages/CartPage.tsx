import {
  Button,
  Center,
  Container,
  Divider,
  Group,
  Loader,
  Paper,
  Stack,
  Text,
  ThemeIcon,
  Title,
  useMantineTheme,
} from "@mantine/core";
import { IconShoppingBag } from "@tabler/icons-react";
import { Fragment } from "react";
import { Link, Navigate } from "react-router-dom";
import { useAppSelector } from "../../../app/hooks";
import { useGetCartQuery } from "../buyApi";
import CartRow from "../components/CartRow";
import CartSummary from "../components/CartSummary";
import { useCart } from "../useCart";

function CartPage() {
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data: cart = [], isLoading, error } = useGetCartQuery(undefined, { skip: !isLoggedIn });
  const { changeQuantity } = useCart();

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  if (isLoading) {
    return (
      <Center h={400}>
        <Loader color="green" />
      </Center>
    );
  }

  if (error) {
    return (
      <Container size={1440} py={60}>
        <Text c="red">{error.message}</Text>
      </Container>
    );
  }

  if (cart.length === 0) {
    return (
      <Container size="sm" py={100}>
        <Stack align="center" gap="md">
          <ThemeIcon variant="light" color="green" radius="xl" size={140}>
            <IconShoppingBag size={72} stroke={1.5} />
          </ThemeIcon>
          <Title order={2}>Your cart is empty!</Title>
          <Text ta="center">Looks like you haven't added anything yet.</Text>
          <Button component={Link} to="/" h={50} fz="md" w={260} mt="md">
            Start shopping
          </Button>
        </Stack>
      </Container>
    );
  }

  const count = cart.reduce((n, i) => n + i.quantity, 0);

  return (
    <Container size={1440} w="100%" py={40}>
      <Group align="flex-start" gap={40} wrap="nowrap">
        <Stack gap="md" style={{ flex: 1, minWidth: 0 }}>
          <Title order={2}>
            Shopping Cart{" "}
            <Text span fz="lg" fw={400}>
              ({count} {count === 1 ? "item" : "items"})
            </Text>
          </Title>
          <Paper withBorder radius="lg" p="lg" bg="white" style={{ borderColor: theme.other.border }}>
            <Stack gap="md">
              {cart.map((item, i) => (
                <Fragment key={item.id}>
                  {i > 0 && <Divider color={theme.other.border} />}
                  <CartRow
                    item={item}
                    onChangeQuantity={(next) => changeQuantity(item.product, next)}
                  />
                </Fragment>
              ))}
            </Stack>
          </Paper>
        </Stack>

        <Stack w={420} style={{ flexShrink: 0 }}>
          <CartSummary
            items={cart}
            action={
              <Button component={Link} to="/checkout/delivery" fullWidth h={50} fz="md" mt="xs">
                Checkout
              </Button>
            }
          />
        </Stack>
      </Group>
    </Container>
  );
}

export default CartPage;
