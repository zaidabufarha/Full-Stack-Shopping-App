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
  IconSearch,
  IconSend2,
} from "@tabler/icons-react";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

function Footer() {
  const [email, setEmail] = useState("");
  const navigate = useNavigate();

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
          <form
            onSubmit={(e) => {
              e.preventDefault();
              //implement a newsletter confirmation. per api hourly limit.
            }}
          >
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
              onChange={(e) => {
                setEmail(e.currentTarget.value);
              }}
              rightSection={
                <ActionIcon bg={"#13C906"} size={40} mr={20}>
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
