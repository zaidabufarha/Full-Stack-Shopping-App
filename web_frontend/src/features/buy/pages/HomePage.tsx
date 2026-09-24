import {
  Box,
  Button,
  Center,
  Chip,
  Container,
  Group,
  Image,
  Loader,
  NumberInput,
  Rating,
  SimpleGrid,
  Stack,
  Text,
  Title,
} from "@mantine/core";
import { Navigate, useNavigate, useSearchParams } from "react-router-dom";
import aisle from "../../../assets/buy_aisle.jpg";
import { useGetCategoriesQuery, useGetProductsQuery } from "../buyApi";
import CategoryIcon from "../components/CategoryIcon";
import { IconHeartFilled } from "@tabler/icons-react";
import ProductCard, { type CardProduct } from "../components/ProductCard";
import { slugify } from "../slug";
import { useCart } from "../useCart";

// Each chip is a product boolean. "All" is the absence of a filter, so it
// doesn't need an entry — and the URL is the state, per the rest of the app.
const FILTERS = [
  { value: "new", label: "New", match: (p: CardProduct) => p.is_new },
  { value: "deals", label: "Deals", match: (p: CardProduct) => p.discount > 0 },
  {
    value: "free-shipping",
    label: "Free Shipping",
    match: (p: CardProduct) => p.free_shipping,
  },
  {
    value: "same-day",
    label: "Same Day Delivery",
    match: (p: CardProduct) => p.same_day_delivery,
  },
];

/** "12.5" -> 12.5, and anything missing or non-numeric -> undefined. */
function numberParam(raw: string | null): number | undefined {
  if (raw === null || raw === "") return undefined;
  const n = Number(raw);
  return Number.isFinite(n) ? n : undefined;
}

type HomePageProps = {
  /** /favorites renders this same page with only the user's favorites. */
  favorites?: boolean;
};

