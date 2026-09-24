import { Divider, Group, Paper, Stack, Text, Title, useMantineTheme } from "@mantine/core";
import type { ReactNode } from "react";
import type { ShippingMethod } from "../shipping";
import type { CartItem } from "./CartRow";

type CartSummaryProps = {
  items: CartItem[];
  /** Chosen shipping method; undefined shows "calculated at checkout". */
  shipping?: ShippingMethod;
  /** Call-to-action slot, e.g. the Checkout button. */
  action?: ReactNode;
};

/** Totals for the cart. Same math as the backend: discount applied per line. */
export function cartTotals(items: CartItem[], shipping?: ShippingMethod) {
  const subtotal = items.reduce((sum, i) => sum + i.product.price * i.quantity, 0);
  const savings = items.reduce(
    (sum, i) => sum + (i.product.price * i.product.discount) / 100 * i.quantity,
    0,
  );
  const shippingCost = shipping?.price ?? 0;
  return { subtotal, savings, shippingCost, total: subtotal - savings + shippingCost };
}

function CartSummary({ items, shipping, action }: CartSummaryProps) {
  const theme = useMantineTheme();
  const { subtotal, savings, shippingCost, total } = cartTotals(items, shipping);
  const count = items.reduce((n, i) => n + i.quantity, 0);

  return (
    <Paper
      withBorder
      radius="lg"
      p="xl"
      bg="white"
      pos="sticky"
      top={24}
      style={{ borderColor: theme.other.border }}
    >
      <Stack gap="md">
        <Title order={4}>Order Summary</Title>
        {/* every row is one line: labels may truncate, amounts never wrap or move */}
        <Stack gap="xs">
          <Group justify="space-between" wrap="nowrap">
            <Text lineClamp={1}>
              Subtotal ({count} {count === 1 ? "item" : "items"})
            </Text>
            <Text c="black" style={{ flexShrink: 0 }}>
              ${subtotal.toFixed(2)}
            </Text>
          </Group>
          {savings > 0 && (
            <Group justify="space-between" wrap="nowrap">
              <Text>You save</Text>
              <Text c="green" fw={600} style={{ flexShrink: 0 }}>
                −${savings.toFixed(2)}
              </Text>
            </Group>
          )}
          <Group justify="space-between" wrap="nowrap">
            <Text lineClamp={1} style={{ minWidth: 0 }}>
              Shipping
              {shipping && (
                <Text span size="sm">
                  {" "}
                  · {shipping.label}
                </Text>
              )}
            </Text>
            <Text c="black" style={{ flexShrink: 0 }}>
              {shipping ? `$${shippingCost.toFixed(2)}` : "At checkout"}
            </Text>
          </Group>
        </Stack>
        <Divider color={theme.other.border} />
        <Group justify="space-between" wrap="nowrap">
          <Text fw={700} fz="lg" c="black">
            Total
          </Text>
          <Text fw={700} fz="lg" c="black" style={{ flexShrink: 0 }}>
            ${total.toFixed(2)}
          </Text>
        </Group>
        {action}
      </Stack>
    </Paper>
  );
}

export default CartSummary;
