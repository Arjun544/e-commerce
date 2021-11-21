
import React from "react";

const StatusButon = ({ text, color,icon, onPressed }) => {
  return (
    <div
      onClick={onPressed}
      className={`flex items-center justify-center py-3 rounded-2xl w-32 h-10 mr-2 ${color} cursor-pointer shadow-md  transform hover:scale-95 transition duration-500 ease-in-out`}
    >
      {icon}
      <span className="font-semibold text-white">{text}</span>
    </div>
  );
};

export default StatusButon;
