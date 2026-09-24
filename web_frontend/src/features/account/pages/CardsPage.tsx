import {
  ActionIcon,
  Badge,
  Collapse,
  Divider,
  Group,
  Image,
  Paper,
  Stack,
  Text,
  useMantineTheme,
} from "@mantine/core";
import { IconChevronDown, IconChevronUp, IconCreditCard, IconPlus } from "@tabler/icons-react";
import { useState } from "react";
import { useAppSelector } from "../../../app/hooks";
import { useAddCardMutation, useGetCreditCardsQuery, useUpdateCreditCardMutation } from "../accountApi";
import AccountShell from "../components/AccountShell";
import CardForm from "../components/CardForm";
import { PROCESSOR_LABELS as LABELS, PROCESSOR_LOGOS as LOGOS } from "../processors";

function CardsPage() {
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data, isLoading, error } = useGetCreditCardsQuery(undefined, { skip: !isLoggedIn });

  const [addCard, addState] = useAddCardMutation();
  const [updateCard, updateState] = useUpdateCreditCardMutation();

  const [editingId, setEditingId] = useState<string | null>(null);
  const [adding, setAdding] = useState(false);

  const cards = data?.credit_card ?? [];
  const defaultId = data?.default_credit_card_id ?? null;

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
      title="My Cards"
      description="Cards you can pay with at checkout."
      isLoading={isLoading}
      error={error}
      action={
        <ActionIcon
          variant="filled"
          color="green"
          radius="xl"
          size="lg"
          aria-label="Add card"
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
                New card
              </Text>
              <CardForm
                key={adding ? "open" : "closed"}
                isSaving={addState.isLoading}
                error={addState.error}
                onSubmit={async (input) => {
                  try {
                    await addCard({ input }).unwrap();
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

        {cards.length === 0 && !adding && <Text>No cards saved yet. Use the + button to add one.</Text>}

        {cards.map((card) => {
          const isDefault = card.id === defaultId;
          const isEditing = editingId === card.id;
          const key = card.processor.toLowerCase();
          const logo = LOGOS[key];
          return (
            <Paper
              key={card.id}
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
              <Group justify="space-between" align="center" p="lg" wrap="nowrap">
                <Group gap="md" wrap="nowrap">
                  <Paper
                    radius="xl"
                    w={56}
                    h={56}
                    bg="gray.0"
                    display="flex"
                    style={{ alignItems: "center", justifyContent: "center", flexShrink: 0 }}
                  >
                    {logo ? <Image src={logo} w={36} fit="contain" /> : <IconCreditCard size={24} />}
                  </Paper>
                  <Stack gap={2}>
                    <Text fw={600} c="black">
                      {LABELS[key] ?? card.processor}
                    </Text>
                    <Text size="sm" style={{ letterSpacing: 1 }}>
                      XXXX XXXX XXXX {card.last4}
                    </Text>
                    <Text size="xs">
                      <Text span fw={600} c="black">
                        Expiry:
                      </Text>{" "}
                      {card.expiry_date}
                      {"   "}
                      <Text span fw={600} c="black">
                        Holder:
                      </Text>{" "}
                      {card.card_holder_name}
                    </Text>
                  </Stack>
                </Group>
                <ActionIcon
                  variant="subtle"
                  color="green"
                  radius="xl"
                  aria-label={isEditing ? "Close" : "Edit card"}
                  onClick={() => openEdit(card.id)}
                >
                  {isEditing ? <IconChevronUp size={18} /> : <IconChevronDown size={18} />}
                </ActionIcon>
              </Group>

              <Collapse expanded={isEditing}>
                <Divider color={theme.other.border} />
                <Stack p="lg">
                  {isEditing && (
                    <CardForm
                      initial={{
                        card_holder_name: card.card_holder_name,
                        expiry_date: card.expiry_date,
                        processor: key,
                        last4: card.last4,
                      }}
                      isCurrentDefault={isDefault}
                      isSaving={updateState.isLoading}
                      error={updateState.error}
                      onSubmit={async (input) => {
                        try {
                          await updateCard({ id: card.id, input }).unwrap();
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

export default CardsPage;
