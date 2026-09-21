import { createTheme, type MantineColorsTuple } from '@mantine/core';

// BigCart green. Index 6 is the primary shade — it matches AppColors.primaryDark
// from the Flutter app, with primaryLight at 0 and primary at 3.
const green: MantineColorsTuple = [
  '#ebffd7', // primaryLight
  '#dbf7bf',
  '#c9efa3',
  '#aedc81', // primary
  '#9bd466',
  '#83cb41',
  '#6cc51d', // primaryDark  <- default shade
  '#5ead19',
  '#4f9214',
  '#3f760f',
];

const FONT = 'Poppins, system-ui, -apple-system, sans-serif';

export const theme = createTheme({
  primaryColor: 'green',
  primaryShade: 6,
  colors: { green },

  fontFamily: FONT,
  fontFamilyMonospace: 'ui-monospace, SFMono-Regular, Menlo, monospace',
  headings: {
    fontFamily: FONT,
    fontWeight: '600',
  },

  black: '#1e1e1e', // AppColors.textPrimary
  defaultRadius: 'md',

  components: {
    Button: {
      defaultProps: {
        w: 300,
        h: 50,
        fz:20,
        variant: 'gradient',
        gradient: { from: 'green.3', to: 'green.6' },
      },
    },
    Text: {
      defaultProps: {
        c: '#7b7b7b',
      },
    },
    Anchor: {
      defaultProps: {
        c: 'black',
        fz: 18,
        fw: 500,
      },
    },
    ActionIcon: {
      defaultProps: {
        variant: 'subtle',
        color: 'black',
      },
    },
  },

  // Tokens with no Mantine slot, read via theme.other.*
  other: {
    textSecondary: '#7b7b7b',
    bgSecondary: '#f4f5f9',
    bgTertiary: '#f5f5f5',
    border: '#ebebeb',
    link: '#1a0dab',
  },
});
