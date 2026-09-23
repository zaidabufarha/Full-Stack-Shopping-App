/** Internal type. DO NOT USE DIRECTLY. */
type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
/** Internal type. DO NOT USE DIRECTLY. */
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
import type * as Types from './schema';

export type GetUserDataQueryVariables = Exact<{ [key: string]: never; }>;


export type GetUserDataQuery = { me: { id: string, name: string, email: string, phone: string, image_path: string, default_address_id: string | null, default_credit_card_id: string | null, address: Array<{ id: string, name: string, street: string, city: string, zip_code: string, country: string, phone: string }>, credit_card: Array<{ id: string, card_holder_name: string, last4: string, expiry_date: string, stripe_payment_id: string, processor: string }>, order: Array<{ id: string, shipping_method: string, total_amount: number, status: string, date_placed: string, order_item: Array<{ id: string, quantity: number, price_at_purchase: number, product: { id: string, name: string, image_path: string, amount: string, description: string, discount: number, price: number, is_new: boolean, is_favorite: boolean, color: string, rating: number } }>, address: { id: string, name: string, street: string, city: string, zip_code: string, country: string, phone: string } | null, credit_card: { id: string, card_holder_name: string, last4: string, expiry_date: string, stripe_payment_id: string, processor: string } | null }>, transaction: Array<{ id: string, amount: number, status: string, payment_method: string, created_at: string }> } };

export type GetAddressesQueryVariables = Exact<{ [key: string]: never; }>;


export type GetAddressesQuery = { me: { default_address_id: string | null, address: Array<{ id: string, name: string, street: string, city: string, zip_code: string, country: string, phone: string }> } };

export type GetCreditCardsQueryVariables = Exact<{ [key: string]: never; }>;


export type GetCreditCardsQuery = { me: { default_credit_card_id: string | null, credit_card: Array<{ id: string, card_holder_name: string, last4: string, expiry_date: string, stripe_payment_id: string, processor: string }> } };

export type GetNotificationPreferencesQueryVariables = Exact<{ [key: string]: never; }>;


export type GetNotificationPreferencesQuery = { me: { notification_preference: { allow_general: boolean, allow_order: boolean, allow_email: boolean } } };

export type GetOrdersQueryVariables = Exact<{ [key: string]: never; }>;


export type GetOrdersQuery = { me: { order: Array<{ id: string, shipping_method: string, total_amount: number, status: string, date_placed: string, order_item: Array<{ id: string, quantity: number, price_at_purchase: number, product: { id: string, name: string, image_path: string, amount: string, description: string, discount: number, price: number, is_new: boolean, is_favorite: boolean, color: string, rating: number } }>, address: { id: string, name: string, street: string, city: string, zip_code: string, country: string, phone: string } | null, credit_card: { id: string, card_holder_name: string, last4: string, expiry_date: string, stripe_payment_id: string, processor: string } | null }> } };

export type GetTransactionsQueryVariables = Exact<{ [key: string]: never; }>;


export type GetTransactionsQuery = { me: { transaction: Array<{ id: string, amount: number, status: string, payment_method: string, created_at: string }> } };

export type AddAddressMutationVariables = Exact<{
  input: Types.AddressInput;
}>;


export type AddAddressMutation = { addAddress: { id: string } };

export type UpdateAddressMutationVariables = Exact<{
  id: string | number;
  input: Types.AddressInput;
}>;


export type UpdateAddressMutation = { updateAddress: { id: string } };

export type AddCardMutationVariables = Exact<{
  input: Types.CardInput;
}>;


export type AddCardMutation = { addCard: { id: string } };

export type UpdateCreditCardMutationVariables = Exact<{
  id: string | number;
  input: Types.CardInput;
}>;


export type UpdateCreditCardMutation = { updateCreditCard: { id: string } };

export type SetDefaultCreditCardMutationVariables = Exact<{
  id: string | number;
}>;


export type SetDefaultCreditCardMutation = { setDefaultCreditCard: { id: string } };

export type UpdateNotificationPreferenceMutationVariables = Exact<{
  email?: boolean | null | undefined;
  order?: boolean | null | undefined;
  general?: boolean | null | undefined;
}>;


