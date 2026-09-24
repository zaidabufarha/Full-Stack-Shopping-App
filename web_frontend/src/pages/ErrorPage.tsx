import { Button, Container, Stack, Text, ThemeIcon, Title } from "@mantine/core";
import { IconAlertTriangle } from "@tabler/icons-react";
import { isRouteErrorResponse, Link, useRouteError } from "react-router-dom";

/**
 * Rendered by React Router in place of whatever threw during render. Hung on
 * a pathless route inside RootLayout, so nav and footer stay up around it;
 * also on the root route as a last resort for the layout itself failing.
 */
function ErrorPage() {
  const error = useRouteError();

  // a thrown Response (e.g. a loader 404) vs. an ordinary exception
  const detail = isRouteErrorResponse(error)
    ? `${error.status} ${error.statusText}`
    : error instanceof Error
      ? error.message
      : null;

  return (
    <Container size="sm" py={100}>
      <Stack align="center" gap="md">
        <ThemeIcon variant="light" color="red" radius="xl" size={120}>
          <IconAlertTriangle size={60} stroke={1.5} />
        </ThemeIcon>
        <Title order={2}>Something went wrong</Title>
        <Text ta="center">
          The page hit an error it couldn't recover from. Your cart and account are safe.
        </Text>
        {detail && (
          <Text size="sm" ta="center" style={{ fontFamily: "monospace" }}>
            {detail}
          </Text>
        )}
        <Button component={Link} to="/" h={50} fz="md" w={240} mt="md">
          Back to home
        </Button>
      </Stack>
    </Container>
  );
}

export default ErrorPage;
