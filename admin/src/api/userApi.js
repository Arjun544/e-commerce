import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

export const userApi = createApi({
  reducerPath: "userApi",
  baseQuery: fetchBaseQuery({ baseUrl: process.env.REACT_APP_API_URL }),
  endpoints: (builder) => ({
    login: builder.mutation({
      query: (body) => ({
        url: "admin/login",
        method: "POST",
        body: body,
      }),
    }),
  }),
});

export const { useLoginMutation } = userApi;
