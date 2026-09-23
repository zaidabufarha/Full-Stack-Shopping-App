import { baseApi } from "../../app/service/baseApi";
import type {
  LogInMutation,
  LogInMutationVariables,
  SignUpMutation,
  SignUpMutationVariables,
  ForgotPasswordMutation,
  ForgotPasswordMutationVariables,
} from "../../gql/operations";
import { setToken } from "./authSlice";

/**
 * The /* GraphQL *​/ comment is what makes codegen pick these up — it scans for
 * tagged or annotated documents, not bare template strings. Operation names
 * (LogIn, SignUp) become the generated type names.
 *
 * Deliberately leaner than the Flutter client's LogIn, which pulls addresses,
 * cards and full order history in one go. Those get their own queries so they
 * cache and invalidate separately.
 */
const LOG_IN = /* GraphQL */ `
  mutation LogIn($email: String!, $password: String!) {
    logIn(email: $email, password: $password) {
      token
      user {
        id
        name
        email
        phone
        image_path
      }
    }
  }
`;

const SIGN_UP = /* GraphQL */ `
  mutation SignUp($email: String!, $number: String!, $password: String!) {
    signUp(email: $email, number: $number, password: $password) {
      id
      name
      email
      phone
    }
  }
`;

const FORGOT_PASSWORD = /* GraphQL */ `
  mutation ForgotPassword($email: String!) {
    forgotPassword(email: $email)
  }
`;

export const authApi = baseApi.injectEndpoints({
  endpoints: (build) => ({
    logIn: build.mutation<
      LogInMutation["logIn"],
      // `remember` is client-only — it picks the storage, and never reaches the
      // server, so it's stripped out before the variables are sent
      LogInMutationVariables & { remember?: boolean }
    >({
      query: ({ email, password }) => ({
        document: LOG_IN,
        variables: { email, password },
      }),
      async onQueryStarted(arg, { dispatch, queryFulfilled }) {
        try {
          const { data } = await queryFulfilled;
          dispatch(
            setToken({ token: data.token, remember: arg.remember ?? false }),
          );
        } catch {
          //handled elsewhere, just used a try-catch here to pass it along
        }
      },
      invalidatesTags: ["User", "Cart"],
    }),

    signUp: build.mutation<SignUpMutation["signUp"], SignUpMutationVariables>({
      query: (variables) => ({ document: SIGN_UP, variables }),
    }),

    forgotPassword: build.mutation<
      ForgotPasswordMutation["forgotPassword"],
      ForgotPasswordMutationVariables
    >({
      query: (variables) => ({ document: FORGOT_PASSWORD, variables }),
    }),
  }),
});

export const {
  useLogInMutation,
  useSignUpMutation,
  useForgotPasswordMutation,
} = authApi;
