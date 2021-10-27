import React, { useState } from "react";

const ItemCard = ({ value, items }) => {
  const [isOpen, setIsOpen] = useState(false);
  return (
    <div
      onMouseEnter={(e) => setIsOpen(true)}
      onMouseLeave={(e) => setIsOpen(false)}
      className="flex-col"
    >
      <div className="flex cursor-pointer">
        <span className="mr-2">{value}</span>
        <span>items</span>
      </div>
      {isOpen && (
        <div className="flex-col absolute z-50 h-auto w-52 rounded-2xl mt-1 p-3 bg-white shadow-md">
          {items.orderItems.map((item, index) => (
            <div className="flex items-center -mb-2">
              <span className="text-2xl mr-2 mb-1">•</span>
              <span id={index} className="text-black font-semibold text-sm ">
                {item.product.name.charAt(0).toUpperCase() +
                  item.product.name.slice(1)}
              </span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default ItemCard;
