/** "32 minutes ago", "3 days ago" — for review timestamps. */
export function timeAgo(iso: string): string {
  const seconds = Math.max(0, Math.floor((Date.now() - new Date(iso).getTime()) / 1000));
  const units: [label: string, seconds: number][] = [
    ["year", 31536000],
    ["month", 2592000],
    ["week", 604800],
    ["day", 86400],
    ["hour", 3600],
    ["minute", 60],
  ];
  for (const [label, size] of units) {
    const n = Math.floor(seconds / size);
    if (n >= 1) return `${n} ${label}${n === 1 ? "" : "s"} ago`;
  }
  return "just now";
}
