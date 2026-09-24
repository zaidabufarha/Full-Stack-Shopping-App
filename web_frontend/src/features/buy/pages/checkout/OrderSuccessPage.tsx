import { Button, Container, Group, Stack, Text, ThemeIcon, Title } from "@mantine/core";
import { IconCircleCheck } from "@tabler/icons-react";
import { Link, Navigate, useParams } from "react-router-dom";
import { useAppSelector } from "../../../../app/hooks";

function OrderSuccessPage() {
  // only needed for the Track order link; the details live on that page
  const { orderId = "" } = useParams();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  return (
    <Container size="sm" py={100}>
      <Stack align="center" gap="md">
        <ThemeIcon variant="light" color="green" radius="xl" size={140}>
          <IconCircleCheck size={72} stroke={1.5} />
        </ThemeIcon>
        <Title order={2}>Order placed!</Title>
        <Text ta="center">Thanks for shopping with BigCart. Your order is on its way.</Text>
        <Group mt="md">
          <Button component={Link} to={`/account/orders/${orderId}`} h={50} fz="md" w={200}>
            Track order
          </Button>
          <Button component={Link} to="/" variant="light" color="green" h={50} fz="md" w={200}>
            Continue shopping
          </Button>
        </Group>
      </Stack>
    </Container>
  );
}

export default OrderSuccessPage;
