import { useNavigate, useSearchParams } from "react-router-dom";

export type CheckoutStep = "delivery" | "address" | "payment";

/**
 * Checkout selections live in the URL, like every other bit of page state:
 *   /checkout/payment?shipping=next-day&address=3&card=7
 * Refresh keeps your place, back walks the steps, and each step can check
 * that the previous ones were actually made.
 */
export function useCheckoutParams() {
  const [params, setParams] = useSearchParams();
  const navigate = useNavigate();

  const shipping = params.get("shipping");
  const addressId = params.get("address");
  const cardId = params.get("card");

  const apply = (next: URLSearchParams, overrides: Record<string, string | null>) => {
    for (const [key, value] of Object.entries(overrides)) {
      if (value) next.set(key, value);
      else next.delete(key);
    }
    return next;
  };

  /** Change a selection on the current step without adding a history entry. */
  const setParam = (key: string, value: string | null) =>
    setParams(apply(new URLSearchParams(params), { [key]: value }), { replace: true });

  /** Move to another step, carrying every selection along. */
  const goTo = (step: CheckoutStep, overrides: Record<string, string | null> = {}) =>
    navigate({
      pathname: `/checkout/${step}`,
      search: apply(new URLSearchParams(params), overrides).toString(),
    });

  return { shipping, addressId, cardId, setParam, goTo, search: params.toString() };
}
