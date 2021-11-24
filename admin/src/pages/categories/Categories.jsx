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
import { ChevronDownIcon } from "@heroicons/react/solid";
import { ChevronUpIcon } from "@heroicons/react/solid";
import AddCategoryDialogue from "./components/AddCategoryDialogue";
import AddSubCategoryDialogue from "./components/AddSubCategoryDialogue";
import { Accordion, AccordionItem } from "react-sanfona";

const Categories = () => {
  const { isBigScreen, socket } = useContext(AppContext);
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [isTileOpen, setIsTileOpen] = useState(false);
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
  const mainCategoryId = categories.map((item) => item._id);
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
      await deleteCategory(category._id, category.iconId);
      socket.current.on("delete-category", (newCategories) => {
        setCategories(newCategories);
      });
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

  const handleSubCategoryDelete = async (e, mainId, category) => {
    e.preventDefault();
    // setIsLoading(true);
    try {
      await deleteSubCategory(mainId, category.id);
      socket.current.on("delete-subCategory", (newCategories) => {
        setCategories(newCategories);
      });
      enqueueSnackbar("Category deleted", {
        variant: "success",
        autoHideDuration: 2000,
      });
    } catch (error) {
      console.log(error.response);
    }
    // const { data } = await getCategories();
    // setCategories(data.categoryList);
    // setIsLoading(false);
  };

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  bg-white">
      {addCategoryAlert && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <AddCategoryDialogue
            isAddCategoryEditing={isAddCategoryEditing}
            editingCategory={editingCategory}
            setIsAddCategoryEditing={setIsAddCategoryEditing}
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
      <div className="flex mb-6 mt-2 items-center justify-between px-8">
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
      ) : categories.length === 0 ? (
        <div className="flex w-full items-center justify-center mt-40">
          <span className="text-black font-semibold">No Categories</span>
        </div>
      ) : (
        <div className=" w-full h-full overflow-x-hidden max-w-full px-8 scrollbar scrollbar-thin hover:scrollbar-thumb-gray-900 scrollbar-thumb-gray-500 scrollbar-track-gray-300">
          {/* Table */}
          <Accordion
            className="h-auto flex-col pt-6 pb-12 items-start mb-6 "
            isHovered={true}
          >
            {categories.map((category) => {
              return (
                <AccordionItem
                  key={category._id}
                  className="mb-4"
                  onExpand={() => setIsTileOpen(true)}
                  onClose={() => setIsTileOpen(false)}
                  title={
                    <div
                      className={`flex h-16 items-center bg-bgColor-light border-none px-4 ${
                        !isTileOpen ? "rounded-2xl" : "rounded-t-2xl"
                      }  shadow-sm justify-between justify-items-center cursor-pointer hover:shadow-md`}
                    >
                      <div className="flex items-center justify-center">
                        <img
                          className="h-10 w-10 rounded-2xl mr-6 ml-4 object-contain"
                          src={category.icon}
                          alt=""
                        />
                        <span
                          className={
                            "font-medium text-black overflow-hidden truncate w-full"
                          }
                        >
                          {category.name.charAt(0).toUpperCase() +
                            category.name.slice(1)}
                        </span>
                      </div>
                      <div className="flex items-center">
                        <div className="flex items-end mr-6">
                          <EditIcon
                            onClick={(e) => handleCategoryEdit(e, category)}
                            className="mr-3 h-5 w-5 cursor-pointer fill-lightGreen hover:fill-green"
                          />
                          <DeleteIcon
                            onClick={(e) => handleCategoryDelete(e, category)}
                            className="cursor-pointer h-5 w-5 fill-lightRed hover:fill-red"
                          />
                        </div>
                        {isTileOpen ? (
                          <ChevronUpIcon className="h-6 w-6 relative text-gray-300 cursor-pointer"></ChevronUpIcon>
                        ) : (
                          <ChevronDownIcon className="h-6 w-6 relative text-gray-300 cursor-pointer"></ChevronDownIcon>
                        )}
                      </div>
                    </div>
                  }
                  expanded={category === 1}
                >
                  <div className="flex flex-col  h-auto bg-bgColor-light bg-opacity-50 w-full px-6">
                    {category.subCategories.length === 0 ? (
                      <span className="text-gray-400 font-semibold my-4">
                        No sub categories
                      </span>
                    ) : (
                      <div className='flex flex-col'>
                        <span className="font-semibold my-4">
                          Subcategories
                        </span>
                        <div className="flex items-center flex-wrap">
                          {category.subCategories.map((item, index) => (
                            <div
                              key={index}
                              className="flex w-64 h-16 mr-8 mb-6  bg-blue-light bg-opacity-30 rounded-2xl items-center justify-between px-6 shadow-sm"
                            >
                              <span className="text-black font-semibold capitalize">
                                {item.name}
                              </span>
                              <div className="flex">
                                <EditIcon
                                  onClick={(e) =>
                                    handleSubCategoryEdit(e, item)
                                  }
                                  className="mr-2 h-5 w-5 cursor-pointer fill-grey hover:fill-green"
                                />
                                <DeleteIcon
                                  onClick={(e) =>
                                    handleSubCategoryDelete(
                                      e,
                                      category._id,
                                      item
                                    )
                                  }
                                  className="cursor-pointer h-5 w-5 fill-grey hover:fill-red"
                                />
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                </AccordionItem>
              );
            })}
          </Accordion>
        </div>
      )}
    </div>
  );
};

export default Categories;
