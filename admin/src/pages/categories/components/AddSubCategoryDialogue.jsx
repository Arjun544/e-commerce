import React, { useState } from "react";
import { useSnackbar } from "notistack";
import Loader from "react-loader-spinner";
import {
  addSubCategory,
  getCategories,
  updateSubCategory,
} from "../../../api/categoriesApi";
import CategoriesDropDown from "./CategoriesDropDown";

const AddSubCategoryDialogue = ({
  mainCategoryId,
  mainCategoryName,
  isAddCategoryEditing,
  editingCategory,
  setIsAddCategoryEditing,
  categories,
  setIsLoading,
  setCategories,
  setAddSubCategoryAlert,
  addSubCategoryInput,
  setAddSubCategoryInput,
}) => {
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [loading, setLoading] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState("");

  const handleAdd = async (e) => {
    e.preventDefault();
    if (addSubCategoryInput.length <= 2 || selectedCategory === "") {
      enqueueSnackbar("Fields can't be empty", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        console.log(addSubCategoryInput);
        console.log(selectedCategory);
        await addSubCategory(selectedCategory, addSubCategoryInput);
        setLoading(false);
        setAddSubCategoryAlert(false);
        setIsLoading(true);
        const { data } = await getCategories();
        setCategories(data.categoryList);
        setIsLoading(false);
        setAddSubCategoryInput("");
        setIsAddCategoryEditing(false);
        enqueueSnackbar("Sub category added", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
        setLoading(false);
        setAddSubCategoryInput("");
        setIsAddCategoryEditing(false);
      }
    }
  };

  const handleEdit = async (e) => {
    e.preventDefault();
    if (addSubCategoryInput.length <= 2 || selectedCategory === "") {
      enqueueSnackbar("Fields can't be empty", {
        variant: "error",
        autoHideDuration: 2000,
      });
    } else {
      try {
        setLoading(true);
        await updateSubCategory(
          mainCategoryId,
          editingCategory.id,
          addSubCategoryInput
        );
        setLoading(false);
        setAddSubCategoryAlert(false);
        setIsLoading(true);
        const { data } = await getCategories();
        setCategories(data.categoryList);
        setIsLoading(false);
        setAddSubCategoryInput("");
        setIsAddCategoryEditing(false);
        enqueueSnackbar("Sub category added", {
          variant: "success",
          autoHideDuration: 2000,
        });
      } catch (error) {
        enqueueSnackbar(error.response.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
        setLoading(false);
        setAddSubCategoryInput("");
        setIsAddCategoryEditing(false);
      }
    }
  };

  return (
    <div className="flex flex-col py-10 w-1/3 rounded-3xl bg-blue-light justify-center px-16">
      <div className="flex items-center justify-center">
        <span className="text-black font-semibold tracking-wider mb-8">
          {isAddCategoryEditing ? "Edit Sub Category" : "Add Sub Category"}
        </span>
      </div>
      <div className="flex items-center justify-center">
        <input
          className="h-14 w-full rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
          placeholder={isAddCategoryEditing ? editingCategory.name : "Name"}
          type="text"
          value={addSubCategoryInput}
          onChange={(e) => {
            setAddSubCategoryInput(e.target.value);
          }}
        />
      </div>

      <CategoriesDropDown
        mainCategoryId={mainCategoryId}
        mainCategoryName={mainCategoryName}
        isAddCategoryEditing={isAddCategoryEditing}
        categories={categories}
        setSelectedCategory={setSelectedCategory}
      />

      <div className="flex items-center justify-center mt-6">
        <div
          onClick={(e) => {
            e.preventDefault();
            setAddSubCategoryAlert(false);
            setAddSubCategoryInput("");
            setIsAddCategoryEditing(false);
          }}
          className="flex h-12 bg-red-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
        >
          <span className="font-semibold text-sm text-white">Cancel</span>
        </div>
        {loading ? (
          <div className="flex items-center justify-center ml-2">
            <Loader
              type="Puff"
              color="#00BFFF"
              height={50}
              width={50}
              timeout={3000} //3 secs
            />
          </div>
        ) : (
          <div
            onClick={isAddCategoryEditing ? handleEdit : handleAdd}
            className="flex h-12 bg-green-500  shadow-sm border-none ml-4 w-32 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">
              {isAddCategoryEditing ? "Edit" : "Add"}
            </span>
          </div>
        )}
      </div>
    </div>
  );
};

export default AddSubCategoryDialogue;
