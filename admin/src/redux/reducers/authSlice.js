import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  isAuth: false,
  user: null,
  accessToken: null,
};

export const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    setAuth: (state, action) => {
      const { accessToken, user } = action.payload;
      state.user = user;
      if (user === null) {
        state.isAuth = false;
        state.accessToken = null;
      } else {
        state.isAuth = true;
        state.accessToken = accessToken;
      }
    },
  },
});

export const { setAuth } = authSlice.actions;

export default authSlice.reducer;
