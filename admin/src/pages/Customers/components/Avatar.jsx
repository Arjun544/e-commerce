import React from "react";

const Avatar = ({ value }) => {
  return (
    <div className="h-8 w-8 rounded-full">
      <img src={value} alt="" />
    </div>
  );
};

export default Avatar;
