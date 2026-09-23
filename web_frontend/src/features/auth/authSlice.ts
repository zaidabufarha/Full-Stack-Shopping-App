import { createSlice, type PayloadAction } from "@reduxjs/toolkit";

type AuthState = { token: string | null };
    
const initialState: AuthState = {token: null};

export const authSlice = createSlice({
    name: 'auth',
    initialState,
    reducers: {
        setToken: (state, action: PayloadAction<string>) =>{
            state.token = action.payload
        },
        logOut: (state)=>{
            state.token = null
        }

    }
})

export const {setToken, logOut} = authSlice.actions

export default authSlice.reducer