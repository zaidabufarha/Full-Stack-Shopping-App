import { baseApi } from "../../app/service/baseApi";
import type {
  GetUserDataQuery,
  GetAddressesQuery,
  GetCreditCardsQuery,
  GetNotificationPreferencesQuery,
  GetOrdersQuery,
  GetTransactionsQuery,
  AddAddressMutation,
  AddAddressMutationVariables,
  UpdateAddressMutation,
  UpdateAddressMutationVariables,
  AddCardMutation,
  AddCardMutationVariables,
  UpdateCreditCardMutation,
  UpdateCreditCardMutationVariables,
  SetDefaultCreditCardMutation,
  SetDefaultCreditCardMutationVariables,
  UpdateNotificationPreferenceMutation,
  UpdateNotificationPreferenceMutationVariables,
  UpdateProfileMutation,
  UpdateProfileMutationVariables,
  UpdateProfilePictureMutation,
  UpdateProfilePictureMutationVariables,
  ChangePasswordMutation,
  ChangePasswordMutationVariables,
} from "../../gql/operations";

// Documents are lifted verbatim from the Flutter client's AccountRemoteDataSource.
// Every query here is a `me` query, so they all share the User tag and any account
// mutation refetches all of them. Coarse, but correct; split the tag if it gets
// wasteful.

const GET_USER_DATA = /* GraphQL */ `
  query GetUserData {
    me {
      id
      name
      email
      phone
      image_path
      default_address_id
      default_credit_card_id
      address {
        id
        name
        street
        city
        zip_code
        country
        phone
      }
      credit_card {
        id
        card_holder_name
        last4
        expiry_date
        stripe_payment_id
        processor
      }
      order {
        id
        shipping_method
        total_amount
        status
        date_placed
        order_item {
          id
          quantity
          price_at_purchase
          product {
            id
            name
            image_path
            amount
            description
            discount
            price
            is_new
            is_favorite
            color
            rating
          }
        }
        address {
          id
          name
          street
          city
          zip_code
          country
          phone
        }
        credit_card {
          id
          card_holder_name
          last4
          expiry_date
          stripe_payment_id
          processor
        }
      }
      transaction {
        id
        amount
        status
        payment_method
        created_at
      }
    }
  }
`;

const GET_ADDRESSES = /* GraphQL */ `
  query GetAddresses {
    me {
      default_address_id
      address {
        id
        name
        street
        city
        zip_code
        country
        phone
      }
    }
  }
`;

const GET_CREDIT_CARDS = /* GraphQL */ `
  query GetCreditCards {
    me {
      default_credit_card_id
      credit_card {
        id
        card_holder_name
        last4
        expiry_date
        stripe_payment_id
        processor
      }
    }
  }
`;

const GET_NOTIFICATION_PREFERENCES = /* GraphQL */ `
  query GetNotificationPreferences {
    me {
      notification_preference {
        allow_general
        allow_order
        allow_email
      }
    }
  }
`;

const GET_ORDERS = /* GraphQL */ `
  query GetOrders {
    me {
      order {
        id
        shipping_method
        total_amount
        status
        date_placed
        date_confirmed
        date_shipped
        date_out_for_delivery
        date_delivered
        order_item {
          id
          quantity
          price_at_purchase
          product {
            id
            name
            image_path
            amount
            description
            discount
            price
            is_new
            is_favorite
            color
            rating
          }
        }
        address {
          id
          name
          street
          city
          zip_code
          country
          phone
        }
        credit_card {
          id
          card_holder_name
          last4
          expiry_date
          stripe_payment_id
          processor
        }
      }
    }
  }
`;

const GET_TRANSACTIONS = /* GraphQL */ `
  query GetTransactions {
    me {
      transaction {
        id
        amount
        status
        payment_method
        created_at
      }
    }
  }
`;

const ADD_ADDRESS = /* GraphQL */ `
  mutation AddAddress($input: AddressInput!) {
    addAddress(input: $input) {
      id
    }
  }
`;

const UPDATE_ADDRESS = /* GraphQL */ `
  mutation UpdateAddress($id: ID!, $input: AddressInput!) {
    updateAddress(id: $id, input: $input) {
      id
    }
  }
`;

const ADD_CARD = /* GraphQL */ `
  mutation AddCard($input: CardInput!) {
    addCard(input: $input) {
      id
    }
  }
`;

const UPDATE_CREDIT_CARD = /* GraphQL */ `
  mutation UpdateCreditCard($id: ID!, $input: CardInput!) {
    updateCreditCard(id: $id, input: $input) {
      id
    }
  }
`;

const SET_DEFAULT_CREDIT_CARD = /* GraphQL */ `
  mutation SetDefaultCreditCard($id: ID!) {
    setDefaultCreditCard(id: $id) {
      id
    }
  }
`;

const UPDATE_NOTIFICATION_PREFERENCE = /* GraphQL */ `
  mutation UpdateNotificationPreference($email: Boolean, $order: Boolean, $general: Boolean) {
    updateNotificationPreference(allow_email: $email, allow_order: $order, allow_general: $general) {
      id
    }
  }
`;

const UPDATE_PROFILE = /* GraphQL */ `
  mutation UpdateProfile($name: String, $email: String, $phone: String) {
    updateProfile(input: { name: $name, email: $email, phone: $phone }) {
      id
      name
      email
      phone
    }
  }
`;

