import { createSlice, type PayloadAction } from "@reduxjs/toolkit";

type AuthState = { token: string | null };

const TOKEN_KEY = "token";

// "Remember me" picks the storage: localStorage survives closing the browser,
// sessionStorage dies with the tab. Only ever one of them holds the token, so
// reading just checks both.
function readToken(): string | null {
  try {
    return (
      sessionStorage.getItem(TOKEN_KEY) ?? localStorage.getItem(TOKEN_KEY)
    );
  } catch {
    return null; // storage can throw in private browsing
  }
}

function writeToken(token: string, remember: boolean) {
  try {
    const [target, other] = remember
      ? [localStorage, sessionStorage]
      : [sessionStorage, localStorage];
    target.setItem(TOKEN_KEY, token);
    other.removeItem(TOKEN_KEY);
  } catch {
    // no persistence available; the in-memory token still works this session
  }
}

function clearToken() {
  try {
    localStorage.removeItem(TOKEN_KEY);
    sessionStorage.removeItem(TOKEN_KEY);
  } catch {
    // nothing to clear
  }
}

const initialState: AuthState = { token: readToken() };

export const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    setToken: (
      state,
      action: PayloadAction<{ token: string; remember: boolean }>,
    ) => {
      state.token = action.payload.token;
      writeToken(action.payload.token, action.payload.remember);
    },
    logOut: (state) => {
      state.token = null;
      clearToken();
    },
  },
});

export const { setToken, logOut } = authSlice.actions;

export default authSlice.reducer;
