import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  isAuth: false,
  user: null,
  token: null,
};

export const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    setAuth: (state, action) => {
      const { admin, token } = action.payload;
      state.user = admin;
      state.token = token;
      if (admin === null) {
        state.isAuth = false;
      } else {
        state.isAuth = true;
      }
    },
  },
});

export const { setAuth } = authSlice.actions;

export default authSlice.reducer;
