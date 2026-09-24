import { useNavigate } from "react-router-dom";
import { useAppSelector } from "../../app/hooks";
import {
  useAddToCartMutation,
  useGetCartQuery,
  useRemoveFromCartMutation,
  useToggleFavoriteMutation,
  useUpdateCartItemMutation,
} from "./buyApi";
import type { GetCartQuery } from "../../gql/operations";

/**
 * The product shape a cart row carries. The home-page product (which also has
 * `review`) is a superset, so both cards and cart rows can call these.
 */
type CartProduct = GetCartQuery["cart"][number]["product"];

/**
 * Everything a page needs to drive ProductCard's cart strip and heart:
 * the current cart quantity per product, and the add / update / remove
 * decision behind "I want this many now". Logged-out clicks go to /login.
 *
 * The cart query is skipped while logged out (it's per-user), and every
 * mutation here is optimistic — see buyApi — so the UI moves instantly.
 */
export function useCart() {
  const navigate = useNavigate();
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));

  const { data: cart = [] } = useGetCartQuery(undefined, { skip: !isLoggedIn });

  const [addToCart] = useAddToCartMutation();
  const [updateCartItem] = useUpdateCartItemMutation();
  const [removeFromCart] = useRemoveFromCartMutation();
  const [toggleFavoriteMutation] = useToggleFavoriteMutation();

  const itemFor = (productId: string) =>
    cart.find((item) => item.product.id === productId);

  const quantityOf = (productId: string) => itemFor(productId)?.quantity ?? 0;

  const requireLogin = () => {
    if (isLoggedIn) return true;
    navigate("/login");
    return false;
  };

  /** Set the cart quantity for a product; 0 removes it. */
  const changeQuantity = (product: CartProduct, next: number) => {
    if (!requireLogin()) return;
    const item = itemFor(product.id);
    if (!item) {
      if (next > 0) addToCart({ productId: product.id, quantity: next, product });
    } else if (next <= 0) {
      removeFromCart({ id: item.id });
    } else {
      updateCartItem({ id: item.id, quantity: next });
    }
  };

  const toggleFavorite = (product: { id: string }) => {
    if (!requireLogin()) return;
    toggleFavoriteMutation({ productId: product.id });
  };

  return { isLoggedIn, quantityOf, changeQuantity, toggleFavorite };
}
