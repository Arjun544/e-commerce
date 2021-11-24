import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  categories: [],
};

export const categoriesSlice = createSlice({
  name: "categories",
  initialState,
  reducers: {
    setcategories: (state, action) => {
      state.categories = action.payload;
    },
  },
});

export const { setcategories } = categoriesSlice.actions;

export default categoriesSlice.reducer;
