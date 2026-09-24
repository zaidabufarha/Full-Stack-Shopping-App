import { Button, Group, Select, SimpleGrid, Stack, Switch, Text, TextInput } from "@mantine/core";
import { isNotEmpty, useForm } from "@mantine/form";
import {
  IconHome,
  IconMap,
  IconMapPin,
  IconPhone,
  IconUser,
  IconWorld,
} from "@tabler/icons-react";
import { defaultCountries, parseCountry } from "react-international-phone";
import type { AddressInput } from "../../../gql/schema";
import { useFieldProps } from "../../auth/useFieldProps";

// Same idea as Flutter's country_picker: a searchable full list, and the
// address stores the country's name. Reuses the phone field's bundled list
// rather than adding a dependency.
const COUNTRIES = defaultCountries.map((c) => parseCountry(c).name);

export type AddressFormValues = {
  name: string;
  street: string;
  city: string;
  zip_code: string;
  country: string;
  phone: string;
  is_default: boolean;
};

const EMPTY: AddressFormValues = {
  name: "",
  street: "",
  city: "",
  zip_code: "",
  country: "",
  phone: "",
  is_default: false,
};

type AddressFormProps = {
  /** Existing address to edit; omit to add a new one. */
  initial?: Partial<AddressFormValues>;
  /** True when this address is already the default — the switch then can't be turned off, only another address can take over. */
  isCurrentDefault?: boolean;
  isSaving: boolean;
  error?: { message?: string };
  onSubmit: (input: AddressInput) => void;
  onCancel: () => void;
};

/** Add and edit share this. Every field is required, as in the Flutter app. */
function AddressForm({ initial, isCurrentDefault = false, isSaving, error, onSubmit, onCancel }: AddressFormProps) {
  const form = useForm<AddressFormValues>({
    mode: "controlled",
    initialValues: { ...EMPTY, ...initial },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      name: isNotEmpty("Cannot be empty"),
      street: isNotEmpty("Cannot be empty"),
      city: isNotEmpty("Cannot be empty"),
      zip_code: isNotEmpty("Cannot be empty"),
      country: isNotEmpty("Cannot be empty"),
      phone: isNotEmpty("Cannot be empty"),
    },
  });
  const { field, revealAll } = useFieldProps(form);

  return (
    <form
      onSubmit={form.onSubmit((values) =>
        onSubmit({
          name: values.name.trim(),
          street: values.street.trim(),
          city: values.city.trim(),
          zip_code: values.zip_code.trim(),
          country: values.country.trim(),
          phone: values.phone.trim(),
          is_default: values.is_default,
        }), revealAll)}
    >
      <Stack gap="sm">
        <TextInput label="Name" placeholder="Name" leftSection={<IconUser size={18} />} {...field("name")} />
        <TextInput
          label="Address"
          placeholder="Street address"
          leftSection={<IconMapPin size={18} />}
          {...field("street")}
        />
        <SimpleGrid cols={2} spacing="sm">
          <TextInput label="City" placeholder="City" leftSection={<IconMap size={18} />} {...field("city")} />
          <TextInput
            label="Zip code"
            placeholder="Zip code"
            leftSection={<IconHome size={18} />}
            {...field("zip_code")}
          />
        </SimpleGrid>
        <Select
          label="Country"
          placeholder="Country"
          data={COUNTRIES}
          searchable
          nothingFoundMessage="No such country"
          leftSection={<IconWorld size={18} />}
          {...field("country")}
        />
        <TextInput
          label="Phone number"
          placeholder="Phone number"
          leftSection={<IconPhone size={18} />}
          {...field("phone")}
        />

        <Switch
          label="Make default"
          color="green"
          mt="xs"
          // once default, it stays default until another address takes over
          disabled={isCurrentDefault}
          {...form.getInputProps("is_default", { type: "checkbox" })}
          checked={isCurrentDefault || form.values.is_default}
        />

        {error && (
          <Text c="red" size="sm">
            {error.message ?? "Something went wrong"}
          </Text>
        )}

        <Group justify="flex-end" mt="xs">
          <Button variant="subtle" color="gray" h={40} fz="md" onClick={onCancel} disabled={isSaving}>
            Cancel
          </Button>
          <Button type="submit" h={40} fz="md" w={140} loading={isSaving}>
            Save
          </Button>
        </Group>
      </Stack>
    </form>
  );
}

export default AddressForm;
