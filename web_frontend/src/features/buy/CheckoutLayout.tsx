import { Box, Center, Container, Group, Loader, Stack, Stepper } from "@mantine/core";
import { IconCreditCard, IconMapPin, IconTruck } from "@tabler/icons-react";
import { Navigate, Outlet, useLocation } from "react-router-dom";
import { useAppSelector } from "../../app/hooks";
import { useGetCartQuery } from "./buyApi";
import CartSummary from "./components/CartSummary";
import { useCheckoutParams, type CheckoutStep } from "./checkoutParams";
import { findShipping } from "./shipping";

const STEPS: { step: CheckoutStep; label: string; icon: typeof IconTruck }[] = [
  { step: "delivery", label: "Delivery", icon: IconTruck },
  { step: "address", label: "Address", icon: IconMapPin },
  { step: "payment", label: "Payment", icon: IconCreditCard },
];

/**
 * Layout route for /checkout/*: the Delivery › Address › Payment indicator,
 * the current step through <Outlet />, and the order summary alongside, with
 * the shipping line following the chosen method. Nothing to check out with an
 * empty cart, so that bounces back to /cart.
 */
function CheckoutLayout() {
  const { pathname } = useLocation();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data: cart = [], isLoading } = useGetCartQuery(undefined, { skip: !isLoggedIn });
  const { shipping, goTo } = useCheckoutParams();

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  if (isLoading) {
    return (
      <Center h={400}>
        <Loader color="green" />
      </Center>
    );
  }

  if (cart.length === 0) return <Navigate to="/cart" replace />;

  const current = pathname.split("/")[2] as CheckoutStep | undefined;
  const active = Math.max(0, STEPS.findIndex((s) => s.step === current));

  return (
    <Container size={1440} w="100%" py={40}>
      <Stack gap={40}>
        <Stepper
          active={active}
          color="green"
          // completed steps are clickable to go back; you can't skip ahead
          onStepClick={(i) => i < active && goTo(STEPS[i].step)}
          allowNextStepsSelect={false}
          maw={640}
          mx="auto"
          w="100%"
        >
          {STEPS.map(({ step, label, icon: Icon }) => (
            <Stepper.Step key={step} label={label} icon={<Icon size={18} />} />
          ))}
        </Stepper>

        <Group align="flex-start" gap={40} wrap="nowrap">
          <Box style={{ flex: 1, minWidth: 0 }}>
            <Outlet />
          </Box>
          <Stack w={420} style={{ flexShrink: 0 }}>
            <CartSummary items={cart} shipping={findShipping(shipping)} />
          </Stack>
        </Group>
      </Stack>
    </Container>
  );
}

export default CheckoutLayout;
