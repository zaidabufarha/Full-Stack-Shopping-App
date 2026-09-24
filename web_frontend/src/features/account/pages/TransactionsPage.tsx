import { Group, Image, Paper, Stack, Text, useMantineTheme } from "@mantine/core";
import { IconCreditCard } from "@tabler/icons-react";
import { useAppSelector } from "../../../app/hooks";
import { useGetTransactionsQuery } from "../accountApi";
import AccountShell from "../components/AccountShell";
import { PROCESSOR_LABELS, PROCESSOR_LOGOS } from "../processors";
import { formatDateTime, money } from "../format";

function TransactionsPage() {
  const theme = useMantineTheme();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data: transactions = [], isLoading, error } = useGetTransactionsQuery(undefined, {
    skip: !isLoggedIn,
  });

  const sorted = [...transactions].sort(
    (a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime(),
  );

  return (
    <AccountShell title="Transactions" isLoading={isLoading} error={error}>
      {sorted.length === 0 ? (
        <Text>No transactions yet.</Text>
      ) : (
        <Stack gap="md">
          {sorted.map((tx) => {
            const key = tx.payment_method.toLowerCase();
            const logo = PROCESSOR_LOGOS[key];
            return (
              <Paper
                key={tx.id}
                withBorder
                radius="md"
                p="lg"
                style={{ borderColor: theme.other.border }}
              >
                <Group justify="space-between" wrap="nowrap">
                  <Group gap="md" wrap="nowrap">
                    <Paper
                      radius="xl"
                      w={48}
                      h={48}
                      bg="gray.0"
                      display="flex"
                      style={{ alignItems: "center", justifyContent: "center", flexShrink: 0 }}
                    >
                      {logo ? <Image src={logo} w={30} fit="contain" /> : <IconCreditCard size={22} />}
                    </Paper>
                    <Stack gap={2}>
                      <Text fw={600} c="black">
                        {PROCESSOR_LABELS[key] ?? tx.payment_method}
                      </Text>
                      <Text size="xs">{formatDateTime(tx.created_at)}</Text>
                    </Stack>
                  </Group>
                  <Text fw={700} c="green" style={{ flexShrink: 0 }}>
                    {money(tx.amount)}
                  </Text>
                </Group>
              </Paper>
            );
          })}
        </Stack>
      )}
    </AccountShell>
  );
}

export default TransactionsPage;
