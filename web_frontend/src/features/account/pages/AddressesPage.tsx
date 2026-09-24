import {
  ActionIcon,
  Badge,
  Collapse,
  Divider,
  Group,
  Paper,
  Stack,
  Text,
  useMantineTheme,
} from "@mantine/core";
import { IconChevronDown, IconChevronUp, IconMapPin, IconPlus } from "@tabler/icons-react";
import { useState } from "react";
import { useAppSelector } from "../../../app/hooks";
import { useAddAddressMutation, useGetAddressesQuery, useUpdateAddressMutation } from "../accountApi";
import AccountShell from "../components/AccountShell";
import AddressForm from "../components/AddressForm";

function AddressesPage() {
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data, isLoading, error } = useGetAddressesQuery(undefined, { skip: !isLoggedIn });

  const [addAddress, addState] = useAddAddressMutation();
  const [updateAddress, updateState] = useUpdateAddressMutation();

  // which card is expanded for editing, and whether the add form is open.
  // One at a time keeps the page calm — opening one closes the other.
  const [editingId, setEditingId] = useState<string | null>(null);
  const [adding, setAdding] = useState(false);

  const addresses = data?.address ?? [];
  const defaultId = data?.default_address_id ?? null;

  const openAdd = () => {
    setEditingId(null);
    setAdding(true);
  };
  const openEdit = (id: string) => {
    setAdding(false);
    setEditingId((current) => (current === id ? null : id));
  };

  return (
    <AccountShell
      title="My Address"
      description="Where your orders get delivered."
      isLoading={isLoading}
      error={error}
      action={
        <ActionIcon
          variant="filled"
          color="green"
          radius="xl"
          size="lg"
          aria-label="Add address"
          onClick={openAdd}
        >
          <IconPlus size={18} />
        </ActionIcon>
      }
    >
      <Stack gap="md">
        <Collapse expanded={adding}>
          <Paper withBorder radius="md" p="lg" style={{ borderColor: theme.other.border }}>
            <Stack gap="md">
              <Text fw={600} c="black">
                New address
              </Text>
              <AddressForm
                key={adding ? "open" : "closed"} // remount so a reopened form starts empty
                isSaving={addState.isLoading}
                error={addState.error}
                onSubmit={async (input) => {
                  try {
                    await addAddress({ input }).unwrap();
                    setAdding(false);
                  } catch {
                    // shown inside the form via addState.error
                  }
                }}
                onCancel={() => setAdding(false)}
              />
            </Stack>
          </Paper>
        </Collapse>

        {addresses.length === 0 && !adding && (
          <Text>No addresses saved yet. Use the + button to add one.</Text>
        )}

        {addresses.map((address) => {
          const isDefault = address.id === defaultId;
          const isEditing = editingId === address.id;
          return (
            <Paper
              key={address.id}
              withBorder
              radius="md"
              style={{
                borderColor: isEditing ? "var(--mantine-color-green-6)" : theme.other.border,
                overflow: "hidden",
              }}
            >
              {isDefault && (
                <Badge color="green" variant="light" radius={0} px="sm">
                  Default
                </Badge>
              )}
              <Group justify="space-between" align="flex-start" p="lg" wrap="nowrap">
                <Group gap="md" wrap="nowrap" align="flex-start">
                  <ActionIcon variant="light" color="green" radius="xl" size={48} component="span">
                    <IconMapPin size={22} />
                  </ActionIcon>
                  <Stack gap={2}>
                    <Text fw={600} c="black">
                      {address.name}
                    </Text>
                    <Text size="sm">{address.street}</Text>
                    <Text size="sm">
                      {address.city}, {address.country} {address.zip_code}
                    </Text>
                    <Text size="sm" fw={500} c="black">
                      {address.phone}
                    </Text>
                  </Stack>
                </Group>
                <ActionIcon
                  variant="subtle"
                  color="green"
                  radius="xl"
                  aria-label={isEditing ? "Close" : "Edit address"}
                  onClick={() => openEdit(address.id)}
                >
                  {isEditing ? <IconChevronUp size={18} /> : <IconChevronDown size={18} />}
                </ActionIcon>
              </Group>

              <Collapse expanded={isEditing}>
                <Divider color={theme.other.border} />
                <Stack p="lg">
                  {isEditing && (
                    <AddressForm
                      initial={address}
                      isCurrentDefault={isDefault}
                      isSaving={updateState.isLoading}
                      error={updateState.error}
                      onSubmit={async (input) => {
                        try {
                          await updateAddress({ id: address.id, input }).unwrap();
                          setEditingId(null);
                        } catch {
                          // shown inside the form via updateState.error
                        }
                      }}
                      onCancel={() => setEditingId(null)}
                    />
                  )}
                </Stack>
              </Collapse>
            </Paper>
          );
        })}
      </Stack>
    </AccountShell>
  );
}

export default AddressesPage;
