/**
 * Shipping methods. `value` is the URL slug, `label` is the string stored on
 * the order (Flutter's names, so both clients write the same thing).
 *
 * Prices are client-side for now — the backend stores only the method name
 * and doesn't add shipping to total_amount. When it becomes the source of
 * truth (a shippingMethods query), this file is what gets replaced.
 */
export type ShippingMethod = {
  value: string;
  label: string;
  price: number;
  description: string;
};

export const SHIPPING_METHODS: ShippingMethod[] = [
  {
    value: "standard",
    label: "Standard Delivery",
    price: 3,
    description: "Delivered to your doorstep in 3–4 business days.",
  },
  {
    value: "next-day",
    label: "Next Day Delivery",
    price: 5,
    description: "Order today, delivered the next business day.",
  },
  {
    value: "nominated",
    label: "Nominated Delivery",
    price: 3,
    description: "Pick the day; delivered in a two-hour window.",
  },
];

export const DEFAULT_SHIPPING = SHIPPING_METHODS[0];

export function findShipping(value: string | null | undefined): ShippingMethod | undefined {
  return SHIPPING_METHODS.find((m) => m.value === value);
}
