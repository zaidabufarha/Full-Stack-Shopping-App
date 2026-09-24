import { useState } from "react";
import type { UseFormReturnType } from "@mantine/form";
import type { FocusEvent } from "react";

/**
 * Wraps form.getInputProps so an error only shows once the field has been
 * blurred, or once a submit has been attempted. The form validates on every
 * change, so after either of those the message updates live and disappears
 * the moment the value is valid.
 *
 * Mantine's own `touched` is set on focus rather than blur, so it can't gate
 * this on its own.
 *
 * Pass `revealAll` as the second argument to form.onSubmit so a failed submit
 * surfaces errors on fields the user never visited.
 */
export function useFieldProps<V extends Record<string, unknown>>(
  form: UseFormReturnType<V>,
) {
  const [blurred, setBlurred] = useState<Record<string, boolean>>({});
  const [submitAttempted, setSubmitAttempted] = useState(false);

  const field = (name: Extract<keyof V, string>) => {
    const props = form.getInputProps(name);

    return {
      ...props,
      error: blurred[name] || submitAttempted ? props.error : null,
      // inputs and textareas both use this; the blur handling is identical
      onBlur: (event: FocusEvent<HTMLInputElement | HTMLTextAreaElement>) => {
        setBlurred((prev) => ({ ...prev, [name]: true }));
        props.onBlur?.(event);
      },
    };
  };

  const revealAll = () => setSubmitAttempted(true);

  return { field, revealAll };
}
