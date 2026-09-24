import {
  ActionIcon,
  Box,
  Divider,
  Group,
  Stack,
  Text,
  TextInput,
  Title,
} from "@mantine/core";
import logo from "../../assets/logo.png";
import visa from "../../assets/visa.png";
import mastercard from "../../assets/mastercard.png";
import paypal from "../../assets/paypal.png";

import SocialIcon from "./SocialIcon";
import {
  IconBrandFacebook,
  IconBrandInstagram,
  IconBrandLinkedin,
  IconBrandTiktok,
  IconBrandX,
  IconSend2,
} from "@tabler/icons-react";
import { useForm, isEmail } from "@mantine/form";
import { useFieldProps } from "../../features/auth/useFieldProps";

function Footer() {
  // same setup as the login form: errors appear after the first blur (or a
  // submit attempt), then update live until the address is valid
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: { email: isEmail("Enter a valid email") },
  });
  const { field, revealAll } = useFieldProps(form);

  const handleSubmit = ({ email }: { email: string }) => {
    // Placeholder for the real call (GraphQL mutation -> Resend, rate-limited
    // server-side). Clearing the field afterwards means a second send needs
    // the address typed again — a mild speed bump, not a rate limit.
    alert(`Subscribed ${email} to the newsletter (placeholder — no email is sent yet).`);
    form.reset();
  };

  return (
    <Box h={577} p={90}>
      <Group justify="space-between" align="flex-start">
        <Stack w={300}>
          <img src={logo} width={200} alt="BigCart" />
          <Text>
            Fresh groceries, fast delivery, unbeatable prices, BigCart has it
            all
          </Text>
        </Stack>
        {/* note do something about the colors this is ridiculous */}
        <Stack ta={"center"} gap={30}>
          <Title order={3}>Account</Title>
          <Text>Wishlist</Text>
          <Text>Cart</Text>
          <Text>Track Order</Text>
          <Text>Shipping Details</Text>
        </Stack>
        <Stack ta={"center"} gap={30}>
          <Title order={3}>Useful Links</Title>
          <Text>About Us</Text>
          <Text>Contact</Text>
          <Text>Deals</Text>
          <Text>Promotions</Text>
          <Text>New Products</Text>
        </Stack>
        <Stack ta={"center"} gap={30}>
          <Title order={3}>Help Center</Title>
          <Text>Payments</Text>
          <Text>Refund Methods</Text>
          <Text>Checkout</Text>
          <Text>Shipping</Text>
          <Text>Privacy Policy</Text>
        </Stack>
        <Stack ta={"left"} h={200} w={400} mr={40}>
          <Title order={1}>Join the BigCart newsletter</Title>
          <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
            <TextInput
              w={400}
              styles={{
                input: {
                  backgroundColor: "#F0F0F0",
                  height: 100,
                  border: "none",
                },
              }}
              size="xl"
              placeholder="Your email address"
              {...field("email")}
              // sections are pointer-events:none by default; the send button
              // needs clicks
              rightSectionPointerEvents="all"
              rightSection={
                <ActionIcon
                  type="submit"
                  bg={"green"}
                  size={40}
                  mr={20}
                  aria-label="Subscribe"
                >
                  <IconSend2 color="white" />
                </ActionIcon>
              }
            />
          </form>
        </Stack>
      </Group>
      <Divider my={30} />
      <Group justify="space-between" h={100} align="flex-start">
        <Group gap={40}>
          <img src={visa} width={100} />
          <img src={mastercard} width={80} />
          <img src={paypal} height={40} />
        </Group>
        <Title order={3} fw={500}>
          ©2025. All rights reserved
        </Title>
        <Group gap={12}>
          <SocialIcon label="Facebook" icon={IconBrandFacebook} />
          <SocialIcon label="Instagram" icon={IconBrandInstagram} />
          <SocialIcon label="TikTok" icon={IconBrandTiktok} />
          <SocialIcon label="X" icon={IconBrandX} />
          <SocialIcon label="LinkedIn" icon={IconBrandLinkedin} />
        </Group>
      </Group>
    </Box>
  );
}

export default Footer;
