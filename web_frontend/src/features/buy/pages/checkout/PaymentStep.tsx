import {
  Anchor,
  Button,
  Center,
  Group,
  Loader,
  Paper,
  Select,
  Stack,
  Text,
  Title,
  useMantineTheme,
} from "@mantine/core";
import { IconPlus } from "@tabler/icons-react";
import { useState } from "react";
import { Navigate, useNavigate } from "react-router-dom";
import { useAddCardMutation, useGetCreditCardsQuery } from "../../../account/accountApi";
import CardForm from "../../../account/components/CardForm";
import { PROCESSOR_LABELS } from "../../../account/processors";
import { useCreateOrderMutation } from "../../buyApi";
import { useCheckoutParams } from "../../checkoutParams";
import { findShipping } from "../../shipping";

// sentinel value for the "add new" option; never a real id
const NEW_CARD = "__new__";

function PaymentStep() {
  const theme = useMantineTheme();
  const navigate = useNavigate();
  const { shipping, addressId, cardId, setParam, goTo } = useCheckoutParams();
  const { data, isLoading, error } = useGetCreditCardsQuery();
  const [addCard, addState] = useAddCardMutation();
  const [createOrder, orderState] = useCreateOrderMutation();
  const [adding, setAdding] = useState(false);

  // the earlier steps have to be done first
  const method = findShipping(shipping);
  if (!method) return <Navigate to="/checkout/delivery" replace />;
  if (!addressId) return <Navigate to={{ pathname: "/checkout/address", search: `?shipping=${shipping}` }} replace />;

  const cards = data?.credit_card ?? [];
  const defaultId = data?.default_credit_card_id ?? null;
  const selectedId =
    (cardId && cards.some((c) => c.id === cardId) ? cardId : null) ??
    (defaultId && cards.some((c) => c.id === defaultId) ? defaultId : null) ??
    cards[0]?.id ??
    null;

  // same pattern as the address step: "add new" in the dropdown and as a link,
  // and the chosen card shown locked in the same form
  const showForm = adding || (data !== undefined && cards.length === 0);
  const selected = cards.find((c) => c.id === selectedId);

  const placeOrder = async () => {
    if (!selectedId) return;
    try {
      const order = await createOrder({
        addressId,
        cardId: selectedId,
        shippingMethod: method.label,
      }).unwrap();
      navigate(`/checkout/success/${order.id}`, { replace: true });
    } catch {
      // shown below via orderState.error
    }
  };

  return (
    <Paper withBorder radius="lg" p="xl" bg="white" style={{ borderColor: theme.other.border }}>
      <Stack gap="lg">
        <Stack gap={4}>
          <Title order={2}>Payment</Title>
          <Text size="sm">Pay with a saved card, or add one.</Text>
        </Stack>

        {isLoading ? (
          <Center h={120}>
            <Loader color="green" />
          </Center>
        ) : error ? (
          <Text c="red">{error.message}</Text>
        ) : (
          <>
            <Select
              label="Pay with"
              data={[
                ...cards.map((c) => ({
                  value: c.id,
                  label: `${PROCESSOR_LABELS[c.processor.toLowerCase()] ?? c.processor} •••• ${c.last4}${
                    c.id === defaultId ? " (default)" : ""
                  }`,
                })),
                { value: NEW_CARD, label: "＋ Add a new card" },
              ]}
              value={showForm ? NEW_CARD : selectedId}
              onChange={(v) => {
                if (v === NEW_CARD) {
                  setAdding(true);
                } else {
                  setAdding(false);
                  setParam("card", v);
                }
              }}
              allowDeselect={false}
              size="md"
            />

            {!showForm && (
              <Anchor
                component="button"
                type="button"
                c="green"
                fw={600}
                fz="sm"
                onClick={() => setAdding(true)}
              >
                <Group gap={4}>
                  <IconPlus size={16} />
                  Add a new card
                </Group>
              </Anchor>
            )}

            <Paper withBorder radius="md" p="lg" style={{ borderColor: theme.other.border }}>
              <Stack gap="md">
                <Text fw={600} c="black">
                  {showForm ? "New card" : "Card details"}
                </Text>
                {showForm ? (
                  <CardForm
                    isSaving={addState.isLoading}
                    error={addState.error}
                    onSubmit={async (input) => {
                      try {
                        const created = await addCard({ input }).unwrap();
                        setParam("card", created.id);
                        setAdding(false);
                      } catch {
                        // shown inside the form
                      }
                    }}
                    onCancel={() => setAdding(false)}
                  />
                ) : (
                  selected && (
                    <CardForm
                      key={selected.id}
                      initial={{
                        card_holder_name: selected.card_holder_name,
                        expiry_date: selected.expiry_date,
                        processor: selected.processor.toLowerCase(),
                        last4: selected.last4,
                      }}
                      isCurrentDefault={selected.id === defaultId}
                      readOnly
                    />
                  )
                )}
              </Stack>
            </Paper>
          </>
        )}

        {orderState.error && (
          <Text c="red" ta="center">
            {orderState.error.message}
          </Text>
        )}

        <Group justify="space-between">
          <Button variant="subtle" color="gray" h={48} fz="md" onClick={() => goTo("address")}>
            Back
          </Button>
          <Button
            h={48}
            fz="md"
            w={200}
            disabled={!selectedId || showForm}
            loading={orderState.isLoading}
            onClick={placeOrder}
          >
            Place order
          </Button>
        </Group>
      </Stack>
    </Paper>
  );
}

export default PaymentStep;
