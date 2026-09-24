import {
  ActionIcon,
  Avatar,
  Center,
  Container,
  Divider,
  Group,
  Loader,
  Paper,
  Rating,
  Stack,
  Text,
  useMantineTheme,
} from "@mantine/core";
import { IconPlus } from "@tabler/icons-react";
import { Link, Navigate, useParams } from "react-router-dom";
import { useGetProductReviewsQuery, useGetProductsQuery } from "../buyApi";
import Crumbs, { productCrumbs } from "../components/Crumbs";
import { timeAgo } from "../timeAgo";

function ReviewsPage() {
  const { id = "" } = useParams();
  const theme = useMantineTheme();

  const { data: products = [] } = useGetProductsQuery();
  const product = products.find((p) => p.id === id);

  const { data: reviews = [], isLoading, error } = useGetProductReviewsQuery(
    { productId: id },
    { skip: !id },
  );

  if (isLoading) {
    return (
      <Center h={400}>
        <Loader color="green" />
      </Center>
    );
  }

  if (error) {
    return (
      <Container size="md" py={60}>
        <Text c="red">{error.message}</Text>
      </Container>
    );
  }

  // There is never an empty reviews list: with nothing to show, the visitor
  // writes the first one instead.
  if (reviews.length === 0) {
    return <Navigate to={`/product/${id}/reviews/new`} replace />;
  }

  const average = reviews.reduce((sum, r) => sum + r.rating, 0) / reviews.length;

  return (
    <Container size="md" w="100%" py={40}>
      <Stack gap="xl">
        <Crumbs
          items={
            product
              ? productCrumbs(product, "Reviews")
              : [{ label: "Home", to: "/" }, { label: "Reviews" }]
          }
        />

        {/* the average is the heading — the crumb already says "Reviews" */}
        <Group justify="space-between" align="center">
          <Group gap="sm" align="center">
            <Text fw={700} fz={36} c="black" lh={1}>
              {average.toFixed(1)}
            </Text>
            <Rating value={average} fractions={4} readOnly color="yellow" size="xl" />
            <Text fz="lg">
              ({reviews.length} {reviews.length === 1 ? "review" : "reviews"})
            </Text>
          </Group>
          <ActionIcon
            component={Link}
            to={`/product/${id}/reviews/new`}
            variant="filled"
            color="green"
            radius="xl"
            size="xl"
            aria-label="Write a review"
          >
            <IconPlus />
          </ActionIcon>
        </Group>

        <Stack gap="md">
          {reviews.map((review) => (
            <Paper
              key={review.id}
              withBorder
              radius="md"
              p="lg"
              style={{ borderColor: theme.other.border }}
            >
              <Stack gap="sm">
                <Group gap="sm">
                  <Avatar src={review.user?.image_path} radius="xl" size="md" />
                  <Stack gap={0}>
                    <Text fw={600} c="black">
                      {review.user?.name ?? "Anonymous"}
                    </Text>
                    <Text size="xs">{timeAgo(review.created_at)}</Text>
                  </Stack>
                </Group>
                <Divider color={theme.other.border} />
                <Group gap={8}>
                  <Text fw={600} c="black" size="sm">
                    {review.rating.toFixed(1)}
                  </Text>
                  <Rating value={review.rating} fractions={2} readOnly size="sm" color="yellow" />
                </Group>
                {review.comment && <Text>{review.comment}</Text>}
              </Stack>
            </Paper>
          ))}
        </Stack>
      </Stack>
    </Container>
  );
}

export default ReviewsPage;
