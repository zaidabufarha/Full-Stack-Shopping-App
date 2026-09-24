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
import { Navigate } from "react-router-dom";
import { useAddAddressMutation, useGetAddressesQuery } from "../../../account/accountApi";
import AddressForm from "../../../account/components/AddressForm";
import { useCheckoutParams } from "../../checkoutParams";

// sentinel value for the "add new" option; never a real id
const NEW_ADDRESS = "__new__";

function AddressStep() {
  const theme = useMantineTheme();
  const { shipping, addressId, setParam, goTo } = useCheckoutParams();
  const { data, isLoading, error } = useGetAddressesQuery();
  const [addAddress, addState] = useAddAddressMutation();
  const [adding, setAdding] = useState(false);

  // a shipping method has to be chosen first
  if (!shipping) return <Navigate to="/checkout/delivery" replace />;

  const addresses = data?.address ?? [];
  const defaultId = data?.default_address_id ?? null;
  // URL choice wins, then the saved default, then the only/first one
  const selectedId =
    (addressId && addresses.some((a) => a.id === addressId) ? addressId : null) ??
    (defaultId && addresses.some((a) => a.id === defaultId) ? defaultId : null) ??
    addresses[0]?.id ??
    null;

  // "Add a new address" is both an option in the dropdown and a link under it.
  // With nothing saved yet the new-address form is simply open. Otherwise the
  // chosen address is shown in the same form, locked, so the details are visible.
  const showForm = adding || (data !== undefined && addresses.length === 0);
  const selected = addresses.find((a) => a.id === selectedId);

  return (
    <Paper withBorder radius="lg" p="xl" bg="white" style={{ borderColor: theme.other.border }}>
      <Stack gap="lg">
        <Stack gap={4}>
          <Title order={2}>Shipping Address</Title>
          <Text size="sm">Where should we deliver?</Text>
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
              label="Deliver to"
              data={[
                ...addresses.map((a) => ({
                  value: a.id,
                  label: `${a.name} — ${a.street}, ${a.city}${a.id === defaultId ? " (default)" : ""}`,
                })),
                { value: NEW_ADDRESS, label: "＋ Add a new address" },
              ]}
              value={showForm ? NEW_ADDRESS : selectedId}
              onChange={(v) => {
                if (v === NEW_ADDRESS) {
                  setAdding(true);
                } else {
                  setAdding(false);
                  setParam("address", v);
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
                  Add a new address
                </Group>
              </Anchor>
            )}

            <Paper withBorder radius="md" p="lg" style={{ borderColor: theme.other.border }}>
              <Stack gap="md">
                <Text fw={600} c="black">
                  {showForm ? "New address" : "Delivery details"}
                </Text>
                {showForm ? (
                  <AddressForm
                    isSaving={addState.isLoading}
                    error={addState.error}
                    onSubmit={async (input) => {
                      try {
                        // saved to the account like any other address, then selected here
                        const created = await addAddress({ input }).unwrap();
                        setParam("address", created.id);
                        setAdding(false);
                      } catch {
                        // shown inside the form
                      }
                    }}
                    onCancel={() => setAdding(false)}
                  />
                ) : (
                  selected && (
                    // key remounts the form when the selection changes, so initial values refresh
                    <AddressForm
                      key={selected.id}
                      initial={selected}
                      isCurrentDefault={selected.id === defaultId}
                      readOnly
                    />
                  )
                )}
              </Stack>
            </Paper>
          </>
        )}

        <Group justify="space-between">
          <Button variant="subtle" color="gray" h={48} fz="md" onClick={() => goTo("delivery")}>
            Back
          </Button>
          <Button
            h={48}
            fz="md"
            w={180}
            // nothing to continue with while the new-address form is open
            disabled={!selectedId || showForm}
            onClick={() => selectedId && goTo("payment", { address: selectedId })}
          >
            Next
          </Button>
        </Group>
      </Stack>
    </Paper>
  );
}

export default AddressStep;
