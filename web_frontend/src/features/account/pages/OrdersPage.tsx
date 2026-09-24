import {
  ActionIcon,
  Anchor,
  Box,
  Collapse,
  Divider,
  Group,
  Paper,
  Stack,
  Text,
  UnstyledButton,
  useMantineTheme,
} from "@mantine/core";
import { IconChevronDown, IconChevronUp } from "@tabler/icons-react";
import { useState } from "react";
import { Link } from "react-router-dom";
import { useAppSelector } from "../../../app/hooks";
import { useGetOrdersQuery } from "../accountApi";
import AccountShell from "../components/AccountShell";
import OrderSummary from "../components/OrderSummary";
import OrderTimeline from "../components/OrderTimeline";

function OrdersPage() {
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data: orders = [], isLoading, error } = useGetOrdersQuery(undefined, {
    skip: !isLoggedIn,
  });
  const [openId, setOpenId] = useState<string | null>(null);

  // newest first
  const sorted = [...orders].sort(
    (a, b) => new Date(b.date_placed).getTime() - new Date(a.date_placed).getTime(),
  );

  return (
    <AccountShell
      title="My Orders"
      description="Click an order to track it; the arrow shows its progress here."
      isLoading={isLoading}
      error={error}
    >
      {sorted.length === 0 ? (
        <Text>
          No orders yet.{" "}
          <Anchor component={Link} to="/" c="green" fz="md">
            Start shopping
          </Anchor>
        </Text>
      ) : (
        <Stack gap="md">
          {sorted.map((order) => {
            const open = openId === order.id;
            return (
              <Paper
                key={order.id}
                withBorder
                radius="md"
                style={{ borderColor: theme.other.border, overflow: "hidden" }}
              >
                <Group justify="space-between" align="center" p="lg" wrap="nowrap">
                  {/* the summary itself is the link to Track Order */}
                  <UnstyledButton component={Link} to={`/account/orders/${order.id}`}>
                    <OrderSummary order={order} />
                  </UnstyledButton>
                  <ActionIcon
                    variant="subtle"
                    color="green"
                    radius="xl"
                    aria-label={open ? "Hide progress" : "Show progress"}
                    onClick={() => setOpenId(open ? null : order.id)}
                  >
                    {open ? <IconChevronUp size={18} /> : <IconChevronDown size={18} />}
                  </ActionIcon>
                </Group>
                <Collapse expanded={open}>
                  <Divider color={theme.other.border} />
                  <Box p="lg">
                    <OrderTimeline order={order} compact />
                  </Box>
                </Collapse>
              </Paper>
            );
          })}
        </Stack>
      )}
    </AccountShell>
  );
}

export default OrdersPage;
