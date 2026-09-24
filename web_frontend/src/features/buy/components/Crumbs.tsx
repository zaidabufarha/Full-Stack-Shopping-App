import { Anchor, Breadcrumbs, Text } from "@mantine/core";
import { Link } from "react-router-dom";
import { slugify } from "../slug";

export type Crumb = { label: string; to?: string };

type CrumbsProps = { items: Crumb[] };

/** One breadcrumb style for every page: links dimmed, the current page black. */
function Crumbs({ items }: CrumbsProps) {
  return (
    <Breadcrumbs>
      {items.map((crumb) =>
        crumb.to ? (
          <Anchor key={crumb.label} component={Link} to={crumb.to} fz="sm" fw={400} c="dimmed">
            {crumb.label}
          </Anchor>
        ) : (
          <Text key={crumb.label} fz="sm" fw={500} c="black">
            {crumb.label}
          </Text>
        ),
      )}
    </Breadcrumbs>
  );
}

type CrumbProduct = {
  id: string;
  name: string;
  category?: { name: string } | null;
};

/**
 * Home › Category › Product, plus an optional current-page tail.
 * Without a tail the product is the current page (plain text); with one it
 * becomes a link back and the tail is the current page.
 */
export function productCrumbs(product: CrumbProduct, tail?: string): Crumb[] {
  const crumbs: Crumb[] = [{ label: "Home", to: "/" }];
  if (product.category) {
    crumbs.push({
      label: product.category.name,
      to: `/?category=${slugify(product.category.name)}`,
    });
  }
  crumbs.push(
    tail ? { label: product.name, to: `/product/${product.id}` } : { label: product.name },
  );
  if (tail) crumbs.push({ label: tail });
  return crumbs;
}

export default Crumbs;
