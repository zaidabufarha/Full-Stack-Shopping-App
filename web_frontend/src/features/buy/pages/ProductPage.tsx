import {
  ActionIcon,
  Anchor,
  Badge,
  Box,
  Button,
  Center,
  Container,
  Divider,
  Grid,
  Group,
  Image,
  Loader,
  Paper,
  Rating,
  SimpleGrid,
  Stack,
  Text,
  Title,
  UnstyledButton,
  useMantineTheme,
} from "@mantine/core";
import {
  IconCheck,
  IconChevronRight,
  IconHeart,
  IconHeartFilled,
  IconMinus,
  IconPlus,
  IconShare,
  IconShoppingCart,
} from "@tabler/icons-react";
import { useEffect, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { useGetProductReviewsQuery, useGetProductsQuery } from "../buyApi";
import { argbToHex } from "../color";
import Crumbs, { productCrumbs } from "../components/Crumbs";
import ProductCard from "../components/ProductCard";
import { useCart } from "../useCart";

const OTHER_PRODUCTS_LIMIT = 8;

function ProductPage() {
  const { id = "" } = useParams();
  const navigate = useNavigate();
  const theme = useMantineTheme();
  const { isLoggedIn, quantityOf, changeQuantity, toggleFavorite } = useCart();

  // The product comes out of the same cached list the home page uses, so
  // arriving from a card costs no request. A direct visit fetches the list.
  const { data: products = [], isLoading, error } = useGetProductsQuery();
  const product = products.find((p) => p.id === id);

  const { data: reviews = [] } = useGetProductReviewsQuery(
    { productId: id },
    { skip: !id },
  );

  const [expanded, setExpanded] = useState(false);
  const [copied, setCopied] = useState(false);

  // navigating between "other products" would otherwise keep the old scroll
  useEffect(() => {
    window.scrollTo({ top: 0 });
    setExpanded(false);
  }, [id]);

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

  if (!product) {
    return (
      <Container size={1440} py={60}>
        <Stack gap="sm">
          <Title order={3}>Product not found</Title>
          <Anchor component={Link} to="/">
            Back to all products
          </Anchor>
        </Stack>
      </Container>
    );
  }

  const inCart = quantityOf(product.id);
  const unitPrice = product.price * (1 - product.discount / 100);

  const otherProducts = products
    .filter((p) => p.id !== product.id && p.category?.id === product.category?.id)
    .slice(0, OTHER_PRODUCTS_LIMIT);

  // The star bar is the way into reviews. There's never an empty list page:
  // with no reviews yet it goes straight to writing the first one.
  const reviewsPath = `/product/${product.id}/reviews`;
  const reviewsTarget = reviews.length === 0 ? `${reviewsPath}/new` : reviewsPath;

  const handleShopNow = () => {
    if (!isLoggedIn) {
      navigate("/login");
      return;
    }
    if (inCart === 0) changeQuantity(product, 1);
    navigate("/cart");
  };

  const handleShare = async () => {
    try {
      await navigator.clipboard.writeText(window.location.href);
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {
      // clipboard blocked (http, permissions) — nothing useful to show
    }
  };

  return (
    <Container size={1440} w="100%" py={40}>
      <Stack gap={48}>
        <Crumbs items={productCrumbs(product)} />

        <Grid gap={48} align="stretch">
          {/* image */}
          <Grid.Col span={{ base: 12, md: 6 }}>
            <Paper
              withBorder
              radius="lg"
              h="100%"
              mih={460}
              display="flex"
              style={{
                borderColor: theme.other.border,
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              <Box
                w={300}
                h={300}
                bg={argbToHex(product.color)}
                display="flex"
                style={{
                  borderRadius: 999,
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                <Image src={product.image_path} w={240} h={240} fit="contain" />
              </Box>
            </Paper>
          </Grid.Col>

          {/* details */}
          <Grid.Col span={{ base: 12, md: 6 }}>
            <Stack gap="lg" py="sm">
              <Group justify="space-between" align="flex-start">
                <Text size="sm">{product.category?.name ?? "Product"}</Text>
                <Group gap="xs">
                  <ActionIcon
                    variant="subtle"
                    color="gray"
                    aria-label="Copy link"
                    onClick={handleShare}
                  >
                    {copied ? <IconCheck color="var(--mantine-color-green-6)" /> : <IconShare />}
                  </ActionIcon>
                  <ActionIcon
                    variant="subtle"
                    color="red"
                    aria-label={
                      product.is_favorite ? "Remove from favorites" : "Add to favorites"
                    }
                    onClick={() => toggleFavorite(product)}
                  >
                    {product.is_favorite ? <IconHeartFilled /> : <IconHeart />}
                  </ActionIcon>
                </Group>
              </Group>

              <Stack gap={4}>
                <Title order={1} c="black">
                  {product.name}
                </Title>
                <Group gap={8} align="baseline">
                  <Text fw={700} fz={28} c="green">
                    ${unitPrice.toFixed(2)}
                  </Text>
                  {product.discount > 0 && (
                    <Text td="line-through" c="dimmed">
                      ${product.price.toFixed(2)}
                    </Text>
                  )}
                  <Text size="sm">/{product.amount}</Text>
                </Group>
                <UnstyledButton
                  component={Link}
                  to={reviewsTarget}
                  aria-label={
                    reviews.length === 0 ? "Write the first review" : "See all reviews"
                  }
                >
                  <Group gap={8}>
                    <Text fw={700} c="black">
                      {product.rating.toFixed(1)}
                    </Text>
                    {/* readOnly Rating sets cursor:default on the stars, which would
                        override the link's pointer mid-hover — let clicks pass through */}
                    <Rating
                      value={product.rating}
                      fractions={4}
                      readOnly
                      color="yellow"
                      style={{ pointerEvents: "none" }}
                    />
                    <Text size="sm">
                      {reviews.length === 0
                        ? "(Be the first to review)"
                        : `(${reviews.length} ${reviews.length === 1 ? "review" : "reviews"})`}
                    </Text>
                    <IconChevronRight size={16} color="var(--mantine-color-dimmed)" />
                  </Group>
                </UnstyledButton>
              </Stack>

              <Group gap="xs">
                {product.is_new && (
                  <Badge color="#E8AD41" variant="light">
                    New
                  </Badge>
                )}
                {product.discount > 0 && (
                  <Badge color="#F56262" variant="light">
                    -{product.discount}%
                  </Badge>
                )}
                {product.free_shipping && (
                  <Badge color="green" variant="light">
                    Free shipping
                  </Badge>
                )}
                {product.same_day_delivery && (
                  <Badge color="green" variant="light">
                    Same day delivery
                  </Badge>
                )}
              </Group>

              <Stack gap={4}>
                <Text lineClamp={expanded ? undefined : 4}>{product.description}</Text>
                {product.description.length > 220 && (
                  <Anchor
                    component="button"
                    type="button"
                    size="sm"
                    c="green"
                    fw={600}
                    onClick={() => setExpanded((v) => !v)}
                  >
                    {expanded ? "Show less" : "Read more…"}
                  </Anchor>
                )}
              </Stack>

              <Divider color={theme.other.border} />

              {/* Same idea as the card strip: the add button turns into the
                  quantity stepper once the product is in the cart. Both
                  states fill the same slot, so nothing shifts. */}
              <Group grow>
                {inCart === 0 ? (
                  <Button
                    variant="light"
                    color="green"
                    h={50}
                    fz="md"
                    leftSection={<IconShoppingCart size={18} />}
                    onClick={() => changeQuantity(product, 1)}
                  >
                    Add to Cart · ${unitPrice.toFixed(2)}
                  </Button>
                ) : (
                  <Group
                    gap={0}
                    wrap="nowrap"
                    justify="space-between"
                    h={50}
                    px={6}
                    bg="green.0"
                    style={{ borderRadius: theme.radius.md }}
                  >
                    <ActionIcon
                      variant="subtle"
                      color="green"
                      size="lg"
                      aria-label="Decrease quantity"
                      onClick={() => changeQuantity(product, inCart - 1)}
                    >
                      <IconMinus size={18} />
                    </ActionIcon>
                    <Group gap={8} wrap="nowrap">
                      <Text fw={700} c="black">
                        {inCart}
                      </Text>
                      <Text size="sm" c="green" fw={600}>
                        ${(unitPrice * inCart).toFixed(2)}
                      </Text>
                    </Group>
                    <ActionIcon
                      variant="subtle"
                      color="green"
                      size="lg"
                      aria-label="Increase quantity"
                      onClick={() => changeQuantity(product, inCart + 1)}
                    >
                      <IconPlus size={18} />
                    </ActionIcon>
                  </Group>
                )}
                <Button h={50} fz="md" onClick={handleShopNow}>
                  Shop Now
                </Button>
              </Group>
            </Stack>
          </Grid.Col>
        </Grid>

        {/* other products in the same category */}
        {otherProducts.length > 0 && (
          <Stack gap="sm">
            <Group justify="space-between" align="baseline">
              <Title order={3}>Other Products</Title>
              {/* a bare "/" — "see all" means every product, no filters carried over */}
              <Anchor component={Link} to="/" size="sm" c="green">
                See all
              </Anchor>
            </Group>
            <SimpleGrid cols={{ base: 1, sm: 2, md: 3, lg: 4 }} spacing="lg">
              {otherProducts.map((p) => (
                <ProductCard
                  key={p.id}
                  product={p}
                  quantity={quantityOf(p.id)}
                  onChangeQuantity={(next) => changeQuantity(p, next)}
                  onToggleFavorite={() => toggleFavorite(p)}
                />
              ))}
            </SimpleGrid>
          </Stack>
        )}
      </Stack>
    </Container>
  );
}

export default ProductPage;
