/**
 * "Edible oil" -> "edible-oil". Category URLs use this instead of the database
 * id, which only works because category names are unique.
 */
export function slugify(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}
