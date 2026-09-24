/**
 * Product and category colours are stored as Flutter ARGB ints serialised to
 * strings ("4294964192" = 0xFFFFF3E0). Drop the alpha byte and return CSS hex.
 */
export function argbToHex(argb: string): string {
  const n = Number(argb);
  if (!Number.isFinite(n)) return "#F4F6F6";
  const rgb = n & 0xffffff;
  return `#${rgb.toString(16).padStart(6, "0")}`;
}
