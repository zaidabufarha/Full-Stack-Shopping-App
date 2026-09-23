export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
};

export type Address = {
  city: Scalars['String']['output'];
  country: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  name: Scalars['String']['output'];
  phone: Scalars['String']['output'];
  street: Scalars['String']['output'];
  user_id: Scalars['ID']['output'];
  zip_code: Scalars['String']['output'];
};

export type AddressInput = {
  city: Scalars['String']['input'];
  country: Scalars['String']['input'];
  is_default?: InputMaybe<Scalars['Boolean']['input']>;
  name: Scalars['String']['input'];
  phone: Scalars['String']['input'];
  street: Scalars['String']['input'];
  zip_code: Scalars['String']['input'];
};

export type AuthPayload = {
  token: Scalars['String']['output'];
  user: User;
};

export type CardInput = {
  card_holder_name?: InputMaybe<Scalars['String']['input']>;
  card_number?: InputMaybe<Scalars['String']['input']>;
  expiry_date?: InputMaybe<Scalars['String']['input']>;
  is_default?: InputMaybe<Scalars['Boolean']['input']>;
  last4?: InputMaybe<Scalars['String']['input']>;
  processor?: InputMaybe<Scalars['String']['input']>;
  stripe_payment_id?: InputMaybe<Scalars['String']['input']>;
};

export type CartItem = {
  id: Scalars['ID']['output'];
  product: Product;
  product_id: Scalars['ID']['output'];
  quantity: Scalars['Int']['output'];
  user_id: Scalars['ID']['output'];
};

export type Category = {
  color: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  image_path: Scalars['String']['output'];
  name: Scalars['String']['output'];
};

export type CreditCard = {
  card_holder_name: Scalars['String']['output'];
  expiry_date: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  last4: Scalars['String']['output'];
  processor: Scalars['String']['output'];
  stripe_payment_id: Scalars['String']['output'];
  user_id: Scalars['ID']['output'];
};

export type NotificationPreference = {
  allow_email: Scalars['Boolean']['output'];
  allow_general: Scalars['Boolean']['output'];
  allow_order: Scalars['Boolean']['output'];
  id: Scalars['ID']['output'];
  user_id: Scalars['ID']['output'];
};

export type Order = {
  address: Maybe<Address>;
  address_id: Scalars['ID']['output'];
  card_id: Scalars['ID']['output'];
  credit_card: Maybe<CreditCard>;
  date_confirmed: Maybe<Scalars['String']['output']>;
  date_delivered: Maybe<Scalars['String']['output']>;
  date_out_for_delivery: Maybe<Scalars['String']['output']>;
  date_placed: Scalars['String']['output'];
  date_shipped: Maybe<Scalars['String']['output']>;
  id: Scalars['ID']['output'];
  order_item: Array<OrderItem>;
  shipping_method: Scalars['String']['output'];
  status: Scalars['String']['output'];
  total_amount: Scalars['Float']['output'];
  transaction: Array<Transaction>;
  user_id: Scalars['ID']['output'];
};

export type OrderItem = {
  id: Scalars['ID']['output'];
  order_id: Scalars['ID']['output'];
  price_at_purchase: Scalars['Float']['output'];
  product: Product;
  product_id: Scalars['ID']['output'];
  quantity: Scalars['Int']['output'];
};

export type Product = {
  amount: Scalars['String']['output'];
  category: Maybe<Category>;
  category_id: Scalars['ID']['output'];
  color: Scalars['String']['output'];
  description: Scalars['String']['output'];
  discount: Scalars['Float']['output'];
  free_shipping: Scalars['Boolean']['output'];
  id: Scalars['ID']['output'];
  image_path: Scalars['String']['output'];
  is_favorite: Scalars['Boolean']['output'];
  is_new: Scalars['Boolean']['output'];
  name: Scalars['String']['output'];
  price: Scalars['Float']['output'];
  rating: Scalars['Float']['output'];
  review: Array<Review>;
  same_day_delivery: Scalars['Boolean']['output'];
};

export type ProductFilterInput = {
  category_id?: InputMaybe<Scalars['ID']['input']>;
  discount_only?: InputMaybe<Scalars['Boolean']['input']>;
  free_shipping_only?: InputMaybe<Scalars['Boolean']['input']>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  max_price?: InputMaybe<Scalars['Float']['input']>;
  min_price?: InputMaybe<Scalars['Float']['input']>;
  min_rating?: InputMaybe<Scalars['Float']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  same_day_delivery_only?: InputMaybe<Scalars['Boolean']['input']>;
  search?: InputMaybe<Scalars['String']['input']>;
};

export type Review = {
  comment: Scalars['String']['output'];
  created_at: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  product: Maybe<Product>;
  product_id: Scalars['ID']['output'];
  rating: Scalars['Float']['output'];
  user: Maybe<User>;
  user_id: Scalars['ID']['output'];
};

