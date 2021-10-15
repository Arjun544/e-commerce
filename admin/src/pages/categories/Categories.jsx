import React, { useState, useContext, useEffect } from "react";
import { AppContext } from "../../App";
import TopBar from "../../components/TopBar";
import {
  deleteCategory,
  deleteSubCategory,
  getCategories,
} from "../../api/categoriesApi";
import Loader from "react-loader-spinner";
import { useSnackbar } from "notistack";
import EditIcon from "../../components/icons/EditIcon";
import DeleteIcon from "../../components/icons/DeleteIcon";
import AddCategoryDialogue from "./components/AddCategoryDialogue";
import AddSubCategoryDialogue from "./components/AddSubCategoryDialogue";

const Categories = () => {
  const { isBigScreen } = useContext(AppContext);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [categories, setCategories] = useState([]);
  const [selectedTab, setSelectedTab] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [addCategoryInput, setAddCategoryInput] = useState("");
  const [addCategoryAlert, setAddCategoryAlert] = useState(false);
  const [isAddCategoryEditing, setIsAddCategoryEditing] = useState(false);
  const [editingCategory, setEditingCategory] = useState({});
  const [addSubCategoryInput, setAddSubCategoryInput] = useState("");
  const [addSubCategoryAlert, setAddSubCategoryAlert] = useState(false);

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

  const mainCategoryName = categories.map((item) => item.name);
  const mainCategoryId = categories.map((item) => item.id);
  const subCategories = categories.map((item) => item.subCategories);

  const handleCategoryEdit = (e, category) => {
    e.preventDefault();
    setAddCategoryAlert(true);
    setIsAddCategoryEditing(true);
    setEditingCategory(category);
  };

  const handleCategoryDelete = async (e, category) => {
    e.preventDefault();
    try {
      setIsLoading(true);
      await deleteCategory(category.id, category.iconId);
      const { data } = await getCategories();
      setCategories(data.categoryList);
      setSelectedTab(0);
      setIsLoading(false);
      enqueueSnackbar("Category deleted", {
        variant: "success",
        autoHideDuration: 2000,
      });
    } catch (error) {
      console.log(error.response);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSubCategoryEdit = (e, subCategory) => {
    e.preventDefault();
    setAddSubCategoryAlert(true);
    setIsAddCategoryEditing(true);
    setEditingCategory(subCategory);
  };

  const handleSubCategoryDelete = async (e, category) => {
    e.preventDefault();
    setIsLoading(true);
    try {
      await deleteSubCategory(mainCategoryId, category.id);
    } catch (error) {
      console.log(error.response);
    }
    const { data } = await getCategories();
    setCategories(data.categoryList);
    setIsLoading(false);
    enqueueSnackbar("Category deleted", {
      variant: "success",
      autoHideDuration: 2000,
    });
  };

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  px-10  bg-white">
      {addCategoryAlert && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <AddCategoryDialogue
            isAddCategoryEditing={isAddCategoryEditing}
            editingCategory={editingCategory}
            setIsAddCategoryEditing={setIsAddCategoryEditing}
            setIsLoading={setIsLoading}
            setCategories={setCategories}
            addCategoryAlert={addCategoryAlert}
            setAddCategoryAlert={setAddCategoryAlert}
            addCategoryInput={addCategoryInput}
            setAddCategoryInput={setAddCategoryInput}
          />
        </div>
      )}
      {addSubCategoryAlert && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <AddSubCategoryDialogue
            isAddCategoryEditing={isAddCategoryEditing}
            editingCategory={editingCategory}
            mainCategoryName={mainCategoryName[selectedTab]}
            mainCategoryId={mainCategoryId[selectedTab]}
            setIsAddCategoryEditing={setIsAddCategoryEditing}
            categories={categories}
            setIsLoading={setIsLoading}
            setCategories={setCategories}
            setAddSubCategoryAlert={setAddSubCategoryAlert}
            addSubCategoryInput={addSubCategoryInput}
            setAddSubCategoryInput={setAddSubCategoryInput}
          />
        </div>
      )}

      <TopBar />
      <div className="flex mb-6 items-center justify-between">
        <span className="text-black font-semibold text-xl">Categories</span>
        <div className="flex items-center">
          <div
            onClick={(e) => setAddCategoryAlert(true)}
            className="flex relative h-12 bg-darkBlue-light  shadow-sm border-none ml-4 w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">
              Add Category
            </span>
          </div>
          <div
            onClick={(e) => setAddSubCategoryAlert(true)}
            className="flex relative h-12 bg-customYellow-light  shadow-sm border-none ml-4 w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">
              Add Sub Category
            </span>
          </div>
        </div>
      </div>

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
        <div className="flex w-full h-full overflow-x-hidden">
          {/* Tabs */}
          <div className="flex flex-col w-1/4 bg-bgColor-light rounded-3xl py-6 px-4 items-center cursor-pointer">
            {categories.map((category, index) => {
              return (
                <div
                  key={category.id}
                  onClick={(e) => {
                    e.preventDefault();
                    setSelectedTab(index);
                  }}
                  className={
                    index === selectedTab
                      ? "flex tabs tab-active w-full h-16 mb-4 items-center bg-customYellow-light justify-start font-semibold capitalize  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95  transition duration-500 ease-in-out"
                      : "flex tabs w-full h-12 mb-4 items-center justify-center font-semibold capitalize text-gray-400 tracking-wide hover:text-darkBlue-light"
                  }
                >
                  <div className="flex w-full px-4 items-center justify-between">
                    <img
                      className="h-8 w-8 rounded-xl object-cover shadow-md"
                      src={category.icon}
                      alt=""
                    />
                    <div className="flex items-center w-full ml-4">
                      <span>{category.name}</span>
                    </div>

                    {index === selectedTab && (
                      <div className="flex items-end">
                        <EditIcon
                          onClick={(e) => handleCategoryEdit(e, category)}
                          className="mr-2 h-5 w-5 cursor-pointer fill-white hover:fill-green"
                        />
                        <DeleteIcon
                          onClick={(e) => handleCategoryDelete(e, category)}
                          className="cursor-pointer h-5 w-5 fill-white hover:fill-red"
                        />
                      </div>
                    )}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Views */}

          {subCategories.length === 0 ? (
            <div className="flex h-full w-full pt-10 justify-center">
              <span className="text-black font-semibold">
                No sub categories
              </span>
            </div>
          ) : (
            <div className="flex flex-wrap w-full h-52 rounded-3xl bg-white ml-8">
              {subCategories[selectedTab].map((item) => {
                return (
                  <div
                    key={item.id}
                    className="flex w-1/5 h-16 mr-8  bg-bgColor-light rounded-2xl items-center justify-between px-6 shadow-sm"
                  >
                    <span className="text-black font-semibold capitalize">
                      {item.name}
                    </span>
                    <div className="flex">
                      <EditIcon
                        onClick={(e) => handleSubCategoryEdit(e, item)}
                        className="mr-2 h-5 w-5 cursor-pointer fill-grey hover:fill-green"
                      />
                      <DeleteIcon
                        onClick={(e) => handleSubCategoryDelete(e, item)}
                        className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Categories;
