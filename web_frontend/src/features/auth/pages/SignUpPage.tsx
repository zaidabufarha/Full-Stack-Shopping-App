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
  Button,
  PinInput,
  Anchor,
} from "@mantine/core";
import vegetables from "../../../assets/auth_veg.jpg";
import PhoneField from "../components/PhoneField";
import { useForm, isEmail } from "@mantine/form";
import { isValidPhoneNumber } from "libphonenumber-js";
import { useFieldProps } from "../useFieldProps";
import google from "../../../assets/google_logo.svg";
import { IconLock, IconMail } from "@tabler/icons-react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import { useSignUpMutation, useLogInMutation } from "../authApi";

function SignUpPage() {
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "", phone: "", password: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      email: isEmail("Enter a valid email"),
      phone: (value) =>
        isValidPhoneNumber(value) ? null : "Enter a valid phone number",
      // mirrors the backend's validator.isLength(password, { min: 8, max: 72 })
      // 72 is bcrypt's truncation point, not an arbitrary cap
      password: (value) =>
        value.length < 8 || value.length > 72
          ? "Password must be between 8 and 72 characters"
          : null,
    },
  });
  const { field, revealAll } = useFieldProps(form);

  const [signUp, { isLoading, error, reset: resetSignUp }] =
    useSignUpMutation();
  const navigate = useNavigate();

  const [logIn, { isLoading: isLoggingIn, error: logInError }] =
    useLogInMutation();

  // The OTP step lives in this component rather than its own route so the
  // credentials stay in `form.values` — logging in afterwards needs the
  // password, and passing it through router state would put it in history.
  const [step, setStep] = useState<"form" | "otp">("form");
  const [code, setCode] = useState("");
  const [codeError, setCodeError] = useState<string | null>(null);

  // Submitting the form only advances to the OTP step — the account is not
  // created until the code is verified, so backing out leaves nothing behind
  // and a half-created unverified user can't exist.
  const handleSubmit = () => {
    resetSignUp(); // drop any error from a previous attempt
    setStep("otp");
  };

  // No OTP in the schema, so the code is simulated. A correct code is what
  // gates the real signUp, and logIn afterwards is what produces the token.
  const handleVerify = async () => {
    if (code !== "123456") {
      setCodeError("That code isn't right. Try 123456.");
      return;
    }
    setCodeError(null);

    try {
      await signUp({
        email: form.values.email,
        number: form.values.phone,
        password: form.values.password,
      }).unwrap();
    } catch {
      // Rejections here are about the details themselves (email already in
      // use, phone taken), so send them back to the step where those are
      // editable. `error` survives the step change and renders there.
      setStep("form");
      return;
    }

    try {
      await logIn({
        email: form.values.email,
        password: form.values.password,
        remember: true,
      }).unwrap();
      navigate("/");
    } catch {
      // account exists but the session didn't start; logInError renders below
    }
  };

  // +962791234567 -> +962 ***** 4567
  const maskedPhone = form.values.phone.replace(
    /^(\+\d{1,3})(\d+)(\d{4})$/,
    (_m, code, middle, tail) => `${code} ${"*".repeat(middle.length)} ${tail}`,
  );
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
          {step === "otp" ? (
            <Stack gap={30} p={100} align="center">
              <Stack gap={10}>
                <Title ta={"center"}>Confirm it's You</Title>
                <Text ta={"center"}>Enter the code sent to {maskedPhone}</Text>
              </Stack>
              <PinInput
                length={6}
                size="xl"
                oneTimeCode
                type="number"
                placeholder=""
                value={code}
                onChange={(value) => {
                  setCode(value);
                  setCodeError(null);
                }}
                error={Boolean(codeError)}
                radius="md"
                styles={{
                  // green outline like the mockup, but let the error state win
                  // so a bad code still turns the boxes red
                  input: codeError
                    ? undefined
                    : {
                        borderColor: "var(--mantine-color-green-6)",
                        borderWidth: 2,
                      },
                }}
              />
              <Text>
                {"Haven't received the code yet? "}
                <Anchor
                  component="button"
                  type="button"
                  fw={600}
                  c="green"
                  onClick={() =>
                    alert("SMS is simulated. The code is always 123456.")
                  }
                >
                  Resend the code
                </Anchor>
              </Text>
              {(codeError || logInError) && (
                <Text c="red" w={500} ta="center">
                  {codeError ?? logInError?.message}
                </Text>
              )}
              <Button
                type="button"
                variant="gradient"
                w={500}
                loading={isLoading || isLoggingIn}
                disabled={code.length < 6}
                onClick={handleVerify}
              >
                Verify
              </Button>
              <Anchor
                component="button"
                type="button"
                c="black"
                onClick={() => setStep("form")}
              >
                Wrong number? Go back
              </Anchor>
            </Stack>
          ) : (
            <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
              <Stack gap={30} p={100} align="center">
                <Stack>
                  <Title ta={"center"}>Welcome!</Title>
                  <Text ta={"center"}>Create an account</Text>
                </Stack>
                <TextInput
                  size="xl"
                  w={500}
                  label={"Email"}
                  placeholder="Enter your email"
                  leftSection={<IconMail />}
                  {...field("email")}
                />
                <PhoneField {...field("phone")} />
                <PasswordInput
                  size="xl"
                  w={500}
                  label={"Password"}
                  placeholder="Enter your password"
                  leftSection={<IconLock />}
                  {...field("password")}
                />

                {error && (
                  <Text c="red" w={500} ta="center">
                    {error.message}
                  </Text>
                )}
                <Button type="submit" variant="gradient" w={500}>
                  Sign up
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
                  {"Already have an account? "}
                  <Text span fw={600} c={"black"}>
                    Sign in
                  </Text>
                </Text>
                <Text w={500} ta={"center"} c={"black"}>
                  {"By signing up, you agree to our "}
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
          )}
        </Grid.Col>
      </Grid>
    </Box>
  );
}

export default SignUpPage;
