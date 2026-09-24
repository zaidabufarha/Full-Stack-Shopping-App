import { Anchor, Divider, Group, Image, Paper, Stack, Text, useMantineTheme } from "@mantine/core";
import { IconArrowLeft } from "@tabler/icons-react";
import { Link, useParams } from "react-router-dom";
import { useAppSelector } from "../../../app/hooks";
import { useGetOrdersQuery } from "../accountApi";
import AccountShell from "../components/AccountShell";
import OrderSummary from "../components/OrderSummary";
import OrderTimeline from "../components/OrderTimeline";
import { money } from "../format";

function TrackOrderPage() {
  const { id = "" } = useParams();
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  // the same cached list as My Orders — arriving from there costs no request
  const { data: orders = [], isLoading, error } = useGetOrdersQuery(undefined, {
    skip: !isLoggedIn,
  });
  const order = orders.find((o) => o.id === id);

  return (
    <AccountShell
      title="Track Order"
      isLoading={isLoading}
      error={error}
      action={
        <Anchor component={Link} to="/account/orders" c="green" fz="sm">
          <Group gap={4}>
            <IconArrowLeft size={16} />
            Back to orders
          </Group>
        </Anchor>
      }
    >
      {!order ? (
        <Text>We couldn't find that order.</Text>
      ) : (
        <Stack gap="md">
          <Paper withBorder radius="md" p="lg" style={{ borderColor: theme.other.border }}>
            <OrderSummary order={order} />
          </Paper>

          <Paper withBorder radius="md" p="xl" style={{ borderColor: theme.other.border }}>
            <OrderTimeline order={order} />
          </Paper>

          <Paper withBorder radius="md" p="lg" style={{ borderColor: theme.other.border }}>
            <Stack gap="sm">
              {order.order_item.map((item) => (
                <Group key={item.id} justify="space-between" wrap="nowrap">
                  <Group gap="sm" wrap="nowrap" style={{ minWidth: 0 }}>
                    <Image src={item.product.image_path} w={40} h={40} fit="contain" />
                    <Text c="black" lineClamp={1}>
                      {item.product.name}
                    </Text>
                  </Group>
                  <Text size="sm" style={{ flexShrink: 0 }}>
                    {item.quantity} × {money(item.price_at_purchase)}
                  </Text>
                </Group>
              ))}

              <Divider color={theme.other.border} />

              <Group gap="xl">
                <Text size="sm">
                  <Text span fw={500} c="black">
                    Shipping:
                  </Text>{" "}
                  {order.shipping_method}
                </Text>
                {order.address && (
                  <Text size="sm">
                    <Text span fw={500} c="black">
                      To:
                    </Text>{" "}
                    {order.address.street}, {order.address.city}
                  </Text>
                )}
                {order.credit_card && (
                  <Text size="sm">
                    <Text span fw={500} c="black">
                      Paid with:
                    </Text>{" "}
                    •••• {order.credit_card.last4}
                  </Text>
                )}
              </Group>
            </Stack>
          </Paper>
        </Stack>
      )}
    </AccountShell>
  );
}

export default TrackOrderPage;
