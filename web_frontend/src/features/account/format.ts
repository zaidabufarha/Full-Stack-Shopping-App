// Dates and money are shown on four account pages; formatting them in one
// place is what keeps "Oct 19, 2021" from becoming "10/19/2021" on another.

/** "Oct 19, 2021" */
export function formatDate(iso: string): string {
  return new Date(iso).toLocaleDateString(undefined, { dateStyle: "medium" });
}

/** "Dec 12, 2021 at 10:00 pm" — the transactions list format from the app. */
export function formatDateTime(iso: string): string {
  const d = new Date(iso);
  const date = d.toLocaleDateString(undefined, { month: "short", day: "numeric", year: "numeric" });
  const time = d.toLocaleTimeString(undefined, { hour: "numeric", minute: "2-digit" }).toLowerCase();
  return `${date} at ${time}`;
}

export function money(n: number): string {
  return `$${n.toFixed(2)}`;
}
