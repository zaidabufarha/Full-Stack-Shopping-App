import { Box, Image, Paper, Stack, Text, UnstyledButton } from "@mantine/core";
import { argbToHex } from "../color";
import type { GetCategoriesQuery } from "../../../gql/operations";

type Category = GetCategoriesQuery["categories"][number];

type CategoryIconProps = {
  category: Category;
  selected: boolean;
  onClick: () => void;
};

// White rounded-square tile with a soft shadow (the UI kit's category style),
// with the category's colour as a pastel disc behind the icon (the Flutter
// style). Tile stays white so the row reads as one set.
function CategoryIcon({ category, selected, onClick }: CategoryIconProps) {
  return (
    <UnstyledButton onClick={onClick} aria-pressed={selected}>
      <Paper
        w={112}
        h={112}
        radius="md"
        shadow="sm"
        bg="white"
        // 2px border either way so selecting a tile doesn't shift the row
        style={{
          border: `2px solid ${selected ? "var(--mantine-color-green-6)" : "transparent"}`,
        }}
      >
        <Stack gap={8} h="100%" align="center" justify="center" px={6}>
          {/* the category's own colour as a pastel disc behind the icon */}
          <Box
            w={56}
            h={56}
            bg={argbToHex(category.color)}
            display="flex"
            style={{
              borderRadius: 999,
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            <Image src={category.image_path} w={36} h={36} fit="contain" />
          </Box>
          <Text size="sm" c="black" ta="center" lineClamp={1}>
            {category.name}
          </Text>
        </Stack>
      </Paper>
    </UnstyledButton>
  );
}

export default CategoryIcon;
