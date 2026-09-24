import {
  ActionIcon,
  Badge,
  Box,
  Divider,
  Group,
  Image,
  Paper,
  Stack,
  Text,
  useMantineTheme,
} from "@mantine/core";
import {
  IconHeart,
  IconHeartFilled,
  IconMinus,
  IconPlus,
  IconShoppingCart,
} from "@tabler/icons-react";
import type { GetProductsQuery } from "../../../gql/operations";
import { argbToHex } from "../color";

export type CardProduct = GetProductsQuery["products"][number];

type ProductCardProps = {
  product: CardProduct;
  /** How many are in the cart right now; 0 shows the add button. */
  quantity: number;
  onChangeQuantity: (next: number) => void;
  onToggleFavorite: () => void;
};

// Right-hand strip: the heart in a square cell at the top, and below it a cart
// button that becomes a vertical + / qty / − stepper. Fixed width so the card
// never reflows.
const STRIP_WIDTH = 56;

function ProductCard({
  product,
  quantity,
  onChangeQuantity,
  onToggleFavorite,
}: ProductCardProps) {
  const theme = useMantineTheme();

  return (
    <Paper
      withBorder
      radius="md"
      h={200}
      style={{ borderColor: theme.other.border, overflow: "hidden" }}
    >
      <Group gap={0} wrap="nowrap" h="100%" align="stretch">
        {/* main area: image, badges, name, price */}
        <Box pos="relative" p="md" style={{ flex: 1, minWidth: 0 }}>
          {product.is_new ? (
            <Badge pos="absolute" top={12} left={12} color="#E8AD41" variant="light">
              New
            </Badge>
          ) : product.discount > 0 ? (
            <Badge pos="absolute" top={12} left={12} color="#F56262" variant="light">
              -{product.discount}%
            </Badge>
          ) : null}

          <Stack gap={4} h="100%" justify="space-between">
            <Box
              w={100}
              h={100}
              mx="auto"
              bg={argbToHex(product.color)}
              display="flex"
              style={{
                borderRadius: 999,
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              <Image src={product.image_path} w={80} h={80} fit="contain" />
            </Box>

            <Stack gap={0}>
              <Text fw={600} c="black" lineClamp={1}>
                {product.name}
              </Text>
              <Group gap={4} wrap="nowrap">
                <Text fw={600} c="green">
                  ${product.price.toFixed(2)}
                </Text>
                <Text size="xs">/{product.amount}</Text>
              </Group>
            </Stack>
          </Stack>
        </Box>

        <Divider orientation="vertical" color={theme.other.border} />

        {/* right strip: heart on top, cart control in the space below */}
        <Stack gap={0} w={STRIP_WIDTH} style={{ flexShrink: 0 }}>
          <Box
            h={STRIP_WIDTH}
            display="flex"
            style={{ alignItems: "center", justifyContent: "center" }}
          >
            <ActionIcon
              variant="subtle"
              color="red"
              aria-label={
                product.is_favorite ? "Remove from favorites" : "Add to favorites"
              }
              onClick={onToggleFavorite}
            >
              {product.is_favorite ? <IconHeartFilled /> : <IconHeart />}
            </ActionIcon>
          </Box>

          <Divider color={theme.other.border} />

          <Box
            display="flex"
            style={{ flex: 1, alignItems: "center", justifyContent: "center" }}
          >
            {quantity === 0 ? (
              <ActionIcon
                variant="subtle"
                color="green"
                size="lg"
                aria-label="Add to cart"
                onClick={() => onChangeQuantity(1)}
              >
                <IconShoppingCart size={22} />
              </ActionIcon>
            ) : (
              <Stack gap={0} h="100%" justify="space-between" align="center" py="sm">
                <ActionIcon
                  variant="subtle"
                  color="green"
                  aria-label="Increase quantity"
                  onClick={() => onChangeQuantity(quantity + 1)}
                >
                  <IconPlus size={18} />
                </ActionIcon>
                <Text fw={600} c="black">
                  {quantity}
                </Text>
                <ActionIcon
                  variant="subtle"
                  color="gray"
                  aria-label="Decrease quantity"
                  onClick={() => onChangeQuantity(quantity - 1)}
                >
                  <IconMinus size={18} />
                </ActionIcon>
              </Stack>
            )}
          </Box>
        </Stack>
      </Group>
    </Paper>
  );
}

export default ProductCard;