export type RootMutation = {
  addAddress: Address;
  addCard: CreditCard;
  addReview: Review;
  addToCart: CartItem;
  changePassword: Scalars['Boolean']['output'];
  clearCart: Scalars['Boolean']['output'];
  createOrder: Order;
  deleteAddress: Scalars['Boolean']['output'];
  deleteCard: Scalars['Boolean']['output'];
  forgotPassword: Scalars['Boolean']['output'];
  logIn: AuthPayload;
  removeFromCart: Scalars['Boolean']['output'];
  setDefaultAddress: Address;
  setDefaultCard: CreditCard;
  setDefaultCreditCard: CreditCard;
  signUp: User;
  toggleFavorite: Scalars['Boolean']['output'];
  updateAddress: Address;
  updateCartItem: CartItem;
  updateCreditCard: CreditCard;
  updateNotificationPreference: NotificationPreference;
  updateProfile: User;
};


export type RootMutationAddAddressArgs = {
  input: AddressInput;
};


export type RootMutationAddCardArgs = {
  input: CardInput;
};


export type RootMutationAddReviewArgs = {
  comment: Scalars['String']['input'];
  product_id: Scalars['ID']['input'];
  rating: Scalars['Float']['input'];
};


export type RootMutationAddToCartArgs = {
  product_id: Scalars['ID']['input'];
  quantity: Scalars['Int']['input'];
};


export type RootMutationChangePasswordArgs = {
  newPassword: Scalars['String']['input'];
  oldPassword: Scalars['String']['input'];
};


export type RootMutationCreateOrderArgs = {
  address_id: Scalars['ID']['input'];
  card_id: Scalars['ID']['input'];
  shipping_method?: InputMaybe<Scalars['String']['input']>;
};


export type RootMutationDeleteAddressArgs = {
  id: Scalars['ID']['input'];
};


export type RootMutationDeleteCardArgs = {
  id: Scalars['ID']['input'];
};


export type RootMutationForgotPasswordArgs = {
  email: Scalars['String']['input'];
};


export type RootMutationLogInArgs = {
  email: Scalars['String']['input'];
  password: Scalars['String']['input'];
};


export type RootMutationRemoveFromCartArgs = {
  cart_item_id: Scalars['ID']['input'];
};


export type RootMutationSetDefaultAddressArgs = {
  id: Scalars['ID']['input'];
};


export type RootMutationSetDefaultCardArgs = {
  id: Scalars['ID']['input'];
};


export type RootMutationSetDefaultCreditCardArgs = {
  id: Scalars['ID']['input'];
};


export type RootMutationSignUpArgs = {
  email: Scalars['String']['input'];
  number: Scalars['String']['input'];
  password: Scalars['String']['input'];
};


export type RootMutationToggleFavoriteArgs = {
  product_id: Scalars['ID']['input'];
};


export type RootMutationUpdateAddressArgs = {
  id: Scalars['ID']['input'];
  input: AddressInput;
};


export type RootMutationUpdateCartItemArgs = {
  cart_item_id: Scalars['ID']['input'];
  quantity: Scalars['Int']['input'];
};


export type RootMutationUpdateCreditCardArgs = {
  id: Scalars['ID']['input'];
  input: CardInput;
};


export type RootMutationUpdateNotificationPreferenceArgs = {
  allow_email?: InputMaybe<Scalars['Boolean']['input']>;
  allow_general?: InputMaybe<Scalars['Boolean']['input']>;
  allow_order?: InputMaybe<Scalars['Boolean']['input']>;
};


export type RootMutationUpdateProfileArgs = {
  input: UpdateProfileInput;
};

export type RootQuery = {
  cart: Array<CartItem>;
  categories: Array<Category>;
  category: Category;
  me: User;
  order: Order;
  product: Product;
  productReviews: Array<Review>;
  products: Array<Product>;
};


export type RootQueryCategoryArgs = {
  id: Scalars['ID']['input'];
};


export type RootQueryOrderArgs = {
  id: Scalars['ID']['input'];
};


export type RootQueryProductArgs = {
  id: Scalars['ID']['input'];
};


export type RootQueryProductReviewsArgs = {
  product_id: Scalars['ID']['input'];
};


export type RootQueryProductsArgs = {
  filter?: InputMaybe<ProductFilterInput>;
};

export type SignUpInput = {
  email: Scalars['String']['input'];
  name: Scalars['String']['input'];
  password: Scalars['String']['input'];
  phone: Scalars['String']['input'];
};

export type Transaction = {
  amount: Scalars['Float']['output'];
  created_at: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  order_id: Scalars['ID']['output'];
  payment_method: Scalars['String']['output'];
  status: Scalars['String']['output'];
  user_id: Scalars['ID']['output'];
};

export type UpdateProfileInput = {
  email?: InputMaybe<Scalars['String']['input']>;
  image_path?: InputMaybe<Scalars['String']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  phone?: InputMaybe<Scalars['String']['input']>;
};

export type User = {
  address: Array<Address>;
  credit_card: Array<CreditCard>;
  default_address_id: Maybe<Scalars['ID']['output']>;
  default_credit_card_id: Maybe<Scalars['ID']['output']>;
  email: Scalars['String']['output'];
  favorite: Array<Product>;
  id: Scalars['ID']['output'];
  image_path: Scalars['String']['output'];
  name: Scalars['String']['output'];
  notification_preference: NotificationPreference;
  order: Array<Order>;
  phone: Scalars['String']['output'];
  transaction: Array<Transaction>;
};
