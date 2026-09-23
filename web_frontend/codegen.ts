import type { CodegenConfig } from "@graphql-codegen/cli";

/**
 * Types are generated from the backend's schema, exported to SDL by
 * `npm run schema:export` in ../backend (its schema lives in a template
 * string, so there's no .graphql file to read directly).
 *
 * Run `npm run codegen` after the schema changes, or `npm run codegen:watch`
 * while working on queries.
 */
const config: CodegenConfig = {
  schema: "../backend/schema.graphql",
  documents: ["src/**/*.{ts,tsx}"],
  ignoreNoDocuments: true,
  generates: {
    "src/gql/graphql.ts": {
      plugins: ["typescript", "typescript-operations"],
      config: {
        skipTypename: true,
        avoidOptionals: { field: true },
      },
    },
  },
};

export default config;
