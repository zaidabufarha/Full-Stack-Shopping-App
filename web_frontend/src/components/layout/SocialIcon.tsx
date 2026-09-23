import { ActionIcon } from "@mantine/core";
import type { Icon } from "@tabler/icons-react";

type SocialIconProps = {
  label: string;
  icon: Icon;
};

function SocialIcon({ label, icon: Icon }: SocialIconProps) {
  return (
    <ActionIcon
      aria-label={label}
      size={40}
      radius={999}
      variant="filled"
      color="green"
    >
      <Icon size={30} stroke={2} />
    </ActionIcon>
  );
}

export default SocialIcon;
