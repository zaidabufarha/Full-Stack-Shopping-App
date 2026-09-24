import { ActionIcon, Button, Group, Popover, Stack, Text } from "@mantine/core";
import { IconMinus } from "@tabler/icons-react";
import { useState } from "react";

type RemoveConfirmProps = {
  /** Product name, for the prompt. */
  name: string;
  onConfirm: () => void;
  iconSize?: number;
};

/**
 * The minus button at quantity 1. It turns red and, instead of removing on
 * click, asks first — so walking a quantity down can't accidentally drop the
 * item. Used by the product card strip and the cart row alike.
 */
function RemoveConfirm({ name, onConfirm, iconSize = 18 }: RemoveConfirmProps) {
  const [opened, setOpened] = useState(false);

  return (
    <Popover
      opened={opened}
      onChange={setOpened}
      position="top"
      withArrow
      shadow="md"
      trapFocus
    >
      <Popover.Target>
        <ActionIcon
          variant="subtle"
          color="red"
          aria-label={`Remove ${name} from cart`}
          onClick={() => setOpened((o) => !o)}
        >
          <IconMinus size={iconSize} />
        </ActionIcon>
      </Popover.Target>
      <Popover.Dropdown>
        <Stack gap="sm">
          <Text size="sm" c="black">
            Remove <Text span fw={600}>{name}</Text> from your cart?
          </Text>
          <Group justify="flex-end" gap="xs">
            <Button
              variant="subtle"
              color="gray"
              size="xs"
              h={32}
              fz="sm"
              onClick={() => setOpened(false)}
            >
              Keep
            </Button>
            <Button
              variant="filled"
              color="red"
              size="xs"
              h={32}
              fz="sm"
              onClick={() => {
                setOpened(false);
                onConfirm();
              }}
            >
              Remove
            </Button>
          </Group>
        </Stack>
      </Popover.Dropdown>
    </Popover>
  );
}

export default RemoveConfirm;
