import { baseApi } from "../../app/service/baseApi";
import type {
  GetCategoriesQuery,
  GetProductsQuery,
  GetProductReviewsQuery,
  GetProductReviewsQueryVariables,
  GetFavoritesQuery,
  GetCartQuery,
  AddToCartMutation,
  AddToCartMutationVariables,
  UpdateCartItemMutation,
  UpdateCartItemMutationVariables,
  RemoveFromCartMutation,
  RemoveFromCartMutationVariables,
  ToggleFavoriteMutation,
  ToggleFavoriteMutationVariables,
  AddReviewMutation,
  AddReviewMutationVariables,
  CreateOrderMutation,
  CreateOrderMutationVariables,
} from "../../gql/operations";

// Documents are lifted verbatim from the Flutter client's BuyRemoteDataSource.
// Two deviations: updateCartItem/removeFromCart take the cart_item id directly
// (getCart already returns it, so Flutter's GetCartIds lookup isn't needed), and
// addAddress/addCard live in accountApi rather than being inlined into checkout.

const GET_CATEGORIES = /* GraphQL */ `
  query GetCategories {
    categories {
      id
      name
      image_path
      color
    }
  }
`;

const GET_PRODUCTS = /* GraphQL */ `
  query GetProducts {
    products {
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
      free_shipping
      same_day_delivery
      category {
        id
        name
        image_path
        color
      }
      review {
        id
        rating
        comment
        created_at
        user {
          name
          email
          phone
          image_path
        }
      }
    }
  }
`;

const GET_PRODUCT_REVIEWS = /* GraphQL */ `
  query GetProductReviews($productId: ID!) {
    productReviews(product_id: $productId) {
      id
      rating
      comment
      created_at
      user {
        name
        email
        phone
        image_path
      }
    }
  }
`;

const GET_FAVORITES = /* GraphQL */ `
  query GetFavorites {
    me {
      favorite {
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
        free_shipping
        same_day_delivery
        category {
          id
          name
          image_path
          color
        }
      }
    }
  }
`;

const GET_CART = /* GraphQL */ `
  query GetCart {
    cart {
      id
      quantity
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
        free_shipping
        same_day_delivery
        category {
          id
          name
          image_path
          color
        }
      }
    }
  }
`;

const ADD_TO_CART = /* GraphQL */ `
  mutation AddToCart($productId: ID!, $quantity: Int!) {
    addToCart(product_id: $productId, quantity: $quantity) {
      id
    }
  }
`;

const UPDATE_CART_ITEM = /* GraphQL */ `
  mutation UpdateCartItem($id: ID!, $quantity: Int!) {
    updateCartItem(cart_item_id: $id, quantity: $quantity) {
      id
    }
  }
`;

const REMOVE_FROM_CART = /* GraphQL */ `
  mutation RemoveFromCart($id: ID!) {
    removeFromCart(cart_item_id: $id)
  }
`;

const TOGGLE_FAVORITE = /* GraphQL */ `
  mutation ToggleFavorite($productId: ID!) {
    toggleFavorite(product_id: $productId)
  }
`;

const ADD_REVIEW = /* GraphQL */ `
  mutation AddReview($productId: ID!, $rating: Float!, $comment: String!) {
    addReview(product_id: $productId, rating: $rating, comment: $comment) {
      id
    }
  }
`;

const CREATE_ORDER = /* GraphQL */ `
  mutation CreateOrder($addressId: ID!, $cardId: ID!, $shippingMethod: String) {
    createOrder(address_id: $addressId, card_id: $cardId, shipping_method: $shippingMethod) {
      id
    }
  }
`;

export const buyApi = baseApi.injectEndpoints({
  endpoints: (build) => ({
    getCategories: build.query<GetCategoriesQuery["categories"], void>({
      query: () => ({ document: GET_CATEGORIES }),
      providesTags: ["Category"],
    }),

    getProducts: build.query<GetProductsQuery["products"], void>({
      query: () => ({ document: GET_PRODUCTS }),
      // one tag per row plus a LIST sentinel, so a single product's mutation
      // refetches this list without every detail query needing to
      providesTags: (result) => [
        { type: "Product", id: "LIST" },
        ...(result ?? []).map((p) => ({ type: "Product" as const, id: p.id })),
      ],
    }),

    getProductReviews: build.query<
      GetProductReviewsQuery["productReviews"],
      GetProductReviewsQueryVariables
    >({
      query: (variables) => ({ document: GET_PRODUCT_REVIEWS, variables }),
      providesTags: (_result, _error, { productId }) => [
        { type: "Review", id: productId },
      ],
    }),

    getFavorites: build.query<GetFavoritesQuery["me"]["favorite"], void>({
      query: () => ({ document: GET_FAVORITES }),
      // the base query unwraps to `me`; hand pages the list they actually want
      transformResponse: (me: GetFavoritesQuery["me"]) => me.favorite,
      providesTags: ["User"],
    }),

    getCart: build.query<GetCartQuery["cart"], void>({
      query: () => ({ document: GET_CART }),
      providesTags: ["Cart"],
    }),

    addToCart: build.mutation<AddToCartMutation["addToCart"], AddToCartMutationVariables>({
      query: (variables) => ({ document: ADD_TO_CART, variables }),
      invalidatesTags: ["Cart"],
    }),

    updateCartItem: build.mutation<
      UpdateCartItemMutation["updateCartItem"],
      UpdateCartItemMutationVariables
    >({
      query: (variables) => ({ document: UPDATE_CART_ITEM, variables }),
      invalidatesTags: ["Cart"],
    }),

    removeFromCart: build.mutation<
      RemoveFromCartMutation["removeFromCart"],
      RemoveFromCartMutationVariables
    >({
      query: (variables) => ({ document: REMOVE_FROM_CART, variables }),
      invalidatesTags: ["Cart"],
    }),

    toggleFavorite: build.mutation<
      ToggleFavoriteMutation["toggleFavorite"],
      ToggleFavoriteMutationVariables
    >({
      query: (variables) => ({ document: TOGGLE_FAVORITE, variables }),
      // is_favorite lives on the product; the favorites list hangs off `me`
      invalidatesTags: (_result, _error, { productId }) => [
        { type: "Product", id: productId },
        "User",
      ],
    }),

    addReview: build.mutation<AddReviewMutation["addReview"], AddReviewMutationVariables>({
      query: (variables) => ({ document: ADD_REVIEW, variables }),
      // the review list gains a row and the backend rewrites product.rating
      invalidatesTags: (_result, _error, { productId }) => [
        { type: "Review", id: productId },
        { type: "Product", id: productId },
      ],
    }),

    createOrder: build.mutation<
      CreateOrderMutation["createOrder"],
      CreateOrderMutationVariables
    >({
      query: (variables) => ({ document: CREATE_ORDER, variables }),
      // empties the cart; orders and transactions hang off `me`
      invalidatesTags: ["Cart", "User"],
    }),
  }),
});

export const {
  useGetCategoriesQuery,
  useGetProductsQuery,
  useGetProductReviewsQuery,
  useGetFavoritesQuery,
  useGetCartQuery,
  useAddToCartMutation,
  useUpdateCartItemMutation,
  useRemoveFromCartMutation,
  useToggleFavoriteMutation,
  useAddReviewMutation,
  useCreateOrderMutation,
} = buyApi;