function HomePage({ favorites = false }: HomePageProps) {
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();
  // Every filter lives in the URL, e.g.
  //   /?search=apple&category=fruits&filter=deals&filter=new&min=2&max=10&rating=3
  // `filter` repeats so several chips can apply at once.
  const activeFilters = searchParams.getAll("filter");
  // a name slug, e.g. "edible-oil" — see slug.ts
  const categorySlug = searchParams.get("category");
  const minPrice = numberParam(searchParams.get("min"));
  const maxPrice = numberParam(searchParams.get("max"));
  const minRating = numberParam(searchParams.get("rating")) ?? 0;
  const search = searchParams.get("search")?.trim() ?? "";

  // Sets or clears one param, keeping the rest. `replace` is for inputs that
  // change on every keystroke, so typing "12" isn't two back-button steps.
  const setParam = (key: string, value: string | null, replace = false) => {
    const next = new URLSearchParams(searchParams);
    if (value === null || value === "") next.delete(key);
    else next.set(key, value);
    setSearchParams(next, { replace });
  };

  const hasAnyFilter =
    search !== "" ||
    activeFilters.length > 0 ||
    categorySlug !== null ||
    minPrice !== undefined ||
    maxPrice !== undefined ||
    minRating > 0;

  // cart quantities + add/update/remove/favorite, shared with ProductPage
  const { isLoggedIn, quantityOf, changeQuantity, toggleFavorite } = useCart();

  const { data: categories = [] } = useGetCategoriesQuery();
  const { data: products = [], isLoading, error } = useGetProductsQuery();

  // A product must pass every active filter; an unset filter passes everything.
  // Price compares the base price (what the card shows), same as Flutter.
  const selected = FILTERS.filter((f) => activeFilters.includes(f.value));
  const visibleProducts = products.filter(
    (p) =>
      selected.every((f) => f.match(p)) &&
      (categorySlug === null ||
        (p.category !== null && slugify(p.category.name) === categorySlug)) &&
      (minPrice === undefined || p.price >= minPrice) &&
      (maxPrice === undefined || p.price <= maxPrice) &&
      p.rating >= minRating &&
      // case-insensitive name match, same as Flutter's search
      (search === "" || p.name.toLowerCase().includes(search.toLowerCase())) &&
      // is_favorite is per-user; the favorites route requires login below
      (!favorites || p.is_favorite),
  );

  // Unfiltered it's a showcase; filtered, the useful thing is how many matched,
  // since the active filters are already visible right above.
  const count = visibleProducts.length;
  const noun = search
    ? count === 1
      ? "result"
      : "results"
    : count === 1
      ? "product"
      : "products";
  const heading = favorites
    ? search
      ? `${count} favorite ${noun} for "${search}"`
      : `${count} favorite ${noun}`
    : !hasAnyFilter
      ? "Popular Products"
      : search
        ? `${count} ${noun} for "${search}"`
        : `${count} ${noun}`;

  // favorites are per-user, so the route only makes sense logged in
  if (favorites && !isLoggedIn) return <Navigate to="/login" replace />;

  return (
    <Stack gap={40} pb={60}>
      {/* hero */}
      <Box pos="relative" h={{ base: 260, md: 415 }}>
        <Image src={aisle} h="100%" fit="cover" />
        <Box
          pos="absolute"
          inset={0}
          display="flex"
          style={{
            alignItems: "flex-end",
            background:
              "linear-gradient(180deg, rgba(30,30,30,0) 0%, rgba(30,30,30,1) 100%)",
          }}
        >
          <Container size={1440} w="100%" pb={40}>
            <Stack gap={6}>
              <Title c="white" fz={{ base: 32, md: 52 }}>
                All Your Daily Needs, All in One Place!
              </Title>
              <Text c="white" fz={{ base: 16, md: 22 }}>
                Enjoy the convenience of shopping without having to leave your
                home.
              </Text>
            </Stack>
          </Container>
        </Box>
      </Box>

      <Container size={1440} w="100%">
        <Stack gap={40}>
          {/* categories */}
          <Stack gap="sm">
            <Title order={3}>Categories</Title>
            <Group gap="lg">
              {categories.map((category) => (
                <CategoryIcon
                  key={category.id}
                  category={category}
                  selected={slugify(category.name) === categorySlug}
                  // clicking the selected tile again clears it
                  onClick={() => {
                    const slug = slugify(category.name);
                    setParam("category", slug === categorySlug ? null : slug);
                  }}
                />
              ))}
            </Group>
          </Stack>

          {/* filters */}
          <Group
            justify="space-between"
            align="flex-end"
            gap="md"
            wrap="nowrap"
          >
            <Group gap="sm" wrap="nowrap" style={{ flexShrink: 0 }}>
              {isLoggedIn && (
                // Favorites is a route, not a URL param. It must sit OUTSIDE
                // Chip.Group: the group's context overrides any inner chip's
                // checked/onChange, which is why this one wouldn't toggle.
                <Chip
                  checked={favorites}
                  color="green.8"
                  size="md"
                  icon={<IconHeartFilled size={14} />}
                  onChange={(checked) =>
                    navigate({
                      pathname: checked ? "/favorites" : "/",
                      search: searchParams.toString(),
                    })
                  }
                >
                  Favorites
                </Chip>
              )}
              <Chip.Group
                multiple
                value={activeFilters.length ? activeFilters : ["all"]}
                onChange={(values) => {
                  // "All" is exclusive: picking it clears the rest, and picking
                  // anything else drops it
                  const pickedAll =
                    values.includes("all") && activeFilters.length > 0;
                  const next = new URLSearchParams(searchParams);
                  next.delete("filter");
                  if (!pickedAll) {
                    values
                      .filter((v) => v !== "all")
                      .forEach((v) => next.append("filter", v));
                  }
                  setSearchParams(next);
                }}
              >
                <Group gap="sm" wrap="nowrap">
                  <Chip value="all" color="green.8" size="md">
                    All
                  </Chip>
                  {FILTERS.map((f) => (
                    <Chip
                      key={f.value}
                      value={f.value}
                      color="green.8"
                      size="md"
                    >
                      {f.label}
                    </Chip>
                  ))}
                </Group>
              </Chip.Group>
            </Group>

            <Group
              gap="md"
              align="flex-end"
              wrap="nowrap"
              style={{ flexShrink: 0 }}
            >
              {/* first in a right-aligned group, so appearing doesn't shift the inputs */}
              <Button
                variant="subtle"
                color="gray"
                size="md"
                h={36}
                fz="md"
                px="sm"
                onClick={() => setSearchParams(new URLSearchParams())}
                // always laid out so the inputs never move; just hidden when idle
                style={{ visibility: hasAnyFilter ? "visible" : "hidden" }}
                tabIndex={hasAnyFilter ? 0 : -1}
                aria-hidden={!hasAnyFilter}
              >
                Clear filters
              </Button>
              <NumberInput
                label="Min price"
                placeholder="Min"
                w={110}
                min={0}
                prefix="$"
                decimalScale={2}
                value={minPrice ?? ""}
                onChange={(v) =>
                  setParam("min", v === "" ? null : String(v), true)
                }
              />
              <NumberInput
                label="Max price"
                placeholder="Max"
                w={110}
                min={0}
                prefix="$"
                decimalScale={2}
                value={maxPrice ?? ""}
                onChange={(v) =>
                  setParam("max", v === "" ? null : String(v), true)
                }
              />
              <Stack gap={4}>
                <Text size="sm" fw={500} c="black">
                  Min rating
                </Text>
                <Box h={36} display="flex" style={{ alignItems: "center" }}>
                  <Rating
                    value={minRating}
                    onChange={(v) => setParam("rating", String(v), true)}
                    color="yellow"
                  />
                </Box>
              </Stack>
            </Group>
          </Group>

          {/* products */}
          <Stack gap="sm">
            <Title order={3}>{heading}</Title>
            {isLoading ? (
              <Center h={200}>
                <Loader color="green" />
              </Center>
            ) : error ? (
              <Text c="red">{error.message}</Text>
            ) : visibleProducts.length === 0 ? (
              <Text>
                {favorites && !hasAnyFilter
                  ? "You haven't favorited anything yet. Tap the heart on a product to save it here."
                  : search
                    ? `No products match "${search}" with these filters.`
                    : "No products match these filters."}
              </Text>
            ) : (
              <SimpleGrid cols={{ base: 1, sm: 2, md: 3, lg: 4 }} spacing="lg">
                {visibleProducts.map((product) => (
                  <ProductCard
                    key={product.id}
                    product={product}
                    quantity={quantityOf(product.id)}
                    onChangeQuantity={(next) => changeQuantity(product, next)}
                    onToggleFavorite={() => toggleFavorite(product)}
                  />
                ))}
              </SimpleGrid>
            )}
          </Stack>
        </Stack>
      </Container>
    </Stack>
  );
}

export default HomePage;
