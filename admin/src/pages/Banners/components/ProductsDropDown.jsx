import React, { useState, useRef } from "react";
import useOutsideClick from "../../../useOutsideClick";
import ArrowDownIcon from "../../../components/icons/ArrowDownIcon";

const ProductsDropDown = ({
  products,
  selectedProductName,
  setSelectedProductName,
  setSelectedProduct,
  setSearchInput,
  searchInput,
}) => {
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

  const handleSort = (e, product) => {
    e.preventDefault();
    setSelectedProductName(product.name);
    setSelectedProduct(product);
    setSearchInput("");
  };

  const filterNames = ({ name }) => {
    return name.toLowerCase().indexOf(searchInput.toLowerCase()) !== -1;
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-14 mr-4 bg-bgColor-light shadow-sm border-none px-4 w-full rounded-xl hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black">
        {selectedProductName.charAt(0).toUpperCase() +
          selectedProductName.slice(1)}
      </span>

      <ArrowDownIcon color={"#000000"} />

      {isOpen && (
        <div className="flex-col h-80 absolute top-16 z-40 left-0 right-1 w-full py-4 px-6 rounded-2xl shadow bg-gray-50">
          <input
            className="h-12 w-full mb-4 rounded-xl font-semibold text-black bg-bgColor-light focus-within: px-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-Grey-dark "
            placeholder="Search product"
            autoFocus={true}
            value={searchInput}
            onChange={(e) => {
              e.preventDefault();
              setSearchInput(e.target.value);
            }}
          />
          <div className="flex-col h-56  overflow-y-auto overflow-x-hidden scrollbar scrollbar-thin hover:scrollbar-thumb-amber-light scrollbar-thumb-gray-200 scrollbar-track-gray-100">
            {searchInput ? (
              products.filter(filterNames).length === 0 ? (
                <div className="div ">
                  <span className="text-gray-400 font-semibold ">
                    No products
                  </span>
                </div>
              ) : (
                products.filter(filterNames).map((product) => {
                  return (
                    <div
                      id={product._id}
                      onClick={(e) => handleSort(e, product)}
                      className="flex items-center hover:bg-blue-light py-2 rounded-md"
                    >
                      <img
                        className="h-6 w-6 rounded-full ml-3"
                        src={product.thumbnail}
                        alt=""
                      />
                      <span className="font-semibold pl-3 text-gray-500">
                        <div>
                          {product.name.charAt(0).toUpperCase() +
                            product.name.slice(1)}
                        </div>
                      </span>
                    </div>
                  );
                })
              )
            ) : (
              products.map((product) => {
                return (
                  <div
                    id={product._id}
                    onClick={(e) => handleSort(e, product)}
                    className="flex items-center hover:bg-blue-light py-2 rounded-md"
                  >
                    <img
                      className="h-6 w-6 rounded-full ml-3"
                      src={product.thumbnail}
                      alt=""
                    />
                    <span className="font-semibold pl-3 text-gray-500">
                      <div>
                        {product.name.charAt(0).toUpperCase() +
                          product.name.slice(1)}
                      </div>
                    </span>
                  </div>
                );
              })
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default ProductsDropDown;
