import React, { useState } from "react";
import Switch from "react-switch";

const Featured = ({status}) => {
  const [value, setValue] = useState(status);
  return (
    <Switch
      value={value}
      checked={value}
      onChange={(e) => setValue((preState) => !preState)}
      onColor="#D1FAE5"
      onHandleColor="#10B981"
      handleDiameter={20}
      uncheckedIcon={false}
      checkedIcon={false}
      boxShadow="0px 1px 5px rgba(0, 0, 0, 0.329)"
      activeBoxShadow="0px 0px 1px 10px rgba(0, 0, 0, 0.062)"
      height={10}
      width={30}
      className="react-switch"
      id="material-switch"
    />
  );
};

export default Featured;
