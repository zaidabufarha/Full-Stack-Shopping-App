import { ActionIcon, Anchor, Box, Group, Image, Stack, Text } from "@mantine/core";
import { IconMinus, IconPlus } from "@tabler/icons-react";
import { Link } from "react-router-dom";
import type { GetCartQuery } from "../../../gql/operations";
import { argbToHex } from "../color";
import RemoveConfirm from "./RemoveConfirm";

export type CartItem = GetCartQuery["cart"][number];

type CartRowProps = {
  item: CartItem;
  onChangeQuantity: (next: number) => void;
};

/** One line of the cart: thumbnail, name, unit price, stepper, line total. */
function CartRow({ item, onChangeQuantity }: CartRowProps) {
  const { product, quantity } = item;
  const unit = product.price * (1 - product.discount / 100);

  return (
    <Group justify="space-between" wrap="nowrap" gap="lg">
      <Group gap="md" wrap="nowrap" style={{ flex: 1, minWidth: 0 }}>
        <Box
          w={64}
          h={64}
          bg={argbToHex(product.color)}
          display="flex"
          style={{ borderRadius: 999, alignItems: "center", justifyContent: "center", flexShrink: 0 }}
        >
          <Image src={product.image_path} w={48} h={48} fit="contain" />
        </Box>
        <Stack gap={2} style={{ minWidth: 0 }}>
          <Anchor component={Link} to={`/product/${product.id}`} fw={600} c="black" fz="md" lineClamp={1}>
            {product.name}
          </Anchor>
          <Group gap={6} wrap="nowrap">
            <Text size="sm" fw={600} c="green">
              ${unit.toFixed(2)}
            </Text>
            {product.discount > 0 && (
              <Text size="sm" td="line-through">
                ${product.price.toFixed(2)}
              </Text>
            )}
            <Text size="sm">/{product.amount}</Text>
          </Group>
        </Stack>
      </Group>

      <Group gap={4} wrap="nowrap" style={{ flexShrink: 0 }}>
        {quantity === 1 ? (
          <RemoveConfirm name={product.name} onConfirm={() => onChangeQuantity(0)} iconSize={16} />
        ) : (
          <ActionIcon
            variant="subtle"
            color="gray"
            aria-label="Decrease quantity"
            onClick={() => onChangeQuantity(quantity - 1)}
          >
            <IconMinus size={16} />
          </ActionIcon>
        )}
        <Text w={32} ta="center" fw={600} c="black">
          {quantity}
        </Text>
        <ActionIcon
          variant="subtle"
          color="green"
          aria-label="Increase quantity"
          onClick={() => onChangeQuantity(quantity + 1)}
        >
          <IconPlus size={16} />
        </ActionIcon>
      </Group>

      <Text fw={700} c="black" w={90} ta="right" style={{ flexShrink: 0 }}>
        ${(unit * quantity).toFixed(2)}
      </Text>
    </Group>
  );
}

export default CartRow;
