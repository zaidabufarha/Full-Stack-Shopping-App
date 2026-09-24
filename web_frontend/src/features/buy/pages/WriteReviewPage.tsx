import {
  Button,
  Container,
  Paper,
  Rating,
  Stack,
  Text,
  Textarea,
  Title,
  useMantineTheme,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { Navigate, useNavigate, useParams } from "react-router-dom";
import { useAppSelector } from "../../../app/hooks";
import { useFieldProps } from "../../auth/useFieldProps";
import { useAddReviewMutation, useGetProductsQuery } from "../buyApi";
import Crumbs, { productCrumbs } from "../components/Crumbs";

function WriteReviewPage() {
  const { id = "" } = useParams();
  const navigate = useNavigate();
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));

  const { data: products = [] } = useGetProductsQuery();
  const product = products.find((p) => p.id === id);

  const [addReview, { isLoading, error }] = useAddReviewMutation();

  const form = useForm({
    mode: "controlled",
    initialValues: { rating: 0, comment: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    // only the rating is required — the comment is optional in the DB, the
    // schema (String! but "" is fine), the resolver and the Flutter form alike
    validate: {
      rating: (v) => (v > 0 ? null : "Tap a star to rate it"),
    },
  });
  const { field, revealAll } = useFieldProps(form);

  // addReview is behind checkAuth on the backend
  if (!isLoggedIn) return <Navigate to="/login" replace />;

  const handleSubmit = async (values: typeof form.values) => {
    try {
      await addReview({
        productId: id,
        rating: values.rating,
        comment: values.comment.trim(),
      }).unwrap();
      // the list can't be empty anymore, so it's safe to land there
      navigate(`/product/${id}/reviews`, { replace: true });
    } catch {
      // rendered below via `error`
    }
  };

  return (
    <Container size="sm" w="100%" py={40}>
      <Stack gap="xl">
        <Crumbs
          items={
            product
              ? productCrumbs(product, "Write a review")
              : [{ label: "Home", to: "/" }, { label: "Write a review" }]
          }
        />

        <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
          <Stack gap="xl" align="center">
            <Stack gap={4} align="center">
              <Title order={2}>What do you think?</Title>
              <Text ta="center">Please give your rating by clicking on the stars below</Text>
            </Stack>

            <Stack gap={6} align="center">
              <Rating
                size="xl"
                fractions={2}
                color="yellow"
                value={form.values.rating}
                onChange={(v) => form.setFieldValue("rating", v)}
              />
              {form.errors.rating && (
                <Text size="sm" c="red">
                  {form.errors.rating}
                </Text>
              )}
            </Stack>

            <Paper
              withBorder
              radius="md"
              p="md"
              w="100%"
              style={{ borderColor: theme.other.border }}
            >
              <Textarea
                variant="unstyled"
                placeholder="Tell us about your experience (optional)"
                autosize
                minRows={5}
                {...field("comment")}
              />
            </Paper>

            {error && (
              <Text c="red" ta="center">
                {error.message}
              </Text>
            )}

            <Button type="submit" fullWidth h={50} fz="md" loading={isLoading}>
              Submit review
            </Button>
          </Stack>
        </form>
      </Stack>
    </Container>
  );
}

export default WriteReviewPage;
