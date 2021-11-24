import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  customers: [],
};

export const customersSlice = createSlice({
  name: "customers",
  initialState,
  reducers: {
    setCustomers: (state, action) => {
      const { customers } = action.payload;
      state.customers = customers;
    },
  },
});

export const { setCustomers } = customersSlice.actions;

export default customersSlice.reducer;
