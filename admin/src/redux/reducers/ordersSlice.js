import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  orders: [],
};

export const ordersSlice = createSlice({
  name: "orders",
  initialState,
  reducers: {
    setOrders: (state, action) => {
      const { orders } = action.payload;
      state.orders = orders;
    },
  },
});

export const { setOrders } = ordersSlice.actions;

export default ordersSlice.reducer;
