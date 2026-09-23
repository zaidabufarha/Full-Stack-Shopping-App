import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import type { BaseQueryFn } from "@reduxjs/toolkit/query";

// type-only import, not circular
import type { RootState } from "../store";

/** What every endpoint passes in: a GraphQL document and its variables. */
export type GraphqlArgs = {
  document: string;
  variables?: Record<string, unknown>;
};

/** What every endpoint gets back when something fails. */
export type GraphqlError = {
  status: number;
  message: string;
};

const rawBaseQuery = fetchBaseQuery({
  baseUrl: import.meta.env.VITE_API_URL,
  prepareHeaders: (headers, { getState }) => {
    const token = (getState() as RootState).auth.token;
    if (token) headers.set("Authorization", `Bearer ${token}`);
    return headers;
  },
});

/**
 * GraphQL answers with HTTP 200 even when an operation fails — the problem
 * arrives in an `errors` array alongside a null `data`. fetchBaseQuery only
 * looks at the status code, so it would report those as successes.
 *
 * This wrapper sits on top of it and does two jobs:
 *   1. turns a GraphQL `errors` array into a real RTK Query error
 *   2. unwraps `data.<operationName>` so endpoints get the value directly
 */
const graphqlBaseQuery: BaseQueryFn<
  GraphqlArgs,
  unknown,
  GraphqlError
> = async ({ document, variables }, api, extraOptions) => {
  const result = await rawBaseQuery(
    { url: "", method: "POST", body: { query: document, variables } },
    api,
    extraOptions,
  );

  // Transport-level failure: server unreachable, CORS, 500 from the host.
  // Nothing GraphQL-shaped came back at all.
  if (result.error) {
    return {
      error: {
        status:
          typeof result.error.status === "number" ? result.error.status : 0,
        message: "Could not reach the server",
      },
    };
  }

  const body = result.data as {
    data?: Record<string, unknown> | null;
    errors?: { message: string }[];
  };

  // The request arrived and GraphQL rejected it — bad credentials, failed
  // validation, an auth guard. The resolver's thrown message is here.
  if (body.errors?.length) {
    return {
      error: { status: 400, message: body.errors[0].message },
    };
  }

  // Success. Every operation has exactly one root field, so hand back its
  // value rather than making every component reach through `data.logIn`.
  const [value] = Object.values(body.data ?? {});
  return { data: value };
};

export const baseApi = createApi({
  reducerPath: "api",
  baseQuery: graphqlBaseQuery,
  tagTypes: ["Product", "Review", "Cart", "User", "Category", "Order"],
  endpoints: () => ({}),
});
