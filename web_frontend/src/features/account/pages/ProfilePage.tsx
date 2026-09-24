import {
  ActionIcon,
  Avatar,
  Box,
  Button,
  FileButton,
  Group,
  Loader,
  PasswordInput,
  Stack,
  Text,
  TextInput,
  Title,
} from "@mantine/core";
import { isEmail, isNotEmpty, useForm } from "@mantine/form";
import { IconCamera, IconLock, IconMail, IconPhone, IconUser } from "@tabler/icons-react";
import { useEffect, useState } from "react";
import { useAppSelector } from "../../../app/hooks";
import { useFieldProps } from "../../auth/useFieldProps";
import {
  useChangePasswordMutation,
  useGetUserDataQuery,
  useUpdateProfileMutation,
  useUpdateProfilePictureMutation,
} from "../accountApi";
import AccountShell from "../components/AccountShell";

// Same unsigned upload the Flutter app uses. Both values are public by design:
// an unsigned preset is how a client uploads without holding an API secret.
const CLOUDINARY_UPLOAD_URL = "https://api.cloudinary.com/v1_1/jz8fffg2/image/upload";
const CLOUDINARY_PRESET = "big_cart";

type ProfileValues = {
  name: string;
  email: string;
  phone: string;
  currentPassword: string;
  newPassword: string;
  confirmPassword: string;
};

