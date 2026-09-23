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
    // Schema types (User, Product, AddressInput, ...) in one file, per-operation
    // types in another. Kept separate because typescript-operations re-emits any
    // input type used in variables unless told to import it from elsewhere.
    "src/gql/schema.ts": {
      plugins: ["typescript"],
      config: {
        skipTypename: true,
        avoidOptionals: { field: true },
      },
    },
    "src/gql/operations.ts": {
      plugins: ["typescript-operations"],
      config: {
        skipTypename: true,
        avoidOptionals: { field: true },
        importSchemaTypesFrom: "src/gql/schema",
      },
    },
  },
};

export default config;
