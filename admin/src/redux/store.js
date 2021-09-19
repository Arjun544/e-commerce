import { configureStore } from "@reduxjs/toolkit";
import { userApi } from "../api/userApi";
import auth from "./authSlice";

export const store = configureStore({
  reducer: {
    auth,
    [userApi.reducerPath]: userApi.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(userApi.middleware),
});