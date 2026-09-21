import { Group, Text } from "@mantine/core";
import type { Icon } from "@tabler/icons-react";
import type { ReactNode } from "react";

type TopBarItemProps = {
  icon: Icon;
  children: ReactNode;
  iconSize?: number;
  fz?: number;
  color?: string;
};

function TopBarItem({
  icon: IconComponent,
  children,
  iconSize = 28,
  fz = 17,
  color = "white",
}: TopBarItemProps) {
  return (
    <Group gap={10}>
      <IconComponent size={iconSize} color={color} />
      <Text fz={fz} c={color}>
        {children}
      </Text>
    </Group>
  );
}

export default TopBarItem;
