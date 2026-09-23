import {
  Box,
  Grid,
  Title,
  Image,
  Text,
  Divider,
  Stack,
  TextInput,
  PasswordInput,
  Group,
  Switch,
  Button,
} from "@mantine/core";
import vegetables from "../../../assets/auth_veg.jpg";
import { useForm, isEmail, isNotEmpty } from "@mantine/form";
import { useFieldProps } from "../useFieldProps";
import google from "../../../assets/google_logo.svg";
import {
  IconBrandGoogle,
  IconLock,
  IconMail,
} from "@tabler/icons-react";
function LoginPage() {
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "", password: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      email: isEmail("Enter a valid email"),
      password: isNotEmpty("Cannot be empty"),
    },
  });
  const { field, revealAll } = useFieldProps(form);

  // placeholder until the RTK Query mutation exists
  const handleSubmit = (values: typeof form.values) => {
    alert(JSON.stringify(values, null, 2));
  };

  return (
    <Box>
      <Grid>
        <Grid.Col span={5}>
          <Box pos={"relative"}>
            <Image
              src={vegetables}
              h={"85vh"}
              style={{ borderRadius: "0 24px 24px 0" }}
              fit="cover"
            />
            <Box
              pos={"absolute"}
              inset={0}
              p={80}
              display={"flex"}
              style={{
                alignItems: "flex-end",
                justifyContent: "center",
                borderRadius: "0 24px 24px 0",
                background:
                  "linear-gradient(180deg, rgba(30,30,30,0) 4%, rgba(30,30,30,0.26) 57%, rgba(30,30,30,1) 87%)",
              }}
            >
              <Stack>
                <Title c={"white"} ta={"center"}>
                  Welcome to BigCart
                </Title>
                <Title order={3} ta={"center"} c={"white"}>
                  Find all your daily needs here with low prices, fast delivery,
                  and no hassle.
                </Title>
              </Stack>
            </Box>
          </Box>
        </Grid.Col>
        <Grid.Col span={6}>
          <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
          <Stack gap={30} p={100} align="center">
            <Stack>
              <Title ta={"center"}>Welcome Back!</Title>
              <Text ta={"center"}>Sign In to your account</Text>
            </Stack>
            <TextInput
              size="xl"
              w={500}
              label={"Email"}
              placeholder="Enter your email"
              leftSection={<IconMail />}
              {...field("email")}
            />
            <PasswordInput
              size="xl"
              w={500}
              label={"Password"}
              placeholder="Enter your password"
              leftSection={<IconLock />}
              {...field("password")}
            />
            <Group justify="space-between" w={500}>
              <Group>
                <Switch />
                <Text>Remember me</Text>
              </Group>
              <Text>Forgot password?</Text>
            </Group>
            <Button type="submit" variant="gradient" w={500}>
              Sign In
            </Button>
            <Divider w={500} label="or" labelPosition="center" />
            <Button
              type="button"
              onClick={() => alert("Still no google integration")}
              variant="default"
              w={500}
              leftSection={<img src={google} />}
            >
              Continue with Google
            </Button>
            <Text c={"black"}>
              {"Don't have an account? "}
              <Text span fw={600} c={"black"}>
                Sign in
              </Text>
            </Text>
            <Text w={500} ta={"center"} c={"black"}>
              {"By signing in, you agree to our "}
              <Text span fw={600} c={"black"}>
                Terms and Conditions.
              </Text>
              {" Learn how we use your data in our "}{" "}
              <Text span fw={600} c={"black"}>
                Privacy Policy.
              </Text>
            </Text>
          </Stack>
          </form>
        </Grid.Col>
      </Grid>
    </Box>
  );
}

export default LoginPage;
