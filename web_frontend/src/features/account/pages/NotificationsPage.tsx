import {
  Button,
  Center,
  Container,
  Group,
  Loader,
  Paper,
  Stack,
  Switch,
  Text,
  Title,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { useEffect } from "react";
import { Navigate } from "react-router-dom";
import { useAppSelector } from "../../../app/hooks";
import {
  useGetNotificationPreferencesQuery,
  useUpdateNotificationPreferenceMutation,
} from "../accountApi";

type Prefs = { allow_email: boolean; allow_order: boolean; allow_general: boolean };

const ROWS: { key: keyof Prefs; title: string; description: string }[] = [
  {
    key: "allow_email",
    title: "Email Notifications",
    description: "Receipts, password resets and account changes by email.",
  },
  {
    key: "allow_order",
    title: "Order Notifications",
    description: "Updates as your order is confirmed, shipped and delivered.",
  },
  {
    key: "allow_general",
    title: "General Notifications",
    description: "Deals, new products and news from BigCart.",
  },
];

function NotificationsPage() {
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data, isLoading, error } = useGetNotificationPreferencesQuery(undefined, {
    skip: !isLoggedIn,
  });
  const [save, { isLoading: isSaving, isSuccess, error: saveError }] =
    useUpdateNotificationPreferenceMutation();

  const form = useForm<Prefs>({
    mode: "controlled",
    initialValues: { allow_email: true, allow_order: true, allow_general: true },
  });

  useEffect(() => {
    if (!data) return;
    form.initialize(data); // no-op after the first call, so a refetch won't clobber edits
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  // "Select all" pattern: the master switch reflects the rows (on if any row
  // is on) and clicking it sets all three. Rows are never disabled, so with
  // everything off you just tick the one you want and it flips on by itself.
  const { allow_email, allow_order, allow_general } = form.values;
  const anyOn = allow_email || allow_order || allow_general;
  const setAll = (v: boolean) =>
    form.setValues({ allow_email: v, allow_order: v, allow_general: v });

  const handleSubmit = (values: Prefs) => {
    save({ email: values.allow_email, order: values.allow_order, general: values.allow_general });
  };

  return (
    <Container size="sm" py={60}>
      <Stack gap="xl">
        <Title order={2}>Notifications</Title>

        {isLoading ? (
          <Center h={200}>
            <Loader color="green" />
          </Center>
        ) : error ? (
          <Text c="red">{error.message}</Text>
        ) : (
          <form onSubmit={form.onSubmit(handleSubmit)}>
            <Stack gap="md">
              <PrefRow
                title="Allow Notifications"
                description="Turn all notifications on or off at once."
                checked={anyOn}
                onChange={setAll}
              />

              {ROWS.map((row) => (
                <PrefRow
                  key={row.key}
                  title={row.title}
                  description={row.description}
                  checked={form.values[row.key]}
                  onChange={(v) => form.setFieldValue(row.key, v)}
                />
              ))}

              {saveError && (
                <Text c="red" ta="center">
                  {saveError.message}
                </Text>
              )}
              {isSuccess && !saveError && (
                <Text c="green" ta="center">
                  Preferences saved.
                </Text>
              )}

              <Button type="submit" fullWidth mt="md" loading={isSaving}>
                Save settings
              </Button>
            </Stack>
          </form>
        )}
      </Stack>
    </Container>
  );
}

type PrefRowProps = {
  title: string;
  description: string;
  checked: boolean;
  onChange: (checked: boolean) => void;
};

function PrefRow({ title, description, checked, onChange }: PrefRowProps) {
  return (
    <Paper withBorder radius="md" p="lg">
      <Group justify="space-between" wrap="nowrap" align="flex-start">
        <Stack gap={4}>
          <Text fw={600} c="black">
            {title}
          </Text>
          <Text size="sm">{description}</Text>
        </Stack>
        <Switch
          size="md"
          color="green"
          checked={checked}
          onChange={(e) => onChange(e.currentTarget.checked)}
          aria-label={title}
        />
      </Group>
    </Paper>
  );
}

export default NotificationsPage;
