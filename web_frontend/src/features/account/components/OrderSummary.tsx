import { Group, Stack, Text, ThemeIcon } from "@mantine/core";
import { IconPackage } from "@tabler/icons-react";
import { formatDate, money } from "../format";

type OrderSummaryProps = {
  order: {
    id: string;
    date_placed: string;
    total_amount: number;
    order_item: { quantity: number }[];
  };
};

/** Order #, placed date, item count and total — the header of an order card. */
function OrderSummary({ order }: OrderSummaryProps) {
  const items = order.order_item.reduce((n, item) => n + item.quantity, 0);
  return (
    <Group gap="md" wrap="nowrap">
      <ThemeIcon variant="light" color="green" radius="xl" size={48}>
        <IconPackage size={22} />
      </ThemeIcon>
      <Stack gap={2}>
        <Text fw={600} c="black">
          Order #{order.id}
        </Text>
        <Text size="xs">Placed on {formatDate(order.date_placed)}</Text>
        <Text size="xs">
          <Text span fw={600} c="black">
            Items:
          </Text>{" "}
          {items}
          {"   "}
          <Text span fw={600} c="black">
            Total:
          </Text>{" "}
          {money(order.total_amount)}
        </Text>
      </Stack>
    </Group>
  );
}

export default OrderSummary;
