import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import type { BaseQueryFn, FetchBaseQueryError } from "@reduxjs/toolkit/query";

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
/** Pulls the most specific message available out of a failed fetch. */
function toGraphqlError(error: FetchBaseQueryError): GraphqlError {
  // RTK's own failure modes carry a string status instead of a number.
  if (error.status === "FETCH_ERROR") {
    return { status: 0, message: "Could not reach the server" };
  }
  if (error.status === "TIMEOUT_ERROR") {
    return { status: 0, message: "The server took too long to respond" };
  }
  if (error.status === "PARSING_ERROR") {
    return { status: error.originalStatus, message: "The server sent a malformed response" };
  }
  if (error.status === "CUSTOM_ERROR") {
    return { status: 0, message: error.error };
  }

  // A real HTTP status. express-graphql answers 4xx/5xx for a malformed
  // document or bad variables, and still includes a GraphQL errors array — so
  // read the body before falling back, otherwise a query bug reads as an outage.
  const status = error.status;
  const data = error.data;

  if (typeof data === "object" && data !== null) {
    const errors = (data as { errors?: { message?: string }[] }).errors;
    if (errors?.length) {
      return { status, message: errors.map((e) => e.message).filter(Boolean).join("; ") };
    }
    const message = (data as { message?: string }).message;
    if (message) return { status, message };
  }

  // Plain-text or HTML body (Render's own 502 page, a proxy error, etc).
  if (typeof data === "string" && data.trim() && !data.trimStart().startsWith("<")) {
    return { status, message: data };
  }

  return { status, message: `Request failed (HTTP ${status})` };
}

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

  if (result.error) {
    return { error: toGraphqlError(result.error) };
  }

  const body = result.data as {
    data?: Record<string, unknown> | null;
    errors?: { message: string }[];
  };

  // The request arrived and GraphQL rejected it — bad credentials, failed
  // validation, an auth guard. The resolver's thrown message is here.
  if (body.errors?.length) {
    return {
      error: {
        status: 400,
        message: body.errors.map((e) => e.message).filter(Boolean).join("; "),
      },
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
