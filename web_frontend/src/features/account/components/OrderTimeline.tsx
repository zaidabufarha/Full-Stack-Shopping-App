import { Text, Timeline } from "@mantine/core";
import {
  IconCircleCheck,
  IconPackage,
  IconShoppingBag,
  IconTruck,
  IconTruckDelivery,
} from "@tabler/icons-react";
import { formatDate } from "../format";

/** The five date columns on an order, in delivery sequence. */
export type TrackableOrder = {
  date_placed: string;
  date_confirmed?: string | null;
  date_shipped?: string | null;
  date_out_for_delivery?: string | null;
  date_delivered?: string | null;
};

// Same labels as the Flutter Track Order page. A step is done when its date
// is set; the backend fills these in as the order moves along.
const STEPS = [
  { label: "Order Placed", key: "date_placed", icon: IconPackage },
  { label: "Order Confirmed", key: "date_confirmed", icon: IconCircleCheck },
  { label: "Order Shipped", key: "date_shipped", icon: IconTruck },
  { label: "Out for Delivery", key: "date_out_for_delivery", icon: IconTruckDelivery },
  { label: "Order Delivered", key: "date_delivered", icon: IconShoppingBag },
] as const;

type OrderTimelineProps = {
  order: TrackableOrder;
  /** Small version for inside an order card; the full one is for Track Order. */
  compact?: boolean;
};

function OrderTimeline({ order, compact = false }: OrderTimelineProps) {
  const dates = STEPS.map((s) => order[s.key] ?? null);
  // index of the last completed step; -1 would mean none, but placed is always set
  const active = dates.reduce((last, d, i) => (d ? i : last), 0);

  return (
    <Timeline
      active={active}
      color="green"
      bulletSize={compact ? 12 : 36}
      lineWidth={2}
    >
      {STEPS.map((step, i) => {
        const date = dates[i];
        const Icon = step.icon;
        return (
          <Timeline.Item
            key={step.key}
            bullet={compact ? undefined : <Icon size={18} />}
            title={
              <Text fw={600} c={date ? "black" : "dimmed"} size={compact ? "sm" : "md"}>
                {step.label}
              </Text>
            }
          >
            <Text size={compact ? "xs" : "sm"} c={date ? undefined : "dimmed"}>
              {date ? formatDate(date) : "Pending"}
            </Text>
          </Timeline.Item>
        );
      })}
    </Timeline>
  );
}

export default OrderTimeline;
