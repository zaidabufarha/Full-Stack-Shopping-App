import {
  Button,
  Group,
  SegmentedControl,
  SimpleGrid,
  Stack,
  Switch,
  Text,
  TextInput,
} from "@mantine/core";
import { isNotEmpty, useForm } from "@mantine/form";
import { IconCalendar, IconCreditCard, IconUser } from "@tabler/icons-react";
import type { CardInput } from "../../../gql/schema";
import { useFieldProps } from "../../auth/useFieldProps";

export type CardFormValues = {
  card_holder_name: string;
  card_number: string;
  expiry_date: string;
  processor: string;
  is_default: boolean;
};

const EMPTY: CardFormValues = {
  card_holder_name: "",
  card_number: "",
  expiry_date: "",
  processor: "visa",
  is_default: false,
};

// stored as the Flutter enum names
const PROCESSORS = [
  { label: "Visa", value: "visa" },
  { label: "Mastercard", value: "mastercard" },
  { label: "PayPal", value: "paypal" },
];

type CardFormProps = {
  /** Existing card to edit; omit to add. The number can't be changed on an existing card — only its last 4 are stored. */
  initial?: Partial<CardFormValues> & { last4?: string };
  isCurrentDefault?: boolean;
  /** Show the values locked, with no buttons — used at checkout to display the chosen card. */
  readOnly?: boolean;
  isSaving?: boolean;
  error?: { message?: string };
  onSubmit?: (input: CardInput) => void;
  onCancel?: () => void;
};

const digits = (s: string) => s.replace(/\D/g, "");

/** Formats "4242424242424242" as "4242 4242 4242 4242" while typing. */
const groupDigits = (s: string) => digits(s).slice(0, 19).replace(/(.{4})/g, "$1 ").trim();

function CardForm({
  initial,
  isCurrentDefault = false,
  readOnly = false,
  isSaving = false,
  error,
  onSubmit,
  onCancel,
}: CardFormProps) {
  const isEdit = Boolean(initial?.last4);

  const form = useForm<CardFormValues>({
    mode: "controlled",
    initialValues: { ...EMPTY, ...initial },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      card_holder_name: isNotEmpty("Cannot be empty"),
      // the number is only asked for on a new card
      card_number: (v) => (isEdit || /^\d{13,19}$/.test(digits(v)) ? null : "Enter a 13–19 digit card number"),
      expiry_date: (v) => (/^(0[1-9]|1[0-2])\/\d{2}$/.test(v) ? null : "Use MM/YY"),
    },
  });
  const { field, revealAll } = useFieldProps(form);

  return (
    <form
      onSubmit={form.onSubmit((values) => {
        const number = digits(values.card_number);
        onSubmit?.({
          card_holder_name: values.card_holder_name.trim(),
          expiry_date: values.expiry_date,
          processor: values.processor,
          is_default: values.is_default,
          // only on add — the backend derives last4 from it and never stores the full number
          ...(isEdit ? {} : { card_number: number, last4: number.slice(-4) }),
        });
      }, revealAll)}
    >
      <Stack gap="sm">
        <TextInput
          label="Name on the card"
          placeholder="Name on the card"
          leftSection={<IconUser size={18} />}
          disabled={readOnly}
          {...field("card_holder_name")}
        />

        {isEdit ? (
          <TextInput
            label="Card number"
            value={`•••• •••• •••• ${initial?.last4}`}
            disabled
            leftSection={<IconCreditCard size={18} />}
          />
        ) : (
          <TextInput
            label="Card number"
            placeholder="Card number"
            inputMode="numeric"
            leftSection={<IconCreditCard size={18} />}
            {...field("card_number")}
            onChange={(e) => form.setFieldValue("card_number", groupDigits(e.currentTarget.value))}
          />
        )}

        <SimpleGrid cols={2} spacing="sm">
          <TextInput
            label="Expiry"
            placeholder="MM/YY"
            maxLength={5}
            leftSection={<IconCalendar size={18} />}
            disabled={readOnly}
            {...field("expiry_date")}
          />
          <Stack gap={4}>
            <Text size="sm" fw={500} c="black">
              Card type
            </Text>
            <SegmentedControl
              data={PROCESSORS}
              value={form.values.processor}
              onChange={(v) => form.setFieldValue("processor", v)}
              color="green"
              disabled={readOnly}
            />
          </Stack>
        </SimpleGrid>

        <Switch
          label={readOnly && isCurrentDefault ? "Default card" : "Make default"}
          color="green"
          mt="xs"
          disabled={readOnly || isCurrentDefault}
          {...form.getInputProps("is_default", { type: "checkbox" })}
          checked={isCurrentDefault || form.values.is_default}
        />

        {error && (
          <Text c="red" size="sm">
            {error.message ?? "Something went wrong"}
          </Text>
        )}

        {!readOnly && (
          <Group justify="flex-end" mt="xs">
            <Button variant="subtle" color="gray" h={40} fz="md" onClick={onCancel} disabled={isSaving}>
              Cancel
            </Button>
            <Button type="submit" h={40} fz="md" w={140} loading={isSaving}>
              Save
            </Button>
          </Group>
        )}
      </Stack>
    </form>
  );
}

export default CardForm;
