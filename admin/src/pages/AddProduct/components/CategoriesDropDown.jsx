import { useState, useRef, useEffect } from "react";
import useOutsideClick from "../../../useOutsideClick";
import ArrowDownIcon from "../../../components/icons/ArrowDownIcon";

const CategoriesDropDown = ({
  mainCategoryName,
  isAddCategoryEditing,
  categories,
  setSelectedCategory,
  subCategories,
  setSubCategories,
  setCurrentSubCategory,
  setSelectedCategoryId,
}) => {
  const [currentCategory, setCurrentCategory] = useState(
    categories.map((item) => item.name)[0]
  );
  const [isOpen, setIsOpen] = useState(false);

  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOpen) {
      setIsOpen(false);
    }
  });

  useEffect(() => {
    if (isAddCategoryEditing) {
      setCurrentCategory(mainCategoryName);
      // setSelectedCategory(mainCategoryId);
    } else {
      setSelectedCategoryId(categories.map((category) => category.id)[0]);
      setSubCategories(categories.map((category) => category.subCategories));
    }
  }, []);

  const toggleMenu = (e) => {
    e.preventDefault();
    setIsOpen((isOpen) => !isOpen);
  };

  const handleOnClick = (e, name, id, index) => {
    e.preventDefault();
    setCurrentCategory(name);
    setSelectedCategory(index);
    setSelectedCategoryId(id);
    setCurrentSubCategory("Select Sub Category");
    console.log(subCategories);
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-14 z-20 bg-bgColor-light shadow-sm border-none mr-14 px-4 w-full rounded-xl hover:bg-gray-100 hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black capitalize">
        {isAddCategoryEditing ? mainCategoryName : currentCategory}
      </span>

      <ArrowDownIcon color={"#000000"} />
      {isOpen && (
        <div className="absolute top-16 z-50 left-0 right-1 h-30 w-full flex flex-col py-4 px-2 rounded-2xl shadow bg-gray-50">
          {categories.map((category, index) => (
            <span
              key={category.id}
              className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light capitalize"
            >
              <div
                key={category.id}
                onClick={(e) =>
                  handleOnClick(e, category.name, category.id, index)
                }
              >
                {category.name}
              </div>
            </span>
          ))}
        </div>
      )}
    </div>
  );
};

export default CategoriesDropDown;
