import { TextInput } from "@mantine/core";
import { CountrySelector, usePhoneInput } from "react-international-phone";
import type { FocusEvent, ReactNode } from "react";
import "react-international-phone/style.css";

type PhoneFieldProps = {
  // optional because getInputProps' return type widens value, even in controlled mode
  value?: string;
  onChange: (phone: string) => void;
  onBlur?: (event: FocusEvent<HTMLInputElement>) => void;
  error?: ReactNode;
};

function PhoneField({ value, onChange, onBlur, error }: PhoneFieldProps) {
  const { inputValue, country, setCountry, handlePhoneValueChange, inputRef } =
    usePhoneInput({
      defaultCountry: "jo",
      value: value ?? "",
      onChange: ({ phone }) => onChange(phone),
    });

  return (
    <TextInput
      size="xl"
      w={500}
      label="Phone"
      placeholder="Enter your phone number"
      type="tel"
      value={inputValue}
      onChange={handlePhoneValueChange}
      onBlur={onBlur}
      error={error}
      ref={inputRef}
      leftSectionWidth={72}
      // Mantine's input section is z-index:1 and creates a stacking context, so the
      // country dropdown can't paint over later fields unless the section itself lifts
      styles={{ section: { zIndex: 5 } }}
      leftSectionPointerEvents="all"
      leftSection={
        <CountrySelector
          selectedCountry={country.iso2}
          onSelect={({ iso2 }) => setCountry(iso2)}
          buttonStyle={{ border: "none", background: "transparent" }}
          dropdownStyleProps={{ style: { zIndex: 300 } }}
        />
      }
    />
  );
}

export default PhoneField;