export type UpdateNotificationPreferenceMutation = { updateNotificationPreference: { id: string } };

export type UpdateProfileMutationVariables = Exact<{
  name?: string | null | undefined;
  email?: string | null | undefined;
  phone?: string | null | undefined;
}>;


export type UpdateProfileMutation = { updateProfile: { id: string, name: string, email: string, phone: string } };

export type UpdateProfilePictureMutationVariables = Exact<{
  imagePath: string;
}>;


export type UpdateProfilePictureMutation = { updateProfile: { id: string, image_path: string } };

export type ChangePasswordMutationVariables = Exact<{
  oldPassword: string;
  newPassword: string;
}>;


export type ChangePasswordMutation = { changePassword: boolean };

export type LogInMutationVariables = Exact<{
  email: string;
  password: string;
}>;


export type LogInMutation = { logIn: { token: string, user: { id: string, name: string, email: string, phone: string, image_path: string } } };

export type SignUpMutationVariables = Exact<{
  email: string;
  number: string;
  password: string;
}>;


export type SignUpMutation = { signUp: { id: string, name: string, email: string, phone: string } };

export type ForgotPasswordMutationVariables = Exact<{
  email: string;
}>;


export type ForgotPasswordMutation = { forgotPassword: boolean };

export type GetCategoriesQueryVariables = Exact<{ [key: string]: never; }>;


export type GetCategoriesQuery = { categories: Array<{ id: string, name: string, image_path: string, color: string }> };

export type GetProductsQueryVariables = Exact<{ [key: string]: never; }>;


export type GetProductsQuery = { products: Array<{ id: string, name: string, image_path: string, amount: string, description: string, discount: number, price: number, is_new: boolean, is_favorite: boolean, color: string, rating: number, free_shipping: boolean, same_day_delivery: boolean, category: { id: string, name: string, image_path: string, color: string } | null, review: Array<{ id: string, rating: number, comment: string, created_at: string, user: { name: string, email: string, phone: string, image_path: string } | null }> }> };

export type GetProductReviewsQueryVariables = Exact<{
  productId: string | number;
}>;


export type GetProductReviewsQuery = { productReviews: Array<{ id: string, rating: number, comment: string, created_at: string, user: { name: string, email: string, phone: string, image_path: string } | null }> };

export type GetFavoritesQueryVariables = Exact<{ [key: string]: never; }>;


export type GetFavoritesQuery = { me: { favorite: Array<{ id: string, name: string, image_path: string, amount: string, description: string, discount: number, price: number, is_new: boolean, is_favorite: boolean, color: string, rating: number, free_shipping: boolean, same_day_delivery: boolean, category: { id: string, name: string, image_path: string, color: string } | null }> } };

export type GetCartQueryVariables = Exact<{ [key: string]: never; }>;


export type GetCartQuery = { cart: Array<{ id: string, quantity: number, product: { id: string, name: string, image_path: string, amount: string, description: string, discount: number, price: number, is_new: boolean, is_favorite: boolean, color: string, rating: number, free_shipping: boolean, same_day_delivery: boolean, category: { id: string, name: string, image_path: string, color: string } | null } }> };

export type AddToCartMutationVariables = Exact<{
  productId: string | number;
  quantity: number;
}>;


export type AddToCartMutation = { addToCart: { id: string } };

export type UpdateCartItemMutationVariables = Exact<{
  id: string | number;
  quantity: number;
}>;


export type UpdateCartItemMutation = { updateCartItem: { id: string } };

export type RemoveFromCartMutationVariables = Exact<{
  id: string | number;
}>;


export type RemoveFromCartMutation = { removeFromCart: boolean };

export type ToggleFavoriteMutationVariables = Exact<{
  productId: string | number;
}>;


export type ToggleFavoriteMutation = { toggleFavorite: boolean };

export type AddReviewMutationVariables = Exact<{
  productId: string | number;
  rating: number;
  comment: string;
}>;


export type AddReviewMutation = { addReview: { id: string } };

export type CreateOrderMutationVariables = Exact<{
  addressId: string | number;
  cardId: string | number;
  shippingMethod?: string | null | undefined;
}>;


export type CreateOrderMutation = { createOrder: { id: string } };
