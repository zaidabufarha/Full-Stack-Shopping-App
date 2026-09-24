import mastercard from "../../assets/mastercard.png";
import paypal from "../../assets/paypal.png";
import visa from "../../assets/visa.png";

// Card processors are stored as the Flutter enum names: visa | mastercard | paypal.
// Used by the cards page and by transactions (payment_method is the same value).
export const PROCESSOR_LOGOS: Record<string, string> = { visa, mastercard, paypal };

export const PROCESSOR_LABELS: Record<string, string> = {
  visa: "Visa Card",
  mastercard: "Master Card",
  paypal: "PayPal",
};
