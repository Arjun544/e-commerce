import React from "react";

const CustomButon = ({ text, width, onPressed, color }) => {
  return (
    <div
      onClick={onPressed}
      className={`flex items-center justify-center py-3 rounded-2xl w-${width} ${color} cursor-pointer shadow-md  transform hover:scale-90 transition duration-500 ease-in-out`}
    >
      <span className="font-semibold text-white">{text}</span>
    </div>
  );
};

export default CustomButon;
