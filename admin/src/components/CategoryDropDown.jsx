import { useState, useRef } from "react";
import useOutsideClick from "../useOutsideClick";
import ArrowDownIcon from "./icons/ArrowDownIcon";

const CategoryDropDown = () => {
  const [selectedCategory, setSelectedCategory] = useState("Overall");
  const [isOpen, setIsOpen] = useState(false);

  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOpen) {
      setIsOpen(false);
    }
  });

  const toggleMenu = (e) => {
    e.preventDefault();
    setIsOpen((isOpen) => !isOpen);
  };

  const handleSortGeneral = (e) => {
    e.preventDefault();
    setSelectedCategory("General");
  };

  const handleSortHome = (e) => {
    e.preventDefault();
    setSelectedCategory("Home");
  };

  const handleSortWork = (e) => {
    e.preventDefault();
    setSelectedCategory("Work");
  };
  const handleSortHealth = (e) => {
    e.preventDefault();
    setSelectedCategory("Health");
  };
  const handleSortVacation = (e) => {
    e.preventDefault();
    setSelectedCategory("Vacation");
  };
  const handleSortGift = (e) => {
    e.preventDefault();
    setSelectedCategory("Gift");
  };

  const handleSortIdeas = (e) => {
    e.preventDefault();
    setSelectedCategory("Ideas");
  };
  const handleSortPayment = (e) => {
    e.preventDefault();
    setSelectedCategory("Payment");
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-12 z-20 bg-bgColor-light shadow-sm border-none px-4 w-40 rounded-xl hover:bg-gray-50 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black">
        {selectedCategory}
      </span>

      <ArrowDownIcon color={"#d4d4d4"} />
      {isOpen && (
        <div className="absolute top-14 z-50 left-0 right-1 h-30 w-40 flex flex-col py-4 px-2 rounded-2xl shadow bg-gray-50">
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortGeneral}>General</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortHome}>Home</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortWork}>Work</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortHealth}>Health</div>
          </span>

          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortVacation}>Vacation</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortGift}>Gift</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortIdeas}>Ideas</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:bg-yellow-100">
            <div onClick={handleSortPayment}>Payment</div>
          </span>
        </div>
      )}
    </div>
  );
};

export default CategoryDropDown;