function ProfilePage() {
  const isLoggedIn = Boolean(useAppSelector((s) => s.auth.token));
  const { data: user, isLoading, error } = useGetUserDataQuery(undefined, { skip: !isLoggedIn });

  const [updateProfile, profileState] = useUpdateProfileMutation();
  const [changePassword, passwordState] = useChangePasswordMutation();
  const [updatePicture, pictureState] = useUpdateProfilePictureMutation();

  const [uploading, setUploading] = useState(false);
  const [uploadError, setUploadError] = useState<string | null>(null);
  const [saved, setSaved] = useState(false);

  const form = useForm<ProfileValues>({
    mode: "controlled",
    initialValues: {
      name: "",
      email: "",
      phone: "",
      currentPassword: "",
      newPassword: "",
      confirmPassword: "",
    },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      name: isNotEmpty("Cannot be empty"),
      email: isEmail("Enter a valid email"),
      phone: isNotEmpty("Cannot be empty"),
      // The password block is optional as a whole, required as a set. Only the
      // New/Confirm fields count as "wanting a change" — password managers
      // autofill "Current password" on their own, which used to trip this.
      currentPassword: (v, values) =>
        wantsPasswordChange(values) && !v ? "Current password required" : null,
      newPassword: (v, values) =>
        wantsPasswordChange(values) && (v.length < 8 || v.length > 72)
          ? "Password must be between 8 and 72 characters"
          : null,
      confirmPassword: (v, values) =>
        wantsPasswordChange(values) && v !== values.newPassword ? "Passwords don't match" : null,
    },
  });
  const { field, revealAll } = useFieldProps(form);

  useEffect(() => {
    if (!user) return;
    form.initialize({
      name: user.name,
      email: user.email,
      phone: user.phone,
      currentPassword: "",
      newPassword: "",
      confirmPassword: "",
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user]);

  const handlePicture = async (file: File | null) => {
    if (!file) return;
    setUploading(true);
    setUploadError(null);
    try {
      const body = new FormData();
      body.append("file", file);
      body.append("upload_preset", CLOUDINARY_PRESET);
      const res = await fetch(CLOUDINARY_UPLOAD_URL, { method: "POST", body });
      const json = (await res.json()) as { secure_url?: string; error?: { message?: string } };
      if (!res.ok || !json.secure_url) {
        throw new Error(json.error?.message ?? "Upload failed");
      }
      await updatePicture({ imagePath: json.secure_url }).unwrap();
    } catch (e) {
      setUploadError(e instanceof Error ? e.message : "Upload failed");
    } finally {
      setUploading(false);
    }
  };

  const handleSubmit = async (values: ProfileValues) => {
    setSaved(false);
    try {
      // password first: a wrong current password should stop everything,
      // not leave the profile changed and the password not
      if (wantsPasswordChange(values)) {
        await changePassword({
          oldPassword: values.currentPassword,
          newPassword: values.newPassword,
        }).unwrap();
      }
      await updateProfile({
        name: values.name.trim(),
        email: values.email.trim(),
        phone: values.phone.trim(),
      }).unwrap();
      form.setValues({ currentPassword: "", newPassword: "", confirmPassword: "" });
      setSaved(true);
    } catch {
      // rendered below via the mutation errors
    }
  };

  const saveError = passwordState.error ?? profileState.error;
  const isSaving = passwordState.isLoading || profileState.isLoading;

  return (
    <AccountShell title="About me" isLoading={isLoading} error={error}>
      {user && (
        <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
          <Stack gap="xl">
            {/* picture */}
            <Stack gap="xs" align="center">
              <Box pos="relative">
                <Avatar src={user.image_path} size={112} radius="xl" color="green">
                  <IconUser size={48} />
                </Avatar>
                {(uploading || pictureState.isLoading) && (
                  <Box
                    pos="absolute"
                    inset={0}
                    display="flex"
                    style={{
                      alignItems: "center",
                      justifyContent: "center",
                      borderRadius: 999,
                      background: "rgba(255,255,255,0.7)",
                    }}
                  >
                    <Loader color="green" size="sm" />
                  </Box>
                )}
                <FileButton onChange={handlePicture} accept="image/*" disabled={uploading}>
                  {(props) => (
                    <ActionIcon
                      {...props}
                      pos="absolute"
                      bottom={0}
                      right={0}
                      variant="filled"
                      color="green"
                      radius="xl"
                      size="lg"
                      aria-label="Change profile picture"
                    >
                      <IconCamera size={18} />
                    </ActionIcon>
                  )}
                </FileButton>
              </Box>
              {(uploadError || pictureState.error) && (
                <Text c="red" size="sm">
                  {uploadError ?? pictureState.error?.message ?? "Upload failed"}
                </Text>
              )}
            </Stack>

            {/* personal details */}
            <Stack gap="sm">
              <Title order={4}>Personal Details</Title>
              <TextInput placeholder="Name" leftSection={<IconUser size={18} />} {...field("name")} />
              <TextInput
                placeholder="Email address"
                leftSection={<IconMail size={18} />}
                {...field("email")}
              />
              <TextInput placeholder="Phone number" leftSection={<IconPhone size={18} />} {...field("phone")} />
            </Stack>

            {/* change password */}
            <Stack gap="sm">
              <Title order={4}>Change Password</Title>
              <Text size="sm">Leave these empty to keep your current password.</Text>
              <PasswordInput
                placeholder="Current password"
                autoComplete="current-password"
                leftSection={<IconLock size={18} />}
                {...field("currentPassword")}
              />
              <PasswordInput
                placeholder="New password"
                autoComplete="new-password"
                leftSection={<IconLock size={18} />}
                {...field("newPassword")}
              />
              <PasswordInput
                placeholder="Confirm password"
                autoComplete="new-password"
                leftSection={<IconLock size={18} />}
                {...field("confirmPassword")}
              />
            </Stack>

            {saveError && (
              <Text c="red" ta="center">
                {saveError.message ?? "Something went wrong"}
              </Text>
            )}
            {saved && !saveError && (
              <Text c="green" ta="center">
                Settings saved.
              </Text>
            )}

            <Group justify="flex-end">
              <Button type="submit" h={48} fz="md" w={200} loading={isSaving}>
                Save settings
              </Button>
            </Group>
          </Stack>
        </form>
      )}
    </AccountShell>
  );
}

function wantsPasswordChange(v: Pick<ProfileValues, "newPassword" | "confirmPassword">) {
  return Boolean(v.newPassword || v.confirmPassword);
}

export default ProfilePage;
