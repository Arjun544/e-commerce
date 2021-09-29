import React, { useState, useEffect } from "react";
import TopBar from "../../components/TopBar";
import { useForm } from "react-hook-form";
import CustomEditor from "./components/CustomEditor";
import { getCategories } from "../../api/categoriesApi";
import Loader from "react-loader-spinner";
import CategoriesDropDown from "./components/CategoriesDropDown";
import SubCategoriesDropDown from "./components/SubCategoriesDropDown";

const AddProduct = () => {
  const [categories, setCategories] = useState([]);
  const [subCategories, setSubCategories] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState("");
  const [selectedSubCategory, setSelectedSubCategory] = useState("");

  const [input, setInput] = useState([
    {
      type: "paragraph",
      children: [{ text: "" }],
    },
  ]);
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        setIsLoading(true);
        const { data } = await getCategories();
        setCategories(data.categoryList);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchCategories();
  }, []);

  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      {isLoading ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader
            type="Puff"
            color="#00BFFF"
            height={50}
            width={50}
            timeout={3000} //3 secs
          />
        </div>
      ) : (
        <div className="flex flex-col h-full px-10 mt-6">
          <span className="text-black font-semibold text-xl">Add Product</span>
          <div className="flex h-full">
            <div className="flex flex-col flex-grow bg-white pr-10">
              <input
                className="h-14 w-1/2 rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                placeholder="Name"
                {...register("name", {
                  required: true,
                  minLength: 2,
                })}
              />
              {errors?.name?.type === "minLength" && (
                <span className="flex mb-2 text-red-500 text-xs">
                  Name must have at least 2 characters
                </span>
              )}
              <input
                className="h-14 w-1/2 rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
                placeholder="Description"
                {...register("description", {
                  required: true,
                  maxLength: 50,
                })}
              />
              {errors?.description?.type === "maxLength" && (
                <span className="flex mb-2 text-red-500 text-xs">
                  Name can't be more than 50 characters
                </span>
              )}
              <div className="bg-bgColor-light text-black font-semibold rounded-2xl">
                <CustomEditor value={input} setValue={setInput} />
              </div>

              {/* categories */}
              <div className="flex">
                <CategoriesDropDown
                  subCategories={subCategories}
                  isEditing={isEditing}
                  categories={categories}
                  setSubCategories={setSubCategories}
                  setSelectedCategory={setSelectedCategory}
                />
                <SubCategoriesDropDown
                  isEditing={isEditing}
                  subCategories={subCategories[0]}
                  setSelectedSubCategory={setSelectedSubCategory}
                />
              </div>
            </div>
            <div className="flex- flex-grow-0 w-1/4 bg-customYellow-light"></div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AddProduct;
