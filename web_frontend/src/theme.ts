import { createTheme, type MantineColorsTuple } from '@mantine/core';

// BigCart green. Generated from #13C906 (the web design's green) — hue 116 held
// across the ramp, lightness stepped. Index 6 is primary; 7 and 9 are the button
// gradient's two stops.
const green: MantineColorsTuple = [
  '#EBFAEA',
  '#D0F3CE',
  '#AFE9AA',
  '#8CDF86',
  '#62D85A',
  '#2DDF20',
  '#13C906',  // primary  <- default shade
  '#12A807',  // gradient from
  '#0E8406',
  '#096303',  // gradient to
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
        h: 50,
        fz: 20,
        variant: 'gradient',
        gradient: { from: 'green.7', to: 'green.9', deg: 90 },
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
    bgSecondary: '#F4F6F6',
    border: '#ebebeb',
    link: '#1a0dab',
  },
});
