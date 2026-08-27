import { defineConfig } from 'vitest/config';
import path from 'path';

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    setupFiles: ['./test/setup.ts'],
  },
  resolve: {
    alias: {
      graphql: path.resolve(__dirname, 'node_modules/graphql/index.js'),
    },
  },
});
