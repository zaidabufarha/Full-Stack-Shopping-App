import { Button, Group, Paper, Radio, Stack, Text, Title, useMantineTheme } from "@mantine/core";
import { useCheckoutParams } from "../../checkoutParams";
import { DEFAULT_SHIPPING, SHIPPING_METHODS } from "../../shipping";

function DeliveryStep() {
  const theme = useMantineTheme();
  const { shipping, setParam, goTo } = useCheckoutParams();
  const value = shipping ?? DEFAULT_SHIPPING.value;

  return (
    <Paper withBorder radius="lg" p="xl" bg="white" style={{ borderColor: theme.other.border }}>
      <Stack gap="lg">
        <Stack gap={4}>
          <Title order={2}>Shipping Method</Title>
          <Text size="sm">How fast do you need it?</Text>
        </Stack>

        <Radio.Group value={value} onChange={(v) => setParam("shipping", v)}>
          <Stack gap="sm">
            {SHIPPING_METHODS.map((method) => (
              <Radio.Card
                key={method.value}
                value={method.value}
                radius="md"
                p="lg"
                style={{
                  borderColor:
                    value === method.value ? "var(--mantine-color-green-6)" : theme.other.border,
                }}
              >
                <Group justify="space-between" wrap="nowrap" align="flex-start">
                  <Group gap="md" wrap="nowrap" align="flex-start">
                    <Radio.Indicator color="green" mt={2} />
                    <Stack gap={2}>
                      <Text fw={600} c="black">
                        {method.label}
                      </Text>
                      <Text size="sm">{method.description}</Text>
                    </Stack>
                  </Group>
                  <Text fw={700} c="green" style={{ flexShrink: 0 }}>
                    ${method.price.toFixed(2)}
                  </Text>
                </Group>
              </Radio.Card>
            ))}
          </Stack>
        </Radio.Group>

        <Group justify="flex-end">
          <Button h={48} fz="md" w={180} onClick={() => goTo("address", { shipping: value })}>
            Next
          </Button>
        </Group>
      </Stack>
    </Paper>
  );
}

export default DeliveryStep;
