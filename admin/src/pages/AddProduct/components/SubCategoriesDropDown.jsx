import { useState, useRef, useEffect } from "react";
import useOutsideClick from "../../../useOutsideClick";
import ArrowDownIcon from "../../../components/icons/ArrowDownIcon";

const SubCategoriesDropDown = ({
  mainCategoryId,
  mainCategoryName,
  isEditing,
  subCategories,
  setSelectedSubCategory,
}) => {
  const [currentSubCategory, setCurrentSubCategory] = useState(
    "Select Sub Category"
  );
  const [isOpen, setIsOpen] = useState(false);

  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOpen) {
      setIsOpen(false);
    }
  });

  useEffect(() => {
    if (isEditing) {
      setCurrentSubCategory(mainCategoryName);
      setSelectedSubCategory(mainCategoryId);
    }
    console.log(subCategories);
  }, [subCategories]);

  const toggleMenu = (e) => {
    e.preventDefault();
    setIsOpen((isOpen) => !isOpen);
  };

  const handleOnClick = (e, name, id) => {
    e.preventDefault();
    setCurrentSubCategory(name);
    setSelectedSubCategory(id);
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-14 z-20 bg-bgColor-light shadow-sm border-none px-4 w-full rounded-xl hover:bg-gray-100 hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black capitalize">
        {isEditing ? mainCategoryName : currentSubCategory}
      </span>

      <ArrowDownIcon color={"#000000"} />
      {isOpen && (
        <div className="absolute top-16 z-50 left-0 right-1 h-30 w-full flex flex-col py-4 px-2 rounded-2xl shadow bg-gray-50">
          {subCategories.map((category) => (
            <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light capitalize">
              <div
                onClick={(e) => handleOnClick(e, category.name, category.id)}
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

export default SubCategoriesDropDown;
