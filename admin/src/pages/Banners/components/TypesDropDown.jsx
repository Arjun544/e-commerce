import { useState, useRef } from "react";
import useOutsideClick from "../../../useOutsideClick";
import ArrowDownIcon from "../../../components/icons/ArrowDownIcon";

const TypesDropDown = ({ selectedType, setSelectedType }) => {
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
    setSelectedType("General");
  };

  const handleSortSell = (e) => {
    e.preventDefault();
    setSelectedType("Sell");
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-14 mb-4 bg-bgColor-light shadow-sm border-none px-4 w-full rounded-xl hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black">{selectedType}</span>

      <ArrowDownIcon color={"#000000"} />
      {isOpen && (
        <div className="absolute top-16 z-40 left-0 right-1 h-30 w-full flex flex-col py-4 px-2 rounded-2xl shadow bg-gray-50">
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortGeneral}>General</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortSell}>Sell</div>
          </span>
        </div>
      )}
    </div>
  );
};

export default TypesDropDown;
