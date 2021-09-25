import React, { useState, useContext, useEffect } from "react";
import { AppContext } from "../../App";
import TopBar from "../../components/TopBar";
import { getCategories } from "../../api/categoriesApi";
import Loader from "react-loader-spinner";
import EditIcon from "../../components/icons/EditIcon";
import DeleteIcon from "../../components/icons/DeleteIcon";
import CategoryDialogue from "./components/CategoryDialogue";

const Categories = () => {
  const { isBigScreen } = useContext(AppContext);
  const [selectedTab, setSelectedTab] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [categoryInput, setCategoryInput] = useState("");
  const [categoryAlert, setCategoryAlert] = useState(false);

  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        setIsLoading(true);
        const { data } = await getCategories();
        setCategories(data.categories);
        console.log(data.categories);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchCategories();
  }, []);

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  px-10  bg-white">
      {categoryAlert && (
        <div className=" flex absolute z-50 left-0 w-screen h-screen bg-blue-light bg-opacity-0 backdrop-filter backdrop-blur-sm justify-center items-center">
          <CategoryDialogue
            categoryAlert={categoryAlert}
            setCategoryAlert={setCategoryAlert}
            categoryInput={categoryInput}
            setCategoryInput={setCategoryInput}
          />
        </div>
      )}

      <TopBar />
      <div className="flex mb-6 items-center justify-between">
        <span className="text-black font-semibold text-xl">Categories</span>
        <div className="flex items-center">
          <div
            onClick={(e) => setCategoryAlert(true)}
            className="flex relative h-12 bg-darkBlue-light  shadow-sm border-none ml-4 w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out"
          >
            <span className="font-semibold text-sm text-white">
              Add Category
            </span>
          </div>
          <div className="flex relative h-12 bg-customYellow-light  shadow-sm border-none ml-4 w-40 rounded-xl  items-center justify-center cursor-pointer transform hover:scale-95  transition duration-500 ease-in-out">
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
                  onClick={(e) => {
                    e.preventDefault();
                    setSelectedTab(index);
                  }}
                  className={
                    index === selectedTab
                      ? "flex tabs tab-active w-full h-12 mb-4 items-center bg-customYellow-light justify-start font-semibold capitalize  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95  transition duration-500 ease-in-out"
                      : "flex tabs w-full h-12 mb-4 items-center justify-center font-semibold capitalize text-gray-400 tracking-wide hover:text-darkBlue-light"
                  }
                >
                  <div className="flex w-full px-4 items-center justify-between  ">
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
                        <EditIcon className="mr-2 h-5 w-5 cursor-pointer fill-white hover:fill-green" />
                        <DeleteIcon className="cursor-pointer h-5 w-5 fill-white hover:fill-red" />
                      </div>
                    )}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Views */}
          {/* <div className="flex flex-wrap w-full h-52 rounded-3xl bg-white ml-8">
            {categories[selectedTab].subCategories.map((item) => {
              return (
                <div className="flex w-1/5 h-16 mr-8  bg-bgColor-light rounded-2xl items-center justify-between px-6 shadow-sm">
                  <span className="text-black font-semibold capitalize">
                    {item.name}
                  </span>
                  <div className="flex">
                    <EditIcon className="mr-2 h-5 w-5 cursor-pointer fill-grey hover:fill-green" />
                    <DeleteIcon className="cursor-pointer h-5 w-5 fill-grey hover:fill-red" />
                  </div>
                </div>
              );
            })}
          </div> */}
        </div>
      )}
    </div>
  );
};

export default Categories;