const UPDATE_PROFILE_PICTURE = /* GraphQL */ `
  mutation UpdateProfilePicture($imagePath: String!) {
    updateProfile(input: { image_path: $imagePath }) {
      id
      image_path
    }
  }
`;

const CHANGE_PASSWORD = /* GraphQL */ `
  mutation ChangePassword($oldPassword: String!, $newPassword: String!) {
    changePassword(oldPassword: $oldPassword, newPassword: $newPassword)
  }
`;

export const accountApi = baseApi.injectEndpoints({
  endpoints: (build) => ({
    getUserData: build.query<GetUserDataQuery["me"], void>({
      query: () => ({ document: GET_USER_DATA }),
      providesTags: ["User"],
    }),

    // returned whole (not unwrapped to the list) because default_address_id
    // is needed alongside it to mark the default row
    getAddresses: build.query<GetAddressesQuery["me"], void>({
      query: () => ({ document: GET_ADDRESSES }),
      providesTags: ["User"],
    }),

    getCreditCards: build.query<GetCreditCardsQuery["me"], void>({
      query: () => ({ document: GET_CREDIT_CARDS }),
      providesTags: ["User"],
    }),

    getNotificationPreferences: build.query<
      GetNotificationPreferencesQuery["me"]["notification_preference"],
      void
    >({
      query: () => ({ document: GET_NOTIFICATION_PREFERENCES }),
      transformResponse: (me: GetNotificationPreferencesQuery["me"]) =>
        me.notification_preference,
      providesTags: ["User"],
    }),

    getOrders: build.query<GetOrdersQuery["me"]["order"], void>({
      query: () => ({ document: GET_ORDERS }),
      transformResponse: (me: GetOrdersQuery["me"]) => me.order,
      providesTags: ["User"],
    }),

    getTransactions: build.query<GetTransactionsQuery["me"]["transaction"], void>({
      query: () => ({ document: GET_TRANSACTIONS }),
      transformResponse: (me: GetTransactionsQuery["me"]) => me.transaction,
      providesTags: ["User"],
    }),

    addAddress: build.mutation<AddAddressMutation["addAddress"], AddAddressMutationVariables>({
      query: (variables) => ({ document: ADD_ADDRESS, variables }),
      invalidatesTags: ["User"],
    }),

    updateAddress: build.mutation<
      UpdateAddressMutation["updateAddress"],
      UpdateAddressMutationVariables
    >({
      query: (variables) => ({ document: UPDATE_ADDRESS, variables }),
      invalidatesTags: ["User"],
    }),

    addCard: build.mutation<AddCardMutation["addCard"], AddCardMutationVariables>({
      query: (variables) => ({ document: ADD_CARD, variables }),
      invalidatesTags: ["User"],
    }),

    updateCreditCard: build.mutation<
      UpdateCreditCardMutation["updateCreditCard"],
      UpdateCreditCardMutationVariables
    >({
      query: (variables) => ({ document: UPDATE_CREDIT_CARD, variables }),
      invalidatesTags: ["User"],
    }),

    setDefaultCreditCard: build.mutation<
      SetDefaultCreditCardMutation["setDefaultCreditCard"],
      SetDefaultCreditCardMutationVariables
    >({
      query: (variables) => ({ document: SET_DEFAULT_CREDIT_CARD, variables }),
      invalidatesTags: ["User"],
    }),

    updateNotificationPreference: build.mutation<
      UpdateNotificationPreferenceMutation["updateNotificationPreference"],
      UpdateNotificationPreferenceMutationVariables
    >({
      query: (variables) => ({ document: UPDATE_NOTIFICATION_PREFERENCE, variables }),
      invalidatesTags: ["User"],
    }),

    updateProfile: build.mutation<
      UpdateProfileMutation["updateProfile"],
      UpdateProfileMutationVariables
    >({
      query: (variables) => ({ document: UPDATE_PROFILE, variables }),
      invalidatesTags: ["User"],
    }),

    // the Cloudinary upload itself happens client-side first; this just stores the URL
    updateProfilePicture: build.mutation<
      UpdateProfilePictureMutation["updateProfile"],
      UpdateProfilePictureMutationVariables
    >({
      query: (variables) => ({ document: UPDATE_PROFILE_PICTURE, variables }),
      invalidatesTags: ["User"],
    }),

    changePassword: build.mutation<
      ChangePasswordMutation["changePassword"],
      ChangePasswordMutationVariables
    >({
      query: (variables) => ({ document: CHANGE_PASSWORD, variables }),
    }),
  }),
});

export const {
  useGetUserDataQuery,
  useGetAddressesQuery,
  useGetCreditCardsQuery,
  useGetNotificationPreferencesQuery,
  useGetOrdersQuery,
  useGetTransactionsQuery,
  useAddAddressMutation,
  useUpdateAddressMutation,
  useAddCardMutation,
  useUpdateCreditCardMutation,
  useSetDefaultCreditCardMutation,
  useUpdateNotificationPreferenceMutation,
  useUpdateProfileMutation,
  useUpdateProfilePictureMutation,
  useChangePasswordMutation,
} = accountApi;
